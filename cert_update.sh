#!/bin/bash

set -e

TARGET_DIR="padavan-ng/trunk/libs/libssl"

if [ ! -f "$TARGET_DIR/ca-certificates_update.sh" ]; then
    echo "错误：找不到脚本"
    exit 1
fi

# 保存原始目录
ORIGINAL_DIR="$(pwd)"

# 进入目标目录
cd "$TARGET_DIR"

echo "当前目录：$(pwd)"
echo "开始执行 ca-certificates_update.sh..."

chmod +x ca-certificates_update.sh
./ca-certificates_update.sh

# 返回原始目录
cd "$ORIGINAL_DIR"

echo "已返回原始目录：$(pwd)"
echo "证书更新完成！"