# 🚀 AutoAmbiente

<p align="center">
  <img src="https://img.shields.io/badge/Ubuntu-24.04-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" alt="Ubuntu 24.04">
  <img src="https://img.shields.io/badge/Shell-Bash-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Bash">
  <img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge" alt="License">
</p>

<p align="center">
  <b>Script automatizado para configuração completa de ambiente de desenvolvimento no Ubuntu 24.04</b>
</p>

---

## 📋 Sobre

O **AutoAmbiente** é um script shell que automatiza a instalação e configuração de todas as ferramentas necessárias para um ambiente de desenvolvimento completo. Com apenas um comando, você terá instalado IDEs, ferramentas de containerização, linguagens de programação e utilitários essenciais.

## ✨ Features

### 🛠️ IDEs & Editores
| Ferramenta | Descrição |
|------------|-----------|
| **VS Code** | Editor de código mais popular do mercado |
| **Antigravity IDE** | IDE com IA integrada by Google DeepMind |
| **Android Studio** | IDE oficial para desenvolvimento Android |
| **Postman** | Cliente API para testes e documentação |
| **DBeaver** | Cliente universal de banco de dados |

### 📦 Containerização & Orquestração
| Ferramenta | Descrição |
|------------|-----------|
| **Docker** | Plataforma de containerização (configurado sem sudo) |
| **kubectl** | CLI do Kubernetes |
| **Minikube** | Kubernetes local para desenvolvimento |
| **k9s** | Terminal UI para gerenciamento de Kubernetes |

### 💻 Linguagens & Runtimes
| Ferramenta | Versão |
|------------|--------|
| **Node.js** | v24.13.0 LTS |
| **Java** | OpenJDK 21 (via SDKMAN) |
| **Gradle** | Latest LTS (via SDKMAN) |
| **Maven** | Latest (via SDKMAN) |

### 🐚 Terminal
| Ferramenta | Descrição |
|------------|-----------|
| **Zsh** | Shell moderno e poderoso |
| **Oh My Zsh** | Framework de configuração do Zsh |
| **zsh-syntax-highlighting** | Realce de sintaxe em tempo real |
| **zsh-autosuggestions** | Sugestões baseadas no histórico |

## 📁 Estrutura de Diretórios

Após a execução, a seguinte estrutura será criada:

```
/opt/dev/
├── ide/
│   ├── vscode/          # VS Code
│   ├── postman/         # Postman
│   ├── antigravity/     # Antigravity IDE
│   └── android_studio/  # Android Studio
├── dbeaver/             # DBeaver Community
├── projects/            # Seus projetos
├── tools/
│   └── k9s/             # k9s
├── node/                # Node.js
├── flutter/             # (reservado para Flutter)
└── env.sh               # Script de variáveis de ambiente
```

## 🚀 Instalação

### Pré-requisitos

- Ubuntu 24.04 LTS
- Conexão com a internet
- Privilégios de administrador (sudo)

### Executando o Script

```bash
# Clone o repositório
git clone https://github.com/kaiquesantanadev/autoambiente.git

# Entre no diretório
cd autoambiente

# Dê permissão de execução
chmod +x setup-ambiente.sh

# Execute com sudo
sudo ./setup-ambiente.sh
```

## ⚙️ Pós-Instalação

Após a execução do script, algumas ações são necessárias:

### 1. Aplicar permissões do Docker
```bash
# Faça logout/login OU execute:
newgrp docker
```

### 2. Carregar variáveis de ambiente
```bash
source /opt/dev/env.sh
```

### 3. Iniciar novo terminal Zsh
```bash
# O Zsh já é o shell padrão, basta abrir um novo terminal
zsh
```

### 4. Tornar configurações permanentes (opcional)
```bash
# Adicione ao seu ~/.zshrc (já configurado automaticamente)
echo 'source /opt/dev/env.sh' >> ~/.zshrc
```

## 📊 Verificação da Instalação

O script exibe um resumo completo ao final da execução:

```
╔═══════════════════════════════════════════════════════════════════════╗
║                    🎉 INSTALAÇÃO CONCLUÍDA! 🎉                        ║
╚═══════════════════════════════════════════════════════════════════════╝

  ┌─────────────────────────────────────────────────────────────┐
  │ FERRAMENTAS DE DESENVOLVIMENTO                              │
  ├─────────────────────────────────────────────────────────────┤
  │ ✓ VS Code:      v1.xx.x                                     │
  │ ✓ Node.js:      v24.13.0                                    │
  │ ✓ Docker:       vXX.X.X                                     │
  │ ✓ kubectl:      instalado                                   │
  │ ✓ minikube:     vX.XX.X                                     │
  │ ✓ k9s:          v0.50.18                                    │
  │ ✓ Zsh:          5.9                                         │
  │ ✓ Oh My Zsh:    instalado                                   │
  │   ✓ zsh-syntax-highlighting                                 │
  │   ✓ zsh-autosuggestions                                     │
  │ ✓ DBeaver:      24.3.4 LTS                                  │
  │ ✓ SDKMAN:       instalado                                   │
  │ ✓ Java:         OpenJDK 21                                  │
  │ ✓ Gradle:       instalado                                   │
  │ ✓ Maven:        instalado                                   │
  └─────────────────────────────────────────────────────────────┘
```

## 🔧 Personalização

### Alterando versões

Edite as variáveis no início do script:

```bash
# Versões
NODE_VERSION="v24.13.0"
K9S_VERSION="v0.50.18"
DBEAVER_VERSION="24.3.4"
```

### Adicionando novas ferramentas

O script segue um padrão consistente para cada ferramenta:

1. Verificar se já está instalada
2. Baixar o arquivo
3. Extrair para o diretório apropriado
4. Criar ícone .desktop (se aplicável)
5. Atualizar variáveis de ambiente

## 📝 Ícones de Aplicativos

O script cria automaticamente ícones `.desktop` para:

- Visual Studio Code
- Postman
- Antigravity IDE
- Android Studio
- DBeaver

Os ícones são salvos em `~/.local/share/applications/` e aparecem no menu de aplicativos.

## 🐛 Troubleshooting

### Docker não funciona sem sudo
```bash
# Verifique se o usuário está no grupo docker
groups $USER

# Se não estiver, adicione manualmente
sudo usermod -aG docker $USER
newgrp docker
```

### SDKMAN não carrega
```bash
# Carregue manualmente
source ~/.sdkman/bin/sdkman-init.sh

# Ou reinicie o terminal
```

### Plugins do Zsh não funcionam
```bash
# Verifique se os plugins estão instalados
ls ~/.oh-my-zsh/custom/plugins/

# Verifique a linha de plugins no .zshrc
grep "plugins=" ~/.zshrc
```

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para:

1. Fazer um Fork do projeto
2. Criar uma branch para sua feature (`git checkout -b feature/NovaFeature`)
3. Commit suas mudanças (`git commit -m 'feat: Adiciona NovaFeature'`)
4. Push para a branch (`git push origin feature/NovaFeature`)
5. Abrir um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

**Kaique Santana** - [@kaiquesantanadev](https://github.com/kaiquesantanadev)

---

<p align="center">
  Made with ❤️ by <b>KAIQUERAS</b>
</p>
