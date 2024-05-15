# Flutter.UI （系统控件及其相关常用属性/方法）

## ***Scaffold：***
* 提供了应用程序的基本结构。可以将`Scaffold`视为应用程序的"装饰"，提供了一个标准的应用程序布局，并且提供了许多方便的功能
  * **AppBar（应用栏）:**通过`appBar`属性，可以在顶部添加一个应用栏，通常用于显示应用程序的标题、操作按钮或其他重要信息；
  * **Body（主体内容区域）:**通过`body`属性，可以设置应用程序的主体内容区域，通常用于放置应用程序的主要内容，例如文本、图像、列表等；
  * **FloatingActionButton（浮动操作按钮）:**通过`floatingActionButton`属性，可以添加一个浮动操作按钮，通常用于触发应用程序中的常见操作；
  * **Drawer（抽屉菜单）:**通过`drawer`属性，可以添加一个抽屉菜单，通常用于放置导航链接、设置选项或其他次要功能；
  * **BottomNavigationBar（底部导航栏）:**通过`bottomNavigationBar`属性，可以添加一个底部导航栏，通常用于快速导航到应用程序的不同部分；
  * **SnackBar（消息提示条）:**通过`showSnackBar()`方法，可以在屏幕底部显示一个消息提示条，用于向用户显示临时消息或通知；
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scaffold Demo',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar标题'), // 标题
        backgroundColor: Colors.blue, // 背景颜色
        centerTitle: true, // 标题是否居中
        elevation: 4, // 阴影高度
        actions: [ // 右侧的操作按钮
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('Scaffold Body'), // 主体内容
      ),
      floatingActionButton: FloatingActionButton( // 悬浮按钮
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // 悬浮按钮位置
      bottomNavigationBar: BottomAppBar( // 底部工具栏
        color: Colors.blue, // 背景颜色
        shape: CircularNotchedRectangle(), // 形状
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
      drawer: Drawer( // 抽屉菜单
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
```
## ***MaterialApp：***
* 创建 <font color="red">**Android 风格**</font>应用程序的**顶级** *Widget*。用于定义应用程序的基本结构和配置。构建基于Material Design（Google提出）风格的应用程序的入口点
  * **title:**通常会显示在操作系统的任务管理器中以及设备的应用程序列表中；
    
    * **字符串值:** 你可以直接将应用程序的名称作为字符串传递给`title`属性。例如：`title: 'My App'`；
    * **Text Widget:** 除了字符串值之外，你还可以将一个*Text Widget*作为`title`属性的值，以便设置更加复杂的标题样式。例如：`title: Text('My App')`；
    * **本地化支持:**如果你的应用程序需要支持多语言和地区，你可以使用Flutter的国际化支持功能来设置应用程序的标题。通常，你可以根据用户的语言和地区设置来动态获取对应的本地化标题。例如：`title: Text(AppLocalizations.of(context).appTitle)`；
    * **动态更新:** 如果你希望在应用程序运行时动态更新标题，你可以使用一个*StatefulWidget*，并在需要更新标题的时候调用`setState()`方法。例如：
  ```dart
  class MyApp extends StatefulWidget {
    @override
    _MyAppState createState() => _MyAppState();
  }
  
  class _MyAppState extends State<MyApp> {
    String _title = 'My App';
  
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: _title,
        // 其他配置...
      );
    }
  
    // 在需要更新标题的地方调用此方法
    void updateTitle(String newTitle) {
      setState(() {
        _title = newTitle;
      });
    }
  }
  ```
  * **theme:**设置应用程序的整体主题，包括颜色、字体样式、图标样式等。Flutter提供了一组预定义的主题，你也可以自定义主题来满足应用程序的需求；
    * ***ThemeData:***定义主题数据，包括颜色、字体、文本样式等;
  ```dart
  import 'package:flutter/material.dart';
  
  void main() {
    runApp(MyApp());
  }
  
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Theme Demo',
        theme: ThemeData(
          primaryColor: Colors.blue, // 设置主要颜色为蓝色
          accentColor: Colors.green, // 设置强调颜色为绿色
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // 定义标题1文本样式
            headline2: TextStyle(fontSize: 20, fontStyle: FontStyle.italic), // 定义标题2文本样式
            bodyText1: TextStyle(fontSize: 16, color: Colors.black87), // 定义正文文本样式
          ),
        ),
        home: HomePage(),
      );
    }
  }
  class HomePage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Theme Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hello, World!',
                style: Theme.of(context).textTheme.headline1, // 使用主题样式设置标题1文本样式
              ),
              Text(
                'Welcome to Flutter',
                style: Theme.of(context).textTheme.headline2, // 使用主题样式设置标题2文本样式
              ),
              Text(
                'This is a body text.',
                style: Theme.of(context).textTheme.bodyText1, // 使用主题样式设置正文文本样式
              ),
            ],
          ),
        ),
      );
    }
  }
  ```
    * **textTheme：**（标题/正文/按钮/输入框/对话框/复选框/单选框/标签/卡片/日期选择器）文本样式（例如字体、大小、颜色等）；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Text Theme Demo',
          theme: ThemeData(
            // 定义文本样式
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              headline2: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.green),
              bodyText1: TextStyle(fontSize: 16, color: Colors.black87),
              bodyText2: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Text Theme Demo'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Headline 1',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  'Headline 2',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  'Body Text 1',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'Body Text 2',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        );
      }
    }
    ```
    * **buttonTheme：**按钮主题，用于设置应用程序中按钮的默认样式，例如按钮的颜色、形状等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Button Theme Demo',
          theme: ThemeData(
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue, // 设置按钮颜色为蓝色
              textTheme: ButtonTextTheme.primary, // 设置按钮文本样式为主要样式
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)), // 设置按钮形状为圆角矩形
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // 设置按钮内边距
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Button Theme Demo'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Click me'), // 按钮文本
            ),
          ),
        );
      }
    }
    ```
    * **iconTheme：**图标主题，用于设置应用程序中图标的默认样式，例如图标的颜色、大小等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Icon Theme Demo',
          theme: ThemeData(
            iconTheme: IconThemeData(
              color: Colors.red, // 设置图标颜色为红色
              size: 36, // 设置图标大小为36像素
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Icon Theme Demo'),
          ),
          body: Center(
            child: Icon(Icons.favorite), // 使用图标
          ),
        );
      }
    }
    ```
    * **dividerTheme：**分割线主题，用于设置应用程序中分割线的默认样式，例如分割线的颜色、宽度等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Divider Theme Demo',
          theme: ThemeData(
            dividerTheme: DividerThemeData(
              color: Colors.blue, // 设置分割线颜色为蓝色
              thickness: 2, // 设置分割线厚度为2像素
              space: 20, // 设置分割线之间的间距为20像素
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Divider Theme Demo'),
          ),
          body: Column(
            children: [
              Text('Item 1'),
              Divider(), // 使用分割线，默认样式
              Text('Item 2'),
              Divider(), // 使用分割线，默认样式
              Text('Item 3'),
              Divider(), // 使用分割线，默认样式
            ],
          ),
        );
      }
    }
    ```
    * **elevationTheme：**高程（海拔高度：传达元素之间的层次关系和视觉深度或阴影效果）主题，用于设置应用程序中各种元素的阴影效果；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Elevation Theme Demo',
          theme: ThemeData(
            elevationTheme: ElevationThemeData(
              shadowColor: Colors.blue, // 设置阴影颜色为蓝色
              ambientElevation: 4, // 设置环境阴影为 4
              bottomAppBarElevation: 8, // 设置底部应用栏阴影为 8
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Elevation Theme Demo'),
          ),
          body: Center(
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).elevationTheme.shadowColor,
                    blurRadius: Theme.of(context).elevationTheme.ambientElevation,
                  ),
                ],
              ),
              child: Center(child: Text('Container with Shadow')),
            ),
          ),
        );
      }
    }
    ```
    * **textTheme：**卡片主题，用于设置应用程序中卡片的默认样式，例如卡片的颜色、形状等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Text Theme Demo',
          theme: ThemeData(
            textTheme: TextTheme(
              headline1: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue), // 标题1样式
              headline2: TextStyle(fontSize: 20, fontStyle: FontStyle.italic, color: Colors.green), // 标题2样式
              bodyText1: TextStyle(fontSize: 16, color: Colors.black87), // 正文样式
              bodyText2: TextStyle(fontSize: 14, color: Colors.grey), // 次要正文样式
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Text Theme Demo'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'This is headline 1',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Text(
                  'This is headline 2',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Text(
                  'This is body text 1',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                  'This is body text 2',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
          ),
        );
      }
    }
    ```
    * **floatingActionButtonTheme：**用于设置浮动操作按钮的默认样式，包括背景色、形状、阴影等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Floating Action Button Theme Demo',
          theme: ThemeData(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green, // 设置浮动操作按钮的背景色为绿色
              foregroundColor: Colors.white, // 设置浮动操作按钮的前景色（图标颜色）为白色
              elevation: 6, // 设置浮动操作按钮的阴影高度为6
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Floating Action Button Theme Demo'),
          ),
          body: Center(
            child: Text('Press the Floating Action Button'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.add), // 浮动操作按钮的图标
          ),
        );
      }
    }
    ```
    * **chipTheme：**用于设置应用程序中芯片（Chip）的默认样式，包括背景色、形状、文本样式等；
    ```dart
    import 'package:flutter/material.dart';
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Chip Theme Demo',
          theme: ThemeData(
            chipTheme: ChipThemeData(
              backgroundColor: Colors.yellow, // 设置芯片背景颜色为黄色
              labelStyle: TextStyle(color: Colors.black), // 设置标签文本颜色为黑色
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // 设置芯片内边距
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // 设置芯片形状为圆角矩形
                side: BorderSide(color: Colors.blue), // 设置芯片边框样式
              ),
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Chip Theme Demo'),
          ),
          body: Center(
            child: Chip(
              label: Text('Flutter'), // 芯片标签文本
              avatar: CircleAvatar(
                backgroundColor: Colors.blue, // 芯片头像背景色
                child: Text('F'), // 芯片头像文本
              ),
            ),
          ),
        );
      }
    }
    ```
    * **sliderTheme：**用于设置应用程序中滑块（*Slider*）的默认样式，包括滑块的颜色、形状、轨道的颜色等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Slider Theme Demo',
          theme: ThemeData(
            sliderTheme: SliderThemeData(
              activeTrackColor: Colors.blue, // 设置滑块激活轨道颜色为蓝色
              inactiveTrackColor: Colors.grey, // 设置滑块非激活轨道颜色为灰色
              thumbColor: Colors.red, // 设置滑块颜色为红色
              overlayColor: Colors.green.withOpacity(0.5), // 设置滑块叠加颜色为半透明的绿色
              valueIndicatorColor: Colors.orange, // 设置值指示器颜色为橙色
              valueIndicatorTextStyle: TextStyle(color: Colors.white), // 设置值指示器文本样式
              trackHeight: 8, // 设置轨道高度为8像素
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatefulWidget {
      @override
      _HomePageState createState() => _HomePageState();
    }
    
    class _HomePageState extends State<HomePage> {
      double _value = 0.5;
    
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Slider Theme Demo'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Slider(
                  value: _value,
                  onChanged: (newValue) {
                    setState(() {
                      _value = newValue;
                    });
                  },
                  min: 0,
                  max: 1,
                ),
                Text('Value: $_value'),
              ],
            ),
          ),
        );
      }
    }
    ```
    * **tabBarTheme：**用于设置应用程序中选项卡栏（*TabBar*）的默认样式，包括选项卡的颜色、文本样式等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'TabBar Theme Demo',
          theme: ThemeData(
            tabBarTheme: TabBarTheme(
              labelColor: Colors.blue, // 选中标签文本颜色为蓝色
              unselectedLabelColor: Colors.grey, // 未选中标签文本颜色为灰色
              indicator: BoxDecoration(
                color: Colors.green, // 设置指示器颜色为绿色
                borderRadius: BorderRadius.circular(20), // 设置指示器形状为圆角矩形
              ),
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Text('TabBar Theme Demo'),
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(child: Text('Content of Tab 1')),
                Center(child: Text('Content of Tab 2')),
                Center(child: Text('Content of Tab 3')),
              ],
            ),
          ),
        );
      }
    }
    ```
    * **inputDecorationTheme：**用于设置输入框（*TextField*）的默认样式，包括边框样式、填充样式、标签样式等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Input Decoration Theme Demo',
          theme: ThemeData(
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue), // 设置边框颜色为蓝色
                borderRadius: BorderRadius.circular(10), // 设置边框形状为圆角矩形
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green), // 设置焦点边框颜色为绿色
                borderRadius: BorderRadius.circular(10), // 设置焦点边框形状为圆角矩形
              ),
              fillColor: Colors.grey[200], // 设置填充颜色为灰色
              filled: true, // 设置是否填充为true
              hintStyle: TextStyle(color: Colors.grey), // 设置提示文本颜色为灰色
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Input Decoration Theme Demo'),
          ),
          body: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter your text here', // 提示文本
                ),
              ),
            ),
          ),
        );
      }
    }
    ```
    * **timePickerTheme：**用于设置应用程序中时间选择器（*TimePicker*）的默认样式，包括时间选择器的颜色、形状等；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Time Picker Theme Demo',
          theme: ThemeData(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white, // 设置时间选择器背景颜色为白色
              hourMinuteColor: Colors.blue, // 设置时分颜色为蓝色
              dayPeriodColor: Colors.green, // 设置时间段颜色为绿色
              dialHandColor: Colors.red, // 设置拨号手颜色为红色
              dialBackgroundColor: Colors.yellow, // 设置拨号背景颜色为黄色
              dialTextColor: Colors.black, // 设置拨号文本颜色为黑色
              entryModeIconColor: Colors.orange, // 设置输入模式图标颜色为橙色
            ),
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Time Picker Theme Demo'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
              },
              child: Text('Open Time Picker'),
            ),
          ),
        );
      }
    }
    ```
    * **primaryColor：**主要颜色，用于应用程序的主要元素。例如*AppBar*的背景色；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Primary Color Demo',
          theme: ThemeData(
            primaryColor: Colors.blue, // 设置主要颜色为蓝色
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Primary Color Demo'),
          ),
          body: Center(
            child: Text(
              'This is the body of the app',
              style: TextStyle(
                color: Theme.of(context).primaryColor, // 使用主要颜色作为文本颜色
                fontSize: 20,
              ),
            ),
          ),
        );
      }
    }
    ```
    * **accentColor：**强调颜色，用于应用程序中的强调元素，例如浮动操作按钮的背景色；
    ```dart
    import 'package:flutter/material.dart';
    
    void main() {
      runApp(MyApp());
    }
    
    class MyApp extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'Accent Color Demo',
          theme: ThemeData(
            accentColor: Colors.green, // 设置强调颜色为绿色
          ),
          home: HomePage(),
        );
      }
    }
    
    class HomePage extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Accent Color Demo'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: () {},
              child: Text(
                'Accent Color Button',
                style: TextStyle(color: Theme.of(context).accentColor), // 使用强调颜色作为按钮文本颜色
              ),
            ),
          ),
        );
      }
    }
    ```
  * **应用程序首页**: 通过`home`属性，你可以指定应用程序的首页，它是应用程序默认显示的第一个界面。通常，你可以将`home`属性设置为一个`Scaffold`小部件，以构建应用程序的基本布局结构；
  ```dart
  import 'package:flutter/material.dart';
  
  void main() {
    runApp(MyApp());
  }
  
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Home Page'),
          ),
          body: Center(
            child: Text('Welcome to my app!'),
          ),
        ),
      );
    }
  }
  ```
  * **路由管理**: *MaterialApp*内置了一个导航器（`Navigator`），用于管理应用程序的页面路由。你可以使用导航器来管理应用程序中的不同页面，并提供了一组方法来实现***页面之间的导航***和***传递数据***。`Navigator.of(context)`，会使用*context*来向上遍历*Element*树，找到*MaterialApp*提供的_NavigatorState再调用其`push/pop`方法完成导航操作；
    * **initialRoute：**这是一个用于指定应用程序初始路由的属性。你可以将应用程序初始路由的名称传递给`initialRoute`属性，以便指定应用程序启动时默认显示的页面；
    * **routes：**这是一个用于指定命名路由的属性。你可以通过`routes`属性设置应用程序的命名路由，将路由名称和对应的构建函数进行映射（Map），从而实现在不同页面之间进行导航时的页面构建；
    * **onGenerateRoute：**这是一个用于动态生成路由的回调函数。当应用程序试图打开一个命名路由但没有找到对应的路由时，会调用`onGenerateRoute`回调函数。你可以在这个回调函数中根据路由名称动态生成并返回对应的`Route`对象，以实现路由的动态生成和管理；
    * **onUnknownRoute：** 这是一个用于处理未知路由的回调函数。当应用程序试图打开一个未知的命名路由时，会调用`onUnknownRoute`回调函数。你可以在这个回调函数中处理未知路由的情况，并返回一个对应的`Route`对象或者`null`；
    * **navigatorKey：**一个 GlobalKey 类型的属性，用于在代码中操作应用程序的导航器（`Navigator`）。通过 `navigatorKey`，可以在任何位置获取到应用程序的导航器，并执行诸如跳转页面、返回上一页、替换页面等操作；
  * **国际化支持**: *MaterialApp*提供了一些国际化相关的属性；
    * **localizationsDelegates：**这是一个***用于指定本地化委托的属性***。本地化委托是一组提供本地化数据和翻译服务的对象，它们负责将应用程序的文本和其他资源翻译成不同的语言和地区。Flutter提供了一些内置的本地化委托，例如`MaterialLocalizationsDelegate`和`WidgetsLocalizationsDelegate`，它们分别负责提供Material Design风格的本地化数据和通用的UI文本翻译。
    * **supportedLocales：**这是一个***用于指定支持的语言和地区的属性***。你可以将应用程序支持的语言和地区列表传递给`supportedLocales`属性，以便Flutter知道应该为哪些语言和地区提供本地化服务。每个Locale对象代表了一个特定的语言和地区，例如Locale('en', 'US')代表了美国英语。
    * **locale：** 这是一个用于***指定应用程序当前语言和地区的属性***。你可以将应用程序的当前语言和地区传递给locale属性，以便Flutter知道应该使用哪种语言和地区的本地化数据和翻译服务。通常，你可以通过获取设备的当前语言和地区来设置locale属性，以实现应用程序自动适应用户的语言和地区设置。
    * **Localizations：** *Localizations*是一个用于在应用程序中***获取本地化数据的小部件***。通过使用`Localizations.of(context, type)`方法，你可以在应用程序的任何地方获取指定类型的本地化数据，例如日期格式、货币格式、UI文本等。
  * **应用程序生命周期管理**: *MaterialApp*提供了一些生命周期相关的回调函数；
    * **onGenerateRoute：** 当应用程序试图打开一个命名路由时，会调用`onGenerateRoute`回调函数。你可以在这个回调函数中根据路由名称生成并返回对应的*Route*对象，以实现路由的动态生成。通常用于动态路由的配置；
    * **onGenerateInitialRoutes：**当应用程序初始化时，会调用`onGenerateInitialRoutes`回调函数。你可以在这个回调函数中生成并返回应用程序的初始路由列表，用于设置应用程序启动时默认显示的页面；
    * **onUnknownRoute：**当应用程序尝试打开一个未知的命名路由时，会调用`onUnknownRoute`回调函数。你可以在这个回调函数中处理未知路由的情况，并返回一个对应的Route对象或者null；
    * **navigatorObservers：** *MaterialApp*提供了一个`navigatorObservers`属性，用于注册导航观察器（*NavigatorObserver*）。导航观察器允许你监听导航器的各种事件，例如页面压栈、页面弹出等，从而可以在应用程序的各个生命周期阶段执行一些额外的操作；
  * 其他
    * **debugShowCheckedModeBanner：** `bool` 类型。***CupertinoApp*** 和 ***MaterialApp*** 共有的一个属性，用于控制是否在应用程序的右上角显示一个***DEBUG***横幅；
    * **showPerformanceOverlay：** `bool` 类型。是否显示性能叠加层，用于在屏幕上显示应用程序的性能统计信息；
    * **builder：**一个回调函数，用于构建应用程序的顶层 *Widget*。通过 `builder`，可以在应用程序顶层嵌套其他 *Widget*，以实现一些全局的状态管理或配置
## ***CupertinoApp***：
* 创建 <font color="red">**iOS 风格**</font>应用程序的**顶级** *Widget*。用于定义应用程序的基本结构和配置

  * **home**: 一个必需的属性，它接受一个 *Widget*，用于指定应用程序的首页。通常情况下，你可以将一个 `CupertinoPage` 或其他自定义的 *Widget* 作为应用程序的首页；
  * **routes**: `Map` 类型。用于指定应用程序中各个页面的路由映射关系，可以通过路由名称直接访问页面；
  * **initialRoute**: `String` 类型。指定应用程序初始化时显示的路由页面的名称；
  * **navigatorKey**: `GlobalKey<NavigatorState> `类型。用于在应用程序中获取 *NavigatorState*，可以通过该 key 控制导航器的行为；
  * **navigatorObservers**: `List<NavigatorObserver> `类型。用于添加导航器观察器，用于监听应用程序中路由的生命周期事件；
  * **onGenerateRoute**: `RouteFactory` 类型。用于在访问未注册的路由时生成路由的回调函数；
  * **builder**: `TransitionBuilder` 类型。用于构建应用程序根部件的回调函数，可以在构建根部件之前进行一些初始化操作；
  * **title**: `String` 类型。应用程序的标题，显示在设备上的任务管理器中；
  * **color**: `Color` 类型。设置应用程序的颜色，用于设备顶部的状态栏；
  * **locale**: `Locale` 类型。指定应用程序的区域设置，用于国际化和本地化；
  * **localizationsDelegates**: `List<LocalizationsDelegate<dynamic>> `类型。用于添加本地化委托，用于加载应用程序的本地化资源；
  * **supportedLocales**: `List<Locale> `类型。指定应用程序支持的区域设置列表，用于国际化和本地化；
  ```dart
  CupertinoApp(
    supportedLocales: [
      const Locale('en', 'US'), // 英文（美国）
      const Locale('zh', 'CN'), // 中文（中国）
      // 其他支持的语言和区域设置...
    ],
    // 其他属性...
  )
  ```
  * **debugShowCheckedModeBanner**: `bool` 类型。**CupertinoApp** 和 **MaterialApp** 共有的一个属性，用于控制是否在应用程序的右上角显示一个***DEBUG***横幅
  ```dart
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  
  void main() {
    runApp(MyApp());
  }
  
  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return CupertinoApp(
        title: 'CupertinoApp Demo',
        home: CupertinoPage(),
      );
    }
  }
  
  class CupertinoPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('CupertinoApp Demo'),
        ),
        child: Center(
          child: Text(
            'Welcome to CupertinoApp Demo!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      );
    }
  }
  ```
* ***Navigator：***负责管理***页面路由***的类，用于管理页面的堆栈导航、页面跳转和页面切换动画等功能
  * **`onGenerateRoute`**: 该属性是一个回调函数，用于生成页面路由。当**试图跳转到一个未知的命名路由时，会调用这个回调函数**，以便生成相应的路由页面。该函数签名为 `Route<dynamic> Function(RouteSettings settings)`，它接收一个 `RouteSettings` 参数，并返回一个路由页面；
  * **`initialRoute`**: 该属性用于指定应用程序的初始路由。它**接收一个字符串，表示初始路由的名称**。当应用程序首次启动时，会根据该属性指定的路由名称显示对应的页面；
  * **`onUnknownRoute`**: 该属性是一个回调函数，用于处理未知的命名路由。当试图跳转到一个未知的命名路由时，如果没有提供 `onGenerateRoute`，或者 `onGenerateRoute` 也无法生成相应的路由页面，则会调用该回调函数。它的函数签名与 `onGenerateRoute` 相类似，用于生成未知路由对应的页面。
  * **`navigatorKey`**: 该属性用于指定一个全局的 `GlobalKey<NavigatorState>`，用于在代码中操作 `Navigator` 的状态。通过 `navigatorKey`，可以在任何位置获取 `Navigator` 的状态，并执行诸如跳转页面、返回上一页、替换页面等操作；
  * **`onPopPage`**: 该属性是一个回调函数，用于处理页面被弹出（即返回）时的逻辑。当页面被弹出时，会调用该回调函数，并传递一个 `Route<dynamic>` 参数，表示被弹出的页面路由。该函数应该返回一个布尔值，表示是否允许弹出该页面。如果返回 true，则允许弹出页面；如果返回 false，则阻止弹出页面；
  * **`observers`**: 该属性用于指定一组 `NavigatorObserver` 对象，用于监听 `Navigator` 的状态变化。`NavigatorObserver` 是一个抽象类，用于监听 `Navigator` 的各种状态变化，例如页面路由的推入和弹出、页面路由的生命周期等；
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 跳转到下一个页面
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailScreen()),
            );
          },
          child: Text('Go to Detail Screen'),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('This is the detail screen'),
            ElevatedButton(
              onPressed: () {
                // 返回上一个页面
                Navigator.pop(context);
              },
              child: Text('Go back'),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.blueAccent, // 自定义背景色
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // 点击抽屉菜单项时关闭抽屉
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // 点击抽屉菜单项时关闭抽屉
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}

在这个示例中，创建了两个页面：HomeScreen 和 DetailScreen。
在 HomeScreen 中，我们显示了一个按钮，当用户点击时会跳转到 DetailScreen 页面。
在 DetailScreen 页面中，我们展示了一些文本和一个按钮，用户点击按钮时可以返回到上一个页面。

此外，还展示了一些其他属性的功能：
在 DetailScreen 页面中自定义了背景色；
使用了抽屉菜单（Drawer），包含了自定义的标题和两个菜单项；
底部导航栏（BottomNavigationBar）包含了两个图标项。
```
* ***BottomNavigationBar：***创建***底部导航栏***的组件，它通常用于在应用程序底部显示一组固定的导航选项，用户可以通过点击不同的选项来切换页面<font color="red">**类似于OC中的UITabBar**</font>
  * **items**: 一个必需的属性，它接受一个 `List<BottomNavigationBarItem>` 类型的列表，用于定义底部导航栏中的每个选项。每个 `BottomNavigationBarItem` 对象通常包括一个图标和一个标题；
  * **currentIndex**: 一个必需的属性，它表示当前选中的导航项的索引。通过设置这个属性，可以控制底部导航栏显示哪个选项是选中状态；
  * **onTap**: 一个回调函数，它接受一个 `int` 类型的参数，表示用户点击了底部导航栏中的哪个选项。当用户点击导航栏中的选项时，会调用该回调函数，并传递相应的选项索引；
  * **backgroundColor**: 底部导航栏的背景颜色；
  * **elevation**: 底部导航栏的阴影高度，设置为 0 表示没有阴影；
  * **fixedColor**: 选中项的颜色。当 `type` 属性设置为 `BottomNavigationBarType.fixed` 时，可以使用这个属性设置选中项的颜色；
  * **iconSize**: 图标的大小，用于指定底部导航栏中图标的大小；
  * **type**: 底部导航栏的类型，有两种类型可选：`BottomNavigationBarType.fixed` 和 `BottomNavigationBarType.shifting`。前者表示固定底部导航栏，所有选项都显示在底部导航栏中；后者表示可变底部导航栏，选中项会突出显示，未选中项会渐变消失；
  * **selectedItemColor**: 选中项的颜色，当 `type` 属性设置为 `BottomNavigationBarType.shifting` 时，可以使用这个属性设置选中项的颜色；
  * **unselectedItemColor**: 未选中项的颜色，当 `type` 属性设置为 `BottomNavigationBarType.shifting` 时，可以使用这个属性设置未选中项的颜色；
  * **selectedFontSize**: 选中项标题的字体大小；
  * **unselectedFontSize**: 未选中项标题的字体大小；
  * **selectedLabelStyle**: 选中项标题的样式；
  * **unselectedLabelStyle**: 未选中项标题的样式；
  * **showSelectedLabels**: 是否显示选中项的标题；
  * **showUnselectedLabels**: 是否显示未选中项的标题；
