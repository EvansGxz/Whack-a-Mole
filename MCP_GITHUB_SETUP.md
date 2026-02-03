# 🔐 Configuración de MCP GitHub con OAuth para Copilot

## 📋 Guía Completa de Configuración

Esta guía te permitirá configurar el servidor MCP de GitHub para que Copilot acceda de forma segura a tu repositorio.

---

## 🚀 Paso 1: Crear una Aplicación OAuth en GitHub

### 1.1 Acceder a Configuración de Desarrollador

1. Ve a tu perfil en GitHub: **Settings → Developer settings → OAuth Apps**
   - URL: https://github.com/settings/developers

2. Haz clic en **New OAuth App**

### 1.2 Completar Formulario de Aplicación

```
Application Name: Whack-a-Mole MCP for Copilot
Homepage URL: http://localhost:3000
Authorization callback URL: http://localhost:3000/callback
Device Flow Enabled: ✓ (marcar si lo necesitas)
```

**Nota:** Puedes ajustar los puertos según tu configuración.

### 1.3 Copiar Credenciales

Después de crear la app, obtendrás:
- **Client ID**: `Xxxxxxxxxxxxxxx`
- **Client Secret**: `Yyyyyyyyyyyyyyyy` (guardalo en secreto)

⚠️ **IMPORTANTE**: No compartas el Client Secret públicamente. Agrégalo a `.gitignore`.

---

## 📦 Paso 2: Instalar y Configurar el Servidor MCP

### 2.1 Instalar npm (si no lo tienes)

```bash
# Verificar si npm está instalado
npm --version

# Si no está instalado, descargar Node.js desde:
# https://nodejs.org/
```

### 2.2 Crear Directorio para el Servidor MCP

```bash
# Crear carpeta
mkdir mcp-github-server
cd mcp-github-server

# Inicializar proyecto Node
npm init -y
```

### 2.3 Instalar Dependencias

```bash
npm install @modelcontextprotocol/sdk axios dotenv express
```

---

## 🔧 Paso 3: Crear el Servidor MCP

### 3.1 Crear archivo `.env`

Crea un archivo `.env` en la raíz del proyecto:

```env
# GitHub OAuth Credentials
GITHUB_CLIENT_ID=tu_client_id_aqui
GITHUB_CLIENT_SECRET=tu_client_secret_aqui
GITHUB_REDIRECT_URI=http://localhost:3000/callback

# Configuración del Servidor
MCP_PORT=3000
NODE_ENV=development

# Token Personal de GitHub (alternativa para desarrollo)
GITHUB_PERSONAL_TOKEN=tu_token_personal_aqui
```

**Para obtener un Personal Token:**
1. Ve a https://github.com/settings/tokens
2. Haz clic en "Generate new token (classic)"
3. Dale estos permisos:
   - `repo` (acceso completo a repositorios privados)
   - `read:issues` (leer issues)
   - `read:user` (información del usuario)
4. Copia el token y guárdalo en `.env`

### 3.2 Crear archivo `server.js`

Crea un archivo `server.js`:

```javascript
const express = require('express');
const axios = require('axios');
require('dotenv').config();

const app = express();
app.use(express.json());

// ==============
// CONFIGURACIÓN
// ==============

const GITHUB_CLIENT_ID = process.env.GITHUB_CLIENT_ID;
const GITHUB_CLIENT_SECRET = process.env.GITHUB_CLIENT_SECRET;
const GITHUB_REDIRECT_URI = process.env.GITHUB_REDIRECT_URI;
const GITHUB_TOKEN = process.env.GITHUB_PERSONAL_TOKEN;
const PORT = process.env.MCP_PORT || 3000;

// Variables globales para almacenar tokens
let userAccessToken = null;

// ==============
// RUTAS OAuth
// ==============

/**
 * Ruta de inicio de sesión OAuth
 * GET /auth
 */
app.get('/auth', (req, res) => {
  const authUrl = `https://github.com/login/oauth/authorize?client_id=${GITHUB_CLIENT_ID}&redirect_uri=${GITHUB_REDIRECT_URI}&scope=repo,read:issues,read:user`;
  res.redirect(authUrl);
});

/**
 * Callback de OAuth
 * GET /callback
 */
