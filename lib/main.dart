import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:date_format/date_format.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // iOS浅色主题
  final ThemeData kAndroidTheme = ThemeData(
      brightness: Brightness.light,//亮色主题
      accentColor: Colors.white,//(按钮)Widget前景色为白色
      primaryColor: Colors.blue,//主题色为蓝色
      iconTheme:IconThemeData(color: Colors.grey),//icon主题为灰色
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.black))//文本主题为黑色
  );
  // Android深色主题
  final ThemeData kIOSTheme = ThemeData(
      brightness: Brightness.dark,//深色主题
      accentColor: Colors.black,//(按钮)Widget前景色为黑色
      primaryColor: Colors.cyan,//主题色Wie青色
      iconTheme:IconThemeData(color: Colors.blue),//icon主题色为蓝色
      textTheme: TextTheme(bodyText2: TextStyle(color: Colors.red))//文本主题色为红色
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTargetPlatform == TargetPlatform.android ? kAndroidTheme : kIOSTheme,
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
class _MyHomePageState extends State<MyHomePage> {
  double x = 0;
  double y = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite),
                    Text('favorite')
                  ],
                ),
                Theme(
                  data: ThemeData(iconTheme: IconThemeData(color: Colors.red)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Text(
                        'favorite',
                        style: TextStyle(fontFamily: 'SyneMono', fontSize: 28),
                      )
                    ],
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(iconTheme: IconThemeData(color: Colors.green)),//设置文本颜色为红色),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite),
                      Text(
                        'favorite',
                        style: TextStyle(fontFamily: 'RobotoCondensed', fontStyle: FontStyle.italic, fontSize: 19),
                      )
                    ],
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Text with a background color',
                    style: Theme.of(context).textTheme.headline6,  // 除了定义 Material Design 规范中那些可自定义部分样式外，主题的另一个重要用途是样式复用。
                  ),
                ),
                Listener(
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, top: 12, right: 0, bottom: 12),
                    child: Image.asset(
                      'assets/IMG_1828.GIF',
                      width: 300,
                    ),
                  ),
                  onPointerDown: (event) {
                    print('down $event');
                  },
                  onPointerUp: (event) {
                    print('up $event');
                  },
                  onPointerMove: (event) {
                    print('move $event');
                  },
                  onPointerCancel: (event) {
                    print('cancel $event');
                  },
                ),
                GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        child: Image.asset('assets/7dae9f013e06a7866e8ab1b1296468bc.jpg'),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      Positioned(
                        top: y,
                        left: x,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:Image.asset('assets/IMG_1828.GIF', width: 100)
                        ),
                      )
                    ],
                  ),
                  onPanUpdate: (event) {
                    print('拖拽');
                    setState(() {
                      x += event.delta.dx;
                      y += event.delta.dy;
                    });
                  },
                  onPanCancel: () {
                    print('脱宅停止x');
                    setState(() {
                      if (x > 100) {
                        x = 0;
                      } else {
                        x = 600;
                      }
                    });
                  },
                )
                ]
            ),
            RawGestureDetector(
              gestures: {
                // 建立多手势识别器与手势识别工厂类的映射关系，从而返回可以响应该手势的recognizer
                MultipleTapGestureRecognizer: GestureRecognizerFactoryWithHandlers<MultipleTapGestureRecognizer>(
                  () => MultipleTapGestureRecognizer(),
                  (MultipleTapGestureRecognizer instance) {
                    instance.onTap = () => print('parent tapped ');//点击回调
                  },
                )
              },
              child: Container(
                color: Colors.pinkAccent,
                child: Center(
                  child: GestureDetector(
                    onTap: () => print('Child tapped'),//子视图的点击回调
                    child: Container(
                      color: Colors.blueAccent,
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => print('Parent tapped'),//父视图的点击回调
              child: Container(
                color: Colors.pinkAccent,
                child: Center(
                  child: GestureDetector(
                    onTap: () => print('Child tapped'),//子视图的点击回调
                    child: Container(
                      color: Colors.blueAccent,
                      width: 200.0,
                      height: 200.0,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                print('parent onTap');
              },
              child: GestureDetector(
                onTap: () {print('textButton onTap');},
                child: TextButton(
                  onPressed: () {print('textButton click');},
                  child: Icon(Icons.android),
                ),
              ),
            ),
            GestureDetector(
              onDoubleTap: () {
                print('parent onDoubleTap');
              },
              child: GestureDetector(
                onDoubleTap: () {print('textButton onDoubleTap');},
                child: TextButton(
                  onPressed: () {print('textButton click');},
                  child: Icon(Icons.dashboard),
                ),
              ),
            )
          ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
