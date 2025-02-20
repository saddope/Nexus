# 📌 Nexus Node – Полный гайд по установке и запуску

## Описание проекта
**Nexus** - это Layer 1 блокчейн, привлекший $27.5M от топ-фондов, включая Pantera Capital и DragonFly Capital. Проект активно развивается, и сейчас проходит вторая фаза тестнета.

---

## 🔧 Требования к серверу
Перед установкой убедитесь, что ваш сервер соответствует минимальным требованиям:
- **ОС:** Ubuntu 20.04 / 22.04
- **RAM:** 4GB (рекомендуется 8GB+)
- **CPU:** 2 vCPU
- **Storage:** 50GB SSD
- **Internet:** стабильное соединение

---

## 1. Обновление системы
```bash
sudo apt update && sudo apt upgrade -y
```

## 2. Установка screen
```bash
sudo apt install screen -y
```

## 3. Создание swap-файла (если не хватает RAM)
```bash
bash <(curl -s https://raw.githubusercontent.com/saddope/Nexus/main/8gbfix.sh)
```

## 4. Установка Nexus Node
```bash
bash <(curl -s https://raw.githubusercontent.com/saddope/Nexus/main/nexus.sh)
```

## 5. Подключение к screen-сессии для просмотра логов
```bash
screen -r nexus
```

## 6. Удаление ноды
Если вам нужно удалить ноду Nexus, выполните следующую команду:
```bash
rm -rf /root/.nexus
```

## 7. Полезные команды
- **Отсоединиться от screen (без завершения процесса):**
  ```bash
  Ctrl + A, затем D
  ```
- **Остановить ноду:**
  ```bash
  pkill -f nexus
  ```

---

### 🚀 Теперь ваша Nexus Node установлена и работает! 

---

## Мои ресурсы

Если у вас возникли вопросы или нужна помощь, присоединяйтесь к моему каналу:

- **Telegram:** [saddope](https://t.me/saddope1)
- **Канал:** [saddopecrypto](https://t.me/saddopecrypto)
