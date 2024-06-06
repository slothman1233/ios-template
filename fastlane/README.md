fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

### match_all

```sh
[bundle exec] fastlane match_all
```

下载所有需要的证书和描述文件到本地，不会重新创建证书和描述文件（只读方式）

### force_match

```sh
[bundle exec] fastlane force_match
```

同步证书，如果证书过期或新增了设备，会重新创建证书和描述文件

该方法仅限管理员使用，其他开发成员只需要使用 match_all 方法即可

### nuke_all

```sh
[bundle exec] fastlane nuke_all
```

清空所有的证书和描述文件，慎用

### sync_devices

```sh
[bundle exec] fastlane sync_devices
```

注册设备，并更新描述文件

----


## iOS

### ios prepare

```sh
[bundle exec] fastlane ios prepare
```

Description of what the lane does

### ios custom_lane

```sh
[bundle exec] fastlane ios custom_lane
```



### ios pgyers

```sh
[bundle exec] fastlane ios pgyers
```



### ios dev

```sh
[bundle exec] fastlane ios dev
```



### ios test

```sh
[bundle exec] fastlane ios test
```



### ios ptest

```sh
[bundle exec] fastlane ios ptest
```



### ios prod

```sh
[bundle exec] fastlane ios prod
```



----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