app.get('/callback', async (req, res) => {
  const code = req.query.code;
  const state = req.query.state;

  if (!code) {
    return res.status(400).json({ error: 'No authorization code provided' });
  }

  try {
    // Intercambiar código por token
    const response = await axios.post('https://github.com/login/oauth/access_token', {
      client_id: GITHUB_CLIENT_ID,
      client_secret: GITHUB_CLIENT_SECRET,
      code: code,
      redirect_uri: GITHUB_REDIRECT_URI
    }, {
      headers: { Accept: 'application/json' }
    });

    userAccessToken = response.data.access_token;

    if (!userAccessToken) {
      return res.status(400).json({ error: response.data.error_description });
    }

    res.json({
      success: true,
      message: 'Autenticación exitosa',
      token: userAccessToken
    });
  } catch (error) {
    console.error('Error en OAuth callback:', error.message);
    res.status(500).json({ error: 'Authentication failed' });
  }
});

// ==============
// API ENDPOINTS
// ==============

/**
 * Obtener información del usuario
 * GET /api/user
 */
app.get('/api/user', async (req, res) => {
  try {
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.get('https://api.github.com/user', {
      headers: { Authorization: `Bearer ${token}` }
    });
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch user info' });
  }
});

/**
 * Obtener repositorios del usuario
 * GET /api/repos
 */
app.get('/api/repos', async (req, res) => {
  try {
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.get('https://api.github.com/user/repos', {
      headers: { Authorization: `Bearer ${token}` },
      params: { type: 'all', sort: 'updated', per_page: 100 }
    });
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch repositories' });
  }
});

/**
 * Obtener repositorio específico
 * GET /api/repos/:owner/:repo
 */
app.get('/api/repos/:owner/:repo', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.get(`https://api.github.com/repos/${owner}/${repo}`, {
      headers: { Authorization: `Bearer ${token}` }
    });
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch repository' });
  }
});

/**
 * Obtener issues de un repositorio
 * GET /api/repos/:owner/:repo/issues
 */
app.get('/api/repos/:owner/:repo/issues', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const { state = 'open' } = req.query;
    const token = userAccessToken || GITHUB_TOKEN;
    
    const response = await axios.get(
      `https://api.github.com/repos/${owner}/${repo}/issues`,
      {
        headers: { Authorization: `Bearer ${token}` },
        params: { state, per_page: 50 }
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch issues' });
  }
});

/**
 * Obtener etiquetas de un repositorio
 * GET /api/repos/:owner/:repo/labels
 */
app.get('/api/repos/:owner/:repo/labels', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const token = userAccessToken || GITHUB_TOKEN;
    
    const response = await axios.get(
      `https://api.github.com/repos/${owner}/${repo}/labels`,
      {
        headers: { Authorization: `Bearer ${token}` },
        params: { per_page: 100 }
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch labels' });
  }
});

/**
 * Obtener pull requests
 * GET /api/repos/:owner/:repo/pulls
 */
app.get('/api/repos/:owner/:repo/pulls', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const { state = 'open' } = req.query;
    const token = userAccessToken || GITHUB_TOKEN;
    
    const response = await axios.get(
      `https://api.github.com/repos/${owner}/${repo}/pulls`,
      {
        headers: { Authorization: `Bearer ${token}` },
        params: { state, per_page: 50 }
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch pull requests' });
  }
});

/**
 * Crear un nuevo issue
 * POST /api/repos/:owner/:repo/issues
 */
app.post('/api/repos/:owner/:repo/issues', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const { title, body, labels, assignees } = req.body;
    const token = userAccessToken || GITHUB_TOKEN;

    const response = await axios.post(
      `https://api.github.com/repos/${owner}/${repo}/issues`,
      { title, body, labels, assignees },
      {
        headers: { Authorization: `Bearer ${token}` }
      }
    );
    res.status(201).json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create issue' });
  }
});

/**
 * Actualizar un issue
 * PATCH /api/repos/:owner/:repo/issues/:issue_number
 */
