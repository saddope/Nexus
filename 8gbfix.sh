#!/bin/bash

# Создание swap-файла размером 8GB
sudo fallocate -l 8G /swapfile || sudo dd if=/dev/zero of=/swapfile bs=1M count=8192

# Ограничение доступа
sudo chmod 600 /swapfile

# Форматирование файла под swap
sudo mkswap /swapfile

# Активация swap
sudo swapon /swapfile

# Добавление в автозапуск
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Проверка, что swap работает
swapon --show
free -h
cat /proc/swaps

echo "✅ Swap 8GB успешно создан и активирован!"