* ***Drawer：***用于***创建抽屉式导航菜单的组件***，通常用于显示应用程序的主要导航选项、设置选项或其他相关内容。<font color="red">**类似于OC中的侧边栏菜单 UISplitViewController**</font>
  * **child**: 一个必需的属性，它接受一个 *Widget*，用于指定抽屉菜单的内容。通常情况下，你可以使用 `ListView` 或 `Column` 等 *Widget* 来包装抽屉菜单的内容；
  * **elevation**: 抽屉的阴影高度。可以使用这个属性来控制抽屉的阴影效果，设置为 0 表示没有阴影；
  * **semanticLabel**: 抽屉的语义标签。用于向屏幕阅读器（例如 *TalkBack*）等辅助功能工具描述抽屉的内容；
  * **backgroundColor**: 抽屉的背景颜色；
  * **semanticLabel**：抽屉的语义标签，用于描述抽屉的内容，这对于辅助功能非常有用；
  * **semanticLabelPlacement**: 语义标签的放置方式，它是一个枚举值，可以是 `DrawerHeader` 或 `DrawerHeader.only`。当设置为 `DrawerHeader` 时，语义标签将显示在抽屉标题下方；当设置为 `DrawerHeader.only` 时，语义标签将只显示在抽屉标题中；
  * **scrollController**: 滚动控制器，用于控制抽屉内容的滚动。可以使用这个属性来控制抽屉内容的滚动位置；
  * **semanticLabel**: 抽屉的语义标签，用于描述抽屉的内容，这对于辅助功能非常有用；
