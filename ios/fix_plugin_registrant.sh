#!/bin/bash

# Скрипт для исправления импорта path_provider_foundation в GeneratedPluginRegistrant.m
# Запускать после flutter pub get или flutter build ios

PLUGIN_FILE="Runner/GeneratedPluginRegistrant.m"

if [ -f "$PLUGIN_FILE" ]; then
    # Заменяем @import на правильный импорт
    sed -i '' 's/@import path_provider_foundation;/#import <path_provider_foundation\/path_provider_foundation-Swift.h>/g' "$PLUGIN_FILE"
    echo "Fixed path_provider_foundation import in $PLUGIN_FILE"
else
    echo "File $PLUGIN_FILE not found"
fi

