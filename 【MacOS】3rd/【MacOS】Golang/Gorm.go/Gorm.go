package main

import (
	"errors"
	"fmt"
	"time"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

/*
*
定义 User 模型，绑定 users 表
ORM库操作数据库，需要定义一个struct类型和MYSQL表进行绑定或者叫映射，struct字段和MYSQL表字段一一对应
在这里 User 类型可以代表 mysql users 表
*/
type User struct {
	ID int64 // 主键
	/**
	通过在字段后面的标签说明，定义golang字段和表字段的关系
	例如 `gorm:"column:username"` 标签说明含义是: Mysql表的列名（字段名)为username
	这里golang定义的Username变量和MYSQL表字段username一样，他们的名字可以不一样。
	*/
	Username string `gorm:"column:username"`
	Password string `gorm:"column:password"`
	//创建时间，时间戳
	CreateTime int64 `gorm:"column:createtime"`
}

func main() {
	//配置MySQL连接参数
	username := "Jobs"          //账号
	password := "Jobs295060456" //密码
	host := "127.0.0.1"         //数据库地址，可以是Ip或者域名
	port := 3306                //数据库端口
	Dbname := "TestGorm_db"     //数据库名

	/**
	通过前面的数据库参数，拼接MYSQL DSN， 其实就是数据库连接串（数据源名称）
	MYSQL dsn格式： {username}:{password}@tcp({host}:{port})/{Dbname}?charset=utf8&parseTime=True&loc=Local
	类似{username}使用花括号包着的名字都是需要替换的参数
	*/
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%d)/%s?charset=utf8&parseTime=True&loc=Local", username, password, host, port, Dbname)
	//连接 MYSQL
	db, err := gorm.Open(mysql.Open(dsn), &gorm.Config{})

	if err != nil {
		panic("连接数据库失败, error=" + err.Error())
	}

	// 定义一个用户，并初始化数据
	u := User{
		Username:   "tizi365",
		Password:   "123456",
		CreateTime: time.Now().Unix(),
	}

	/**
	gorm库在执行数据库操作的时候，如果出现错误，则会更新gorm.DB的Error属性
	Error属性默认为nil，因此在执行数据库操作后检测下Error属性是否为nil即可知道有没有错误发生。

	插入一条用户数据
	下面代码会自动生成 SQL 语句:
	INSERT INTO `users` (`username`,`password`,`createtime`) VALUES ('tizi365','123456','1540824823')
	*/
	if err := db.Create(&u).Error; err != nil {
		fmt.Println("插入失败", err)
		return
	}
	/**
	查询并返回第一条数据
	定义需要保存数据的 struct 变量
	*/
	u = User{}
	//自动生成sql： SELECT * FROM `users`  WHERE (username = 'tizi365') LIMIT 1
	result := db.Where("username = ?", "tizi365").First(&u)
	if errors.Is(result.Error, gorm.ErrRecordNotFound) {
		fmt.Println("找不到记录")
		return
	}
	//打印查询到的数据
	fmt.Println(u.Username, u.Password)

	/**
	更新
	自动生成 SQL:
	UPDATE `users` SET `password` = '654321'  WHERE (username = 'tizi365')
	*/
	db.Model(&User{}).Where("username = ?", "tizi365").Update("password", "654321")

	/**
	删除
	自动生成 SQL :
	DELETE FROM `users`  WHERE (username = 'tizi365')
	*/
	// db.Where("username = ?", "tizi365").Delete(&User{})
}