app.patch('/api/repos/:owner/:repo/issues/:issue_number', async (req, res) => {
  try {
    const { owner, repo, issue_number } = req.params;
    const updates = req.body;
    const token = userAccessToken || GITHUB_TOKEN;

    const response = await axios.patch(
      `https://api.github.com/repos/${owner}/${repo}/issues/${issue_number}`,
      updates,
      {
        headers: { Authorization: `Bearer ${token}` }
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update issue' });
  }
});

/**
 * Obtener commits
 * GET /api/repos/:owner/:repo/commits
 */
app.get('/api/repos/:owner/:repo/commits', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const token = userAccessToken || GITHUB_TOKEN;
    
    const response = await axios.get(
      `https://api.github.com/repos/${owner}/${repo}/commits`,
      {
        headers: { Authorization: `Bearer ${token}` },
        params: { per_page: 50 }
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch commits' });
  }
});

// ==============
// HEALTH CHECK
// ==============

app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    message: 'MCP GitHub Server is running',
    authenticated: !!userAccessToken || !!GITHUB_TOKEN,
    port: PORT
  });
});

// ==============
// SERVIDOR
// ==============

app.listen(PORT, () => {
  console.log(`🚀 MCP GitHub Server running on http://localhost:${PORT}`);
  console.log(`📝 Configure OAuth: http://localhost:${PORT}/auth`);
  console.log(`🔍 Check status: http://localhost:${PORT}/health`);
});

module.exports = app;
```

### 3.3 Crear archivo `package.json` (si no existe)

```json
{
  "name": "mcp-github-server",
  "version": "1.0.0",
  "description": "MCP GitHub Server with OAuth for Copilot",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "node server.js"
  },
  "keywords": ["mcp", "github", "oauth", "copilot"],
  "author": "EvansGxz",
  "license": "MIT",
  "dependencies": {
    "@modelcontextprotocol/sdk": "^1.0.0",
    "axios": "^1.6.0",
    "dotenv": "^16.3.1",
    "express": "^4.18.2"
  }
}
```

### 3.4 Crear `.gitignore`

```
# Variables de entorno
.env
.env.local
.env.*.local

# Dependencias
node_modules/
package-lock.json
yarn.lock

# Logs
logs/
*.log
npm-debug.log*

# Sistema operativo
.DS_Store
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo

# Tokens y credenciales
*.pem
*.key
```

---

## 🎯 Paso 4: Iniciar el Servidor

```bash
# Desde la carpeta mcp-github-server
npm install
npm start

# Deberías ver:
# 🚀 MCP GitHub Server running on http://localhost:3000
# 📝 Configure OAuth: http://localhost:3000/auth
# 🔍 Check status: http://localhost:3000/health
```

---

## 🔌 Paso 5: Configurar VS Code para Copilot

### 5.1 Instalar Extensión Necesaria

1. Abre VS Code
2. Ve a Extensions (Ctrl+Shift+X)
3. Busca "GitHub Copilot Chat"
4. Instala la extensión oficial

### 5.2 Configurar MCP en VS Code

Crea un archivo `.vscode/settings.json`:

```json
{
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": false
  },
  "mcp": {
    "servers": {
      "github": {
        "command": "node",
        "args": [
          "/ruta/absoluta/a/mcp-github-server/server.js"
        ],
        "env": {
          "GITHUB_CLIENT_ID": "tu_client_id",
          "GITHUB_CLIENT_SECRET": "tu_client_secret",
          "GITHUB_PERSONAL_TOKEN": "tu_token_personal",
          "NODE_ENV": "development"
        }
      }
    }
  }
}
```

### 5.3 Configuración Alternativa: VS Code Settings JSON Global

```bash
Ctrl + Shift + P → Preferences: Open Settings (JSON)
```

Agrega:

```json
{
  "github.copilot.enable": true,
  "[github]": {
    "editor.defaultFormatter": "GitHub.copilot"
  }
}
```

---

## 🧪 Paso 6: Probar la Configuración

### 6.1 Verificar Estado del Servidor

```bash
curl http://localhost:3000/health
```

Deberías recibir:
```json
{
  "status": "ok",
  "message": "MCP GitHub Server is running",
  "authenticated": true,
  "port": 3000
}
```

### 6.2 Obtener Información del Usuario

```bash
curl -H "Authorization: Bearer TU_TOKEN" http://localhost:3000/api/user
```

### 6.3 Obtener Repositorios

```bash
curl http://localhost:3000/api/repos
```

### 6.4 Obtener Issues de tu Repositorio

```bash
curl http://localhost:3000/api/repos/EvansGxz/Whack-a-Mole/issues
```

---

## 📝 Prompts para Copilot con MCP

Una vez configurado, puedes usar prompts como:

```
@github List all open issues in EvansGxz/Whack-a-Mole
@github Create a new issue titled "Add difficulty levels"
@github Show me all PRs with label "enhancement"
@github Get the last 10 commits from main branch
@github Update issue #5 to add labels: bug, priority:high
@github Search for issues related to "performance"
```

---

## 🐛 Solucionar Problemas

### Error: "GITHUB_CLIENT_ID no definido"

Solución:
```bash
# Verificar que .env exista
cat .env