* ***ScaffoldMessenger：***在应用程序中传递全局消息并在屏幕上显示通知。它<font color="red">**通常与 `Scaffold` 组件一起使用，用于在应用程序的顶层进行全局通信**</font>；
  * **showSnackBar**: 用于显示一个 *SnackBar*，它是一个临时性的通知，显示在屏幕底部。*SnackBar* 可以包含文本、操作按钮或其他小部件，<font color="red">**并在一段时间后自动消失**</font>；
  * **showBottomSheet**: 显示一个底部工作表，它是一个持久性的通知，覆盖屏幕的一部分，并且通常包含更复杂的内容。底部工作表可以是自定义的 *Widget*；
  * **removeCurrentSnackBar**: 用于从屏幕上移除当前显示的 *SnackBar*；
  * **removeCurrentBottomSheet**: 用于从屏幕上移除当前显示的底部工作表；
  * **hideCurrentSnackBar**: 用于隐藏当前显示的 *SnackBar*；
  * **showMaterialBanner**: 显示一个 Material 风格的横幅，类似于 *SnackBar*，但更适合用于长期显示。可以用于显示重要信息或操作状态；
* ***Container：***创建***矩形***视觉元素的*Widget*
  * **alignment**: 用于设置子部件在容器内的对齐方式。常见的值有 `Alignment.topLeft`、`Alignment.center`、`Alignment.bottomRight` 等；
  * **padding**: 用于设置容器***内边距***，即子部件与容器边缘之间的间距；
  * **margin**: 用于设置容器***外边距***，即容器与其父容器或其他相邻元素之间的间距；
  * **color**: 用于设置容器的背景色；
  * **width / height**: 用于设置容器的宽度和高度。<font color="red">**可以是一个固定的像素值，也可以是一个百分比值，或者是一个 `double.infinity` 以充分利用父容器的剩余空间**</font>；
  * **constraints**: 用于设置容器的约束条件，例如最小宽度、最大宽度、最小高度和最大高度；
  * **decoration**: 用于对容器进行装饰，例如添加背景、边框、阴影等。<font color="red">**通常与 `BoxDecoration` 类型的对象一起使用；**</font>；
  * **transform**: 用于对容器进行变换，例如平移、旋转、缩放等；
  * **foregroundDecoration**: 用于在容器前景上添加装饰，与 `decoration` 类似，***但是在子部件之上***；
  * **clipBehavior**: 用于控制容器如何剪裁其子部件。常见的值有 `Clip.none`、`Clip.antiAlias`、`Clip.hardEdge` 等；
  * **child**: 用于设置容器中的子部件。***可以是任何 Widget***；

