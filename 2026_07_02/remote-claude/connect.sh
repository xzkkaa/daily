#!/bin/bash
# ============================================
# 从笔记本电脑连接台式机的 SSH 脚本
# 使用方法: bash connect.sh [台式机IP或主机名]
# ============================================

DESKTOP_HOST="${1:-}"

if [ -z "$DESKTOP_HOST" ]; then
    echo "用法: bash connect.sh <台式机IP>"
    echo "示例: bash connect.sh 192.168.1.100"
    echo "      bash connect.sh my-desktop  (需配好 Tailscale)"
    exit 1
fi

echo "=== 连接台式机: $DESKTOP_HOST ==="
echo ""
echo "连接成功后在台式机上直接运行:"
echo "  claude"
echo ""

ssh "$DESKTOP_HOST"
