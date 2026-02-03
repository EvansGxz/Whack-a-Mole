#!/bin/bash

# Script de Setup Automático para MCP GitHub Server
# Uso: bash setup-mcp.sh

set -e

echo "================================"
echo "🚀 Setup MCP GitHub Server"
echo "================================"
echo ""

# Colores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Verificar Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ Node.js no está instalado${NC}"
    echo "   Descargalo en: https://nodejs.org/"
    exit 1
fi

echo -e "${GREEN}✅ Node.js encontrado: $(node --version)${NC}"
echo ""

# Crear directorio
echo -e "${BLUE}📁 Creando directorio mcp-github-server...${NC}"
mkdir -p mcp-github-server
cd mcp-github-server
echo -e "${GREEN}✅ Directorio creado${NC}"
echo ""

# Inicializar npm
if [ ! -f "package.json" ]; then
    echo -e "${BLUE}📦 Inicializando npm...${NC}"
    npm init -y > /dev/null 2>&1
    echo -e "${GREEN}✅ package.json creado${NC}"
else
    echo -e "${YELLOW}⚠️  package.json ya existe${NC}"
fi
echo ""

# Instalar dependencias
echo -e "${BLUE}📥 Instalando dependencias...${NC}"
npm install axios dotenv express > /dev/null 2>&1
echo -e "${GREEN}✅ Dependencias instaladas${NC}"
echo ""

# Crear .env
if [ ! -f ".env" ]; then
    echo -e "${BLUE}🔑 Creando archivo .env...${NC}"
    cat > .env << 'EOF'
# GitHub OAuth Credentials
GITHUB_CLIENT_ID=your_client_id_here
GITHUB_CLIENT_SECRET=your_client_secret_here
GITHUB_REDIRECT_URI=http://localhost:3000/callback

# GitHub Personal Token
GITHUB_PERSONAL_TOKEN=your_token_here

# Server Config
MCP_PORT=3000
NODE_ENV=development
EOF
    echo -e "${GREEN}✅ Archivo .env creado${NC}"
    echo -e "${YELLOW}⚠️  Reemplaza los valores con tus credenciales${NC}"
else
    echo -e "${YELLOW}⚠️  .env ya existe${NC}"
fi
echo ""

# Crear .gitignore
if [ ! -f ".gitignore" ]; then
    echo -e "${BLUE}🙈 Creando archivo .gitignore...${NC}"
    cat > .gitignore << 'EOF'
.env
.env.local
node_modules/
package-lock.json
*.log
.DS_Store
.idea/
.vscode/
EOF
    echo -e "${GREEN}✅ Archivo .gitignore creado${NC}"
else
    echo -e "${YELLOW}⚠️  .gitignore ya existe${NC}"
fi
echo ""

# Crear server.js
if [ ! -f "server.js" ]; then
    echo -e "${BLUE}⚙️  Creando archivo server.js...${NC}"
    cat > server.js << 'SERVEREOF'
const express = require('express');
const axios = require('axios');
require('dotenv').config();

const app = express();
app.use(express.json());

const GITHUB_CLIENT_ID = process.env.GITHUB_CLIENT_ID;
const GITHUB_CLIENT_SECRET = process.env.GITHUB_CLIENT_SECRET;
const GITHUB_REDIRECT_URI = process.env.GITHUB_REDIRECT_URI;
const GITHUB_TOKEN = process.env.GITHUB_PERSONAL_TOKEN;
const PORT = process.env.MCP_PORT || 3000;

let userAccessToken = null;

// OAuth Routes
app.get('/auth', (req, res) => {
  const authUrl = `https://github.com/login/oauth/authorize?client_id=${GITHUB_CLIENT_ID}&redirect_uri=${GITHUB_REDIRECT_URI}&scope=repo,read:issues,read:user`;
  res.redirect(authUrl);
});

app.get('/callback', async (req, res) => {
  const code = req.query.code;
  if (!code) return res.status(400).json({ error: 'No authorization code' });

  try {
    const response = await axios.post('https://github.com/login/oauth/access_token', {
      client_id: GITHUB_CLIENT_ID,
      client_secret: GITHUB_CLIENT_SECRET,
      code: code,
      redirect_uri: GITHUB_REDIRECT_URI
    }, {
      headers: { Accept: 'application/json' }
    });

    userAccessToken = response.data.access_token;
    res.json({ success: true, token: userAccessToken });
  } catch (error) {
    res.status(500).json({ error: 'Authentication failed' });
  }
});

// API Endpoints
app.get('/health', (req, res) => {
  res.json({
    status: 'ok',
    message: 'MCP GitHub Server is running',
    authenticated: !!userAccessToken || !!GITHUB_TOKEN,
    port: PORT
  });
});

app.get('/api/user', async (req, res) => {
  try {
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.get('https://api.github.com/user', {
      headers: { Authorization: `Bearer ${token}` }
    });
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch user' });
  }
});

app.get('/api/repos', async (req, res) => {
  try {
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.get('https://api.github.com/user/repos', {
      headers: { Authorization: `Bearer ${token}` },
      params: { type: 'all', sort: 'updated', per_page: 100 }
    });
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch repos' });
  }
});

app.get('/api/repos/:owner/:repo/issues', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.get(
      `https://api.github.com/repos/${owner}/${repo}/issues`,
      {
        headers: { Authorization: `Bearer ${token}` },
        params: { state: 'open', per_page: 50 }
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch issues' });
  }
});

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

app.get('/api/repos/:owner/:repo/pulls', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.get(
      `https://api.github.com/repos/${owner}/${repo}/pulls`,
      {
        headers: { Authorization: `Bearer ${token}` },
        params: { state: 'open', per_page: 50 }
      }
    );
    res.json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch PRs' });
  }
});

app.post('/api/repos/:owner/:repo/issues', async (req, res) => {
  try {
    const { owner, repo } = req.params;
    const { title, body, labels } = req.body;
    const token = userAccessToken || GITHUB_TOKEN;
    const response = await axios.post(
      `https://api.github.com/repos/${owner}/${repo}/issues`,
      { title, body, labels },
      { headers: { Authorization: `Bearer ${token}` } }
    );
    res.status(201).json(response.data);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create issue' });
  }
});

app.listen(PORT, () => {
  console.log(`🚀 MCP GitHub Server running on http://localhost:${PORT}`);
  console.log(`🔐 OAuth: http://localhost:${PORT}/auth`);
  console.log(`🔍 Health: http://localhost:${PORT}/health`);
});
SERVEREOF
    echo -e "${GREEN}✅ Archivo server.js creado${NC}"
else
    echo -e "${YELLOW}⚠️  server.js ya existe${NC}"
fi
echo ""

# Resultado final
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}✅ Setup completado!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo -e "${BLUE}📋 Próximos pasos:${NC}"
echo ""
echo -e "1. ${YELLOW}Edita el archivo .env:${NC}"
echo "   Reemplaza los valores con tus credenciales de GitHub"
echo ""
echo -e "2. ${YELLOW}Inicia el servidor:${NC}"
echo "   ${BLUE}npm start${NC}"
echo ""
echo -e "3. ${YELLOW}Verifica que funcione:${NC}"
echo "   ${BLUE}curl http://localhost:3000/health${NC}"
echo ""
echo -e "4. ${YELLOW}Configura VS Code${NC}"
echo "   Crea .vscode/settings.json con la configuración MCP"
echo ""
echo -e "${BLUE}📚 Para más información:${NC}"
echo "   Ver: MCP_GITHUB_SETUP.md"
echo ""
echo -e "${GREEN}¡Listo para empezar! 🚀${NC}"
