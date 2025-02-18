# Установка ноды Nexus

## Требования

- **Linux** (Ubuntu/Debian)
- **Rust** (Nightly)
- **Git**
- **curl**

## 1️⃣ Установка необходимых зависимостей
```bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl pkg-config libssl-dev protobuf-compiler
```

## 2️⃣ Установка Rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
```

## 3️⃣ Добавить поддержку RISC-V
```bash
rustup target add riscv32i-unknown-none-elf
rustup component add rust-src
```

## 4️⃣ Установить Protobuf для Rust
```bash
cargo install protobuf-codegen
```

## 5️⃣ Клонировать репозиторий Nexus
```bash
mkdir -p $HOME/.nexus
cd $HOME/.nexus
git clone https://github.com/nexus-xyz/network-api
cd network-api
```

## 6️⃣ Переключиться на последнюю версию
```bash
git fetch --tags
git checkout $(git rev-list --tags --max-count=1)
```

## 7️⃣ Собрать ноду
```bash
cd clients/cli
cargo build --release
```

## 8️⃣ Запустить ноду
```bash
cargo run --release -- --start --beta
```

## 🔄 Если возникли ошибки
Если возникли ошибки с конфигурацией **Node ID**, можно вручную заменить его:
1. Перейдите в папку с настройками:
   ```bash
   cd ~/.nexus/network-api/clients/cli/src
   nano setup.rs
   ```
2. Найдите строку `let node_id = "NODE_ID_MU".to_string();` и замените `NODE_ID_MU` на ваш ID.
3. Сохраните файл (`Ctrl + X`, затем `Y`, затем `Enter`).
4. Пересоберите ноду:
   ```bash
   cd ~/.nexus/network-api/clients/cli
   cargo build --release
   ```
5. Запустите заново через `screen`:
   ```bash
   screen -S nexus
   cargo run --release -- --start --beta
   ```
   Чтобы выйти из `screen`, нажмите `Ctrl + A`, затем `D`. Вернуться обратно можно командой:
   ```bash
   screen -r nexus
   ```

Теперь ваша нода работает! 🎉

---

### Автор гайда:  
DM: @saddope1  
Мой канал: [@saddopecrypto](https://t.me/saddopecrypto)