* ***Column：***用于***垂直排列***子组件的布局 *Widget*
  * **mainAxisAlignment**: 定义子组件在主轴（垂直方向）上的对齐方式。常见的值有 `MainAxisAlignment.start`、`MainAxisAlignment.center`、`MainAxisAlignment.end` 等；
  * **crossAxisAlignment**: 定义子组件在交叉轴（水平方向）上的对齐方式。常见的值有 `CrossAxisAlignment.start`、`CrossAxisAlignment.center`、`CrossAxisAlignment.end` 等；
  * **mainAxisSize**: 定义主轴的尺寸大小。可以是 `MainAxisSize.max`，表示尽可能占用主轴方向上的空间；也可以是 `MainAxisSize.min`，表示只占用子组件所需的最小空间；
  * **verticalDirection**: 定义子组件在垂直方向上的布局顺序，是从上到下（`VerticalDirection.down`）还是从下到上（`VerticalDirection.up`）；
  * **textDirection**: 定义子组件的文本方向，用于决定子组件中文本的排列顺序；
  * **textBaseline**: 定义子组件的基线对齐方式，通常在子组件中包含文本时使用；
  * **children**: `Column` 中包含的子组件列表；
  * **key**: 用于标识 `Column` 的唯一键；
  * **crossAxisAlignment**: 定义子组件在交叉轴（水平方向）上的对齐方式。常见的值有 `CrossAxisAlignment.start`、`CrossAxisAlignment.center`、`CrossAxisAlignment.end` 等；
  * **mainAxisSize**: 定义主轴的尺寸大小。可以是 `MainAxisSize.max`，表示尽可能占用主轴方向上的空间；也可以是 `MainAxisSize.min`，表示只占用子组件所需的最小空间；
  * **verticalDirection**: 定义子组件在垂直方向上的布局顺序，是从上到下（`VerticalDirection.down`）还是从下到上（`VerticalDirection.up`）；
  * **textDirection**: 定义子组件的文本方向，用于决定子组件中文本的排列顺序；
  * **textBaseline**: 定义子组件的基线对齐方式，通常在子组件中包含文本时使用；
