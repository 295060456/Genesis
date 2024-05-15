package main

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

var db *sql.DB

type USER struct {
	student_id   int
	student_name string
	student_age  int
	student_sex  int
}

func main() {

	err := initDB()
	if err != nil {
		panic(err)
	}

	insert()
	queryOneRow()
}

// 获得数据库连接
func initDB() (err error) {
	dsn := "Jobs:Jobs295060456@tcp(127.0.0.1:3306)/Test_db"
	db, err = sql.Open("mysql", dsn)
	if err != nil {
		return err
	}
	err = db.Ping()
	if err != nil {
		panic(err)
	}
	return nil
}

// 数据库插入数据
func insert() {
	s := "insert into user_tbl (student_name,student_age,student_sex) values(?,?,?)"
	r, err := db.Exec(s, "zhangsan", "123", "23")
	defer db.Close()
	if err != nil {
		fmt.Printf("err: %v\n", err)
	} else {
		i, _ := r.LastInsertId()
		fmt.Printf("i: %v\n", i)
	}
}

// 单行查询
func queryOneRow() {
	s := "select * from user_tbl where student_id = ?"
	var u USER
	err := db.QueryRow(s, 1).Scan(&u.student_id, &u.student_name, &u.student_age, &u.student_sex)
	if err != nil {
		fmt.Printf("err: %v\n", err)
	} else {
		fmt.Printf("u: %v\n", u)
	}
}

// 查询多行
func queryOneSome() {
	s := "select * from user_tbl"
	r, err := db.Query(s)
	defer db.Close()
	var u USER
	if err != nil {
		fmt.Printf("err: %v\n", err)
	} else {
		for r.Next() {
			r.Scan(&u.student_id, &u.student_name, &u.student_age, &u.student_sex)
			fmt.Printf("u: %v\n", u)
		}
	}
}

// 更新数据
func queryUpdate() {
	s := "update user_tbl set student_name=?,student_age=?,student_sex=? where student_id=?"
	r, err := db.Exec(s, "new kate", "123123", "2")
	defer db.Close()
	if err != nil {
		fmt.Printf("err: %v\n", err)
	} else {
		i, _ := r.RowsAffected()
		fmt.Printf("i: %v\n", i)
	}
}

// 删除数据
func queryDelete() {
	s := "delete from user_tbl where student_id=?"
	r, err := db.Exec(s, 3)
	defer db.Close()
	if err != nil {
		fmt.Printf("err: %v\n", err)
	} else {
		i, _ := r.RowsAffected()
		fmt.Printf("i: %v\n", i)
	}
}
