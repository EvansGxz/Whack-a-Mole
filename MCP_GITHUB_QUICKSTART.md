# 🔐 MCP GitHub - Guía Rápida de Implementación

## ¿Qué es MCP GitHub?

**MCP (Model Context Protocol)** es un protocolo que permite que **GitHub Copilot** acceda de forma segura a tus repositorios de GitHub sin necesidad de abrir la interfaz web.

Con MCP GitHub configurado, Copilot puede:
- 📋 Listar issues y pull requests
- ✍️ Crear y actualizar issues
- 🏷️ Asignar etiquetas y responsables
- 🔍 Buscar commits
- 📊 Analizar el repositorio

---

## ⚡ Inicio Rápido (5 minutos)

### 1️⃣ Crear Aplicación OAuth en GitHub

```
1. Ve a: https://github.com/settings/developers
2. Haz clic en "New OAuth App"
3. Completa:
   - Name: "Whack-a-Mole MCP"
   - Homepage URL: http://localhost:3000
   - Callback URL: http://localhost:3000/callback
4. Copia: Client ID y Client Secret
```

### 2️⃣ Crear Personal Token

```
1. Ve a: https://github.com/settings/tokens
2. Haz clic en "Generate new token (classic)"
3. Selecciona permisos: repo, read:issues, read:user
4. Copia el token (aparece solo una vez)
```

### 3️⃣ Crear Servidor MCP

```bash
# Crear carpeta
mkdir mcp-github-server
cd mcp-github-server

# Instalar dependencias
npm init -y
npm install axios dotenv express
```

### 4️⃣ Copiar Archivos

Copia estos archivos a la carpeta `mcp-github-server`:
- `server.js` (desde MCP_GITHUB_SETUP.md)
- `.env` (con tus credenciales)
- `.gitignore`
- `package.json`

### 5️⃣ Configurar `.env`

```env
GITHUB_CLIENT_ID=tu_client_id
GITHUB_CLIENT_SECRET=tu_client_secret
GITHUB_PERSONAL_TOKEN=tu_token_personal
GITHUB_REDIRECT_URI=http://localhost:3000/callback
MCP_PORT=3000
NODE_ENV=development
```

### 6️⃣ Iniciar Servidor

```bash
npm start
```

### 7️⃣ Verificar

```bash
curl http://localhost:3000/health
```

Deberías ver:
```json
{
  "status": "ok",
  "message": "MCP GitHub Server is running",
  "authenticated": true,
  "port": 3000
}
```

---

## 📚 Documentación Completa

| Archivo | Contenido |
|---------|----------|
| [MCP_GITHUB_SETUP.md](MCP_GITHUB_SETUP.md) | Guía detallada paso a paso |
| [MCP_GITHUB_CONFIG_EXAMPLE.md](MCP_GITHUB_CONFIG_EXAMPLE.md) | Ejemplos de archivos de configuración |
| [setup-mcp.sh](setup-mcp.sh) | Script automático de instalación |

---

## 🧪 Probar el Servidor

```bash
# Verificar que el servidor esté corriendo
curl http://localhost:3000/health

# Obtener información del usuario
curl http://localhost:3000/api/user

# Obtener repositorios
curl http://localhost:3000/api/repos

# Obtener issues
curl http://localhost:3000/api/repos/EvansGxz/Whack-a-Mole/issues

# Obtener etiquetas
curl http://localhost:3000/api/repos/EvansGxz/Whack-a-Mole/labels

# Obtener PRs
curl http://localhost:3000/api/repos/EvansGxz/Whack-a-Mole/pulls
```

---

## 🎯 Usar Copilot con MCP

Una vez configurado, en VS Code puedes usar:

```
@github List all open issues in EvansGxz/Whack-a-Mole

@github Create a new issue titled "Add power-ups"
with labels: enhancement, gameplay

@github Show me the last 10 commits

@github What issues are labeled "bug"?

@github Update issue #5 to add label "priority:high"
```

---

## 📁 Estructura Final

```
tu-proyecto/
├── Creado/
│   ├── golpea-al-topo.html
│   ├── GITHUB_ISSUES_LABELS.md
│   ├── ISSUE_TEMPLATES.md
│   ├── MCP_GITHUB_SETUP.md
│   ├── MCP_GITHUB_CONFIG_EXAMPLE.md
│   ├── MCP_GITHUB_QUICKSTART.md (este archivo)
│   └── setup-mcp.sh
│
└── mcp-github-server/  ← Crear esta carpeta
    ├── server.js
    ├── package.json
    ├── .env (secreto - no pushear)
    ├── .gitignore
    └── node_modules/
```

