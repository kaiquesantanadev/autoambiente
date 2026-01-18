#!/bin/bash

#######################################################
# Script de Configuração do Ambiente de Desenvolvimento
# Ubuntu 24.04
# Autor: AutoAmbiente - MADE BY KAIQUERAS
# Data: 2026-01-14
#######################################################

set -e  # Para em caso de erro

# Cores para log
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # Sem cor

# Função de log
log_info() {
    echo -e "${BLUE}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_step() {
    echo -e "${MAGENTA}[STEP]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Variáveis
BASE_DIR="/opt/dev"
USER_OWNER="${SUDO_USER:-$USER}"
USER_HOME=$(getent passwd "${USER_OWNER}" | cut -d: -f6)

# URLs de Download (Versões mais recentes)
VSCODE_URL="https://update.code.visualstudio.com/latest/linux-x64/stable"
NODE_VERSION="v24.13.0"
NODE_URL="https://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.xz"
K9S_VERSION="v0.50.18"
K9S_URL="https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz"
POSTMAN_URL="https://dl.pstmn.io/download/latest/linux_64"
ANTIGRAVITY_URL="https://antigravity.google/download/linux"
ANDROID_STUDIO_URL="https://redirector.gvt1.com/edgedl/android/studio/ide-zips/2025.2.2.8/android-studio-2025.2.2.8-linux.tar.gz"
DBEAVER_VERSION="24.3.4"
DBEAVER_URL="https://github.com/dbeaver/dbeaver/releases/download/${DBEAVER_VERSION}/dbeaver-ce-${DBEAVER_VERSION}-linux.gtk.x86_64.tar.gz"

echo ""
echo "╔═══════════════════════════════════════════════════════════════════════════════╗"
echo "║   CONFIGURAÇÃO DE AMBIENTE DE DESENVOLVIMENTO - UBUNTU - MADE BY KAIQUERAS    ║"
echo "╚═══════════════════════════════════════════════════════════════════════════════╝"
echo ""

# Verificar se está rodando como root
if [[ $EUID -ne 0 ]]; then
   log_error "Este script precisa ser executado como root (sudo)"
   exit 1
fi

log_info "Usuário identificado: ${USER_OWNER}"
log_info "Home do usuário: ${USER_HOME}"

#######################################################
# ETAPA 1: Criar estrutura de diretórios
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 1: Criando estrutura de diretórios..."
log_step "═══════════════════════════════════════════"

DIRS=("ide" "projects" "tools" "node" "flutter")

# Criar diretório base
if [ ! -d "$BASE_DIR" ]; then
    log_info "Criando diretório base: ${BASE_DIR}"
    mkdir -p "$BASE_DIR"
    log_success "Diretório base criado: ${BASE_DIR}"
else
    log_warning "Diretório base já existe: ${BASE_DIR}"
fi

# Criar subdiretórios
for dir in "${DIRS[@]}"; do
    FULL_PATH="${BASE_DIR}/${dir}"
    if [ ! -d "$FULL_PATH" ]; then
        log_info "Criando subdiretório: ${FULL_PATH}"
        mkdir -p "$FULL_PATH"
        log_success "Subdiretório criado: ${FULL_PATH}"
    else
        log_warning "Subdiretório já existe: ${FULL_PATH}"
    fi
done

# Criar pasta vscode dentro de ide
VSCODE_DIR="${BASE_DIR}/ide/vscode"
if [ ! -d "$VSCODE_DIR" ]; then
    log_info "Criando diretório do VSCode: ${VSCODE_DIR}"
    mkdir -p "$VSCODE_DIR"
    log_success "Diretório do VSCode criado: ${VSCODE_DIR}"
else
    log_warning "Diretório do VSCode já existe: ${VSCODE_DIR}"
fi

# Criar pasta antigravity dentro de ide
ANTIGRAVITY_DIR="${BASE_DIR}/ide/antigravity"
if [ ! -d "$ANTIGRAVITY_DIR" ]; then
    log_info "Criando diretório do Antigravity: ${ANTIGRAVITY_DIR}"
    mkdir -p "$ANTIGRAVITY_DIR"
    log_success "Diretório do Antigravity criado: ${ANTIGRAVITY_DIR}"
else
    log_warning "Diretório do Antigravity já existe: ${ANTIGRAVITY_DIR}"
fi

# Criar pasta postman dentro de ide
POSTMAN_DIR="${BASE_DIR}/ide/postman"
if [ ! -d "$POSTMAN_DIR" ]; then
    log_info "Criando diretório do Postman: ${POSTMAN_DIR}"
    mkdir -p "$POSTMAN_DIR"
    log_success "Diretório do Postman criado: ${POSTMAN_DIR}"
else
    log_warning "Diretório do Postman já existe: ${POSTMAN_DIR}"
fi

# Criar pasta android_studio dentro de ide
ANDROID_STUDIO_DIR="${BASE_DIR}/ide/android_studio"
if [ ! -d "$ANDROID_STUDIO_DIR" ]; then
    log_info "Criando diretório do Android Studio: ${ANDROID_STUDIO_DIR}"
    mkdir -p "$ANDROID_STUDIO_DIR"
    log_success "Diretório do Android Studio criado: ${ANDROID_STUDIO_DIR}"
else
    log_warning "Diretório do Android Studio já existe: ${ANDROID_STUDIO_DIR}"
fi

# Criar pasta dbeaver
DBEAVER_DIR="${BASE_DIR}/dbeaver"
if [ ! -d "$DBEAVER_DIR" ]; then
    log_info "Criando diretório do DBeaver: ${DBEAVER_DIR}"
    mkdir -p "$DBEAVER_DIR"
    log_success "Diretório do DBeaver criado: ${DBEAVER_DIR}"
else
    log_warning "Diretório do DBeaver já existe: ${DBEAVER_DIR}"
fi

# Criar pasta k9s dentro de tools
K9S_DIR="${BASE_DIR}/tools/k9s"
if [ ! -d "$K9S_DIR" ]; then
    log_info "Criando diretório do k9s: ${K9S_DIR}"
    mkdir -p "$K9S_DIR"
    log_success "Diretório do k9s criado: ${K9S_DIR}"
else
    log_warning "Diretório do k9s já existe: ${K9S_DIR}"
fi

# Alterar proprietário de toda a estrutura
log_info "Alterando proprietário de ${BASE_DIR} para ${USER_OWNER}..."
chown -R "${USER_OWNER}:${USER_OWNER}" "$BASE_DIR"
log_success "Proprietário alterado para: ${USER_OWNER}"

#######################################################
# ETAPA 2: Baixar e instalar VS Code
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 2: Baixando VS Code..."
log_step "═══════════════════════════════════════════"

VSCODE_TAR="${BASE_DIR}/ide/vscode-linux-x64.tar.gz"

if [ -f "${VSCODE_DIR}/bin/code" ]; then
    log_warning "VS Code já está instalado em: ${VSCODE_DIR}"
    log_info "Pulando download do VS Code..."
else
    log_info "Baixando VS Code de: ${VSCODE_URL}"
    log_info "Destino: ${VSCODE_TAR}"
    
    wget -q --show-progress -O "$VSCODE_TAR" "$VSCODE_URL"
    
    if [ $? -eq 0 ]; then
        log_success "VS Code baixado com sucesso!"
        
        log_info "Extraindo VS Code para: ${VSCODE_DIR}"
        tar -xzf "$VSCODE_TAR" -C "${BASE_DIR}/ide/"
        
        if [ -d "${BASE_DIR}/ide/VSCode-linux-x64" ]; then
            log_info "Movendo arquivos para pasta vscode..."
            mv "${BASE_DIR}/ide/VSCode-linux-x64"/* "${VSCODE_DIR}/"
            rmdir "${BASE_DIR}/ide/VSCode-linux-x64"
        fi
        
        log_success "VS Code extraído com sucesso!"
        
        log_info "Removendo arquivo temporário: ${VSCODE_TAR}"
        rm -f "$VSCODE_TAR"
        log_success "Arquivo temporário removido."
    else
        log_error "Falha ao baixar o VS Code!"
        exit 1
    fi
fi

#######################################################
# ETAPA 3: Baixar e instalar Node.js
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 3: Baixando Node.js ${NODE_VERSION} LTS..."
log_step "═══════════════════════════════════════════"

NODE_DIR="${BASE_DIR}/node"
NODE_TAR="${NODE_DIR}/node-${NODE_VERSION}-linux-x64.tar.xz"

if [ -f "${NODE_DIR}/bin/node" ]; then
    log_warning "Node.js já está instalado em: ${NODE_DIR}"
    log_info "Pulando download do Node.js..."
else
    log_info "Baixando Node.js de: ${NODE_URL}"
    log_info "Destino: ${NODE_TAR}"
    
    wget -q --show-progress -O "$NODE_TAR" "$NODE_URL"
    
    if [ $? -eq 0 ]; then
        log_success "Node.js baixado com sucesso!"
        
        log_info "Extraindo Node.js para: ${NODE_DIR}"
        tar -xJf "$NODE_TAR" -C "${NODE_DIR}" --strip-components=1
        
        log_success "Node.js extraído com sucesso!"
        
        log_info "Removendo arquivo temporário: ${NODE_TAR}"
        rm -f "$NODE_TAR"
        log_success "Arquivo temporário removido."
    else
        log_error "Falha ao baixar o Node.js!"
        exit 1
    fi
fi

#######################################################
# ETAPA 4: Instalar Docker (Documentação Oficial)
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 4: Instalando Docker..."
log_step "═══════════════════════════════════════════"

if command -v docker &> /dev/null; then
    log_warning "Docker já está instalado."
    docker --version
else
    log_info "Removendo versões antigas do Docker (se existirem)..."
    apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
    
    log_info "Instalando dependências do Docker..."
    apt-get update
    apt-get install -y ca-certificates curl gnupg
    
    log_info "Adicionando chave GPG oficial do Docker..."
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    
    log_info "Adicionando repositório do Docker..."
    tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Signed-By: /etc/apt/keyrings/docker.asc
EOF
    
    log_info "Atualizando repositórios..."
    apt-get update
    
    log_info "Instalando Docker Engine..."
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    log_success "Docker instalado com sucesso!"
    
    # Configurar Docker para rodar sem sudo
    log_info "Configurando Docker para rodar sem sudo..."
    if ! getent group docker > /dev/null; then
        groupadd docker
    fi
    usermod -aG docker "${USER_OWNER}"
    log_success "Usuário ${USER_OWNER} adicionado ao grupo docker."
    log_warning "ATENÇÃO: Faça logout/login ou execute 'newgrp docker' para aplicar as permissões."
fi

#######################################################
# ETAPA 5: Instalar kubectl
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 5: Instalando kubectl..."
log_step "═══════════════════════════════════════════"

if command -v kubectl &> /dev/null; then
    log_warning "kubectl já está instalado."
    kubectl version --client --short 2>/dev/null || kubectl version --client 2>/dev/null || true
else
    log_info "Instalando dependências do kubectl..."
    apt-get update
    apt-get install -y apt-transport-https ca-certificates curl gnupg
    
    log_info "Adicionando chave GPG do Kubernetes..."
    mkdir -p /etc/apt/keyrings
    curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    
    log_info "Adicionando repositório do Kubernetes..."
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | tee /etc/apt/sources.list.d/kubernetes.list
    chmod 644 /etc/apt/sources.list.d/kubernetes.list
    
    log_info "Atualizando repositórios..."
    apt-get update
    
    log_info "Instalando kubectl..."
    apt-get install -y kubectl
    
    log_success "kubectl instalado com sucesso!"
fi

#######################################################
# ETAPA 6: Instalar minikube
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 6: Instalando minikube..."
log_step "═══════════════════════════════════════════"

if command -v minikube &> /dev/null; then
    log_warning "minikube já está instalado."
    minikube version
else
    log_info "Baixando minikube..."
    curl -LO https://github.com/kubernetes/minikube/releases/latest/download/minikube-linux-amd64
    
    log_info "Instalando minikube em /usr/local/bin..."
    install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64
    
    log_success "minikube instalado com sucesso!"
fi

#######################################################
# ETAPA 7: Instalar k9s
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 7: Instalando k9s ${K9S_VERSION}..."
log_step "═══════════════════════════════════════════"

K9S_TAR="${K9S_DIR}/k9s_Linux_amd64.tar.gz"

if [ -f "${K9S_DIR}/k9s" ]; then
    log_warning "k9s já está instalado em: ${K9S_DIR}"
else
    log_info "Baixando k9s de: ${K9S_URL}"
    wget -q --show-progress -O "$K9S_TAR" "$K9S_URL"
    
    if [ $? -eq 0 ]; then
        log_success "k9s baixado com sucesso!"
        
        log_info "Extraindo k9s para: ${K9S_DIR}"
        tar -xzf "$K9S_TAR" -C "${K9S_DIR}"
        
        log_success "k9s extraído com sucesso!"
        
        log_info "Removendo arquivo temporário..."
        rm -f "$K9S_TAR"
        
        # Criar link simbólico para /usr/local/bin
        ln -sf "${K9S_DIR}/k9s" /usr/local/bin/k9s
        log_success "Link simbólico criado: /usr/local/bin/k9s"
    else
        log_error "Falha ao baixar o k9s!"
    fi
fi

#######################################################
# ETAPA 8: Instalar Postman
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 8: Instalando Postman..."
log_step "═══════════════════════════════════════════"

POSTMAN_TAR="${BASE_DIR}/ide/postman-linux-x64.tar.gz"

if [ -f "${POSTMAN_DIR}/Postman" ] || [ -f "${POSTMAN_DIR}/app/Postman" ]; then
    log_warning "Postman já está instalado em: ${POSTMAN_DIR}"
else
    log_info "Baixando Postman de: ${POSTMAN_URL}"
    wget -q --show-progress -O "$POSTMAN_TAR" "$POSTMAN_URL"
    
    if [ $? -eq 0 ]; then
        log_success "Postman baixado com sucesso!"
        
        log_info "Extraindo Postman para: ${POSTMAN_DIR}"
        tar -xzf "$POSTMAN_TAR" -C "${BASE_DIR}/ide/"
        
        # O Postman extrai para uma pasta chamada "Postman"
        if [ -d "${BASE_DIR}/ide/Postman" ]; then
            log_info "Movendo arquivos para pasta postman..."
            mv "${BASE_DIR}/ide/Postman"/* "${POSTMAN_DIR}/"
            rmdir "${BASE_DIR}/ide/Postman"
        fi
        
        log_success "Postman extraído com sucesso!"
        
        log_info "Removendo arquivo temporário..."
        rm -f "$POSTMAN_TAR"
    else
        log_error "Falha ao baixar o Postman!"
    fi
fi

#######################################################
# ETAPA 9: Instalar Antigravity IDE
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 9: Instalando Antigravity IDE..."
log_step "═══════════════════════════════════════════"

ANTIGRAVITY_TAR="${BASE_DIR}/ide/antigravity-linux.tar.gz"

if [ -f "${ANTIGRAVITY_DIR}/antigravity" ] || [ -f "${ANTIGRAVITY_DIR}/Antigravity" ]; then
    log_warning "Antigravity já está instalado em: ${ANTIGRAVITY_DIR}"
else
    log_info "Baixando Antigravity de: ${ANTIGRAVITY_URL}"
    wget -q --show-progress -O "$ANTIGRAVITY_TAR" "$ANTIGRAVITY_URL" || {
        log_warning "Download direto falhou. Tentando método alternativo..."
        curl -L -o "$ANTIGRAVITY_TAR" "$ANTIGRAVITY_URL" || {
            log_error "Falha ao baixar Antigravity. Por favor, baixe manualmente de: ${ANTIGRAVITY_URL}"
        }
    }
    
    if [ -f "$ANTIGRAVITY_TAR" ] && [ -s "$ANTIGRAVITY_TAR" ]; then
        log_success "Antigravity baixado com sucesso!"
        
        log_info "Extraindo Antigravity para: ${ANTIGRAVITY_DIR}"
        tar -xzf "$ANTIGRAVITY_TAR" -C "${ANTIGRAVITY_DIR}" --strip-components=1 2>/dev/null || \
        tar -xzf "$ANTIGRAVITY_TAR" -C "${ANTIGRAVITY_DIR}" 2>/dev/null || \
        tar -xf "$ANTIGRAVITY_TAR" -C "${ANTIGRAVITY_DIR}" 2>/dev/null || {
            # Se não for tar.gz, pode ser outro formato
            log_warning "Formato de arquivo não reconhecido. Movendo arquivo para pasta de destino..."
            mv "$ANTIGRAVITY_TAR" "${ANTIGRAVITY_DIR}/antigravity-installer"
            chmod +x "${ANTIGRAVITY_DIR}/antigravity-installer"
        }
        
        log_success "Antigravity extraído com sucesso!"
        
        # Limpar arquivo temporário se ainda existir
        rm -f "$ANTIGRAVITY_TAR" 2>/dev/null || true
    else
        log_warning "Arquivo do Antigravity não encontrado ou vazio."
        log_info "Por favor, baixe manualmente de: ${ANTIGRAVITY_URL}"
    fi
fi

#######################################################
# ETAPA 10: Instalar Android Studio
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 10: Instalando Android Studio..."
log_step "═══════════════════════════════════════════"

ANDROID_STUDIO_TAR="${BASE_DIR}/ide/android-studio-linux.tar.gz"

if [ -f "${ANDROID_STUDIO_DIR}/bin/studio.sh" ]; then
    log_warning "Android Studio já está instalado em: ${ANDROID_STUDIO_DIR}"
else
    log_info "Baixando Android Studio de: ${ANDROID_STUDIO_URL}"
    wget -q --show-progress -O "$ANDROID_STUDIO_TAR" "$ANDROID_STUDIO_URL"
    
    if [ $? -eq 0 ]; then
        log_success "Android Studio baixado com sucesso!"
        
        log_info "Extraindo Android Studio para: ${ANDROID_STUDIO_DIR}"
        tar -xzf "$ANDROID_STUDIO_TAR" -C "${BASE_DIR}/ide/"
        
        # O Android Studio extrai para uma pasta chamada "android-studio"
        if [ -d "${BASE_DIR}/ide/android-studio" ]; then
            log_info "Movendo arquivos para pasta android_studio..."
            mv "${BASE_DIR}/ide/android-studio"/* "${ANDROID_STUDIO_DIR}/"
            rmdir "${BASE_DIR}/ide/android-studio"
        fi
        
        log_success "Android Studio extraído com sucesso!"
        
        log_info "Removendo arquivo temporário..."
        rm -f "$ANDROID_STUDIO_TAR"
    else
        log_error "Falha ao baixar o Android Studio!"
    fi
fi

#######################################################
# ETAPA 10.5: Instalar DBeaver Community Edition
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 10.5: Instalando DBeaver Community Edition ${DBEAVER_VERSION} LTS..."
log_step "═══════════════════════════════════════════"

DBEAVER_TAR="${BASE_DIR}/dbeaver-linux.tar.gz"

if [ -f "${DBEAVER_DIR}/dbeaver" ]; then
    log_warning "DBeaver já está instalado em: ${DBEAVER_DIR}"
else
    log_info "Baixando DBeaver de: ${DBEAVER_URL}"
    wget -q --show-progress -O "$DBEAVER_TAR" "$DBEAVER_URL"
    
    if [ $? -eq 0 ]; then
        log_success "DBeaver baixado com sucesso!"
        
        log_info "Extraindo DBeaver para: ${DBEAVER_DIR}"
        tar -xzf "$DBEAVER_TAR" -C "${BASE_DIR}/"
        
        # O DBeaver extrai para uma pasta chamada "dbeaver"
        if [ -d "${BASE_DIR}/dbeaver" ] && [ ! -f "${DBEAVER_DIR}/dbeaver" ]; then
            # Se extraiu para outra pasta, mover arquivos
            if [ -d "${BASE_DIR}/dbeaver" ] && [ -f "${BASE_DIR}/dbeaver/dbeaver" ]; then
                log_info "DBeaver extraído diretamente para pasta correta."
            fi
        fi
        
        log_success "DBeaver extraído com sucesso!"
        
        log_info "Removendo arquivo temporário..."
        rm -f "$DBEAVER_TAR"
    else
        log_error "Falha ao baixar o DBeaver!"
    fi
fi

#######################################################
# ETAPA 11: Criar ícones .desktop
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 11: Criando ícones .desktop..."
log_step "═══════════════════════════════════════════"

DESKTOP_DIR="${USER_HOME}/.local/share/applications"
mkdir -p "$DESKTOP_DIR"

# Ícone do VS Code
log_info "Criando ícone do VS Code..."
cat > "${DESKTOP_DIR}/vscode.desktop" << EOF
[Desktop Entry]
Name=Visual Studio Code
Comment=Code Editing. Redefined.
GenericName=Text Editor
Exec=${VSCODE_DIR}/bin/code --no-sandbox --unity-launch %F
Icon=${VSCODE_DIR}/resources/app/resources/linux/code.png
Type=Application
StartupNotify=true
StartupWMClass=Code
Categories=Development;IDE;TextEditor;
MimeType=text/plain;application/x-code-workspace;
Actions=new-empty-window;
Keywords=vscode;

[Desktop Action new-empty-window]
Name=New Empty Window
Exec=${VSCODE_DIR}/bin/code --no-sandbox --new-window %F
Icon=${VSCODE_DIR}/resources/app/resources/linux/code.png
EOF
chmod +x "${DESKTOP_DIR}/vscode.desktop"
log_success "Ícone do VS Code criado: ${DESKTOP_DIR}/vscode.desktop"

# Ícone do Postman
log_info "Criando ícone do Postman..."
POSTMAN_ICON="${POSTMAN_DIR}/app/resources/app/assets/icon.png"
POSTMAN_EXEC="${POSTMAN_DIR}/Postman"

# Verificar localização do executável do Postman
if [ -f "${POSTMAN_DIR}/app/Postman" ]; then
    POSTMAN_EXEC="${POSTMAN_DIR}/app/Postman"
fi

cat > "${DESKTOP_DIR}/postman.desktop" << EOF
[Desktop Entry]
Name=Postman
Comment=API Development Environment
GenericName=API Client
Exec=${POSTMAN_EXEC} %U
Icon=${POSTMAN_ICON}
Type=Application
StartupNotify=true
StartupWMClass=Postman
Categories=Development;Network;
Keywords=api;rest;http;graphql;
EOF
chmod +x "${DESKTOP_DIR}/postman.desktop"
log_success "Ícone do Postman criado: ${DESKTOP_DIR}/postman.desktop"

# Ícone do Antigravity
log_info "Criando ícone do Antigravity..."

# Tentar encontrar o executável e ícone do Antigravity
ANTIGRAVITY_EXEC="${ANTIGRAVITY_DIR}/antigravity"
ANTIGRAVITY_ICON="${ANTIGRAVITY_DIR}/resources/app/resources/linux/antigravity.png"

if [ -f "${ANTIGRAVITY_DIR}/Antigravity" ]; then
    ANTIGRAVITY_EXEC="${ANTIGRAVITY_DIR}/Antigravity"
fi

# Fallback para ícone se não existir
if [ ! -f "$ANTIGRAVITY_ICON" ]; then
    ANTIGRAVITY_ICON="${ANTIGRAVITY_DIR}/icon.png"
fi

cat > "${DESKTOP_DIR}/antigravity.desktop" << EOF
[Desktop Entry]
Name=Antigravity IDE
Comment=Advanced AI Coding Assistant by Google DeepMind
GenericName=Code Editor
Exec=${ANTIGRAVITY_EXEC} --no-sandbox %F
Icon=${ANTIGRAVITY_ICON}
Type=Application
StartupNotify=true
StartupWMClass=Antigravity
Categories=Development;IDE;TextEditor;
Keywords=antigravity;ai;coding;google;
EOF
chmod +x "${DESKTOP_DIR}/antigravity.desktop"
log_success "Ícone do Antigravity criado: ${DESKTOP_DIR}/antigravity.desktop"

# Ícone do Android Studio
log_info "Criando ícone do Android Studio..."
cat > "${DESKTOP_DIR}/android-studio.desktop" << EOF
[Desktop Entry]
Name=Android Studio
Comment=The Official IDE for Android
GenericName=Android IDE
Exec=${ANDROID_STUDIO_DIR}/bin/studio.sh %f
Icon=${ANDROID_STUDIO_DIR}/bin/studio.svg
Type=Application
StartupNotify=true
StartupWMClass=jetbrains-studio
Categories=Development;IDE;
Keywords=android;studio;ide;jetbrains;
EOF
chmod +x "${DESKTOP_DIR}/android-studio.desktop"
log_success "Ícone do Android Studio criado: ${DESKTOP_DIR}/android-studio.desktop"

# Ícone do DBeaver
log_info "Criando ícone do DBeaver..."
cat > "${DESKTOP_DIR}/dbeaver.desktop" << EOF
[Desktop Entry]
Name=DBeaver Community
Comment=Universal Database Tool
GenericName=Database Client
Exec=${DBEAVER_DIR}/dbeaver %U
Icon=${DBEAVER_DIR}/dbeaver.png
Type=Application
StartupNotify=true
StartupWMClass=DBeaver
Categories=Development;Database;IDE;
Keywords=database;sql;mysql;postgresql;oracle;mongodb;
EOF
chmod +x "${DESKTOP_DIR}/dbeaver.desktop"
log_success "Ícone do DBeaver criado: ${DESKTOP_DIR}/dbeaver.desktop"

# Atualizar cache de ícones
log_info "Atualizando cache de ícones..."
chown -R "${USER_OWNER}:${USER_OWNER}" "$DESKTOP_DIR"
update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
log_success "Cache de ícones atualizado."

#######################################################
# ETAPA 11.5: Instalar Zsh + Oh My Zsh + Plugins
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 11.5: Instalando Zsh + Oh My Zsh + Plugins..."
log_step "═══════════════════════════════════════════"

ZSH_CUSTOM="${USER_HOME}/.oh-my-zsh/custom"

# Instalar Zsh via apt
if command -v zsh &> /dev/null; then
    log_warning "Zsh já está instalado."
    zsh --version
else
    log_info "Instalando Zsh via apt..."
    apt-get update
    apt-get install -y zsh
    log_success "Zsh instalado com sucesso!"
fi

# Instalar Oh My Zsh
if [ -d "${USER_HOME}/.oh-my-zsh" ]; then
    log_warning "Oh My Zsh já está instalado em: ${USER_HOME}/.oh-my-zsh"
else
    log_info "Instalando Oh My Zsh para o usuário ${USER_OWNER}..."
    
    # Instalar Oh My Zsh sem mudar o shell automaticamente (RUNZSH=no) e sem interação (--unattended)
    sudo -u "${USER_OWNER}" bash -c 'RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
    
    if [ -d "${USER_HOME}/.oh-my-zsh" ]; then
        log_success "Oh My Zsh instalado com sucesso!"
    else
        log_error "Falha ao instalar Oh My Zsh!"
    fi
fi

# Instalar plugin zsh-syntax-highlighting
ZSH_SYNTAX_DIR="${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
if [ -d "$ZSH_SYNTAX_DIR" ]; then
    log_warning "Plugin zsh-syntax-highlighting já está instalado."
else
    log_info "Instalando plugin zsh-syntax-highlighting..."
    sudo -u "${USER_OWNER}" git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_SYNTAX_DIR"
    log_success "Plugin zsh-syntax-highlighting instalado!"
fi

# Instalar plugin zsh-autosuggestions
ZSH_AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
if [ -d "$ZSH_AUTOSUGGESTIONS_DIR" ]; then
    log_warning "Plugin zsh-autosuggestions já está instalado."
else
    log_info "Instalando plugin zsh-autosuggestions..."
    sudo -u "${USER_OWNER}" git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_AUTOSUGGESTIONS_DIR"
    log_success "Plugin zsh-autosuggestions instalado!"
fi

# Configurar plugins no .zshrc
ZSHRC="${USER_HOME}/.zshrc"
if [ -f "$ZSHRC" ]; then
    log_info "Configurando plugins no .zshrc..."
    
    # Verificar se os plugins já estão configurados
    if grep -q "zsh-syntax-highlighting" "$ZSHRC" && grep -q "zsh-autosuggestions" "$ZSHRC"; then
        log_warning "Plugins já estão configurados no .zshrc"
    else
        # Fazer backup do .zshrc original
        cp "$ZSHRC" "${ZSHRC}.backup"
        
        # Atualizar a linha de plugins
        # Procura por plugins=(git) ou plugins=(algo) e adiciona os novos plugins
        if grep -q "^plugins=(" "$ZSHRC"; then
            sed -i 's/^plugins=(\(.*\))/plugins=(\1 zsh-syntax-highlighting zsh-autosuggestions)/' "$ZSHRC"
            # Limpar plugins duplicados (git git -> git)
            sed -i 's/plugins=(\(.*\)git\(.*\)git\(.*\))/plugins=(\1git\2\3)/' "$ZSHRC"
        else
            echo 'plugins=(git zsh-syntax-highlighting zsh-autosuggestions)' >> "$ZSHRC"
        fi
        
        log_success "Plugins configurados no .zshrc!"
    fi
    
    # Adicionar source do env.sh ao .zshrc se não existir
    if ! grep -q "source /opt/dev/env.sh" "$ZSHRC"; then
        log_info "Adicionando source do env.sh ao .zshrc..."
        echo '' >> "$ZSHRC"
        echo '# Ambiente de desenvolvimento' >> "$ZSHRC"
        echo 'source /opt/dev/env.sh' >> "$ZSHRC"
        log_success "env.sh adicionado ao .zshrc!"
    fi
    
    # Adicionar source do SDKMAN ao .zshrc se não existir
    if ! grep -q "sdkman-init.sh" "$ZSHRC"; then
        log_info "Adicionando SDKMAN ao .zshrc..."
        echo '' >> "$ZSHRC"
        echo '# SDKMAN' >> "$ZSHRC"
        echo '[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"' >> "$ZSHRC"
        log_success "SDKMAN adicionado ao .zshrc!"
    fi
    
    chown "${USER_OWNER}:${USER_OWNER}" "$ZSHRC"
else
    log_warning ".zshrc não encontrado. Oh My Zsh pode não ter sido instalado corretamente."
fi

# Definir Zsh como shell padrão
log_info "Definindo Zsh como shell padrão para ${USER_OWNER}..."
chsh -s "$(which zsh)" "${USER_OWNER}"
log_success "Zsh definido como shell padrão!"

#######################################################
# ETAPA 12: Instalar SDKMAN + Java 21 + Gradle + Maven
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 12: Instalando SDKMAN + Java + Gradle + Maven..."
log_step "═══════════════════════════════════════════"

SDKMAN_DIR="${USER_HOME}/.sdkman"

if [ -d "${SDKMAN_DIR}" ]; then
    log_warning "SDKMAN já está instalado em: ${SDKMAN_DIR}"
else
    log_info "Instalando SDKMAN para o usuário ${USER_OWNER}..."
    
    # SDKMAN precisa ser instalado como usuário não-root
    sudo -u "${USER_OWNER}" bash -c 'curl -s "https://get.sdkman.io" | bash'
    
    if [ -f "${SDKMAN_DIR}/bin/sdkman-init.sh" ]; then
        log_success "SDKMAN instalado com sucesso!"
    else
        log_error "Falha ao instalar SDKMAN!"
    fi
fi

# Instalar Java, Gradle e Maven via SDKMAN (como usuário)
if [ -f "${SDKMAN_DIR}/bin/sdkman-init.sh" ]; then
    log_info "Instalando Java 21 OpenJDK via SDKMAN..."
    sudo -u "${USER_OWNER}" bash -c "
        source \"${SDKMAN_DIR}/bin/sdkman-init.sh\"
        sdk install java 21-open <<< 'Y' || sdk install java 21-open
    " || log_warning "Java 21 pode já estar instalado ou ocorreu um erro."
    
    log_info "Instalando Gradle LTS via SDKMAN..."
    sudo -u "${USER_OWNER}" bash -c "
        source \"${SDKMAN_DIR}/bin/sdkman-init.sh\"
        sdk install gradle <<< 'Y' || sdk install gradle
    " || log_warning "Gradle pode já estar instalado ou ocorreu um erro."
    
    log_info "Instalando Maven via SDKMAN..."
    sudo -u "${USER_OWNER}" bash -c "
        source \"${SDKMAN_DIR}/bin/sdkman-init.sh\"
        sdk install maven <<< 'Y' || sdk install maven
    " || log_warning "Maven pode já estar instalado ou ocorreu um erro."
    
    # Verificar instalações
    log_info "Verificando instalações do SDKMAN..."
    sudo -u "${USER_OWNER}" bash -c "
        source \"${SDKMAN_DIR}/bin/sdkman-init.sh\"
        echo '  Java: '\$(java -version 2>&1 | head -1)
        echo '  Gradle: '\$(gradle --version 2>/dev/null | grep 'Gradle' | head -1)
        echo '  Maven: '\$(mvn --version 2>/dev/null | head -1)
    " || true
    
    log_success "SDKMAN, Java, Gradle e Maven configurados!"
else
    log_warning "SDKMAN não encontrado. Pulando instalação de Java, Gradle e Maven."
fi

#######################################################
# ETAPA 13: Configurar variáveis de ambiente
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 13: Criando script de environment..."
log_step "═══════════════════════════════════════════"

ENV_SCRIPT="${BASE_DIR}/env.sh"

cat > "$ENV_SCRIPT" << 'EOF'
#!/bin/bash
# Script de configuração de ambiente de desenvolvimento
# Execute com: source /opt/dev/env.sh

export DEV_HOME="/opt/dev"
export ANDROID_HOME="${DEV_HOME}/ide/android_studio"
export PATH="${DEV_HOME}/node/bin:${DEV_HOME}/ide/vscode/bin:${DEV_HOME}/ide/antigravity:${DEV_HOME}/ide/postman:${DEV_HOME}/ide/android_studio/bin:${DEV_HOME}/dbeaver:${DEV_HOME}/tools/k9s:$PATH"

echo ""
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║        ✓ Ambiente de desenvolvimento configurado!         ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo ""
echo "  Ferramentas disponíveis:"
echo "  ────────────────────────"
echo "  - Node.js: $(node --version 2>/dev/null || echo 'não encontrado')"
echo "  - npm: $(npm --version 2>/dev/null || echo 'não encontrado')"
echo "  - VS Code: $(code --version 2>/dev/null | head -1 || echo 'não encontrado')"
echo "  - Docker: $(docker --version 2>/dev/null || echo 'não encontrado')"
echo "  - kubectl: $(kubectl version --client --short 2>/dev/null || kubectl version --client 2>/dev/null | head -1 || echo 'não encontrado')"
echo "  - minikube: $(minikube version --short 2>/dev/null || echo 'não encontrado')"
echo "  - k9s: $(k9s version --short 2>/dev/null || echo 'disponível')"
echo "  - Java: $(java -version 2>&1 | head -1 || echo 'não encontrado')"
echo "  - Gradle: $(gradle --version 2>/dev/null | grep 'Gradle' | head -1 || echo 'não encontrado')"
echo "  - Maven: $(mvn --version 2>/dev/null | head -1 || echo 'não encontrado')"
echo ""

# Carregar SDKMAN se disponível
if [ -f "$HOME/.sdkman/bin/sdkman-init.sh" ]; then
    source "$HOME/.sdkman/bin/sdkman-init.sh"
fi
EOF

chmod +x "$ENV_SCRIPT"
log_success "Script de ambiente criado: ${ENV_SCRIPT}"

#######################################################
# ETAPA 14: Alterar proprietário final
#######################################################
log_step "═══════════════════════════════════════════"
log_step "ETAPA 14: Finalizando permissões..."
log_step "═══════════════════════════════════════════"

chown -R "${USER_OWNER}:${USER_OWNER}" "$BASE_DIR"
log_success "Permissões finalizadas para: ${USER_OWNER}"

#######################################################
# RESUMO FINAL
#######################################################
echo ""
echo "╔═══════════════════════════════════════════════════════════════════════╗"
echo "║                    🎉 INSTALAÇÃO CONCLUÍDA! 🎉                        ║"
echo "╚═══════════════════════════════════════════════════════════════════════╝"
echo ""
log_success "Estrutura de diretórios criada:"
echo ""
echo "  ${BASE_DIR}/"
echo "  ├── ide/"
echo "  │   ├── vscode/          (VS Code binário)"
echo "  │   ├── postman/         (Postman binário)"
echo "  │   ├── antigravity/     (Antigravity IDE)"
echo "  │   └── android_studio/  (Android Studio)"
echo "  ├── dbeaver/             (DBeaver ${DBEAVER_VERSION} LTS)"
echo "  ├── projects/"
echo "  ├── tools/"
echo "  │   └── k9s/             (k9s ${K9S_VERSION})"
echo "  ├── node/                (Node.js ${NODE_VERSION})"
echo "  ├── flutter/"
echo "  └── env.sh               (Script de ambiente)"
echo ""

# Verificar versões
log_info "Verificando instalações..."
echo ""

echo "  ┌─────────────────────────────────────────────────────────────┐"
echo "  │ FERRAMENTAS DE DESENVOLVIMENTO                              │"
echo "  ├─────────────────────────────────────────────────────────────┤"

if [ -f "${VSCODE_DIR}/bin/code" ]; then
    VSCODE_VER=$("${VSCODE_DIR}/bin/code" --version 2>/dev/null | head -1 || echo "erro")
    echo "  │ ✓ VS Code:      v${VSCODE_VER}"
else
    echo "  │ ✗ VS Code:      não encontrado"
fi

if [ -f "${NODE_DIR}/bin/node" ]; then
    NODE_VER=$("${NODE_DIR}/bin/node" --version 2>/dev/null || echo "erro")
    NPM_VER=$("${NODE_DIR}/bin/npm" --version 2>/dev/null || echo "erro")
    echo "  │ ✓ Node.js:      ${NODE_VER}"
    echo "  │ ✓ npm:          v${NPM_VER}"
else
    echo "  │ ✗ Node.js:      não encontrado"
fi

if command -v docker &> /dev/null; then
    DOCKER_VER=$(docker --version 2>/dev/null | cut -d' ' -f3 | tr -d ',')
    echo "  │ ✓ Docker:       v${DOCKER_VER}"
else
    echo "  │ ✗ Docker:       não encontrado"
fi

if command -v kubectl &> /dev/null; then
    echo "  │ ✓ kubectl:      instalado"
else
    echo "  │ ✗ kubectl:      não encontrado"
fi

if command -v minikube &> /dev/null; then
    MINIKUBE_VER=$(minikube version --short 2>/dev/null || echo "instalado")
    echo "  │ ✓ minikube:     ${MINIKUBE_VER}"
else
    echo "  │ ✗ minikube:     não encontrado"
fi

if [ -f "${K9S_DIR}/k9s" ]; then
    echo "  │ ✓ k9s:          ${K9S_VERSION}"
else
    echo "  │ ✗ k9s:          não encontrado"
fi

if [ -f "${POSTMAN_DIR}/Postman" ] || [ -f "${POSTMAN_DIR}/app/Postman" ]; then
    echo "  │ ✓ Postman:      instalado"
else
    echo "  │ ✗ Postman:      não encontrado"
fi

if [ -d "${ANTIGRAVITY_DIR}" ] && [ "$(ls -A ${ANTIGRAVITY_DIR})" ]; then
    echo "  │ ✓ Antigravity:  instalado"
else
    echo "  │ ✗ Antigravity:  não encontrado"
fi

if [ -f "${ANDROID_STUDIO_DIR}/bin/studio.sh" ]; then
    echo "  │ ✓ Android Studio: instalado"
else
    echo "  │ ✗ Android Studio: não encontrado"
fi

if [ -f "${DBEAVER_DIR}/dbeaver" ]; then
    echo "  │ ✓ DBeaver:       ${DBEAVER_VERSION} LTS"
else
    echo "  │ ✗ DBeaver:       não encontrado"
fi

# Verificar Zsh e Oh My Zsh
if command -v zsh &> /dev/null; then
    ZSH_VER=$(zsh --version 2>/dev/null | cut -d' ' -f2 || echo "instalado")
    echo "  │ ✓ Zsh:           ${ZSH_VER}"
else
    echo "  │ ✗ Zsh:           não encontrado"
fi

if [ -d "${USER_HOME}/.oh-my-zsh" ]; then
    echo "  │ ✓ Oh My Zsh:     instalado"
    if [ -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
        echo "  │   ✓ zsh-syntax-highlighting"
    fi
    if [ -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
        echo "  │   ✓ zsh-autosuggestions"
    fi
else
    echo "  │ ✗ Oh My Zsh:     não encontrado"
fi

# Verificar SDKMAN e ferramentas Java
if [ -d "${SDKMAN_DIR}" ]; then
    echo "  │ ✓ SDKMAN:       instalado"
    
    # Verificar Java
    if [ -d "${SDKMAN_DIR}/candidates/java/current" ]; then
        JAVA_VER=$(sudo -u "${USER_OWNER}" bash -c "source ${SDKMAN_DIR}/bin/sdkman-init.sh && java -version 2>&1 | head -1" || echo "21-open")
        echo "  │ ✓ Java:         ${JAVA_VER}"
    else
        echo "  │ ✗ Java:         não encontrado"
    fi
    
    # Verificar Gradle
    if [ -d "${SDKMAN_DIR}/candidates/gradle/current" ]; then
        echo "  │ ✓ Gradle:       instalado"
    else
        echo "  │ ✗ Gradle:       não encontrado"
    fi
    
    # Verificar Maven
    if [ -d "${SDKMAN_DIR}/candidates/maven/current" ]; then
        echo "  │ ✓ Maven:        instalado"
    else
        echo "  │ ✗ Maven:        não encontrado"
    fi
else
    echo "  │ ✗ SDKMAN:       não encontrado"
fi

echo "  └─────────────────────────────────────────────────────────────┘"
echo ""

echo "  ┌─────────────────────────────────────────────────────────────┐"
echo "  │ ÍCONES .DESKTOP CRIADOS                                     │"
echo "  ├─────────────────────────────────────────────────────────────┤"
echo "  │ • ${DESKTOP_DIR}/vscode.desktop"
echo "  │ • ${DESKTOP_DIR}/postman.desktop"
echo "  │ • ${DESKTOP_DIR}/antigravity.desktop"
echo "  │ • ${DESKTOP_DIR}/android-studio.desktop"
echo "  │ • ${DESKTOP_DIR}/dbeaver.desktop"
echo "  └─────────────────────────────────────────────────────────────┘"
echo ""

log_warning "⚠️  AÇÕES NECESSÁRIAS:"
echo ""
echo "  1. Para usar Docker sem sudo, faça logout/login ou execute:"
echo "     newgrp docker"
echo ""
echo "  2. Para carregar o SDKMAN (Java, Gradle, Maven), execute:"
echo "     source ~/.sdkman/bin/sdkman-init.sh"
echo ""
echo "  3. Para ativar as variáveis de ambiente, execute:"
echo "     source /opt/dev/env.sh"
echo ""
echo "  4. Para tornar permanente, adicione ao seu ~/.bashrc ou ~/.zshrc:"
echo "     echo 'source /opt/dev/env.sh' >> ~/.bashrc"
echo "     echo 'source ~/.sdkman/bin/sdkman-init.sh' >> ~/.bashrc"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "                    Script criado por KAIQUERAS"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
