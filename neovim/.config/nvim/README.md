# nvim config

Автономный: серверы (Mason), tree-sitter CLI (Mason) и парсеры (nvim-treesitter) ставятся внутрь nvim.

Из системы нужны только: nvim 0.12+, git, node+npm (для svelte/ts/html/css серверов), gcc или clang.
Проверка: `command -v git node npm cc`

## Чистая установка
    mv ~/.config/nvim ~/.config/nvim.bak
    rm -rf ~/.local/share/nvim ~/.local/state/nvim ~/.cache/nvim   # сотрёт и undo-историю
    cp -r nvim ~/.config/nvim
    nvim

Первый запуск: подтвердить установку плагинов (y), подождать 1-3 минуты (Mason + сборка парсеров).
Прогресс: `:Mason`. Если что-то не поставилось: `:messages`, `:checkhealth mason`, `:checkhealth vim.treesitter`.

Системные пакеты tree-sitter-* (парсеры), если стоят, лучше удалить: они могут конфликтовать с парсерами плагина.