* ***Row：***用于***水平排列***子组件的布局 *Widget*
  * **mainAxisAlignment**: 定义子组件在主轴（水平方向）上的对齐方式。常见的值有 `MainAxisAlignment.start`、`MainAxisAlignment.center`、`MainAxisAlignment.end` 等了；
  * **crossAxisAlignment**: 定义子组件在交叉轴（垂直方向）上的对齐方式。常见的值有 `CrossAxisAlignment.start`、`CrossAxisAlignment.center`、`CrossAxisAlignment.end` 等；
  * **mainAxisSize**: 定义主轴的尺寸大小。可以是 `MainAxisSize.max`，表示尽可能占用主轴方向上的空间；也可以是 `MainAxisSize.min`，表示只占用子组件所需的最小空间；
  * **verticalDirection**: 定义子组件在垂直方向上的布局顺序，是从上到下（`VerticalDirection.down`）还是从下到上（`VerticalDirection.up`）；
  * **textDirection**: 定义子组件的文本方向，用于决定子组件中文本的排列顺序；
  * **textBaseline**: 定义子组件的基线对齐方式，通常在子组件中包含文本时使用；
  * **mainAxisAlignment**: 定义子组件在主轴（水平方向）上的对齐方式。常见的值有 `MainAxisAlignment.start`、`MainAxisAlignment.center`、`MainAxisAlignment.end` 等；
  * **crossAxisAlignment**: 定义子组件在交叉轴（垂直方向）上的对齐方式。常见的值有 `CrossAxisAlignment.start`、`CrossAxisAlignment.center`、`CrossAxisAlignment.end` 等；
  * **mainAxisSize**: 定义主轴的尺寸大小。可以是 `MainAxisSize.max`，表示尽可能占用主轴方向上的空间；也可以是 `MainAxisSize.min`，表示只占用子组件所需的最小空间；
  * **verticalDirection**: 定义子组件在垂直方向上的布局顺序，是从上到下（`VerticalDirection.down`）还是从下到上（`VerticalDirection.up`）；
  * **textDirection**: 定义子组件的文本方向，用于决定子组件中文本的排列顺序；
  * **textBaseline**: 定义子组件的基线对齐方式，通常在子组件中包含文本时使用；
