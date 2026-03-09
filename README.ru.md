# proxyctl

[English](README.md) | [Русский](README.ru.md)

`proxyctl` — это Bash CLI/TUI для администрирования SOCKS5-прокси на базе Dante в Ubuntu.

Он собирает в одном инструменте то, что обычно приходится делать вручную через `systemctl`, `ufw`, `journalctl`, `passwd` и правки `/etc/danted.conf`.

## Что умеет

- интерактивный терминальный интерфейс
- управление сервисом `danted`
- создание, блокировка и удаление proxy-пользователей
- выдача данных доступа в обычном формате, URI и Telegram-ссылке
- работа с правилами UFW для SOCKS-доступа
- аудит с учетом `fail2ban`
- учет трафика по пользователям по логам Dante
- квоты трафика и автоматическое ежедневное применение лимитов
- диагностика готовности Telegram-звонков через UDP relay

## Для чего подходит

Проект рассчитан на личное использование или небольшую эксплуатацию Dante-прокси на Ubuntu-подобной системе, где уже есть:

- `systemd`
- `ufw`
- `journalctl`
- `dante-server`
- PAM-аутентификация

Это не веб-панель и не универсальный мультидистрибутивный фреймворк.

## Структура репозитория

```text
bin/proxyctl              Основной исполняемый файл
scripts/bootstrap.sh      Bootstrap-обертка для чистого сервера
docs/OPERATIONS.md        Операционная документация и команды
scripts/install.sh        Установка
scripts/uninstall.sh      Удаление
systemd/*.service         Systemd unit-файлы для эксплуатации
systemd/*.timer           Systemd timer-файлы для эксплуатации
```

## Быстрая установка

```bash
git clone <your-repo-url>
cd proxyctl
sudo ./scripts/install.sh
```

После установки будут доступны:

- `bin/proxyctl` -> `/usr/local/bin/proxyctl`
- `docs/OPERATIONS.md` -> `/usr/local/share/doc/proxyctl/OPERATIONS.md`
- `systemd/proxyctl-quota-enforce.*` -> `/etc/systemd/system/`
- `systemd/proxyctl-usage-cache-warm.*` -> `/etc/systemd/system/`

И автоматически включатся:

- ежедневный timer применения квот
- периодический timer прогрева месячного кэша usage

## Bootstrap для чистого сервера

Для нового Ubuntu VPS можно сразу использовать bootstrap-обертку из репозитория:

```bash
git clone <your-repo-url>
cd proxyctl
sudo ./scripts/bootstrap.sh --proxy-password-random
```

Полезные варианты:

```bash
sudo ./scripts/bootstrap.sh --proxy-password-random --allow-ip 203.0.113.10
sudo ./scripts/bootstrap.sh --proxy-user alice --proxy-password 'strong-pass' --format telegram
sudo ./scripts/bootstrap.sh --dry-run
```

Что делает bootstrap:

- ставит `dante-server`, `ufw` и при необходимости `fail2ban`
- записывает управляемые конфиги `danted`, PAM и fail2ban
- создает или подхватывает стартового proxy-пользователя
- включает и перезапускает нужные сервисы
- настраивает UFW для TCP SOCKS и UDP relay
- выводит данные доступа и запускает `doctor`

## Быстрый старт

```bash
sudo proxyctl
sudo proxyctl help
sudo proxyctl bootstrap --dry-run
sudo proxyctl doctor
sudo proxyctl user add alice --random --format telegram
sudo proxyctl usage
sudo proxyctl usage --warm-cache
sudo proxyctl quota list
```

## Чем управляет proxyctl

Инструмент работает с такими системными путями:

- `/etc/danted.conf`
- `/etc/pam.d/danted`
- `/etc/proxyctl/lang`
- `/etc/proxyctl/quotas.conf`
- `/etc/proxyctl/cache/usage-YYYY-MM.db`
- `/etc/proxyctl/backups/*`
- `/etc/systemd/system/proxyctl-quota-enforce.service`
- `/etc/systemd/system/proxyctl-quota-enforce.timer`
- `/etc/systemd/system/proxyctl-usage-cache-warm.service`
- `/etc/systemd/system/proxyctl-usage-cache-warm.timer`

Если используются функции аудита и защиты, также ожидается настроенный `fail2ban` для Dante.

## Как устроен runtime

`proxyctl` сознательно остается эксплуатационным инструментом:

- предполагается, что `dante-server` уже установлен и настроен
- статистика трафика читается из `journalctl`
- для быстрых месячных отчетов используется локальный кэш в `/etc/proxyctl/cache`
- применение квот запускается ежедневным systemd timer
- прогрев usage-кэша запускается отдельным systemd timer

## Публикация и развитие

Репозиторий уже оформлен для публикации на GitHub, но текущая реализация сознательно остается операционной и прямой:

- управление от `root`
- ориентация на Ubuntu/Debian-подобную среду
- прямые правки системных файлов

Если развивать проект дальше для более широкой аудитории, следующий шаг:

- отделить runtime-конфигурацию от продуктового кода
- добавить тесты для парсеров `journalctl`
- стабилизировать формат логов и проверок

## Лицензия

MIT. См. [LICENSE](LICENSE).
