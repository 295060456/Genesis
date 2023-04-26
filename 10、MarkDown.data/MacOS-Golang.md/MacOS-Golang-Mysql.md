# 利用 Golang 向 Mysql 数据库 增/删/改 数据

[toc]

```javascript
资料来源

https://studygolang.com/articles/14642
```

## 1、下载 Mysql 的驱动包

```go
go get github.com/go-sql-driver/mysql
```

## 2、建表和字段

```mysql
CREATE TABLE IF NOT EXISTS `test`.`user` (
 `user_id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '用户编号',
 `user_name` VARCHAR(45) NOT NULL COMMENT '用户名称',
 `user_age` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户年龄',
 `user_sex` TINYINT(3) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户性别',
 PRIMARY KEY (`user_id`))
 ENGINE = InnoDB
 AUTO_INCREMENT = 1
 DEFAULT CHARACTER SET = utf8
 COLLATE = utf8_general_ci
 COMMENT = '用户表'
```

## 3、数据库的操作代码

### 3.1、**对数据的增（insert）操作**

```go
package main
import (
    "fmt"
    "database/sql"
    //导入mysql的驱动
    _ "github.com/go-sql-driver/mysql" 
)

func main(){
    //使用database/sql包中的Open连接数据库
    db,err := sql.Open("mysql","root:root@tcp(localhost:3306)/test?charset=utf8")
    if err != nil {
        fmt.Println("连接数据库失败:",err)
        return 
    }
    //使用DB结构体实例方法Prepare预处理插入,Prepare会返回一个stmt对象
    stmt,err := db.Prepare("insert into `user`(user_name,user_age,user_sex)values(?,?,?)")
    if err!=nil{
        fmt.Println("预处理失败:",err)
        return         
    }
    //使用Stmt对象执行预处理参数
    result,err := stmt.Exec("pengjin",33,"男")
    if err!=nil{
        fmt.Println("执行预处理失败:",err)
        return         
    }else{
        rows,_ := result.RowsAffected()
        fmt.Println("执行成功,影响行数",rows,"行" )
    }
}
```

### 3.2、**实现对数据的删（delete）操作**

```go
package main
import (
    "fmt"
    "database/sql"
    //导入mysql的驱动
    _ "github.com/go-sql-driver/mysql" 
)

func main(){
    //使用database/sql包中的Open连接数据库
    db,err := sql.Open("mysql","root:root@tcp(localhost:3306)/test?charset=utf8")
    if err != nil {
        fmt.Println("连接数据库失败:",err)
        return 
    }
    //直接调用db实例中的Exec方法实现预处理
    result,err := db.Exec("delete from `user` where user_id=?",1)
    if err!=nil{
        fmt.Println("预处理失败:",err)
        return         
    }

    if err!=nil{
        fmt.Println("执行预处理失败:",err)
        return         
    }else{
        rows,_ := result.RowsAffected()
        fmt.Println("执行成功,影响行数",rows,"行" )
    }
}
```

### 3.3、**实现对数据库的改（update）操作**

```go
package main
import (
    "fmt"
    "database/sql"
    //导入mysql的驱动
    _ "github.com/go-sql-driver/mysql" 
)

func main(){
    //使用database/sql包中的Open连接数据库
    db,err := sql.Open("mysql","root:root@tcp(localhost:3306)/test?charset=utf8")
    if err != nil {
        fmt.Println("连接数据库失败:",err)
        return 
    }
    //直接调用db实例中的Exec方法实现预处理
    result,err := db.Exec("update `user` set user_age=?,user_name=? where user_id=?",
    34,"zhangsan",2)
    if err!=nil{
        fmt.Println("预处理失败:",err)
        return         
    }

    if err!=nil{
        fmt.Println("执行预处理失败:",err)
        return         
    }else{
        rows,_ := result.RowsAffected()
        fmt.Println("执行成功,影响行数",rows,"行" )
    }
}
```

