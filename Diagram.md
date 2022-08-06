## 代码逻辑0726
* 初始化
	* 检查Git是否安装
	* 设置Git账户
	* 指定需要Git追踪的目录
* 检查全局量
	* 检查`.git`是否存在
	* 检查其他全局变量
* 设置文件目录及文件
	* 如果有`.git`，则根据git来
	* 如果没有则初始化生成
* 追踪Git，实现Git的功能

## 代码逻辑0806
修改逻辑到先考虑本地化功能，在考虑远端仓库;
* gitBashDev init ; 初始化git，并且生成本地git仓库,
* gitBashDev config; 配置远程github仓库设置
* gitBashDev commit；执行diff，查看区别；执行commit指令
* gitBashDev 执行push到github上；


