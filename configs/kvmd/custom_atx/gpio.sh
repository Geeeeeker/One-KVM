#!/bin/bash
# RP2040 串口控制脚本

DEV="/dev/ttyUSB0"
BAUD="115200"

# 初始化串口参数
stty -F $DEV $BAUD -echo -icrnl -ixon -opost -onlcr

case "$1" in
    short)
        echo -e "short\n" > $DEV
        ;;
    long)
        echo -e "long\n" > $DEV
        ;;
    reset)
        echo -e "reset\n" > $DEV
        ;;
    status)
        # 清空缓存并读取状态
        echo -e "status\n" > $DEV
        # 读取一行返回，超时 0.5 秒
        RES=$(timeout 0.5 head -n 1 $DEV | tr -d '\r\n')
        if [ "$RES" == "ON" ]; then
            exit 1 # 1 代表开机 (High)
        else
            exit 0 # 0 代表关机 (Low)
        fi
        ;;
esac
exit 0