* ***Flex：***实现***弹性布局***的 *Widget*
  * **direction**: 定义子组件的排列方向。常见的值有 `Axis.horizontal`（水平方向）和 `Axis.vertical`（垂直方向）；
  * **mainAxisAlignment**: 定义子组件在主轴上的对齐方式。对于水平布局，主轴是水平方向；对于垂直布局，主轴是垂直方向。常见的值有 `MainAxisAlignment.start`、`MainAxisAlignment.center`、`MainAxisAlignment.end` 等；
  * **crossAxisAlignment**: 定义子组件在交叉轴上的对齐方式。对于水平布局，交叉轴是垂直方向；对于垂直布局，交叉轴是水平方向。常见的值有 `CrossAxisAlignment.start`、`CrossAxisAlignment.center`、`CrossAxisAlignment.end` 等；
  * **mainAxisSize**: 定义主轴的尺寸大小。可以是 `MainAxisSize.max`，表示尽可能占用主轴方向上的空间；也可以是 `MainAxisSize.min`，表示只占用子组件所需的最小空间；
  * **verticalDirection**: 定义子组件在垂直方向上的布局顺序，是从上到下（`VerticalDirection.down`）还是从下到上（`VerticalDirection.up`）；
  * **textDirection**: 定义子组件的文本方向，用于决定子组件中文本的排列顺序；
  * **textBaseline**: 定义子组件的基线对齐方式，通常在子组件中包含文本时使用；
  * **clipBehavior**: 定义子组件的剪裁行为。常见的值有 `Clip.none`、`Clip.hardEdge`、`Clip.antiAlias`；
  * **children**: `Flex` 中包含的子组件列表；
  * **key**: 用于标识 `Flex` 的唯一键；
