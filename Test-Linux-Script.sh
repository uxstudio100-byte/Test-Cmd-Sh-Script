#!/bin/bash

# =====【用户配置区】=====
MENU_TITLE="高级控制台"         # 窗口标题
MENU_ITEMS=("系统诊断" "文件管理" "网络工具")  # 菜单项数组
COLOR_SCHEME="\e[37;44m"       # 蓝底白字ANSI颜色代码
RESET_COLOR="\e[0m"            # 重置颜色
AUTO_PADDING=18                # 对齐宽度

# =====【核心引擎】=====
function build_menu() {
    ITEM_COUNT=${#MENU_ITEMS[@]}
}

function display_menu() {
    clear
    echo -e "${COLOR_SCHEME}"
    echo "╔══════════════════════════╗"
    echo "║       ${MENU_TITLE}       ║"
    echo "╠══════════════════════════╣"

    for ((i=0; i<$ITEM_COUNT; i++)); do
        printf "║ $((i+1)). %-${AUTO_PADDING}s║\n" "${MENU_ITEMS[$i]}"
    done

    echo "╠══════════════════════════╣"
    echo "║  0. 退出                 ║"
    echo "╚══════════════════════════╝${RESET_COLOR}"
}

# =====【主循环】=====
build_menu
while true; do
    display_menu
    read -p "选择: " INPUT
    
    case $INPUT in
        0) exit 0 ;;
        *) if (( INPUT > 0 && INPUT <= ITEM_COUNT )); then
            "func_${MENU_ITEMS[$((INPUT-1))]// /_}"
            read -p "按回车继续..."
           fi ;;
    esac
done

# =====【功能扩展区】=====
func_系统诊断() {
    echo -e "\n系统信息："
    grep -iE "OS|内存|处理器" /proc/meminfo /proc/cpuinfo 2>/dev/null || 
    system_profiler SPHardwareDataType 2>/dev/null
}

func_文件管理() {
    echo -e "\n当前目录文件："
    ls -lh --color=auto | head -n 20
}

func_网络工具() {
    echo -e "\n网络检测："
    ping -c 2 127.0.0.1
    ip a | grep -w inet || ifconfig | grep -w inet
}
