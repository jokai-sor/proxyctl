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
docs/OPERATIONS.md        Операционная документация и команды
scripts/install.sh        Установка
scripts/uninstall.sh      Удаление
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

## Быстрый старт

```bash
sudo proxyctl
sudo proxyctl help
sudo proxyctl doctor
sudo proxyctl user add alice --random --format telegram
sudo proxyctl usage
sudo proxyctl quota list
```

## Чем управляет proxyctl

Инструмент работает с такими системными путями:

- `/etc/danted.conf`
- `/etc/pam.d/danted`
- `/etc/proxyctl/lang`
- `/etc/proxyctl/quotas.conf`
- `/etc/systemd/system/proxyctl-quota-enforce.service`
- `/etc/systemd/system/proxyctl-quota-enforce.timer`

Если используются функции аудита и защиты, также ожидается настроенный `fail2ban` для Dante.

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