* ***Stack：***用于在***重叠的方式***排列子组件的 *Widget* <font color="red">类似于在绘图软件中的图层</font>
  * **alignment**: 定义子组件在 *Stack* 中的对齐方式。常见的值有 `Alignment.topLeft`、`Alignment.center`、`Alignment.bottomRight` 等；
  * **textDirection**: 定义子组件的文本方向，用于决定子组件中文本的排列顺序；
  * **fit**: 定义子组件在 *Stack* 中的布局方式。常见的值有 `StackFit.loose` 和 `StackFit.expand`。`StackFit.loose` 表示子组件根据其自身大小进行布局，而 `StackFit.expand` 表示子组件扩展以填充整个 *Stack*；
  * **overflow**: 定义子组件超出 *Stack* 区域时的处理方式。常见的值有 `Overflow.visible` 和 `Overflow.clip`。`Overflow.visible` 表示子组件可以超出 Stack 区域，而 `Overflow.clip` 表示子组件将被剪切到 *Stack* 区域内；
  * **clipBehavior**: 定义 *Stack* 是否剪裁子组件。常见的值有 `Clip.none`、`Clip.hardEdge`、`Clip.antiAlias`；
  * **children**: *Stack* 中包含的子组件列表；
  * **key**: 用于标识 `Stack` 的唯一键；
* ***ListView：***用于***显示滚动列表***的布局 *Widget*
  * **scrollDirection**: 定义列表的滚动方向。常见的值有 `Axis.vertical`（垂直方向）和 `Axis.horizontal`（水平方向）；
  * **controller**: 用于控制列表的滚动位置。可以通过 *ScrollController* 对象来控制列表的滚动；
  * **primary**: 定义是否使用与父级 *Widget* 相同的滚动控制器。如果为 true，则列表会使用父级 *Widget* 的滚动控制器；
  * **physics**: 定义列表的滚动物理特性。通常使用 `ScrollPhysics` 类型的对象，例如 `BouncingScrollPhysics`、`ClampingScrollPhysics` 等；
  * **shrinkWrap**: 定义是否根据子组件的总长度来调整列表的大小。如果为 true，则列表的长度将根据子组件的总长度调整，否则列表将尽可能占用可用空间；
  * **padding**: 定义列表的内边距，即列表内容与列表边缘之间的间距；
  * **itemExtent**: 定义每个子组件的固定长度。当列表中的子组件具有相同的长度时，可以使用此属性来提高性能；
  * **addAutomaticKeepAlives**: 定义是否在子组件重新创建时保留现有子组件的状态。通常用于在滚动列表时保持子组件的状态；
  * **addRepaintBoundaries**: 定义是否在子组件重新创建时添加重绘边界。通常用于提高性能，减少不必要的重绘；
  * **addSemanticIndexes**: 定义是否为列表中的子组件添加语义索引。通常用于使屏幕阅读器能够正确识别列表中的项目；
  * **cacheExtent**: 定义在滚动过程中预加载的子组件的数量。可以提前加载一定数量的子组件，以提高滚动性能；
  * **itemBuilder**: 用于构建列表中每个子组件的回调函数。通常返回一个 *Widget*，根据给定的索引来构建相应的子组件；
  * **itemCount**: 定义列表中子组件的数量。通常与 *itemBuilder* 配合使用；
  * **key**: 用于标识 *ListView* 的唯一键。
