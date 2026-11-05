#!/bin/sh

CONFIG="padavan-ng/trunk/configs/boards/busybox.config"

if [ ! -f "$CONFIG" ]; then
    echo "[错误] 找不到配置文件: $CONFIG"
    exit 1
fi

# 备份配置
cp "$CONFIG" "$CONFIG.bak"

enable_config() {
    KEY="$1"

    if grep -q "^${KEY}=y$" "$CONFIG"; then
        echo "[已开启] $KEY"
    elif grep -q "^# ${KEY} is not set$" "$CONFIG"; then
        sed -i "s/^# ${KEY} is not set$/${KEY}=y/" "$CONFIG"
        echo "[开启成功] $KEY"
    elif grep -q "^${KEY}=" "$CONFIG"; then
        sed -i "s/^${KEY}=.*/${KEY}=y/" "$CONFIG"
        echo "[开启成功] $KEY"
    else
        echo "${KEY}=y" >> "$CONFIG"
        echo "[添加成功] $KEY"
    fi
}

enable_config CONFIG_UNZIP
enable_config CONFIG_NOHUP

echo
echo "========== 最终配置 =========="
grep -E '^CONFIG_(UNZIP|NOHUP)=y$' "$CONFIG"

echo
echo "BusyBox 配置修改完成！"
echo "备份文件: $CONFIG.bak"
