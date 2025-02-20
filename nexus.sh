#!/bin/bash

set -e

# мой тг
echo -e "\033[0;35m"
cat << "EOF"

 _____                   _                      _    _             
(____ \                 | |                    | |  | |            
 _   \ \ ____ _   _ ____| | ___  ____   ____ _ | |  | | _  _   _ _ 
| |   | / _  ) | | / _  ) |/ _ \|  _ \ / _  ) || |  | || \| | | (_)
| |__/ ( (/ / \ V ( (/ /| | |_| | | | ( (/ ( (_| |  | |_) ) |_| |_ 
|_____/ \____) \_/ \____)_|\___/| ||_/ \____)____|  |____/ \__  (_)
                                |_|                       (____/   

Telegram Channel: t.me/saddopecrypto
Telegram Profile: @saddope1


EOF
echo -e "\033[0m"

echo -e "\033[0;36m>>> Starting Nexus Auto-Installer...\033[0m"
sleep 2

# Цвета для логов
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m'

# Функция логирования
log() {
    local level=$1
    local message=$2
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    case $level in
        "INFO") echo -e "${CYAN}[INFO] ${timestamp} - ${message}${NC}" ;;
        "OK") echo -e "${GREEN}[OK] ${timestamp} - ${message}${NC}" ;;
        "ERROR") echo -e "${RED}[ERROR] ${timestamp} - ${message}${NC}" ;;
        *) echo -e "${YELLOW}[?] ${timestamp} - ${message}${NC}" ;;
    esac
}

# Проверка наличия sudo
if [[ $EUID -ne 0 ]]; then
    log "ERROR" "Этот скрипт нужно запускать с правами root! Используй: sudo bash $0"
    exit 1
fi

# Функция загрузочного индикатора
progress_bar() {
    local duration=$1
    local message=$2
    local chars="/—\\|"
    
    echo -n -e "${YELLOW}${message}...${NC} "
    for ((i = 0; i < duration; i++)); do
        printf "\b${chars:i%${#chars}:1}"
        sleep 0.1
    done
    printf "\r${GREEN}✔ Done!${NC} \n"
}

log "INFO" "Обновление системы..."
sudo apt update && sudo apt upgrade -y

log "INFO" "Установка зависимостей..."
sudo apt install -y build-essential pkg-config libssl-dev git unzip

# Установка Rust
if ! command -v rustc &> /dev/null; then
    log "INFO" "Установка Rust..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source $HOME/.cargo/env
fi

# Установка rush (если отсутствует)
if ! command -v rush &> /dev/null; then
    log "INFO" "Установка rush..."
    cargo install rush
fi

# Установка protobuf
log "INFO" "Установка protobuf..."
PROTOC_ZIP=protoc-25.2-linux-x86_64.zip
curl -LO https://github.com/protocolbuffers/protobuf/releases/download/v25.2/$PROTOC_ZIP
unzip $PROTOC_ZIP -d $HOME/.local
export PATH="$HOME/.local/bin:$PATH"
rm -f $PROTOC_ZIP

# Rust таргеты
log "INFO" "Настройка Rust..."
rustup update
rustup target add riscv32i-unknown-none-elf
rustup component add rust-src
cargo install cargo-zigbuild

# Установка Nexus CLI в screen-сессии
log "INFO" "Запуск установки Nexus в screen-сессии..."
screen -S nexus -dm bash -c 'wget -qO- https://cli.nexus.xyz/ | sh'

log "OK" "Установка Nexus запущена! Используй 'screen -r nexus' для просмотра процесса."