# Si no existe, crear uno con:
GITHUB_CLIENT_ID=tu_valor
GITHUB_CLIENT_SECRET=tu_valor
GITHUB_PERSONAL_TOKEN=tu_valor
```

### Error: "Puerto 3000 ya en uso"

Solución:
```bash
# Cambiar puerto en .env
MCP_PORT=3001

# O liberar puerto actual
# Windows
netstat -ano | findstr :3000
taskkill /PID PID_NUMERO /F

# macOS/Linux
lsof -ti:3000 | xargs kill -9
```

### Error: "Token inválido"

Solución:
1. Verificar que el token no haya expirado
2. Crear un nuevo Personal Token en GitHub
3. Copiar el nuevo token a `.env`

### Copilot no detecta el servidor

Solución:
1. Verificar que el servidor esté corriendo: `curl http://localhost:3000/health`
2. Reiniciar VS Code
3. Verificar la configuración de `settings.json`

---

## 🔒 Seguridad y Mejores Prácticas

### ✅ Lo Que Debes Hacer:

- ✅ Usar variables de entorno para credenciales
- ✅ Agregar `.env` a `.gitignore`
- ✅ Usar HTTPS en producción
- ✅ Rotar tokens regularmente
- ✅ Limitar permisos del token solo a lo necesario
- ✅ Usar URLs de callback que apunten a tu dominio

### ❌ Lo Que NO Debes Hacer:

- ❌ Comitear credenciales en GitHub
- ❌ Usar Client Secret en el navegador
- ❌ Compartir tokens personales públicamente
- ❌ Usar HTTP en producción
- ❌ Permitir permisos innecesarios

---

## 🚀 Desplegar a Producción

### Usando Railway, Heroku, o Similar:

1. **Variables de Entorno:**
   ```
   GITHUB_CLIENT_ID=xxx
   GITHUB_CLIENT_SECRET=xxx
   GITHUB_REDIRECT_URI=https://tudominio.com/callback
   GITHUB_PERSONAL_TOKEN=xxx
   NODE_ENV=production
   ```

2. **Comando de Inicio:**
   ```bash
   npm start
   ```

3. **Health Check:**
   ```
   GET /health
   ```

---

## 📚 Recursos Adicionales

- [Documentación OAuth GitHub](https://docs.github.com/en/developers/apps/building-oauth-apps)
- [API REST de GitHub](https://docs.github.com/en/rest)
- [MCP Documentation](https://modelcontextprotocol.io/)
- [Copilot Documentation](https://github.com/features/copilot)

---

## 📋 Checklist de Configuración

- [ ] Crear aplicación OAuth en GitHub
- [ ] Copiar Client ID y Client Secret
- [ ] Crear carpeta `mcp-github-server`
- [ ] Instalar dependencias con `npm install`
- [ ] Crear archivo `.env` con credenciales
- [ ] Crear archivo `server.js`
- [ ] Iniciar servidor con `npm start`
- [ ] Verificar estado en `/health`
- [ ] Configurar VS Code
- [ ] Instalar extensión Copilot Chat
- [ ] Probar prompts con `@github`
- [ ] Agregar `.env` a `.gitignore`

---

¡Listo! Ahora Copilot puede acceder a GitHub de forma segura. 🎉🔐

Para preguntas o problemas, consulta los logs del servidor o la documentación oficial.

Contáctame si necesitas ayuda adicional: @EvansGxz
