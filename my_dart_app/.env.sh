#!/bin/bash
# Dart 环境变量配置脚本
# 使用方法: source .env.sh

export PATH="/usr/lib/dart/bin:$PATH"
export PATH="$PATH:$HOME/.pub-cache/bin"

echo "✅ Dart 环境已配置"
echo "📦 Dart 版本: $(dart --version 2>&1 | head -n 1)"
echo ""
echo "可用命令:"
echo "  dart run        - 运行应用程序"
echo "  dart test       - 运行测试"
echo "  dart analyze    - 分析代码"
echo "  dart pub get    - 获取依赖"