---

## 🔐 Seguridad

### ✅ Hacer

- ✅ Usar `.env` para credenciales
- ✅ Agregar `.env` a `.gitignore`
- ✅ Usar HTTPS en producción
- ✅ Rotar tokens regularmente
- ✅ Usar scopes mínimos

### ❌ No Hacer

- ❌ Commitear `.env`
- ❌ Compartir Client Secret
- ❌ Usar HTTP en producción
- ❌ Permisos innecesarios
- ❌ Hardcodear credenciales

---

## 🚀 Desplegar a Producción

Si quieres desplegar el servidor:

```
Variables de Entorno:
- GITHUB_CLIENT_ID
- GITHUB_CLIENT_SECRET
- GITHUB_REDIRECT_URI (cambiar a tu dominio)
- GITHUB_PERSONAL_TOKEN
- NODE_ENV=production

Comando: npm start

URL base: https://tudominio.com
Health check: https://tudominio.com/health
```

Opciones de hosting gratuito:
- [Railway.app](https://railway.app)
- [Render.com](https://render.com)
- [Fly.io](https://fly.io)
- [Replit](https://replit.com)

---

## 🐛 Solucionar Problemas

| Problema | Solución |
|----------|----------|
| "Port 3000 en uso" | Cambiar `MCP_PORT=3001` en `.env` |
| "Token inválido" | Crear nuevo token en https://github.com/settings/tokens |
| "Copilot no detecta" | Reiniciar VS Code, verificar `/health` |
| "CORS error" | Verificar configuración en `server.js` |
| "Node no encontrado" | Instalar desde https://nodejs.org |

---

## 📞 Endpoints Disponibles

### Autenticación
- `GET /auth` - Iniciar OAuth flow
- `GET /callback` - Callback de OAuth

### Usuario
- `GET /api/user` - Información del usuario

### Repositorios
- `GET /api/repos` - Listar repositorios
- `GET /api/repos/:owner/:repo` - Obtener repositorio

### Issues
- `GET /api/repos/:owner/:repo/issues` - Listar issues
- `POST /api/repos/:owner/:repo/issues` - Crear issue
- `PATCH /api/repos/:owner/:repo/issues/:number` - Actualizar issue

### Labels
- `GET /api/repos/:owner/:repo/labels` - Listar etiquetas

### Pull Requests
- `GET /api/repos/:owner/:repo/pulls` - Listar PRs

### Commits
- `GET /api/repos/:owner/:repo/commits` - Listar commits

### Health
- `GET /health` - Estado del servidor

---

## 📖 Referencias

- [Documentación OAuth GitHub](https://docs.github.com/en/developers/apps/building-oauth-apps)
- [GitHub API REST](https://docs.github.com/en/rest)
- [Model Context Protocol](https://modelcontextprotocol.io/)
- [GitHub Copilot Documentation](https://github.com/features/copilot)

---

## ✅ Checklist Completo

- [ ] Crear OAuth App en GitHub
- [ ] Generar Personal Token
- [ ] Crear carpeta `mcp-github-server`
- [ ] Instalar dependencias con `npm install`
- [ ] Crear archivos de configuración
- [ ] Llenar `.env` con credenciales
- [ ] Iniciar servidor con `npm start`
- [ ] Verificar `/health` endpoint
- [ ] Configurar VS Code
- [ ] Instalar Copilot Chat
- [ ] Probar prompts con `@github`
- [ ] Agregar `.env` a `.gitignore`
- [ ] Hacer commit de código

---

## 🎉 ¡Listo!

Ahora tu repositorio de GitHub está completamente integrado con Copilot mediante MCP.

Puedes:
- Usar Copilot para gestionar issues
- Crear PRs automáticamente
- Buscar información del repositorio
- Automatizar tareas de GitHub

**Próximos pasos:**
1. Lee [MCP_GITHUB_SETUP.md](MCP_GITHUB_SETUP.md) para más detalles
2. Explora los endpoints de API
3. Crea automaciones con Copilot

¡Que disfrutes! 🚀

---

**Preguntas o problemas?** Consulta la documentación completa en los archivos markdown o abre un issue en GitHub.

Contribuidor: @EvansGxz
Último actualizado: 2024-02-03
