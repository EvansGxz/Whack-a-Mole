# Configuración MCP GitHub - Archivos de Ejemplo

Esta carpeta contiene ejemplos de archivos que necesitas crear para configurar el servidor MCP de GitHub.

## 📁 Estructura de Carpetas Recomendada

```
tu-proyecto/
├── Creado/
│   ├── golpea-al-topo.html
│   ├── MCP_GITHUB_SETUP.md
│   └── MCP_GITHUB_CONFIG_EXAMPLE.md (este archivo)
│
└── mcp-github-server/  ← Crear esta carpeta
    ├── server.js
    ├── package.json
    ├── .env (NUNCA pushear a GitHub)
    ├── .gitignore
    ├── .envexample
    └── node_modules/
```

## 📝 Ejemplo: .env

Copia este contenido en un archivo llamado `.env` en la carpeta `mcp-github-server`:

```env
# ===========================
# GitHub OAuth Credentials
# ===========================
GITHUB_CLIENT_ID=Xxxxxxxxxxxxxxxxxxxxxxxx
GITHUB_CLIENT_SECRET=Yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
GITHUB_REDIRECT_URI=http://localhost:3000/callback

# ===========================
# GitHub Personal Token
# (Alternativa a OAuth para desarrollo)
# ===========================
GITHUB_PERSONAL_TOKEN=ghp_Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# ===========================
# Configuración del Servidor
# ===========================
MCP_PORT=3000
NODE_ENV=development
```

## 📝 Ejemplo: .envexample

Copia este contenido en un archivo `.envexample` (SÍ pushear a GitHub):

```env
# ===========================
# GitHub OAuth Credentials
# ===========================
# Obtén estos valores en: https://github.com/settings/developers
GITHUB_CLIENT_ID=your_client_id_here
GITHUB_CLIENT_SECRET=your_client_secret_here
GITHUB_REDIRECT_URI=http://localhost:3000/callback

# ===========================
# GitHub Personal Token
# ===========================
# Obtén este valor en: https://github.com/settings/tokens
# Permisos necesarios: repo, read:issues, read:user
GITHUB_PERSONAL_TOKEN=ghp_your_token_here

# ===========================
# Configuración del Servidor
# ===========================
MCP_PORT=3000
NODE_ENV=development
```

## 📝 Ejemplo: .gitignore

Copia este contenido en un archivo `.gitignore`:

```gitignore
# Variables de entorno - NUNCA pushear credenciales
.env
.env.local
.env.*.local
.env.production

# Dependencias
node_modules/
package-lock.json
yarn.lock

# Logs
logs/
*.log
npm-debug.log*
yarn-error.log*

# Sistema operativo
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE
.vscode/
!.vscode/settings.json
!.vscode/extensions.json
.idea/
*.swp
*.swo
*~

# Archivos de sistema
.env.local.php
*.pem
*.key
secrets/
```

## 📝 Ejemplo: package.json

Copia este contenido en un archivo `package.json`:

```json
{
  "name": "mcp-github-server",
  "version": "1.0.0",
  "description": "MCP GitHub Server with OAuth for Copilot Integration",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "node server.js",
    "test": "node -e \"console.log('Tests would go here')\""
  },
  "keywords": [
    "mcp",
    "model-context-protocol",
    "github",
    "oauth",
    "copilot",
    "api"
  ],
  "author": "EvansGxz",
  "license": "MIT",
  "dependencies": {
    "axios": "^1.6.0",
    "dotenv": "^16.3.1",
    "express": "^4.18.2"
  },
  "devDependencies": {},
  "engines": {
    "node": ">=16.0.0",
    "npm": ">=8.0.0"
  },
  "repository": {
    "type": "git",
    "url": "https://github.com/EvansGxz/Whack-a-Mole.git"
  }
}
```

## 🔧 Ejemplo: Configuración VS Code (.vscode/settings.json)

```json
{
  "editor.formatOnSave": true,
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  
  "github.copilot.enable": {
    "*": true,
    "plaintext": false,
    "markdown": false
  },
  
  "mcp": {
    "enabled": true,
    "servers": {
      "github": {
        "enabled": true,
        "command": "node",
        "args": ["${workspaceFolder}/mcp-github-server/server.js"],
        "env": {
          "GITHUB_CLIENT_ID": "${env:GITHUB_CLIENT_ID}",
          "GITHUB_CLIENT_SECRET": "${env:GITHUB_CLIENT_SECRET}",
          "GITHUB_PERSONAL_TOKEN": "${env:GITHUB_PERSONAL_TOKEN}",
          "NODE_ENV": "development"
        }
      }
    }
  }
}
```

## 🔑 Paso a Paso: Obtener Credenciales

### Obtener Client ID y Client Secret

1. Ve a https://github.com/settings/developers
2. Haz clic en "New OAuth App"
3. Completa con:
   - **Application name**: Whack-a-Mole MCP for Copilot
   - **Homepage URL**: http://localhost:3000
   - **Authorization callback URL**: http://localhost:3000/callback
