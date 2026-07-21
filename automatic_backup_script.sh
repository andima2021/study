#!/bin/bash
echo "🚀 Запуск автоматического бэкапа..."

# Переходим в папку проекта
cd ~/study || exit

# 1. Делаем бэкап Grafana
echo "🔵 Бэкап Grafana..."
docker run --rm -v grafana-data:/source -v $(pwd):/backup alpine tar czf /backup/grafana_backup.tar.gz -C /source .

# 2. Делаем бэкап Portainer
echo "🔵 Бэкап Portainer..."
docker run --rm -v portainer-data:/source -v$(pwd):/backup alpine tar czf /backup/portainer_backup.tar.gz -C /source .

# 3. Отправляем в Git
echo "📤 Отправляем в Git..."
git add grafana_backup.tar.gz portainer_backup.tar.gz
git commit -m "Автоматический бэкап $(date +%Y-%m-%d)"
git push

echo "Готово"
