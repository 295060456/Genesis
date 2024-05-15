# Gorm 对 Mysql 的增删改查操作
# 引用项目需要的依赖增加到 go.mod 文件,并且去掉 go.mod 文件中项目不需要的依赖。
go mod tidy
# 删除下载的缓存以及解压缩的代码依赖项。这些包可以在目录中找到＄GOPATH/pkg/mod
go clean -modcache 可以清理已下载的依赖
# 安装MySQL驱动
go get -u gorm.io/driver/mysql
# 安装gorm包
go get -u gorm.io/gorm