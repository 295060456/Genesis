# Swift 相关经验

- [Swift 相关经验](#swift-相关经验)
  - [一些相关文献](#一些相关文献)
  - [Swift视频教学](#swift视频教学)
  - [网络分层](#网络分层)
    - [OSI 参考模型](#osi-参考模型)
    - [参考模型和 TCP/IP 协议族](#参考模型和-tcpip-协议族)
  - [内存区域分类](#内存区域分类)
  - [数据结构](#数据结构)
  - [锁](#锁)
  - [在Swift中，一个结构体（*struct*），占据多大的内存？](#在swift中一个结构体struct占据多大的内存)
  - [***Copy-On-Write***](#copy-on-write)
  - [【Swift vs Java vs C/C++】***static*** 和 ***final***的区别](#swift-vs-java-vs-ccstatic-和-final的区别)
  - [Swift里面可否用*var*来接受一个*func*？](#swift里面可否用var来接受一个func)
  - [为什么在Swift里面新建一个*view*要用*struct*，而不用*class*](#为什么在swift里面新建一个view要用struct而不用class)
  - [元组（***Tuples***）和结构体（***Struct***）](#元组tuples和结构体struct)
  - [***Swift.Closure（闭包）***](#swiftclosure闭包)
  - [***Swift.初始化方法***](#swift初始化方法)
  - [***Swift.`map` 和 Swift.`joined`***](#swiftmap-和-swiftjoined)
  - [***Swift.where***](#swiftwhere)
  - [***Swift.yield***](#swiftyield)
  - [***Swift***.*mutating*](#swiftmutating)
    - [对比 ***Swift***.*mutating* 和 ***Swift***.*inout*](#对比-swiftmutating-和-swiftinout)
  - [内联函数。内联这两个字，我怎么去理解？](#内联函数内联这两个字我怎么去理解)
  - [当前函数的***上下文***。这个***上下文***是什么意思？](#当前函数的上下文这个上下文是什么意思)
  - [***Swift.依赖注入***](#swift依赖注入)
  - [*SwiftUI.UIHostingController* 和一般的控制器，有何特别之处？（向下兼容）](#swiftuiuihostingcontroller-和一般的控制器有何特别之处向下兼容)
  - [*UIKit.UIViewRepresentable* 干嘛的？（向上兼容）](#uikituiviewrepresentable-干嘛的向上兼容)
  - [属性修饰符（*Property Attributes*）≠ 属性包装器（*Property Wrappers*）](#属性修饰符property-attributes-属性包装器property-wrappers)
  - [***Swift.@标记***](#swift标记)
    - [***`@frozen`***](#frozen)
    - [***`@usableFromInline`***](#usablefrominline)
    - [***`@discardableResult`***](#discardableresult)
    - [***`@available`***](#available)
    - [***`@MainActor`***](#mainactor)
    - [***`@objc`***](#objc)
    - [***`@Binding`***](#binding)
    - [***`@escaping`***](#escaping)
    - [***`@inline`***](#inline)
    - [***`@Main`***](#main)
    - [***`@UIApplicationMain`***](#uiapplicationmain)
    - [***`@State`***](#state)
    - [***`@EnvironmentObject`***](#environmentobject)
    - [***`@Environment`***](#environment)
    - [***`@ObservedObject`***](#observedobject)
    - [***`@Published`***](#published)
  - [***`@main`***和***`@UIApplicationMain`***的区别](#main和uiapplicationmain的区别)
  - [Swift中，***Any***和***Anyobject***的区别？](#swift中any和anyobject的区别)
  - [*var body: some View*  这里面的`some`是什么意思？](#var-body-some-view--这里面的some是什么意思)
  - [`#available` 和 ***`@available`***在Swift中有什么区别？](#available-和-available在swift中有什么区别)
  - [***Swift***.***`extension`***](#swiftextension)
  - [***在Swift中，有两种类型不允许定义存储属性***：](#在swift中有两种类型不允许定义存储属性)
  - [***Swift.`初始化方法`***](#swift初始化方法-1)
  - [***Swift.`单例`***](#swift单例)
  - [***Swift.`网络请求`***](#swift网络请求)
    - [1、URLSession（原生的工具）](#1urlsession原生的工具)
    - [2、Alamofire](#2alamofire)
    - [3、Moya（基于Alamofire的二次封装）](#3moya基于alamofire的二次封装)
  - [***Swift.`Json数据解析`***](#swiftjson数据解析)
    - [1、*Codable 协议*  ***（原生.简洁.官方推荐首选）***](#1codable-协议--原生简洁官方推荐首选)
    - [2、*SwiftyJSON*（第三方.流行）](#2swiftyjson第三方流行)
    - [3、*ObjectMapper*（第三方.常用）](#3objectmapper第三方常用)
  - [***SwiftUI***](#swiftui)
  - [其他](#其他)

## 一些相关文献

[***Swift自动布局SnapKit的详细使用介绍***](https://www.jianshu.com/p/2bad53a2a180)
[***SwiftUI - 与UIKit集成***](https://www.jianshu.com/p/fbc920c11b0d)
[***SwiftUI -SwiftUI 和 UIKit 的相互引用***](https://juejin.cn/post/7153879743107399710)
[***JXSegmentedView***](https://github.com/pujiaxin33/JXSegmentedView)

## Swift视频教学

[***BBCo - iOS开发入门教程 SwiftUI 微博App项目实战 Lesson 1 (零基础学习Swift编程)***](https://www.youtube.com/watch?v=5n0qoRZ8gXA&list=PLotizAeaV0nPM7a7Yy3Uyh4rkgBvT9N_H&index=2)

## 网络分层
最常见的网络分层是 OSI（***O**pen **S**ystems **I**nterconnection*）
### OSI 参考模型

* **物理层（*Physical Layer*）**：
   - 负责传输比特流（0 和 1）。
   - 包括物理介质、电压等传输媒介的规范。
* **数据链路层（*Data Link Layer*）**：
   - 提供了物理层之上的逻辑传输，将比特流转化为数据帧。
   - 提供了数据帧的传输和错误检测。
* **网络层（*Network Layer*）**：
   - 负责将数据包从源节点传输到目的节点，跨越不同的网络。
   - 提供了路由选择、分组转发等功能。
* **传输层（*Transport Layer*）**：
   - 提供端到端的数据传输服务，确保数据的可靠性和完整性。
   - 提供了流量控制、拥塞控制等功能，如 TCP 和 UDP 协议。
* **会话层（*Session Layer*）**：
   - 管理应用程序之间的会话，建立、维护和终止会话。
   - 提供了会话管理、同步和恢复等功能。
* **表示层（*Presentation Layer*）**：
   - 负责数据的格式化、加密和解密，以确保数据的可读性和安全性。
   - 提供了数据的表示、编码和解码。
* **应用层（*Application Layer*）**：
   - 提供了网络服务和应用程序之间的接口。
   - 包括 HTTP、FTP、SMTP 等协议，以及各种应用程序。
### 参考模型和 TCP/IP 协议族

* **应用层**：包含了 OSI 参考模型中的应用层、表示层和会话层;
* **传输层**：类似于 OSI 参考模型的传输层，提供了端到端的数据传输，如 TCP 和 UDP 协议;
* **网络层**：类似于 OSI 参考模型的网络层，负责数据包的传输和路由选择，如 IP 协议;
* **链路层**：类似于 OSI 参考模型的数据链路层和物理层，负责数据帧的传输和物理介质的规范;
## 内存区域分类

*在计算机中，内存可以**根据其功能和用途**划分为不同的区域。*以下是常见的内存区域分类：(7大区)
* **代码区（*Code or Text Segment*）**
  * 代码区存储程序的可执行代码，包括机器指令和只读数据（如字符串常量）；
  * 代码区**通常是只读的**，因为程序的代码在运行时不应该被修改；
* **数据区（*Data Segment*）**
   * 数据区包含了**已初始化的全局变量和静态变量**；
   * 这些变量在程序开始时分配并初始化，存储在内存的数据段中；
* **BSS 区（*BSS Segment*）**
   * BSS（***B**lock **S**tarted by **S**ymbol*）区存储**未初始化的全局变量和静态变量**；
   * 在程序启动时，这些变量被自动初始化为零值；
* [***堆（Heap）***](# 堆(Heap))
   * 堆是动态分配的内存区域，用于存储**程序运行时动态分配的内存**；
   * [***堆(Heap)***](# 堆(Heap))上的内存可以通过函数如 `malloc()`、`calloc()` 或者 `new` 来分配，并通过 `free()` 或者 `delete` 函数来释放；
* [***栈（Stack）***](# 栈(Stack))
   * [***栈***](# 栈(Stack))用于存储函数的局部变量、函数参数、函数的**返回地址**等；
   * 每次函数调用时，会在栈上分配一块称为栈帧（Stack Frame）的内存，**函数返回后，栈帧会被销毁**；
   * [***栈***](# 栈(Stack))的大小是有限的，通常比堆的大小小得多（[***栈***](# 栈(Stack))<< [***堆***](# 堆(Heap))）；
   * 可以看作是一个**容器**；
     * 其中元素的添加和移除都发生在同一端，通常称为栈顶；
     * 向栈中添加元素的操作称为“压栈”（Push），从栈中移除元素的操作称为“弹栈”（Pop）；
     * 在栈中，最后压入的元素首先被弹出，这就是先进后出的特性；
   * 栈在计算机科学和软件工程中有广泛的应用，例如函数调用的过程、表达式求值、逆波兰表达式计算等场景都可以使用栈来实现。
* **常量区（*Constant Segment*）**：
   * 常量区存储常量值，如字符串常量；
   * 这些常量**在程序运行期间是不可修改的**；
* **全局区（*Global Segment*）**：
   * 全局区存储全局变量，但是和数据区的区别是，它包含了**未初始化的全局变量**；
   * 在程序开始时，未初始化的全局变量会被初始化为默认值；
```
1、不同操作系统和编程语言的实现可能会有所不同，上述分类只是一种常见的划分方式；
2、TCP/IP 协议族中的层次结构并不是严格按照 OSI 参考模型来定义的，但它们都提供了类似的功能；
3、网络分层的好处在于可以提高系统的模块化、灵活性和可维护性，同时也促进了不同厂商之间的互操作性；
```
## 数据结构

* **单向链表**是一种常见的链表数据结构

  * 它由一系列节点组成，每个节点包含两部分：**数据部分**和**指向下一个节点的指针（或者称为链接或引用）**；
  * 在单向链表中，每个节点只有一个指向下一个节点的指针，**而没有指向前一个节点的指针**；
  * 单向链表的特点包括：

    * **节点结构**：每个节点包含一个数据元素以及一个指向下一个节点的指针。
    * **头节点**：链表的起始节点称为头节点。头节点不包含有效的数据元素，它的主要作用是指向链表的第一个节点。
    * **尾节点**：链表的最后一个节点称为尾节点。尾节点的指针指向 NULL（或者称为 Nil、None），表示链表的结束。
    * **动态内存分配**：单向链表中的节点是动态分配的，可以根据需要动态地添加或删除节点，因此单向链表具有灵活的内存管理特性。
    * **顺序访问**：单向链表只能从头节点开始顺序访问，因为每个节点只有指向下一个节点的指针，无法直接访问前一个节点。
  * **单向链表适用于需要频繁插入和删除操作的场景**，因为它们不需要像数组那样移动大量元素来进行插入和删除操作。然而，单向链表的缺点是访问任意位置的元素的效率较低，需要从头节点开始顺序遍历链表。
  * 单向链表的环
    * 链表中某个节点指向链表中的一个先前节点，从而形成了一个闭合的循环结构
    * 链表中某个节点的 next 指针指向了链表中已经遍历过的节点，则称该链表中存在环；
    * 如果链表中不存在环，则称其为单向链表；
    * 如果链表中存在环，则称其为带环链表；
    * 检测链表中是否存在环通常可以通过快慢指针的方法来实现：使用两个指针，一个快指针每次移动两步，一个慢指针每次移动一步。**如果链表中存在环，那么这两个指针最终会相遇**；**如果链表中不存在环，则快指针会先到达链表的末尾**。
  * 带环链表：指链表中某个节点指向了链表中已经遍历过的节点，形成了一个闭合的循环结构。
    * 可以通过快慢指针的方法进行检测：使用两个指针，一个快指针每次移动两步，一个慢指针每次移动一步，如果链表中存在环，那么这两个指针最终会相遇；如果链表中不存在环，则快指针会先到达链表的末尾。
    * 带环链表的存在可能会导致一些问题，比如在遍历链表时可能陷入死循环，或者在执行某些操作时可能无法正确地终止。因此，在实现链表操作时，**需要特别注意处理带环链表的情况**。
  * 无论是单向链表还是双向链表。带环链表是指链表中某个节点指向了链表中已经遍历过的节点，形成了一个闭合的循环结构
* **双向链表**是一种链表数据结构，每个节点包含两个指针，分别**指向前一个节点和后一个节点**，因此可以从任一方向遍历整个链表。
  * 双向链表的特点包括：
    * **节点结构**：每个节点包含数据元素以及两个指针，分别指向前一个节点和后一个节点；
    * **头节点和尾节点**：与单向链表类似，双向链表也可以有头节点和尾节点。头节点指向链表的第一个节点，尾节点指向链表的最后一个节点；
    * **双向遍历**：由于每个节点都有指向前一个节点和后一个节点的指针，因此可以从头节点开始向后遍历，也可以从尾节点开始向前遍历；
    * **动态内存分配**：双向链表中的节点也是动态分配的，可以根据需要动态地添加或删除节点；

  * 双向链表相比于单向链表，提供了更灵活的遍历方式，可以从任一方向快速访问链表的元素；

  * 然而，双向链表相对于单向链表，占用的空间更大，因为每个节点需要存储额外的指向前一个节点的指针；

  * 双向链表的实现会避免出现环的情况。在某些特殊情况下，**双向链表也可能出现环，这通常是由于程序错误导致的**；
*  *堆(**Heap**)*

  * <font color="red">***堆内存的分配和释放是由程序员手动管理的***</font>，通常通过 `malloc`、`calloc`、`realloc` 等函数进行分配，通过 `free` 函数进行释放；
  * 堆区相对于栈区更靠内存高字节；（内存后部署堆区）
  * 堆内存的分配不是连续的，它的分配由系统的内存管理器根据需要从堆中的空闲内存块中分配合适大小的内存；
  * 堆内存是用于**存储动态分配的内存**，通常用于存储动态创建的对象、数据结构等；
  * 在堆上分配的内存由 **ARC**（***A**utomatic **R**eference **C**ounting*）管理；
  * 存储：<u>**类实例.方法**</u>、<u>**类实例.属性**</u>；
  * **存放引用类型**：*Class*类型、闭包和函数；
    * 浅拷贝；
    * **堆操作牵涉到合并、移位、重新链接等**；
*  *栈(**Stack**)*

  * <font color="red">***栈上的内存分配和释放由编译器（或操作系统）自动管理***</font>，通常以页为单位进行分配和管理；
  * 数据先进后出（**L**ast-**I**n-**F**irst-**O**ut，**LIFO**）
  * 栈内存通常是一块**固定大小**的内存区域，用于存储函数调用的**局部变量**、**函数参数**、**函数调用的返回地址**等信息；
  * **栈内存是连续的**，即在栈中分配的内存地址是依次递增的；
  * 栈区相对于堆区更靠内存低字节；（内存先部署栈区）
  * 将*String*，*Array*，*Dictionary*设计成值类型，**大幅减少了堆上的内存分配和回收的次数**。同时[***C**opy-**O**n-**W**rite*](# Copy-On-Write)又将值传递和复制的开销降到了最低；
  * **存放值类型**：结构体（*struct*）、枚举（*enum*）、元祖（*tuple*）；
    * 深拷贝：可以确保在函数内部或者在其他变量中修改值类型的值时，不会影响到原始值；
    * 性能优势：**仅仅是单个指针的上下移动**；
    * 线程安全：直接存储于内存 ＋ 不需要引用（没有引用计数）和垃圾回收等操作 = 不会发生因为引用计数的增减而引起的竞态条件；
* **队列（Queue）**
  * 一种先进先出（**F**irst-**I**n-**F**irst-**O**ut，**FIFO**）的线性数据结构；
  * 支持在一端进行插入操作，在另一端进行删除操作；
  * 队列常用于实现任务调度、消息传递等场景；
* **数组（Array）**

  * 一种**线性数据结构**，由一组**连续的内存单元**组成，用于**存储相同类型的数据**元素；
  * 数组支持随机访问，但插入和删除操作的效率较低；
* 字符串 == 字符数组。可以使用下标索引来访问字符串中的字符。特别是在C语言中，字符串通常被存储为字符数组，**以 null 字符（'\0'）结尾**；
* **哈希表（Hash Table）**

  * 一种使用哈希函数来实现**键值对映射**的数据结构；
  * 支持快速的查找、插入和删除操作；
  * 哈希表常用于实现关联数组、集合等；
* **哈希映射（HashMap）**

  * 也称为关联数组、字典或映射，存储键值对的集合，通过键快速查找对应的值
* **哈希集合（HashSet）**

  * 类似于哈希表，但**只存储键而不存储值**，用于**存储不重复的元素集合**
* **树（Tree）**

  * 一种**非线性数据结构**；
  * 由节点和边组成，每个节点可以有零个或多个子节点；
  * 树常用于表示层次关系，如文件系统、组织结构等；
* **二叉树（Binary Tree）**：一种特殊的树形数据结构，**每个节点最多有两个子节点**，分为**左子树**和**右子树**

  * **红黑树（Red-Black Tree）**：一种自平衡的二叉查找树，保持良好的平衡性能，用于实现有序集合和映射；
  * **AVL树**：一种高度平衡的二叉查找树，通过旋转操作来保持平衡，用于实现有序集合和映射。
* **B树（B-Tree）**：一种多路搜索树，每个节点可以存储多个键值对，**用于实现数据库索引、文件系统**等。
* **Trie树（Trie Tree）**：也称为字典树或前缀树，用于**高效地存储和检索字符串集合**。
* **字典树（Suffix Tree）**：用于高效地存储和检索字符串集合的一种树形数据结构，通常**用于字符串匹配和搜索**。
* **图（Graph）**

  * 一种非线性数据结构；
  * 由节点（顶点）和边组成，用于表示各种实体之间的关系；
  * 图常用于网络分析、路由算法等场景。

## 锁

在操作系统中，常见的锁包括：

* **互斥锁（Mutex Lock）：** 互斥锁是最基本的一种锁，用于保护临界区，确保在同一时刻只有一个线程可以访问共享资源。当一个线程持有互斥锁时，其他线程必须等待该线程释放锁才能访问共享资源。

* **自旋锁（Spin Lock）：** 自旋锁是一种忙等待的锁，当线程尝试获取锁时，如果锁已被其他线程持有，则该线程会循环等待直到锁被释放。自旋锁适用于对临界区的访问时间很短的情况。

* **读写锁（Read-Write Lock）：** 读写锁允许多个线程同时读取共享资源，但是在写操作时需要互斥访问。读写锁通过分离读操作和写操作来提高并发性能。

* **条件变量（Condition Variable）：** 条件变量通常与互斥锁一起使用，用于实现线程间的同步。它允许线程在特定条件下等待并在条件满足时被唤醒。条件变量提供了 `wait`、`signal` 和 `broadcast` 等操作。

* **信号量（Semaphore）：** 信号量是一种计数器，用于控制对共享资源的访问。它可以用于限制同时访问共享资源的线程数量，或者用于线程间的同步和通信。

* **屏障（Barrier）：** 屏障用于在多线程环境下同步多个线程的执行顺序。它可以保证在达到屏障之前的所有线程都执行完毕后，再执行屏障之后的操作。

这些锁和同步机制在操作系统中起着至关重要的作用，可以有效地控制对共享资源的访问，保证多个线程之间的协调和同步。不同的锁适用于不同的场景和需求，开发人员需要根据具体的应用场景选择合适的锁来实现线程安全和并发控制。

```swift
import Foundation

class CustomLock {
    private var lock = NSLock()
    
    func lock() {
        lock.lock()
    }
    
    func unlock() {
        lock.unlock()
    }
}

func testCustomLock() {
    let lock = CustomLock()
    
    DispatchQueue.global().async {
        lock.lock()
        print("Thread 1: Lock acquired")
        sleep(2) // 模拟一些工作
        lock.unlock()
        print("Thread 1: Lock released")
    }
    
    DispatchQueue.global().async {
        lock.lock()
        print("Thread 2: Lock acquired")
        sleep(2) // 模拟一些工作
        lock.unlock()
        print("Thread 2: Lock released")
    }
    
    // 防止主线程结束
    dispatchMain()
}

testCustomLock()

/**
在这个示例中，我们定义了一个名为 CustomLock 的类，它使用 NSLock 来实现互斥锁。
lock 方法通过调用 NSLock 的 lock 方法来获取锁，unlock 方法通过调用 NSLock 的 unlock 方法来释放锁。
在 testCustomLock 函数中，我们创建了一个 CustomLock 对象，并在两个后台线程中分别调用 lock 和 unlock 方法来模拟锁的获取和释放。
最后，我们调用 dispatchMain() 来防止主线程提前结束。
*/
```

## 在Swift中，一个结构体（*struct*），占据多大的内存？

* 在Swift中，结构体（*struct*）的大小取决于其包含的成员变量的大小和对齐方式；
* Swift 的内存布局是由编译器决定的，并且受到目标平台和编译器版本等因素的影响；
* 通常情况下，***结构体的内存布局是按照其成员变量的顺序依次排列的，并且可能会进行字节对齐***。这意味着如果结构体的成员包含不同类型的数据，编译器**可能会在其间插入一些填充字节以保持对齐**。
你可以使用Swift的`MemoryLayout`来获取结构体的大小。例如：
```swift
struct MyStruct {
    var member1: Int
    var member2: Double
    var member3: Bool
}

let size = MemoryLayout<MyStruct>.size
print("MyStruct 占用的内存大小为 \(size) 字节")
```
这将输出结构体 `MyStruct` 占用的字节数。请注意，实际的大小可能因为对齐而有所不同。如果你需要详细的信息，你还可以使用 `MemoryLayout<MyStruct>.alignment` 和 `MemoryLayout<MyStruct>.stride` 来获取对齐和步幅的信息。
```swift
let alignment = MemoryLayout<MyStruct>.alignment
let stride = MemoryLayout<MyStruct>.stride

print("MyStruct 对齐方式为 \(alignment) 字节")
print("MyStruct 步幅为 \(stride) 字节")
```
总之，要确定一个结构体占据多大的内存，最好使用 `MemoryLayout`。
## <font color="red">***Copy-On-Write***</font>

* **C**opy-**O**n-**W**rite（COW）是一种内存管理技术，通常**用于优化复杂数据结构的拷贝操作**。
* 它的基本思想是**延迟拷贝**，只有在**需要修改数据时才进行实际的拷贝操作**，这样可以节省内存和提高性能。
* 具体来说，**当多个变量共享同一块内存时，如果其中一个变量需要修改数据，那么就会进行拷贝操作，而不是直接修改原始数据**
  * 这样，在修改数据之前，所有的变量都指向同一块内存，称为*共享状态*；
  * 而在修改数据后，修改发生的变量会拷贝一份数据到新的内存空间，然后修改新的内存空间中的数据，这样其他变量不受影响，仍然指向原来的内存空间。
* **C**opy-**O**n-**W**rite 的优点是在**大部分情况下避免了不必要的数据拷贝**，节省了内存和运行时间。它通常用于处理复杂数据结构，如字符串、数组、字典等，这些数据结构在进行赋值操作时可能需要进行大量的数据拷贝，使用 **C**opy-**O**n-**W**rite技术可以显著提高性能。
* 在实际应用中，**C**opy-**O**n-**W**rite 技术常见于编程语言的标准库中，如 Swift 中的<font color="red">***字符串和数组类型***</font>就采用了**C**opy-**O**n-**W**rite  
## 【Swift vs Java vs C/C++】<font color="red">***static***</font> 和 <font color="red">***final***</font>的区别

* ### <font color="red">***static***</font>
  
  * #### C/C++
    
    * 在函数内部，<font color="red">***static***</font> 关键字用于**声明静态局部变量**。这些变量**在整个程序的生命周期内保持其值，但只在声明它们的函数内可见**；
    * 在全局作用域，<font color="red">***static***</font>关键字用于限制变量和函数的可见性。使用<font color="red">***static***</font>关键字声明的全局变量和函数**只在当前源文件中可见，对其他源文件不可见**；
    * 存储在数据段中的**静态存储区**；
  * #### Java
    
    - 在 Java 中，<font color="red">***static***</font>关键字用于**声明静态成员**（静态变量和静态方法）。静态成员属于类而不是类的实例，可以通过类名直接访问，而不需要创建类的实例；
    - 静态成员**在整个程序的生命周期内保持其值**，并且可以被类的所有实例共享；
    - 存储在**方法区（Method Area）**中；
  * #### Swift
    
    * 在 Swift 中，<font color="red">***static***</font>关键字用于定义类型范围的属性和方法。这些属性和方法属于类型本身，而不是类的实例或结构体的实例；
    * 这些属性和方法**在整个程序的生命周期内保持其值**，并且可以通过类型名来访问，而不需要创建实例；
    * [***定义单例***](# Swift单例的写法和用法)
    * 在 Swift 中，静态成员的存储位置**取决于具体的上下文**；
      * 在类中，静态属性和方法通常存储在类的元类型中，而元类型本身**存储在[*堆*](# 堆(Heap))上**；
      * 而在结构体或枚举中，静态属性和方法**存储在静态数据区**中；
* ### <font color="red">***final***</font>
  
  * #### C/C++
    
    * **没有 <font color="red">*final*</font> 关键字的概念**。如果要限制变量的值不可修改，可以使用 `const` 关键字来声明常量
    ```c
    const int constantValue = 10; // 声明一个常量
    ```
  * #### Java
    
    * 当一个类被声明为<font color="red">***final***</font>时，它**不能被其他类继承**；
    * 当一个方法被声明为<font color="red">***final***</font>时，它**不能被子类重写**；
    * 当一个变量被声明为<font color="red">***final***</font>时，它的**值不能被修改，相当于常量**（**内存分布：常量池**）；
    * 在内存中，<font color="red">***final***</font>类的对象和成员变量**存储在[***堆(Heap)***](# 堆(Heap))上**，和普通类的对象存储位置相同；
  * #### Swift
    
    - 在 Swift 中，<font color="red">***final***</font>关键字用于限制类、方法或者属性**不可被继承或者重写**；
    - 当一个类被声明为<font color="red">***final***</font> 时，它**不能被其他类继承**；
    - 当一个方法或者属性被声明为<font color="red">***final***</font>时，它**不能被子类重写**；
    - 在内存中，<font color="red">***final***</font>方法或属性的存储位置和普通方法或属性相同，取决于具体的上下文环境；
      * **堆（*Heap*）**：如果方法或属性属于类的实例，则它们通常**存储在[*堆*](# 堆(Heap))上**（ARC）；
      * **栈（*Stack*）**：如果方法或属性属于结构体的实例或是局部变量，则它们通常存储在[***栈***](# 栈(Stack))上（编译器自动）；
      * **常量池（*Constant Pool*）**：对于某些特定的常量或静态变量，它们可能被存储在常量池中，这取决于编译器的优化和实现方式；
## Swift里面可否用*var*来接受一个*func*？

**不能直接使用<font color="red">*var*</font>关键字来声明一个变量来接受一个函数。但是可以变通处理（转变为类型）👇🏻**

````swift
// 声明一个函数类型
typealias MyFunctionType = (Int, Int) -> Int
// 使用变量来接受函数
var myFunction: MyFunctionType
// 分配一个具体的函数给变量
myFunction = { (a, b) in
    return a + b
}
// 调用保存在变量中的函数
let result = myFunction(2, 3)
print(result)  // 输出: 5
````
## 为什么在Swift里面新建一个*view*要用*struct*，而不用*class*

```swift
在 SwiftUI 中，视图（View）被建议使用结构体（struct）而不是类（class）。
这是因为 SwiftUI 采用了声明式的编程范式，而结构体更符合声明式编程的特性。
```
*下面是一些原因：*
* 不可变性：结构体是值类型，而类是引用类型。值类型在传递和复制时会产生副本，这有助于保持不可变性；
  * SwiftUI 的设计倾向于使用不可变的数据模型，以确保状态的一致性和可预测性；

* 简单性和可预测性：结构体更简单，不涉及继承和引用计数等概念，使得代码更易于理解和维护。结构体通常更容易推导和预测其行为。
* 值语义：结构体提供了值语义，这意味着它们的比较是基于值而不是引用的；
  * 这有助于在 SwiftUI 中更容易管理视图层次结构和状态。

* 性能优势:结构体在一些情况下可能具有性能优势；
  * 由于值语义和不可变性，Swift 编译器可以进行更多的优化，例如避免不必要的副本操作；

*综上所述：*

```swift
在 SwiftUI 中，View 协议的实现通常要求是不可变的，因此使用结构体是一个自然的选择。
在 SwiftUI 中创建的视图是根据数据模型的变化而自动更新的，这与结构体的值语义非常契合。

尽管 SwiftUI 偏向结构体，但在其他上下文中，仍然可能使用类，特别是在需要引用语义和共享可变状态的情况下。
在 SwiftUI 中，这样的情况相对较少，因为 SwiftUI 本身的设计目标是通过数据驱动界面。
```
## 元组（***Tuples***）和结构体（***Struct***）

* 都可以包含不同的数据类型；
* 在 Swift 中，元组的内存结构并不一定是连续的，因为 Swift 元组的实现方式可以根据编译器的优化和其他因素而有所不同。而结构体的内存是连续的；
* 结构体是一种自定义数据类型，你需要在代码中明确定义它的结构，并为其提供属性和方法。结构体的成员可以是不同类型的数据；
* 元组则是一种轻量级的数据结构，它不需要在代码中显式声明，而是通过在使用时直接定义。元组的主要用途是在**临时情况下组合**多个值，而不需要为其定义专门的结构；
* 元组的比较需要遵循的规则
  * 两个元组的元素个数必须相同
  * 对应位置的元素类型必须相同，并且支持比较操作
  * 元组的元素个数实际上是没有硬性限制的。可以创建包含任意数量元素的元组

## ***Swift.Closure（闭包）***

<font color="red">即，C语言中的***Block***</font>

* 匿名闭包（*Anonymous Closure*）

```swift
// 无参数，无返回值的匿名闭包
let closure1 = {
    print("This is an anonymous closure.")
}
// 带参数，带返回值的匿名闭包
let closure2 = { (name: String) -> String in
    return "Hello, \(name)!"
}
// 调用匿名闭包
closure1()
let greeting = closure2("World")
print(greeting)
```

* 带参数的闭包（*Closure with Parameters*）

```swift
let add: (Int, Int) -> Int = { (a, b) in
    return a + b
}

let result = add(3, 5)
print(result) // 输出: 8
```

* 尾随闭包（*Trailing Closure*）

```swift
func performOperation(_ operation: () -> Void) {
    // 执行闭包操作
    operation()
}
// 调用函数时使用尾随闭包
performOperation {
    print("Performing an operation.")
}
```

* 逃逸闭包（*Escaping Closure*）

*逃逸闭包不带捕获值*

```swift
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func executeCompletionHandlers() {
    for handler in completionHandlers {
        handler()
    }
}

someFunctionWithEscapingClosure {
    print("Closure has escaped.")
}

executeCompletionHandlers() // 输出: Closure has escaped.
```

*逃逸闭包带捕获值（Escaping Closure with Captured Values）*

```swift
var closure: (() -> Int)?

func someFunctionWithEscapingAndCapture(capture: Int, completionHandler: @escaping () -> Int) {
    closure = completionHandler
    print("Closure captured value: \(capture)")
}

someFunctionWithEscapingAndCapture(capture: 10) {
    return $0 * 2
}

if let closure = closure {
    let result = closure()
    print("Result: \(result)") // 输出: 20
}
```

* 自动闭包（*Autoclosure*）

```swift
func functionWithAutoclosure(closure: @autoclosure () -> Int) {
    let result = closure()
    print("Result is \(result)")
}

// 调用时自动包装成闭包
functionWithAutoclosure(closure: 3 + 5) // 输出: Result is 8
```

* 带捕获值的闭包（*Closure with Captured Values*）

```swift
func makeAdder(_ x: Int) -> (Int) -> Int {
    return { y in
        return x + y
    }
}

let addTwo = makeAdder(2)
let result = addTwo(3) // 输出: 5
```

* 泛型闭包（*Generic Closure*）

```swift
func apply<T>(_ value: T, _ closure: (T) -> T) -> T {
    return closure(value)
}

let result = apply(5) { $0 * 2 } // 输出: 10
```

## ***Swift.初始化方法***

初始化方法负责确保新创建的实例在使用之前完成所有必要的初始化工作。

* 类的初始化方法

  * 指定初始化方法（*Designated Initializers*）：用于初始化该类所定义的所有属性，并且调用父类的初始化方法确保整个类层次结构被正确初始化。
    * 指定初始化方法可以有一个或多个，但只能有一个指定初始化方法在类的继承链中最终被调用来完成初始化；
    * 其他的指定初始化方法可以提供额外的初始化路径，但它们***最终都要调用同一个指定初始化方法来保证对象完全初始化***；
    * 如果一个类有多个指定初始化方法，它们之间必须保证参数列表不同，这样编译器才能够正确地区分它们；

  ```swift
  class MyClass {
      var property: Int
      
      init(property: Int) {
          self.property = property
      }
  }
  ```

  * 便捷初始化方法（*Convenience Initializers*）：用于简化类的初始化过程，必须调用同一类中的另一个初始化方法（可以是指定初始化方法或其他便捷初始化方法）作为最终的初始化点。<font color="red">***convenience***</font>

  ```swift
  class MyClass {
      var property: Int
      
      init(property: Int) {
          self.property = property
      }
      
      convenience init() {
          self.init(property: 0)
      }
  }
  ```

  * 必要初始化方法（*Required Initializers*）<font color="red">***required***</font>

  ```swift
  class MyClass {
      var property: Int
      
      required init(property: Int) {
          self.property = property
      }
  }
  
  class MySubclass: MyClass {
      var additionalProperty: String
      
      init(property: Int, additionalProperty: String) {
          self.additionalProperty = additionalProperty
          super.init(property: property)
      }
      
      required init(property: Int) {
          self.additionalProperty = "default"
          super.init(property: property)
      }
  }
  ```

* 结构体和枚举的初始化方法：因为没有继承的概念，因此无需考虑指定初始化方法和便捷初始化方法。

```swift
struct MyStruct {
    var property: Int
    init(property: Int) {
        self.property = property
    }
}

enum MyEnum {
    case case1, case2
    init() {
        self = .case1
    }
}
```

## ***Swift.`map` 和 Swift.`joined`***

在Swift中，`map` 和 `joined` 是两个不同的方法。
* `map`方法： 它用于对集合中的每个元素应用一个转换，返回一个包含转换结果的新集合。例如：
```swift
let numbers = [1, 2, 3, 4]
let squaredNumbers = numbers.map { $0 * $0 }
// squaredNumbers 现在是 [1, 4, 9, 16]
```
* `joined`方法： 它用于将包含子集合的集合（例如嵌套数组）连接成一个单一的集合。通常与`flatMap`结合使用。例如：
```swift
let nestedArray = [[1, 2], [3, 4], [5, 6]]
let flattenedArray = nestedArray.joined().map { $0 * 2 }
// flattenedArray 现在是 [2, 4, 6, 8, 10, 12]
```
## ***Swift.where***

* 在Swift中，<font color="red">***where***</font> 关键字主要用于**对泛型提供额外的条件约束**，以确保在特定条件下的类型兼容性；
* 它在泛型参数列表之后，可以用于指定一些条件，以限制泛型的类型。<font color="red">***where***</font> 子句通常在函数、结构体、类、枚举的定义中出现；
例如，考虑以下泛型函数的声明：
```swift
// 泛型类型 `T` 必须符合 `Equatable` 协议，这样函数就可以使用 `==` 运算符比较 `value` 的相等性。
func someFunction<T>(value: T) where T: Equatable {
    // 函数体
}
```
<font color="red">***where***</font> 子句也可以在[***扩展（extension）***](# Swift.extension)中使用，例如：

```swift
extension Array where Element: Equatable {
    // 扩展适用于数组元素是 Equatable 的情况。这使得在特定条件下对类型进行泛型扩展成为可能。
}
```
## ***Swift.yield***

***yield***：
*【v】产生（收益、效益等），产生（结果）；出产（天然产品，农产品，工业产品）；屈服，让步；放弃，让出；给（大路上的车辆）让路；（受压）活动，弯曲，折断；<正式>被……替代；请（某人）讲话；停止争论*
*【n】产量；收益，利润，红利（或股息）率*

* 在Dart中，<font color="red">***yield***</font> 关键字通常与`Iterable`相关的函数一起使用，例如`Iterable`或`Stream`；
* <font color="red">***yield***</font>用于**在迭代中产生值，而不是一次性返回所有值**。这使得函数可以在需要时生成值，而不必一次性生成所有值，这在**处理大量数据或无限数据流**时非常有用。

*以下是一个简单的示例，演示了如何使用  <font color="red">yield</font> 在Dart中创建一个生成器函数：*

```dart
// 默认情况下，Dart 中的生成器函数是同步的，即使不显式地使用 sync* 关键字声明。
// 这意味着生成器函数会在需要时立即生成值，但不会涉及异步操作
Iterable<int> generateEvenNumbers(int n) sync* {
  for (int i = 0; i < n; i++) {
    if (i % 2 == 0) {
      // 在生成器函数中，yield 不会结束函数的执行，而只是暂停函数的执行，并返回生成的值。
      yield i;
    }
  }
}

void main() {
  // 生成前10个偶数
  var evenNumbers = generateEvenNumbers(10);
  // 打印生成的偶数
  for (var number in evenNumbers) {
    print(number);
  }
}
```
* 在这个示例中，`generateEvenNumbers`函数是一个生成器函数，它使用<font color="red">sync*</font>关键字（显式）声明；
* 在循环中，如果`i`是偶数，则通过<font color="red">*yield*</font>语句产生该值；
* 在`main`函数中，我们使用`generateEvenNumbers`生成前10个偶数，并通过`for-in`循环逐个打印这些偶数；
* **需要注意的是，生成器函数中的<font color="red">*yield*</font> 语句并不会立即执行，而是在调用生成器函数的迭代器时才执行；**

## ***Swift***.<font color="red">*mutating*</font>

***mutating***：

*【vi.】突变，变异（mutate 的现在分词）*

*【vt.】使突变（mutate 的现在分词）*

* 用于结构体（*struct*）和枚举（*enum*）中的**方法声明**中，*表示该方法可以修改该结构体或枚举的属性值*，即使该方法在实例被声明为常量（`let`）时调用也可以；
* 对于类（*class*）中的方法，不需要使用<font color="red">*mutating*</font>关键字，因为类是引用类型，即使在常量类实例上调用方法，也可以修改其属性；
```swift
struct Point {
    var x = 0.0
    var y = 0.0
    // 如果不将该方法标记为mutating，试图在常量结构体实例上调用此方法时将会导致编译错误。
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var point = Point(x: 1.0, y: 1.0)
print("Before moving: \(point)")

point.moveBy(x: 2.0, y: 3.0)
print("After moving: \(point)")
```
### 对比 ***Swift***.<font color="red">*mutating*</font> 和 ***Swift***.<font color="red">*inout*</font>

* <font color="red">***inout***</font>
  
  *  <font color="red">*inout*</font>是Swift中**用于函数参数**的关键字。它**允许函数修改参数**的值，并且这种修改是在函数内部生效并影响到函数外部传入的实际参数；
  * 使用<font color="red">*inout*</font>时，传入函数的参数被当做可变的，因此函数可以对其进行修改。在函数内部对<font color="red">*inout*</font>参数的任何更改都会反映到调用该函数时传入的原始参数上；
  * <font color="red">*inout*</font>参数本质上是**传递参数的引用**，因此对参数的任何更改都会影响调用者的原始数据；
  * 定义函数的时候加<font color="red">*inout*</font>;
  * <u>**使用的时候配合取地址符号`&`使用**</u>
  ```swift
  // 定义一个函数，接受一个 inout 参数
  func increment(value: inout Int) {
      value += 1
  }
  // 定义一个变量
  var number = 5
  
  print("Before increment: \(number)")
  
  // 调用函数，并传递变量的引用作为参数
  increment(value: &number)
  
  print("After increment: \(number)")
  
  // 输出结果将会是：
  Before increment: 5
  After increment: 6
  ```
* <font color="red">***mutating***</font>（***专修结构体和枚举***）
  
  * <font color="red">*mutating*</font>是Swift中**用于结构体和枚举中方法**的关键字。它**允许方法修改结构体或枚举的实例属性**。由于结构体和枚举是值类型，它们的属性默认是不可变的。因此，如果需要在方法中修改属性，则必须将方法标记为<font color="red">*mutating*</font>；
  * <font color="red">*mutating*</font>关键字仅用于值类型（结构体和枚举）的方法声明。这样的方法可以修改调用该方法的实例的属性值；
## 内联函数。内联这两个字，我怎么去理解？

```
理解内联（Inlining）涉及到编程语言的编译和执行的一些概念。
简单来说，内联是一种编译器优化技术，它将调用函数的地方直接替换为被调用函数的实际代码，而不是通过在执行时跳转到函数的位置。
这样可以减少函数调用的开销，提高代码的执行效率。
```
*具体来说，理解内联函数涉及以下几个概念：*
* 函数调用开销
  * 在程序执行期间，每次调用函数都会引入一些开销，如保存当前函数的上下文、跳转到被调用函数的位置、执行函数体等；
  * 对于一些小而频繁调用的函数，这些开销可能在一定程度上影响性能；
* 内联优化
  * 内联是一种编译器优化策略，它试图减少函数调用的开销，将函数调用处直接替换为函数体的内容；
  * 这样可以避免调用开销，减少了跳转和上下文保存的开销；
  <font color="red">***内联的适用情况： 内联适用于一些小型的、频繁调用的函数，这样可以减少函数调用的开销，提高性能。***</font>
  ***但并不是所有函数都适合内联，因为内联会增加代码的体积，可能导致代码膨胀。***
  ***@inlineable*** 和 ***@usableFromInline***
* 在 Swift 中，可以使用***@inlineable*** 和 ***@usableFromInline*** 属性来影响编译器对函数的内联决策；
* ***@inlineable*** 表示一个函数可以被内联，但具体是否内联取决于编译器的决策；
* ***@usableFromInline*** 则用于指示一个函数可以在同一模块的其他地方内联使用；
* 在 Swift 中，编译器会根据具体情况决定是否内联函数，而使用 ***@inlineable*** 和 ***@usableFromInline*** 可以影响这个决策；
* 开发者通常无需过多关注内联，因为 Swift 的编译器会自动进行相应的优化；
## 当前函数的<font color="red">***上下文***</font>。这个<font color="red">***上下文***</font>是什么意思？
在计算机科学中，函数的上下文（***Context***）通常指的是<font color="red">***函数执行时的运行环境，包括函数调用时的一些信息和状态***</font>。
* 这个上下文包括但不限于以下内容：
  * 局部变量：
    * 函数内部声明的局部变量和参数是函数上下文的一部分；
    * 这些变量在函数调用时被创建，在函数返回时被销毁；
  * 参数：函数的参数值是上下文的一部分，它们存储了调用函数时传递的实际参数；
  * 函数的返回地址：在函数调用时，调用点的地址通常会被保存下来，以便在函数执行完成后返回到正确的位置；
  * 调用[***栈***](# 栈(Stack))信息：函数调用时，系统会在调用栈上保留一些信息，包括返回地址、局部变量和其他与函数调用相关的信息；
  * 寄存器状态：当函数被调用时，一些寄存器的状态也可能被保存，以便在函数返回时能够恢复调用前的寄存器状态；
  * 异常处理信息：如果支持异常处理机制，相关信息也可能包含在函数的上下文中；
* 值得注意：
  * 这些信息组成了函数的上下文，它在函数调用期间用于保持函数的执行状态；
  * 在函数执行完成后，这个上下文的信息通常被恢复或者销毁；
  * 函数的上下文是为了支持函数调用的正确执行而存在的，它确保了在函数调用期间可以正确地传递参数、保存执行状态，以及函数返回时恢复执行环境；
## ***Swift.依赖注入***
***UserService 使用依赖注入的 Logger 对象来记录日志***

```swift
import Foundation
// 依赖注入的协议
protocol Logger {
    func log(message: String)
}

// 实现依赖注入协议的具体类
class ConsoleLogger: Logger {
    func log(message: String) {
        print("ConsoleLogger: \(message)")
    }
}
// 依赖注入的类
class UserService {
    let logger: Logger
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func doSomething() {
        // 使用依赖注入的 Logger 对象记录日志
        self.logger.log(message: "Something is done in UserService")
    }
}
// 创建一个 ConsoleLogger 实例
let consoleLogger = ConsoleLogger()
// 创建 UserService 实例，并传入 ConsoleLogger 依赖
let userService = UserService(logger: consoleLogger)
// 调用 UserService 的方法
userService.doSomething()
```
*  ***UserService*** 类，它依赖于 ***Logger*** 类型的对象来记录日志；
* 在初始化 ***UserService***  实例时，我们通过构造函数将 ***ConsoleLogger*** 的实例传递给 ***UserService*** ，实现了依赖注入；

## *SwiftUI.UIHostingController* 和一般的控制器，有何特别之处？（向下兼容）

* SwiftUI 视图的承载：*UIHostingController*的主要功能是将 SwiftUI 的视图嵌入到 UIKit 中。你可以通过在*UIHostingController*中设置一个 SwiftUI 视图，将 SwiftUI 和 UIKit 进行无缝集成。<font color="red">**SwiftUI.view 👉🏻UIKit**</font>
 ```swift
 let swiftUIView = MySwiftUIView()
 let hostingController = UIHostingController(rootView: swiftUIView)
 ```
* 动态视图更新：由于 SwiftUI 的特性，*UIHostingController*能够自动响应 SwiftUI 视图状态的变化，从而动态地更新其包含的 UIKit 视图。这使得在 SwiftUI 中定义的视图能够自动保持同步，而无需手动刷新
* 声明式 UI 编程： 使用*UIHostingController*时，你可以继续使用 SwiftUI 的声明式 UI 编程范式，而不是传统的命令式 UI 编程方式。这使得 UI 的构建和维护更加简单和直观。
* 跨平台兼容性：*UIHostingController*的使用不仅限于 iOS 平台，你也可以在 macOS 上使用*NSHostingController*，在 watchOS 上使用*WKHostingController*，以实现在不同平台上的 SwiftUI 视图承载。
*总体而言*
*UIHostingController*提供了一种方便的方式，将 SwiftUI 和 UIKit 结合使用，使得你可以逐步采用 SwiftUI，而无需立即完全迁移到 SwiftUI 构建整个应用程序。这种渐进性迁移对于那些已有的 UIKit 项目而言是非常有帮助的。
## *UIKit.UIViewRepresentable* 干嘛的？（向上兼容）

`UIViewRepresentable` 是SwiftUI中的一个协议，用于将 UIKit 中的 `UIView` 集成到 SwiftUI 视图层次结构中。当您想要在SwiftUI中使用一个基于*UIView*的自定义视图或控件时，可以通过遵循 `UIViewRepresentable` 协议来实现这个集成。<font color="red">**UIKit.UIView👉🏻SwiftUI**</font>
`UIViewRepresentable` 要求您实现两个必备的方法：

1. `makeUIView(context:)`：该方法创建并返回一个*UIView*实例。您可以在这个方法中配置和初始化您的*UIView*。
2. `updateUIView(_:context:)`：当视图需要更新时，系统调用此方法。您可以在这里更新您的*UIView*的状态或内容，以确保它与 SwiftUI 视图同步。
通过实现这两个方法，您可以在 SwiftUI 中使用自定义的*UIView*类型，使其成为 SwiftUI 视图体系的一部分。这对于集成一些原生的 UIKit 控件、图形渲染或其他需要直接使用*UIView*的情况非常有用。
```swift
import SwiftUI

struct TextFieldWrapper: UIViewRepresentable {
    @Binding var text: String

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField()
        textField.delegate = context.coordinator
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldWrapper

        init(_ parent: TextFieldWrapper) {
            self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}

struct ContentView: View {
    @State private var text = ""

    var body: some View {
        TextFieldWrapper(text: $text)
            .padding()
    }
}
/**
  在这个例子中，TextFieldWrapper 结构体实现了 UIViewRepresentable 协议，将 UITextField 集成到 SwiftUI 中。
  通过 @Binding 属性，它能够与 SwiftUI 视图的数据进行双向绑定。
*/
```
## 属性修饰符（*Property Attributes*）≠ 属性包装器（*Property Wrappers*）

属性修饰符用于**修饰属性的行为**，而属性包装器用于**提供属性的包装和自定义行为**。
* ### 属性修饰符（*Property Attributes*）
  
  * 属性修饰符是一种用于在 Swift 中***附加额外信息或行为的语法元素***；
    属性修饰符是一种用于***改变属性行为或特性的关键字***；
  * 在 Swift 中，有一些属性修饰符可以用于声明属性。例如：
    * <font color="red">***lazy***</font>： 延迟加载属性，只有在第一次访问时才会进行初始化。
    * <font color="red">***weak***</font> 和 <font color="red">***unowned***</font>： 用于管理引用关系，避免循环引用。
    * <font color="red">***public***</font>、<font color="red">***internal***</font>、<font color="red">***fileprivate***</font> 和 <font color="red">***private***</font>： 控制属性的访问级别。
```swift
class MyClass {
    lazy var lazyProperty: Int = 42
    weak var weakReference: MyClass?
    private var privateProperty: String
    // ...
}
```
* ### 属性包装器（*Property Wrappers*）

  * 属性包装器是一种用于包装属性的特性，通过在属性定义前使用包装器来***提供一些额外的行为***；
  * 属性包装器通常***用于简化属性的代码***、***提供额外逻辑***或***封装属性存储***；
  * 类似于***OC.AssociatedObjects***（关联对象）；
```swift
@propertyWrapper
struct MyWrapper {
    var value: Int
    
    init(initialValue: Int) {
        self.value = initialValue
    }
    
    var wrappedValue: Int {
        get { return value }
        set { value = newValue }
    }
}

struct MyStruct {
    @MyWrapper(initialValue: 10)
    var wrappedProperty: Int
}
/**
  在上述示例中，MyWrapper 是一个属性包装器，MyStruct 中的 wrappedProperty 使用了这个包装器。
  属性包装器提供了一种可以自定义属性访问和修改的方式。
*/
```
## ***Swift.@标记***

### <font color="red">***`@frozen`***</font>

*用于标记枚举声明，表示该枚举是冻结的，即其**成员在编译时是不可改变的**。这有助于编译器进行一些优化。*

```swift
@frozen enum Status {
    case success
    case failure(errorCode: Int)
}
```
在这个例子中，**Status**是一个枚举，通过 <font color="red">***`@frozen`***</font> 标记表示它是冻结的。这意味着在***后续的代码中不能再添加新的枚举成员***，使得编译器可以进行一些优化。
### <font color="red">***`@usableFromInline`***</font>

*用于标记属性、方法、类型等，表示它们可以在模块内的其他地方内联使用，但对模块外不可见。*

```swift
// MyModule.swift
@usableFromInline
struct InternalStruct {
    var value: Int
}

@usableFromInline
func internalFunction() {
    print("Internal function")
}

public struct PublicStruct {
    @usableFromInline
    var internalStruct: InternalStruct

    public init(value: Int) {
        self.internalStruct = InternalStruct(value: value)
    }
}

public func publicFunction() {
    print("Public function")
    internalFunction() // 可以直接调用 @usableFromInline 的函数
}

// 在模块外部的其他文件或模块
let myStruct = InternalStruct(value: 42) // 错误，InternalStruct 对模块外不可见
let result = internalFunction() // 错误，internalFunction 对模块外不可见
```
### <font color="red">***`@discardableResult`***</font>

*discard：*
*【v.】扔掉，弃置；打出（无用的牌），垫（牌）*
*【n.】被抛弃物；（纸牌游戏中）垫出的牌*
*用于标记函数或方法，表示其返回值可以被忽略而不会触发编译器警告。**仅仅是抑制警告***

```swift
@discardableResult
func processResult() -> Int {
    // ...
}
```
### <font color="red">***`@available`***</font>

 *用于标记函数、方法、属性等，指示它们的可用性和版本要求。*
```swift
@available(iOS 14.0, *)
func newAPI() {
    // ...
}
```
### <font color="red">***`@MainActor`***</font>

* 是一个[***属性包装器***（*property wrapper*）](# 属性包装器（Property Wrappers）)，它用于标记特定的属性、方法或函数在主线程上执行；

* 这是为了确保在 Swift 的并发编程中遵循特定的并发模型；
* 具体来说，`@MainActor`是 Swift Concurrency 中的一部分，引入了 <font color="red">***`async/await`***</font>  等新的并发编程特性；
* 它的目的是将代码标记为在主线程上执行，以确保操作 UI 或其他需要在主线程上执行的任务时不会发生线程不安全的情况。

```swift
@MainActor
func updateUI() {
    // 在主线程上执行的代码
    // 可以直接操作 UI 元素
}
// 在异步函数中使用 @MainActor
func fetchData() async {
    let data = await fetchDataFromNetwork()
    
    // 在主线程上执行更新 UI 的操作
    updateUI()
}
```
### <font color="red">***`@objc`***</font>

* <font color="red">***`@objc`***</font> 是一个 *Objective-C* 的修饰符；
* 在 Swift 中用于标记特定的声明以便与 *Objective-C* 代码进行交互；
* 它可以应用于类、协议、方法、属性等；
* 兼容 *Objective-C* 代码： 当你需要在 *Swift* 中使用*Objective-C* 的框架、类、方法等时，你可能需要使用 <font color="red">***`@objc`***</font> 修饰符。*Objective-C* 使用动态消息传递，而 *Swift* 使用静态派发，因此在 *Swift* 中调用 *Objective-C* 代码时，需要一些额外的信息来确保兼容性。

```swift
@objc class MySwiftClass: NSObject {
    @objc func mySwiftMethod() {
        // 方法实现
    }
}
```
* 在 Selector 中使用：在 *Objective-C* 中，方法的名称被表示为一个 `Selector` 对象。在 *Swift* 中，通过 `#selector` 语法可以引用一个 *Objective-C* 的方法。

```swift
@objc func myObjectiveCMethod() {
    // 方法实现
}
let selector = #selector(myObjectiveCMethod)
```
* 处理动态派发：<font color="red">***`@objc`***</font> 也用于处理动态派发的情况，例如在 KVO（**K**ey-**V**alue **O**bserving）中。
```swift
@objc dynamic var myProperty: Int = 0
```
* 需要注意的是：
  * 使用 <font color="red">***`@objc`***</font> 会使得相应的声明变得更加 *Objective-C* 友好，但也可能导致一些 *Swift* 特性无法使用；
  * 在新的 *Swift* 代码中，尽量避免不必要的 <font color="red">***`@objc`***</font> 标记，以便充分利用 *Swift* 的静态类型检查和性能优势；

### <font color="red">***`@Binding`***</font>

* <font color="red">***`@Binding`***</font> 是一个[***属性包装器***（*property wrapper*）](# 属性包装器（Property Wrappers）)，用于在 SwiftUI 中创建**双向绑定**（*two-way binding*）。它允许你在视图层次结构中传递数据，并确保这些数据的改变在整个视图层次结构中传播；
  * 当你在一个视图中使用 <font color="red">***`@Binding`***</font> 修饰符时，它表示该属性是一个引用到另一个视图层次结构中的数据的绑定；
  * 当被绑定的数据发生变化时，相关的视图会自动更新，并且对绑定属性的修改也会反映到原始数据上；

```swift
struct ContentView: View {
    @State private var textValue = ""

    var body: some View {
        VStack {
            Text("Entered Text: \(textValue)")
            TextField("Enter text", text: $textValue)
            Subview(bindingText: $textValue)
        }
    }
}

struct Subview: View {
    @Binding var bindingText: String

    var body: some View {
        TextField("Enter text in Subview", text: $bindingText)
    }
}
/**
  在上述例子中，ContentView 包含一个 TextField 和一个名为 Subview 的子视图。
  通过在 Subview 中使用 @Binding，bindingText 成为与 ContentView 中的 $textValue 双向绑定的属性。
  因此，当用户在 Subview 中输入文本时，ContentView 中的相应文本字段也会自动更新。
  @Binding 是 SwiftUI 中用于实现数据流动和双向绑定的关键属性包装器之一，它使得构建响应式、动态的用户界面变得更加简单。
*/
```
* *拓展知识*：**Vue中的数据绑定**
  **在Vue中，使用插值表达式实现单向绑定**
```vue
<div>{{ message }}</div>
这里message是模型中的数据，它会动态地显示在页面上。
```
    * 单向绑定是指数据从模型（或视图模型）流向视图（DOM）的过程。
    * 当模型的数据发生变化时，视图会相应地更新，但是反过来不成立。
    * 在Vue中，常见的单向绑定方式是使用插值表达式（`{{}}`）或者指令（例如`v-bind`）将模型中的数据绑定到视图上。
  **在Vue中，通常使用`v-model`指令来实现双向绑定**

  * 双向绑定是指数据在模型和视图之间进行双向同步；
  * 当模型中的数据发生变化时，视图会更新；
  * 同时，当用户在视图中输入数据时，模型中的数据也会随之更新；
  ```vue
  <input type="text" v-model="message">
  这里message是模型中的数据，用户在输入框中输入的值会动态地更新到模型中，并且模型中的数据变化也会反映到输入框中。
  ```
### <font color="red">***`@escaping`***</font>

* 用于标记函数或闭包参数，表示它们在函数返回后仍然可以被调用；
* 通常，当闭包作为参数传递给函数时，它默认是非逃逸的，即被保证在函数返回之前被执行；
* 然而，如果该闭包可能在函数返回后执行，就需要使用 <font color="red">***`@escaping`***</font> 修饰符

```swift
class MyViewController {
    var completionHandlers: [() -> Void] = []
    // 函数参数闭包标记为 @escaping
    func fetchData(completion: @escaping () -> Void) {
        // 模拟异步操作
        DispatchQueue.global().async {
            // 数据加载完成后执行闭包
            // 这里需要使用 self，因为在异步操作中，self 引用可能是弱引用
            completion()

            // 如果不标记 @escaping，编译器会产生错误：
            // Closure use of non-escaping parameter 'completion' may allow it to escape the function body
        }
    }
    // 函数参数闭包默认是非逃逸的
    func registerCompletionHandler(completion: () -> Void) {
        completionHandlers.append(completion)
    }
    // 函数参数闭包标记为 @escaping
    func executeCompletionHandlers() {
        for handler in completionHandlers {
            handler()
        }
        completionHandlers = []
    }
}
/**
	在上面的例子中，`fetchData(completion:)` 函数的参数闭包被标记为 `@escaping`，因为它在异步操作完成后被调用；
	而 `registerCompletionHandler(completion:)` 函数的参数闭包默认是非逃逸的，因为它被保存在数组中，不会在函数返回后被`executeCompletionHandlers()` 函数用于执行保存的闭包数组中的所有闭包；
*/
```
### <font color="red">***`@inline`***</font>

* 用于标记函数，表示希望编译器尽可能地将函数内容内联到调用点，以提高性能；

* 在大多数情况下，Swift 编译器会自动进行内联优化，但使用 <font color="red">***`@inline`***</font> 可以对编译器的行为进行更明确的指导；

* <font color="red">***使用 `@inline` 需要慎重，因为过度的内联可能导致代码体积膨胀，反而影响性能***</font> ；

* 编译器通常能够很好地处理内联，因此在大多数情况下，开发者无需手动添加<font color="red">***`@inline`***</font>；

* 只有在对性能有特殊需求，且经过测试确认内联带来的性能提升时，才建议使用<font color="red">***`@inline`***</font>；

```swift
@inline(__always)
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

let result = add(5, 7)
print(result)
/**
  在这个例子中，`add` 函数使用 `@inline(__always)`，表示开发者明确希望这个函数在调用点被始终内联。
  这样，编译器会尽可能地将 `add` 函数的内容嵌入到调用点，而不是生成一个函数调用。
*/
```

### <font color="red">***`@Main`***</font>

* 在Swift中，<font color="red">***`@Main`***</font> 是一个属性，用于标识应用程序的入口点，指定应用程序的主入口（*main entry point*）；
* 在Swift应用程序中，可以使用 <font color="red">***`@Main`***</font> 属性来指定一个遵循 `App` 协议的类型，以表示应用程序的主要入口；

```swift
import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
/**
  在这个示例中，MyApp 结构体采用 App 协议，表示它是一个应用程序。
  @main 属性标记了这个结构体，表明它是应用程序的主入口点。
  MyApp 结构体中的 body 属性返回一个 Scene，表示应用程序的主窗口中要显示的内容，这里是一个包含 ContentView 的 WindowGroup。
*/
```
<font color="red">***总的来说，`@main` 属性简化了应用程序的入口点的定义，使得代码更加简洁和易读。***</font>

<font color="red">***在应用程序启动时，系统将自动创建并运行标记为 `@main` 的结构体，从而启动应用程序。***</font>

### <font color="red">***`@UIApplicationMain`***</font>

* 是 Swift 中的一个标记性的属性，通常用于标识应用程序的主要入口点；
* 在 Swift 中，它通常用于标记 *AppDelegate* 类，以指定应用程序的主要运行类；
* 一个应用程序只能有一个使用 <font color="red">***`@UIApplicationMain`***</font> 标记的类；

通过在 *AppDelegate* 类的声明前添加 <font color="red">***`@UIApplicationMain`***</font> 属性，可以省略编写 `main.swift` 文件来启动应用程序

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // 应用程序启动时的初始化代码
        return true
    }
}
// 这样，编译器会自动生成 main.swift 文件，并在其中创建 UIApplication 对象和 AppDelegate 对象，从而启动应用程序。
```
### <font color="red">***`@State`***</font>

* 是 SwiftUI 中的一个[***属性包装器***（*Property Wrapper*）](# 属性包装器（Property Wrappers）)，用于声明和管理视图的状态；
* <font color="red">***`@State`***</font> 用于标识由视图持有和管理的可变状态，当状态发生改变时，视图会自动重新渲染以反映最新的状态；

```swift
import SwiftUI

struct MyView: View {
    @State private var counter: Int = 0
    
    var body: some View {
        VStack {
            Text("Counter: \(counter)")
            Button("Increment") {
                counter += 1
            }
        }
    }
}
/**
  自动刷新： 当使用 @State 修饰的变量发生改变时，SwiftUI 会自动检测到变化，并重新渲染相关的视图。
  仅在视图内有效： @State 用于管理视图内的状态，而不是应用程序的整体状态。每个使用 @State 的视图都有其自己的状态，这使得每个视图的状态都是独立的。
  不保留历史值： @State 修饰的变量不保留历史值。当视图重新创建时，@State 变量会被重置为其初始值。
*/
```
<font color="red">***总的来说，`@State` 是 SwiftUI 中用于处理视图状态的重要[属性包装器](# 属性包装器（Property Wrappers）)，它使得状态管理更加简单和直观。***</font> 

### <font color="red">***`@EnvironmentObject`***</font>

*是 SwiftUI 中的一个[**属性包装器**（Property Wrapper）](# 属性包装器（Property Wrappers）)，用于在视图之间传递和共享数据。它允许你在整个 SwiftUI 视图层次结构中传递一个共享的对象，并在需要的地方访问该对象的属性。*

```swift
import SwiftUI
// 定义一个共享的数据模型
class UserData: ObservableObject {
    @Published var username = "Guest"
}
// 在 @main 函数中设置环境对象
@main
struct MyApp: App {
    @StateObject private var userData = UserData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData) // 在整个应用程序中共享 UserData
        }
    }
}
// 在视图中使用 @EnvironmentObject
struct ContentView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Text("Welcome, \(userData.username)!")
            Button("Login") {
                userData.username = "User123"
            }
        }
    }
}
/**
  在上述示例中，UserData 是一个可观察的对象，通过 @Published 标记的属性可以自动发布变化。
  在 MyApp 中，使用 @StateObject 修饰的 userData 被设置为环境对象，然后在 ContentView 中使用 @EnvironmentObject 来获取该环境对象。
  这样，在整个应用程序中，无需手动传递 userData，所有使用 @EnvironmentObject 的视图都能访问到共享的 UserData 对象。
*/
```
**主要用途和特点：**
* 传递共享数据： 通过使用 <font color="red">***`@EnvironmentObject`***</font>，你可以在整个 *SwiftUI* 视图层次结构中传递一个共享的数据模型，而不必在每个视图中手动传递该数据。
* 全局访问： 通过在 *SwiftUI* 的 **Environment** 中存储对象，你可以在整个应用程序中提供对该对象的全局访问。
* 数据更新时刷新视图： 当通过 <font color="red">***`@EnvironmentObject`***</font>引用的对象发生更改时，相关视图会自动刷新以反映最新的数据。
* 典型用法是在 <font color="red">***`@main`***</font> 函数中设置环境对象，以便在整个应用程序中共享。

### <font color="red">***`@Environment`***</font>

*在 Swift 中，<font color="red">**`@Environment`**</font> 是一个[**属性包装器**（property wrapper）](# 属性包装器（Property Wrappers）)，用于访问环境值（Environment Values）。*
*环境值是一种在应用程序中传递数据的方式，通常用于在视图层次结构中传递全局设置或共享的数据。*
*`@Environment` 允许您在视图中声明需要从环境中获取的值，并使其在整个视图层次结构中自动传递。*

```swift
import SwiftUI

struct ContentView: View {
    // 定义一个环境值，用于存储用户的偏好设置
    @Environment(\.userDefaults) var userDefaults

    var body: some View {
        VStack {
            Text("User's Preferences:")
            Text("Theme: \(userDefaults.string(forKey: "theme") ?? "Default")")
        }
    }
}
// 在应用程序的其他地方设置偏好设置，例如在AppDelegate中
extension EnvironmentValues {
    var userDefaults: UserDefaults {
        get { self[UserDefaultsKey.self] }
        set { self[UserDefaultsKey.self] = newValue }
    }
}

struct UserDefaultsKey: EnvironmentKey {
    static let defaultValue: UserDefaults = .standard
}

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
/**
  在这个示例中，ContentView 结构体声明了一个 @Environment(\.userDefaults) 属性，该属性将从环境中获取用户偏好设置。
  然后，在 extension EnvironmentValues 中，我们为 userDefaults 创建了一个环境键，并为其提供了默认值（在这里是 UserDefaults.standard）。
*/
```
在应用程序的其他地方，例如在 *AppDelegate* 中，您可以设置用户的偏好设置，然后这些设置将在整个应用程序中自动传递给使用 `@Environment(\.userDefaults)` 的视图。这是一种方便的方式，<font color="red">***使得全局设置和共享数据能够轻松地在整个视图层次结构中传递。***</font> 

### <font color="red">***`@ObservedObject`***</font>

*是 SwiftUI 中的一个[**属性包装器**（property wrapper）](# 属性包装器（Property Wrappers）)，用于将一个对象标记为可观察的。当被 <font color="red">**`@ObservedObject`**</font> 标记的对象发生变化时，相关视图将会被刷新以反映这些变化。通常情况下，<font color="red">**`@ObservedObject`**</font> 用于关联可观察对象和视图，使得 SwiftUI 能够自动响应对象的变化并更新 UI。*

```swift
import SwiftUI
import Combine

// 定义一个可观察的对象
class MyViewModel: ObservableObject {
    @Published var data: String = "Initial Data"
}

// 使用 @ObservedObject 关联视图和可观察对象
struct MyView: View {
    @ObservedObject var viewModel = MyViewModel()
    
    var body: some View {
        VStack {
            Text("Data: \(viewModel.data)")
            Button("Update Data") {
                viewModel.data = "New Data"
            }
        }
    }
}
/**
  在上述示例中，MyViewModel 是一个实现了 ObservableObject 协议的类，其中使用 @Published 标记的 data 属性将被观察。
  在 MyView 中，通过 @ObservedObject 关联了一个 MyViewModel 对象。
  当按钮点击时，data 发生变化，观察 @ObservedObject 的视图将会自动刷新以反映最新的数据。
*/
```
**主要用途和特点：**
* 可观察对象： 通过 <font color="red">***`@ObservedObject`***</font> 标记的对象必须符合 <font color="red">***`@ObservedObject`***</font> 协议，这通常是一个具有可发布属性的类。
* 刷新视图： 当 <font color="red">***`@ObservedObject`***</font> 标记的对象的可发布属性发生变化时，相关视图将会自动刷新以反映最新的数据。
* 局部订阅： <font color="red">***`@ObservedObject`***</font> 用于局部的、在视图层次结构中的某个特定位置进行数据绑定，而 <font color="red">***`@EnvironmentObject`***</font> 用于全局的、在整个应用程序范围内传递数据。

<font color="red">***总的来说，`@ObservedObject` 是 SwiftUI 中用于观察对象变化并刷新视图的关键属性包装器。它通常用于将可观察对象与特定视图关联，以便在对象变化时更新相关 UI。***</font> 

### <font color="red">***`@Published`***</font>

*是 Swift 中的[**属性包装器**（property wrapper）](# 属性包装器（Property Wrappers）)，通常用于标记可观察对象的属性。在 SwiftUI 中，<font color="red">**`@Published`**</font> 通常与 `ObservableObject` 协议一起使用，以提供一种简单的方式来发布属性的变化，从而让相关视图能够及时地更新。需要`import Combine`* 

```swift
import SwiftUI
import Combine
// 定义可观察对象
class MyViewModel: ObservableObject {
    @Published var data: String = "Initial Data"
}

// 使用 @ObservedObject 监听变化
struct MyView: View {
    @ObservedObject var viewModel = MyViewModel()
    
    var body: some View {
        VStack {
            Text("Data: \(viewModel.data)")
            Button("Update Data") {
                viewModel.data = "New Data"
            }
        }
    }
}
/**
  在上述示例中，MyViewModel 类实现了 ObservableObject 协议，并使用 @Published 标记了 data 属性。
  在 MyView 中，通过 @ObservedObject 关联了一个 MyViewModel 对象。
  当按钮点击时，data 的值发生变化，@Published 将自动发布通知，@ObservedObject 的视图将会自动刷新。
*/
```
<font color="red">***总的来说，`@Published` 是 SwiftUI 中用于简化可观察对象的属性变化通知的属性包装器。***</font> 

<font color="red">***它与 `ObservableObject` 协议一起使用，使得 SwiftUI 能够在数据发生变化时自动刷新相关的视图。***</font> 

## <font color="red">***`@main`***</font>和<font color="red">***`@UIApplicationMain`***</font>的区别

<font color="red">**`@main`**</font> 和 <font color="red">**`@UIApplicationMain`**</font> 都是在 *Swift* 中用于标识应用程序入口的属性，但它们有一些不同之处：

1. **平台差异：**
   
   * <font color="red">***`@main`***</font>是 *Swift 5.3* 及更高版本引入的属性，用于iOS、macOS、tvOS等所有平台。它是一种通用的属性，用于标识应用程序的入口。
   - <font color="red">***`@UIApplicationMain`***</font> 是在较早的Swift版本中引入的，主要用于iOS开发。它是在*AppDelegate*中标识应用程序的主入口。
   
2. **使用方式：**
   
   - <font color="red">***`@main`***</font> 用于标识遵循 `App` 协议的类型，表示整个应用程序的入口。在该类型中，通过实现 `body` 属性来定义应用程序的场景（Scene）；
   - <font color="red">***`@UIApplicationMain`***</font> 用于标识一个包含 *UIApplication* 子类的文件，该子类充当应用程序的代理并定义应用程序的入口点。在这种情况下，`main.swift` 文件是不必要的，因为入口点由 <font color="red">***`@UIApplicationMain`***</font> 属性标识的类的 `main` 方法提供。
   
3. **灵活性：**
   
   - <font color="red">***`@main`***</font>更加灵活，允许您使用 `App` 协议自定义应用程序的入口，使其适用于不同的场景和平台；
   - <font color="red">***`@UIApplicationMain`***</font> 相对较死板，主要用于传统的iOS应用程序入口点的定义；
   综上所述，如果您在Swift 5.3及更高版本上进行跨平台开发，推荐使用 <font color="red">***`@main`***</font>。如果您在较早的Swift版本上仅进行iOS开发，可以使用 <font color="red">***`@UIApplicationMain`***</font>。在实践中，大多数新的Swift项目会选择使用 <font color="red">***`@main`***</font>，因为它提供更大的灵活性，并且在未来的Swift版本中可能会成为标准的应用程序入口点标识方式。

## Swift中，***Any***和***Anyobject***的区别？

***Any***：

- ***Any***可以表示任何类型，包括值类型（如结构体和枚举）和引用类型（如类）；
- 使用***Any***可以存储任何类型的值，但在操作这些值时，你需要进行类型转换；
- ***Any***是一个协议（*protocol*），所有类型都实现了 ***Any***。因此，可以使用***Any***来表示任何值，而不管是值类型还是引用类型；
```swift
var value: Any
value = 42
value = "Hello"
value = [1, 2, 3]

if let intValue = value as? Int {
    print("It's an Int: \(intValue)")
}
```
***AnyObject:***

- ***Anyobject*** 是一个协议（*protocol*），用于表示类类型（*class types*）；
- 只有类（*class*）可以遵循 ***Anyobject*** 协议，而值类型（*value types*）不能；
- 对于使用 ***Anyobject*** 存储的值，你可以直接调用类的方法和属性，而无需进行类型转换；
```swift
var object: AnyObject
object = NSString(string: "Hello, AnyObject!")

// 调用NSString的方法
let length = object.length
```
**综上所述：**
1、主要区别在于 ***Any*** **可以表示任何类型**，而 ***Anyobject*** **仅表示类类型**。
2、因此，当你需要处理混合类型的数据时，可以使用 ***Any***。当你知道你要处理的是类对象时，可以使用 ***Anyobject***。
3、在实践中，尽量避免使用 ***Any*** 和 ***Anyobject***，而是使用具体的类型，因为这样有助于代码的可读性和类型安全。

## *var body: some View*  这里面的`some`是什么意思？

* 这是 Swift 5.1 引入的一项功能，用于简化泛型代码中的类型表达；
* 在 SwiftUI 中，***some View*** 是一个不透明类型（*opaque type*）；
* 在 SwiftUI 中，***some View***  的主要作用是表示返回的视图类型是不透明的，即编译器知道它是一种 View 类型，但不需要具体指定是哪一种 View；
* **不透明类型的优势在于它允许隐藏具体的实现细节，这在复杂的视图层次结构中非常有用**；
* 在编写 SwiftUI 代码时，通常不需要知道具体的视图类型，只需要知道它们是 View 协议的实现即可；
* 这使得 SwiftUI 的视图层次结构能够更加灵活，因为你可以在不暴露具体实现细节的情况下返回不同类型的视图；

*在这个例子中，some View 表示 body 属性返回的视图类型是不透明的，并且编译器知道它遵循 View 协议。*

```swift
struct MyView: View {
    var body: some View {
        Text("Hello, SwiftUI!")
    }
}
```
## `#available` 和 <font color="red">***`@available`***</font>在Swift中有什么区别？

*在Swift中，`#available`和 <font color="red">**`@available`**</font>都用于处理平台和版本的可用性检查，但它们在语法上和用途上有一些不同。*
**`#available`：** 

- `#available` 是一个条件编译指令，用于在编译时检查代码的可用性。
- 你可以使用 `#available` 来检查某个特定平台上是否可用某个特定版本的API，以便在编译时做出相应的决策。这在编写跨平台应用时很有用。
```swift
if #available(iOS 15, *) {
    // 使用 iOS 15 及以上版本的API
} else {
    // 使用 iOS 15 以下版本的备用代码
}
```
<font color="red">***`@available`***</font>

- <font color="red">***`@available`***</font> 是一个属性包装器，用于在运行时检查代码的可用性。
- 可以使用 <font color="red">***`@available`***</font>来标记特定的函数、类、结构体等，并指定它们在不同平台和版本上的可用性。这允许编译器在运行时检查代码的使用情况，并在不支持的平台或版本上引发警告或错误。
```swift
@available(iOS 15, *)
func myFunction() {
    // 只有在 iOS 15 及以上版本才可用
}
```
**总体来说**
1、`#available` 用于条件编译，而 <font color="red">***`@available`***</font> 用于标记在运行时检查的实体；

2、在实际编码中，它们经常一起使用，以确保代码在编译和运行时都考虑到平台和版本的差异；

##  ***Swift***.<font color="red">***`extension`***</font>

1、<font color="red">***类似于OC中的分类***</font>；
2、***允许你在不修改原始类型定义的情况下，向已有的类（Class）、结构体（Struct）、枚举（enum）或协议（Protocol）添加新的功能。***；
3、<font color="red">***`extension`***</font> 可以用于添加新的计算属性、方法、初始化方法、下标等；

***扩展添加新方法***：

```swift
extension Double {
    func square() -> Double {
        return self * self
    }
}
let number = 4.0
let squared = number.square()  // 结果为 16.0
```
***扩展添加新计算属性***：

```swift
extension Int {
    var squared: Int {
        return self * self
    }
}
let num = 5
let squaredNum = num.squared  // 结果为 25
```
***扩展添加新初始化方法***：

```swift
extension String {
    init(repeating: String, count: Int) {
        self = String(repeating: repeating, count: count)
    }
}
let repeatedString = String(repeating: "Hello", count: 3)
// 结果为 "HelloHelloHello"
```
***扩展实现协议***：

```swift
protocol Describable {
    var description: String { get }
}

extension Double: Describable {
    var description: String {
        return "Value: \(self)"
    }
}

let value: Double = 3.14
print(value.description)  // 输出 "Value: 3.14"
```
**请注意，<font color="red">*`extension`*</font> 中不能添加存储属性，只能添加计算属性。**

## <font color="red">***在Swift中，有两种类型不允许定义存储属性***</font>：

* **协议（*Protocol*）：** 协议本身不能包含存储属性。协议可以定义计算属性，以及方法、下标等，但它不支持直接定义存储属性。**和OC一致**
```
protocol MyProtocol {
    // 不允许在协议中定义存储属性
    // var myProperty: Int { get set } // 错误的示例

    // 可以定义计算属性
    var myComputedProperty: Int { get }
}
```
* **扩展（*Extension*）中的存储属性：** 在使用扩展为现有类型添加新功能时，不允许添加存储属性。扩展只能添加计算属性，而不能添加存储属性。**和OC一致**

```
extension String {
    // 不允许在扩展中添加存储属性
    // var myProperty: Int // 错误的示例

    // 可以添加计算属性
    var length: Int {
        return count
    }
}
```
## ***Swift.`初始化方法`***

*在Swift中，初始化方法是用于创建并初始化实例的特殊方法。*
*Swift的初始化方法具有灵活性，可以包含多个参数、默认值、可选值，以及各种初始化阶段的操作。*
*以下是一些关于Swift初始化方法的重要概念：*

* **指定初始化方法（*Designated Initializer*）**：是一个类中的主要初始化方法，用于初始化类的所有存储属性，并最终调用父类的初始化方法；
```swift
class MyClass {
    var property: Int
    
    init(property: Int) {
        self.property = property
    }
}
```
*  **便利初始化方法（*Convenience Initializer*）**：是一个辅助方法，用于在指定初始化方法内部调用其他初始化方法，提供更多的初始化选项；
```swift
class MyClass {
    var property: Int
    
    init(property: Int) {
        self.property = property
    }
    
    convenience init() {
        self.init(property: 0)
    }
}
```
* **初始化参数的默认值**：初始化方法可以为参数提供默认值，使得在创建实例时可以选择性地省略某些参数；
```swift
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int = 25) {
        self.name = name
        self.age = age
    }
}
```
*  **可选初始化方法（*Failable Initializer*）**：允许初始化过程失败，返回一个可选值（初始化失败返回`nil`）；

```swift
class MyObject {
    var value: Int
    
    init?(value: Int) {
        guard value >= 0 else {
            return nil
        }
        self.value = value
    }
}
```
## ***Swift.`单例`***

```swift
class MySingleton {
    // 静态常量，用于保存唯一实例
    static let shared = MySingleton()

    // 私有构造函数，确保只能通过.shared创建实例
    private init() {
        // 初始化代码
    }

    // 其他方法和属性
    func doSomething() {
        // 实现功能
    }
}
// 这确保了在应用程序中只存在一个MySingleton实例，且可以在任何地方通过.shared访问它。
let myInstance = MySingleton.shared
myInstance.doSomething()
```
## ***Swift.`网络请求`***

### 1、URLSession（原生的工具）
```swift
import Foundation
// 定义请求的 URL
let url = URL(string: "https://example.com/api")!
// 创建请求对象
var request = URLRequest(url: url)
request.httpMethod = "POST"
// 添加自定义的 header 信息
request.allHTTPHeaderFields = [
    "Content-Type": "application/json",
    "Authorization": "Bearer YourAccessToken"
]
// 添加需要发送的数据，例如 JSON 数据
let jsonData = """
{
    "key1": "value1",
    "key2": "value2"
}
""".data(using: .utf8)
request.httpBody = jsonData
// 创建 URLSession 对象
let session = URLSession.shared
// 发送请求
let task = session.dataTask(with: request) { (data, response, error) in
    // 处理响应
    if let error = error {
        print("Error: \(error)")
    } else if let data = data {
        // 处理返回的数据
        let responseString = String(data: data, encoding: .utf8)
        print("Response: \(responseString ?? "")")
    }
}
// 启动任务
task.resume()
```
**需要特别指出的：** *发送请求*

* *一般的请求*
```swift
let url = "https://example.com/api"
// 这里的URL可以为String类型，框架可以接受URLRequest类型和String
let task = session.dataTask(with: url) { (data, response, error) in
  // TODO
}
```
```swift
import Foundation
// 如果不配置httpMethod（不创建URLRequest），则默认为httpMethod.GET方法 
// 定义请求的 URL
let url = URL(string: "https://example.com/api")!
// 创建 URLSession 对象
let session = URLSession.shared
// 发送请求
let task = session.dataTask(with: url) { (data, response, error) in
    // 处理响应
    if let error = error {
        print("Error: \(error)")
    } else if let data = data {
        // 处理返回的数据
        let responseString = String(data: data, encoding: .utf8)
        print("Response: \(responseString ?? "")")
    }
}
// 启动任务
task.resume()
```
* *数据下载*
```swift
let task = session.downloadTask(with: request) { (data, response, error) in
	// TODO
}
```
* *数据上载*
```swift
let task = session.uploadTask(with: request) { (data, response, error) in
	// TODO
}
```
### 2、Alamofire
```Ruby
pod 'Alamofire'
```
```swift
import Alamofire
// 定义请求的 URL
let url = "https://example.com/api"

// 发送 GET 请求
AF.request(url, method: .get).responseJSON { response in
    switch respo`nse.result {
    case .success(let data):
        print("Response JSON: \(data)")
    case .failure(let error):
        print("Error: \(error)")
    }
}
```
### 3、Moya（基于Alamofire的二次封装）
```ruby
pod 'Moya'
```
```swift
import Moya
// 将你的 API 定义为一个枚举
enum MyAPIService {
    case getPosts
}
// 遵循 TargetType 协议以提供关于你的 API 的详细信息
extension MyAPIService: TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }

    var path: String {
        switch self {
        case .getPosts:
            return "/posts"
        }
    }

    var method: Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        return .requestPlain
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
// 使用你的 API 服务创建一个 Moya 提供者
let provider = MoyaProvider<MyAPIService>()
// 发送网络请求
provider.request(.getPosts) { result in
    switch result {
    case .success(let response):
        do {
            // 使用你喜欢的 JSON 解析方法解析响应数据
            let posts = try JSONDecoder().decode([Post].self, from: response.data)
            print(posts)
        } catch {
            print("解码响应数据时出错：\(error)")
        }
    case .failure(let error):
        print("网络请求失败：\(error)")
    }
}
```
## ***Swift.`Json数据解析`***
### 1、*Codable 协议*  <font color="red">***（原生.简洁.官方推荐首选）***</font>

定义你的数据模型➕遵循 `Codable` 协议➕使用***JSONDecoder*** = 解码***JSON***数据

```swift
struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

do {
    let jsonData = // Your JSON data
    let post = try JSONDecoder().decode(Post.self, from: jsonData)
    print(post)
} catch {
    print("Error decoding JSON: \(error)")
}
```
### 2、*SwiftyJSON*（第三方.流行）

*更灵活➕链式语法*

```swift
import SwiftyJSON

let json = // Your JSON data
let jsonObject = try? JSON(data: json)

// Accessing values
let title = jsonObject?["title"].stringValue
let userId = jsonObject?["userId"].intValue
```
### 3、*ObjectMapper*（第三方.常用）

***对象到 ==>JSON*** 和 ***JSON  ==>对象的映射功能***

```swift
import ObjectMapper

class Post: Mappable {
  var userId: Int?
  var id: Int?
  var title: String?
  var body: String?

  required init?(map: Map) {}

  func mapping(map: Map) {
      userId <- map["userId"]
      id <- map["id"]
      title <- map["title"]
      body <- map["body"]
  }
}

let post = Mapper<Post>().map(JSONString: jsonString)
```
## <font color="red">***SwiftUI***</font>

* ***文本标签 Text**（类似于UIKit.UILabel）*
```swift
import SwiftUI

struct ContentView: View {
  var body: some View {
      VStack {
          Text("Hello, World!")
              .font(.title) // 设置文本的字体大小
              .foregroundColor(.blue) // 设置文本的颜色
              .padding() // 添加内边距
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
```
* ***输入控件TextField**（类似于UIKit.UITextField）*
```swift
import SwiftUI

struct ContentView: View {
@State private var textInput: String = ""
  var body: some View {
      VStack {
          TextField("Enter text", text: $textInput)
              .padding()
              .border(Color.gray, width: 1) // 添加边框
              .textFieldStyle(RoundedBorderTextFieldStyle()) // 设置输入框样式
              .padding() // 添加内边距

          Text("You entered: \(textInput)")
              .padding()
      }
      .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
```
* ***列表控件List**（类似于UIKit.UITableView）*
```swift
import SwiftUI

struct ContentView: View {
  let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
  var body: some View {
      List(items, id: \.self) { item in
          Text(item)
      }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
```
* ***LazyVGrid 或者 LazyHGrid** （类似于UIKit.UICollectionView）*
  * 在 SwiftUI 中，*LazyVGrid* 和 *LazyHGrid* 并没有像 *UICollectionView* 那样直接提供委托或协议方法。
  
```swift
import SwiftUI

struct ContentView: View {
    let items = Array(1...20)

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 10) {
                ForEach(items, id: \.self) { item in
                    Text("\(item)")
                        .frame(width: 150, height: 150)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}
// 或者
struct ContentView: View {
    let items = [
        Item(name: "Item 1"),
        Item(name: "Item 2"),
        Item(name: "Item 3"),
        Item(name: "Item 4"),
        Item(name: "Item 5"),
        Item(name: "Item 6"),
        Item(name: "Item 7"),
        Item(name: "Item 8"),
        Item(name: "Item 9"),
        Item(name: "Item 10")
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(items) { item in
                    Text(item.name)
                        .frame(width: 100, height: 100)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
* ***按钮控件Button**（类似于UIKit.UIButton）*
```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            // 按钮点击时执行的操作
            print("Button tapped")
        }) {
            Text("Tap Me")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```

## 其他

* <font color="red">***可选项的本质是枚举类型***</font>；
* Swift的泛型应用字协议上的时候，需要使用***关联类型***；

```swift
protocol Container {
    associatedtype Item // Item不是系统类型，可以命名为自定义的字符串（占位符类型）
    mutating func addItem(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}
```

```swift
struct IntStack: Container {
    // IntStack 的关联类型是 Int
    typealias Item = Int
    var items = [Int]()
  
    mutating func addItem(_ item: Int) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}
```

* 访问控制：<font color="red">***open***</font> > <font color="red">***public***</font> ><font color="red">***internal***</font>（默认） > <font color="red">***fileprivate***</font>（**在本文件内可见**） > <font color="red">***private***</font>（**在最近的一个定义域区间内可见**）
  * <font color="red">***open***</font>只针对模块化的文件（被打成二进制的`.a`、`.o`、`.framework`）。所以<font color="red">***对于源代码：open === public***</font>；
  * <font color="red">***open***</font> - <font color="red">***public***</font> = 允许类及其成员在其他模块中被继承和被重写；
* *protocol*
  * Swift中的*protocol*还可以对接口进行抽象；
  * Swift中的*protocol*还可以实现面向协议；
  * Swift中的*protocol*还可以用于值类型、结构体（*Struct*）、枚举（*enum*）；
