# Test-Cmd-Sh-Script

* Windows CMD脚本说明:
* 配置区变量说明:
-----
* MENU_TITLE:
* 作用：控制窗口标题栏显示文字
* 格式：字符串（建议不超过15字符）
* 示例：set "MENU_TITLE=运维工具箱"
-----
* MENU_ITEMS
* 作用：定义菜单选项列表
* 格式：竖线分隔的字符串
* 示例：set "MENU_ITEMS=磁盘清理|进程管理|服务控制"
-----
* COLOR_SCHEME
* 作用：设置控制台颜色
* 格式：两位十六进制数（前背景色）
* 示例：set "COLOR_SCHEME=3A"（绿底淡红色）
-----
* AUTO_PADDING
* 作用：控制菜单项对齐宽度
* 格式：数字（推荐18-25）
* 示例：set "AUTO_PADDING=20"
-----
* 功能区扩展步骤:
* 添加新选项：
* 在MENU_ITEMS追加|新功能名
* 示例：set "MENU_ITEMS=磁盘清理|进程管理|新功能"
-----
* 实现功能逻辑：
* 在脚本末尾添加功能子程序
```
:DO_新功能
  echo 正在执行新功能...
  timeout /t 3
  :: 实际功能代码写在这里
exit /b
```
-----
* 多级菜单实现：
* 在功能中调用新菜单标签
```
:DO_高级功能
  call :ADVANCED_MENU
exit /b
```
-----
* 注意事项
* 命名规范：
* 功能标签必须与MENU_ITEMS项对应
* 使用:DO_前缀保持统一
* -----
* 输入验证：
* 建议添加if not defined ITEM_!INPUT!判断
使用choice命令可限制输入范围
-----
* 常见问题：
* 乱码问题：保存文件时编码选ANSI
* 对齐异常：调整AUTO_PADDING值
* 功能不生效：检查标签命名一致性
-----
* 高级技巧：
* 通过%*传递参数给功能
* 使用start命令启动外部程序
* 集成powershell命令增强功能
-----
* Linux脚本说明:
* 功能概述​
-----
* 核心功能：
* 通过纯文本配置生成交互式终端菜单
* 自动解析数组项构建动态选项列表
* 支持ANSI彩色界面和自适应对齐
* 模块化功能设计，便于扩展
-----
* 跨平台特性：
* 兼容Bash 4.0+环境
* 适配Linux/macOS系统命令
* 智能检测system_profiler和ip等命令
-----
* 配置说明:
```
# 基础配置  
MENU_TITLE="控制台"          # 标题（支持中文）  
MENU_ITEMS=("选项1" "选项2") # 菜单项数组  
COLOR_SCHEME="\e[37;44m"     # 前景色;背景色  
AUTO_PADDING=20              # 文字对齐宽度  

# 颜色代码参考：  
# \e[30-37m 前景色 | \e[40-47m 背景色  
# 红色\e[31m 绿色\e[32m 黄色\e[33m
```
-----
* 使用示例:
* 基础运行：
```
chmod +x menu.sh  
./menu.sh
```
-----
* 添加新功能：
```
# 在MENU_ITEMS追加"文件搜索"
MENU_ITEMS+=("文件搜索")

# 添加对应函数  
func_文件搜索() {
    find . -name "*.log"  
}
```
-----
* 扩展指南​
* 高级功能开发：
* 二级菜单：在函数内调用display_menu
* 参数传递：通过$1接收用户输入
* 异步执行：使用&启动后台任务
-----
* 企业级优化：
```
# 加载外部配置  
source config.conf  

# 日志记录  
exec &> >(tee -a runtime.log)
```
-----
* 安全增强：
* 输入消毒：[[ $INPUT =~ ^[0-9]+$ ]]
* 超时控制：read -t 5 INPUT
* 权限检查：[ $(id -u) -eq 0 ]
* 附：完整ANSI颜色表可通过man console_codes查询
-----
有 Windows CMD脚本和Linux脚本两种版本

测试 CMD/SH 脚本，不用保留版权声明(其实也没有)
