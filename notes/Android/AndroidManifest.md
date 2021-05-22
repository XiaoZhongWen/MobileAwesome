## AndroidManifest

### \<uses-permission\>

**使用权限声明**

* android:permission.READ_EXTERNAL_STORAGE

  读SD卡

* android:permission.WRITE_EXTERNAL_STORAGE

  写SD卡

* MediaStore.Images.Media.INTERNAL_CONTENT_URI

  读内部存储器上的图片

* MediaStore.Images.Media.EXTERNAL_CONTENT_URI

  读SD卡上的图片

* android:permission.ACCESS_FINE_LOCATION 

* android:permission.ACCESS_COARSE_LOCATION 

* android:permission.ACCESS_BACKGROUND_LOCATION

  定位相关

* android:permission.ACCESS_NETWORK_STATE

  检测网络状态

* android:permission.ACCESS_WIFI_STATE

  检测wifi状态

* android:permission.READ_PHONE_STATE

  获取手机的IMEI

  

### \<application\>的属性

* android:allowBackup

  表示是否允许APP加入到备份还原的结构中。如果设置成false，那么应用就不会备份还原。默认值为true

  *allowBackup是Android2.2引入的一个系统备份功能，它允许用户备份系统应用和第三方应用的apk安装包和应用数据，以便在刷机或数据丢失后恢复应用，用户通过adb backup和adb restore来进行应用数据的备份和恢复。*

  *allowBackup安全风险源于adb backup容许任何一个能够打开USB 调试开关的人从Android手机中复制应用数据到外设，一旦应用数据被备份之后，所有应用数据都可被用户读取；adb restore容许用户指定一个恢复的数据来源（即备份的应用数据）来恢复应用程序数据的创建。因此，当一个应用数据被备份之后，用户即可在其他Android手机或模拟器上安装同一个应用，以及通过恢复该备份的应用数据到该设备上，在该设备上打开该应用即可恢复到被备份的应用程序的状态，尤其是通讯录应用，一旦应用程序支持备份和恢复功能，攻击者即可通过adb backup和adb restore进行恢复新安装的同一个应用来查看聊天记录等信息；对于支付金融类应用，攻击者可通过此来进行恶意支付、盗取存款等。*

  **解决方案**

  * 将allowBackup 的值设置为false；（allowBackup的值为false 对项目运行没有任何影响）
  * 通过手机设备的IMEI号来辨识来设备编号和备份前是否一致，不一致则直接跳转登陆页面的同时清空当前应用数据及缓存；

* android:supportRtl

  声明APP是否支持RTL（Right To Left）布局

* android:networkSecurityConfig

  * stateHidden

    状态隐藏，如果我们设置了这个属性，键盘状态就一定是隐藏的，不管上个界面是什么状态，也不管当前界面有没有输入的需求，就是不显示软键盘

  * stateUnchanged

    状态不改变，当前界面的软键盘状态，取决于上一个界面的软键盘状态



### \<activity\>的属性

**一个Implicit Intent发送给activity，需要进行三个匹配：action、category和data**

* android.intent.action.MAIN

  决定应用程序最先启动的Activity

* android.intent.category.LAUNCHER

  决定应用程序是否显示在程序列表里

* android.intent.category.DEFAULT

  1. Explicit Intent

     明确的指定了要启动的Acitivity

  2. Implicit Intent

     没有明确的指定要启动哪个Activity ，而是通过设置一些Intent Filter来让系统去筛选合适的Acitivity去启动

  *当通过 startActivity() 方法发出的隐式 Intent，android会默认加上一个CATEGORY_DEFAULT，如果想接收一个隐式 Intent 的 Activity，就要配置"`android.intent.category.DEFAULT`" category，否则Intent会匹配失败。*

* android.intent.category.BROWSABLE

  指定该Activity能被浏览器安全调用

* 