4. Copia el **Client ID**
5. Haz clic en "Generate a new client secret"
6. Copia el **Client Secret** (aparece solo una vez)

### Obtener Personal Token

1. Ve a https://github.com/settings/tokens
2. Haz clic en "Generate new token (classic)"
3. Dale un nombre: `Whack-a-Mole MCP`
4. Selecciona permisos:
   - ✅ `repo` (acceso completo a repositorios)
   - ✅ `read:issues`
   - ✅ `read:user`
   - ✅ `read:org`
5. Haz clic en "Generate token"
6. **Copia el token inmediatamente** (no se puede ver después)
7. Pégalo en `.env` como `GITHUB_PERSONAL_TOKEN`

## 🚀 Comandos Rápidos para Empezar

```bash
# 1. Crear carpeta del servidor
mkdir mcp-github-server
cd mcp-github-server

# 2. Inicializar npm
npm init -y

# 3. Instalar dependencias
npm install axios dotenv express

# 4. Crear archivos (copia el contenido de los ejemplos anteriores)
# - Crea: server.js
# - Crea: .env (con tus credenciales)
# - Crea: .gitignore
# - Crea: .envexample (sin credenciales)

# 5. Iniciar servidor
npm start

# 6. Verificar en otra terminal
curl http://localhost:3000/health

# 7. Probar obtener repositorios
curl http://localhost:3000/api/repos
```

## 📊 Ejemplo de Respuesta API

### GET /health

```json
{
  "status": "ok",
  "message": "MCP GitHub Server is running",
  "authenticated": true,
  "port": 3000
}
```

### GET /api/user

```json
{
  "login": "EvansGxz",
  "id": 123456789,
  "avatar_url": "https://avatars.githubusercontent.com/u/123456789?v=4",
  "name": "Tu Nombre",
  "company": "Tu Empresa",
  "blog": "tu-blog.com",
  "location": "Tu Ciudad",
  "email": "tu@email.com",
  "bio": "Tu biografía",
  "twitter_username": "tu_twitter",
  "public_repos": 25,
  "followers": 100,
  "following": 50
}
```

### GET /api/repos/EvansGxz/Whack-a-Mole/issues

```json
[
  {
    "id": 1234567890,
    "number": 1,
    "title": "Agregar niveles de dificultad",
    "body": "Implementar sistema de niveles progresivos",
    "state": "open",
    "created_at": "2024-02-03T10:00:00Z",
    "updated_at": "2024-02-03T10:00:00Z",
    "labels": [
      {
        "name": "enhancement",
        "color": "a2eeef"
      },
      {
        "name": "priority: high",
        "color": "ff6600"
      }
    ],
    "assignees": []
  }
]
```

## 🧪 Ejemplos de Prompts para Copilot

Una vez todo configurado, prueba estos prompts:

```
@github List all issues in my Whack-a-Mole repository

@github Show me the 5 most recent commits

@github Create an issue titled "Add leaderboard feature" 
with labels: enhancement, ui/ux

@github What pull requests do I have open?

@github Update issue #3 to add the "bug" label

@github Show me all issues labeled "priority: high"

@github Give me a summary of my GitHub activity
```

## 🔍 Variables Disponibles en Copilot

Con MCP configurado, puedes usar:

```javascript
// En prompts de Copilot
@github #owner/repo          // Selecciona un repositorio
@github #issue123            // Referencia a un issue
@github #pr456               // Referencia a un PR
@github #user:EvansGxz       // Información del usuario
```

## 📱 Integración con tu Workflow

Copilot puede ahora:

- 🔍 Buscar issues existentes
- ✍️ Crear nuevos issues
- 🏷️ Asignar etiquetas
- 👥 Asignar responsables
- 📝 Actualizar descripciones
- 🔗 Ver commits recientes
- 📊 Generar reportes de repositorio

## ⚙️ Solucionar Problemas Comunes

| Problema | Solución |
|----------|----------|
| Port 3000 en uso | Cambiar `MCP_PORT=3001` en `.env` |
| Token inválido | Crear nuevo token en https://github.com/settings/tokens |
| Copilot no ve server | Reiniciar VS Code y verificar `/health` |
| CORS errors | Configurar headers en `server.js` |
| Node no encontrado | Instalar desde https://nodejs.org |

## 📚 Próximos Pasos

1. ✅ Crear credenciales OAuth
2. ✅ Copiar archivos de ejemplo
3. ✅ Configurar `.env`
4. ✅ Instalar dependencias
5. ✅ Iniciar servidor
6. ✅ Configurar VS Code
7. ✅ Probar con prompts
8. ✅ Integrar en workflow

¡Listo! Ahora tienes MCP GitHub totalmente configurado. 🚀

Para más información, consulta la documentación completa en `MCP_GITHUB_SETUP.md`
