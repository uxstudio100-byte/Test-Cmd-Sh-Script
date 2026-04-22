@echo off
setlocal enabledelayedexpansion

:: =====【用户配置区】=====
set "MENU_TITLE=高级控制台"      :: 窗口标题（不超过15字）
set "MENU_ITEMS=系统诊断|文件管理|网络工具"  :: 竖线分隔菜单项
set "COLOR_SCHEME=1F"           :: 蓝底白字（0-9A-F前景/背景色）
set "AUTO_PADDING=18"           :: 菜单项对齐宽度（字符数）

:: =====【核心引擎】=====
:INIT
title !MENU_TITLE!
color !COLOR_SCHEME!
call :BUILD_MENU "!MENU_ITEMS!"  :: 解析配置生成菜单结构

:MAIN_LOOP
cls
echo ╔══════════════════════════╗
echo ║       !MENU_TITLE!       ║
echo ╠══════════════════════════╣

:: 动态渲染菜单（自动适应配置项）
for /L %%i in (1,1,!ITEM_COUNT!) do (
    set "DISPLAY_TEXT=!ITEM_%%i!"
    set "PADDING=                    "  :: 20个空格用于对齐
    echo ║ %%i. !DISPLAY_TEXT!!PADDING:~0,%AUTO_PADDING%!║
)

echo ╠══════════════════════════╣
echo ║  0. 退出                 ║
echo ╚══════════════════════════╝

:: 输入处理（带基本验证）
set /p "INPUT=选择: "
if "!INPUT!"=="0" exit /b
if defined ITEM_!INPUT! call :FUNC_!INPUT!
goto MAIN_LOOP

:: =====【菜单构造器】=====
:BUILD_MENU
set "CONFIG=%~1"
set "ITEM_COUNT=0"
for %%a in ("!CONFIG:|=" "!") do (  :: 拆分管道符配置
    set /a ITEM_COUNT+=1
    set "ITEM_!ITEM_COUNT!=%%~a"
    set "FUNC_!ITEM_COUNT!=:DO_%%~a"  :: 自动关联功能标签
)
exit /b

:: =====【功能扩展区】=====
:DO_系统诊断
systeminfo | findstr /i "OS 内存 处理器"
pause
exit /b

:DO_文件管理
dir /a-d /on  :: 列出文件（按名称排序）
pause
exit /b

:DO_网络工具
ping 127.0.0.1 -n 2
ipconfig | findstr IPv4
pause
exit /b
