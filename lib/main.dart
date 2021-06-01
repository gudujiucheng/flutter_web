import 'package:flutter/material.dart';

import 'TimerWidget.dart';
import 'model/city_info.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '时刻表',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '时刻表'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isEditType = false;
  List<CityInfo> cityList = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 50),
            child: TextButton(
              onPressed: () {
                setState(() {
                  isEditType = !isEditType;
                });
              },
              child: Text(isEditType ? "完成" : "编辑",
                  style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          )
        ],
      ),
      body: Center(
          child: Column(children: [
        TimerWidget(),
        Expanded(
          child: AnimatedList(
            key: _listKey,
            initialItemCount: cityList.length,
            itemBuilder: (context, index, animation) {
              return getItem(index, animation);
            },
          ),
        ),
      ])),
    );
  }

  Widget getItem(int index, Animation _animation) {
    var cityInfo = cityList[index];

    return SlideTransition(
        position: _animation
            .drive(CurveTween(curve: Curves.easeIn))
            .drive(Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))),
        child: Container(
          margin: EdgeInsets.all(40),
          padding: EdgeInsets.all(12),

          //边框设置
          decoration: new BoxDecoration(
            //背景
            color: Colors.blueGrey,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            //设置四周边框
            // border: new Border.all(width: 1, color: Colors.red),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(cityInfo.cityName,
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                    Text(cityInfo.cityTime.toString(),
                        style: TextStyle(fontSize: 20, color: Colors.white))
                  ],
                ),
              ),
              Visibility(
                visible: isEditType,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    iconSize: 60,
                    onPressed: () {
                      _listKey.currentState?.removeItem(index,
                          (context, animation) {
                        return getItem(index, animation);
                      });
                      cityList.removeAt(index);
                    },
                    color: Colors.redAccent, //控制图标颜色
                    icon: Icon(Icons.delete_forever_outlined),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void loadData() {
    setState(() {
      cityList.add(CityInfo(cityName: "北京1", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京2", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京3", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京4", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京5", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京6", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京7", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京8", cityTime: 1111));
      cityList.add(CityInfo(cityName: "北京9", cityTime: 1111));
    });
  }
}

// Text.rich(TextSpan(children: [
// TextSpan(text: "北京", style: TextStyle(fontSize: 40,color: Colors.white)),
// TextSpan(text: "\n2021-10-11 12:45", style: TextStyle(fontSize: 20))
// ])),
