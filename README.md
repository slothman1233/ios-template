# iOS MVP 框架

[TOC]



### 目录说明

```
├── Source    入口及基础配置
|   |── R.generated    获取assets图片         
|   |── Bridge         桥接文件 
|   └── TabbarVC       底部  
|── Common    公共业务
|   |── Manage         当前项目常用业务
|   |── Api            接口名称定义      
|   |── Config      公共配置
|   |   |── Config     各种全局配置以及公用的枚举
|   |── Style       样式配置
|   |   |── BaseFont         字体样式   
|   |   |── BasePadding      边距
|   |   |── BaseColor        颜色 
|   |   |── Radius           圆角
|   |   |── ProportionImage  图片比例  
|   |   |── BaseImage        公用图片及渐变色图片
|   |── BaseModel   基础model
|   └── Service     业务处理
|── Utils    工具类              
|   |── Tools     基类及常用工具类       
|   |   |── tools           工具及全局方法
|   |   |── CryptTools      加密
|   |── Extension 扩展
|   |── Cache     缓存
|   |   |── SP              沙盒
|   |   |── DB              数据库
|   |── NetWork   网络请求       
|   |   |── Net             http请求
|   |   └── Socket          长连接
|   |── Library   sdk及其封装       
|   |   |── Animate         动画
|   |   └── MessageDrop     顶部弹窗
|   |   └── YBAttributeTextTapAction     label点击
|   |   └── Alert           alert sheet弹窗
|   |   └── JYCardView      卡片式轮播
|   |   └── Scan            二维码扫描
|   |   └── Hud             hud
|   └── Adapter    屏幕适配
|── Widget    公共widget             
|   |── Widget       常用控件       
|   |── BaseView     基础控件及基类      
|   |── PresentView  mvp类view     
|   └── Viper        viper基类     
└── Pages     当前项目页面(根据项目需求自己创建)     
```


### 全局重要环境及开关配置

> 配置位置：Common-Config-Config
>

1. 网络请求地址环境
   配置位置：Common-Config-BaseApi
   环境名：DEV、Test、PTest、Production
   地址名：baseUrl="地址"


### 是否启用Debug模块单独调试模式
> 使用pLog打印即可
    


### 用户信息+Token
1. 属于公共业务 存放在 Utils--Cache-UserDefaults 中
2. Token使用 Common-Manage

   

### viper使用
1.Widget-Viper文件中均有注释
2.Pages文件中有具体实现 包括正向传值 反向传值


### 命令创建模板工程参数（脚手架创建模板使用）

1.cjjc_viper_cjjc 做为标识，新工程走命令行替换该标识即可

2.

```
切换公司npm源：
npm config set registry https://nexus.ops.hncjjc.cn/repository/npm-group/

安装脚手架：
npm i -g @cjjc/cjjc-cli
```

3.创建模板项目步骤(注意工程创建位置是命令控制台打开的位置)

​    3.1 文件夹权限问题, 解决方案 :  sudo chmod -R 777 要授权的文件目录路径

​	3.2 执行创建命令   cjjc-cli create 工程名

​	3.3 选择框架选项

​	3.4 选择ios_viper框架

​	3.5 输入{"cjjc_viper_cjjc":"项目名"} 回车即可