* ***GridView：***用于显示***网格布局***的布局 *Widget*
  【n.】网格，方格；栅栏；输电网，电力网；赛车起跑线；美式橄榄球球场，橄榄球赛；（控制）栅极；计算机联网
  【v.】使……构成网格状，布置成网格结构
  * **scrollDirection**: 定义网格布局的滚动方向。常见的值有 `Axis.vertical`（垂直方向）和 `Axis.horizontal`（水平方向）；
  * **controller**: 用于控制网格布局的滚动位置。可以通过 `ScrollController` 对象来控制网格布局的滚动；
  * **primary**: 定义是否使用与父级 Widget 相同的滚动控制器。如果为 true，则网格布局会使用父级 Widget 的滚动控制器；
  * **physics**: 定义网格布局的滚动物理特性。通常使用 `ScrollPhysics` 类型的对象，例如 `BouncingScrollPhysics`、`ClampingScrollPhysics` 等；
  * **shrinkWrap**: 定义是否根据子组件的总长度来调整网格布局的大小。如果为 true，则网格布局的长度将根据子组件的总长度调整，否则网格布局将尽可能占用可用空间；
  * **padding**: 定义网格布局的内边距，即网格布局内容与网格布局边缘之间的间距；
  * **gridDelegate**: 定义网格布局的委托对象，用于控制网格布局的排列方式。通常使用 `SliverGridDelegate` 的子类，例如 `SliverGridDelegateWithFixedCrossAxisCount`、`SliverGridDelegateWithMaxCrossAxisExtent` 等；<font color="red">使用最频繁的，因为它决定了网格布局的行数、列数以及子组件的排列方式</font>
  * **children**: *GridView* 中包含的子组件列表；
  * **key**: 用于标识 *GridView* 的唯一键；
  *创建一个垂直滚动的网格布局，并显示一些简单的网格项*
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GridView Demo',
      home: MyGridView(),
    );
  }
}

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GridView Demo'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // 每行显示的列数
        mainAxisSpacing: 10.0, // 主轴（垂直方向）的间距
        crossAxisSpacing: 10.0, // 交叉轴（水平方向）的间距
        padding: EdgeInsets.all(10.0), // 网格布局的内边距
        children: List.generate(20, (index) {
          // 生成网格项
          return Container(
            color: Colors.blue[100 * (index % 9)], // 每个网格项的颜色
            child: Center(
              child: Text(
                'Item $index', // 网格项的文本内容
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }),
      ),
    );
  }
}
```
* ***SingleChildScrollView：***用于在***只有一个子组件的情况下支持滚动***。它***只能包含一个子组件***，这个子组件通常是一个 `Column` 或 `Row`，用于在垂直或水平方向上排列其他子组件；
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('SingleChildScrollView Demo'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(
              50,
              (index) => ListTile(
                leading: Icon(Icons.star),
                title: Text('Item $index'),
                subtitle: Text('Subtitle $index'),
                onTap: () {
                  print('Tapped on item $index');
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
```
* ***TabBar*** 和 ***TabBarView：***
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3, // 指定标签页的数量
        child: Scaffold(
          appBar: AppBar(
            title: Text('TabBar and TabBarView Demo'),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Tab 1'),
                Tab(text: 'Tab 2'),
                Tab(text: 'Tab 3'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // 第一个标签页
              Center(
                child: Text('Content of Tab 1'),
              ),
              // 第二个标签页
              Center(
                child: Text('Content of Tab 2'),
              ),
              // 第三个标签页
              Center(
                child: Text('Content of Tab 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```
* ***Expanded*** 和 ***Flexible：***
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Expanded and Flexible Demo'),
        ),
        body: Column(
          children: [
            Container(
              height: 100,
              color: Colors.blue,
              child: Center(child: Text('Fixed height')),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Center(child: Text('Expanded')),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                color: Colors.yellow,
                child: Center(child: Text('Flexible with flex: 2')),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.orange,
                child: Center(child: Text('Flexible with flex: 1')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```
* ***PopupMenuButton：***用于在***用户点击时显示一个弹出菜单***。它通常用于显示一组操作或选项，并在用户选择时触发相应的操作。
  * `itemBuilder`：一个回调函数，用于构建弹出菜单中的各个菜单项。这个回调函数接受一个 `BuildContext` 和一个 `int` 类型的索引参数，并返回一个 `PopupMenuItem` `Widget`列表；
  * `onSelected`：一个回调函数，用于处理用户选择菜单项的事件。当用户选择一个菜单项时，这个回调函数会被调用，传入用户选择的菜单项的值作为参数；
  * `icon`：可选的图标，用于显示在按钮旁边；
```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('PopupMenuButton Demo'),
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'item1',
                  child: Text('Item 1'),
                ),
                const PopupMenuItem<String>(
                  value: 'item2',
                  child: Text('Item 2'),
                ),
                const PopupMenuItem<String>(
                  value: 'item3',
                  child: Text('Item 3'),
                ),
              ],
              onSelected: (String value) {
                print('You selected: $value');
              },
            ),
          ],
        ),
        body: Center(
          child: Text('PopupMenuButton Demo'),
        ),
      ),
    );
  }
}
```
