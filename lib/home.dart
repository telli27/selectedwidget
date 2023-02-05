import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'select.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MyContainer();
  }
}

class MyContainer extends StatefulWidget {
  const MyContainer({super.key});

  @override
  State<MyContainer> createState() => _MyContainerState();
}

class _MyContainerState extends State<MyContainer> {
  GlobalKey<MyCustomAllWidgetState> _myKey = GlobalKey();
  GlobalKey<MyCustomAllWidgetState> _myKey2 = GlobalKey();
  GlobalKey<MyCustomAllWidgetState> _myKey3 = GlobalKey();
  PanelController _pc1 = new PanelController();

  @override
  Widget build(BuildContext context) {
    print("merhabaaa burası build **********  ");
    return Scaffold(
        body: Stack(
      children: [
        MyWidget(pc1: _pc1, myKey: _myKey),
        SlidingUpPanel(
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.white
                : Colors.black,
            controller: _pc1,
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height * 0.5,
            backdropEnabled: true,
            backdropOpacity: 0.5,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            panel: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () {
                                _myKey.currentState?.onClear(myjson);
                                //  _myKey2.currentState?.onClear(myjson2);
                                //_myKey3.currentState?.onClear(myjson3);
                                _pc1.close();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(99))),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: MyCustomAllWidget(
                              key: _myKey,
                              prewiew: true,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              dropdownIcon: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ),
                              items: myList,
                              multiselect: true,
                              menuMode: true,
                              label: "Ülke",
                              initialSelectedValues: myjson,
                              showDialogKeyListName: 'name',
                              onChanged: (value) {
                                setState(() {
                                  //Bu kısım sadece panelde ki kaydet butonuna tıklanıldığı zaman aktif olur
                                  myjson = jsonDecode(value);
                                });
                                print("gelen veri ************ $myjson");
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              searchpositionName = "";
                              searchpositionName2 = "";
                              searchpositionName2 = "";
                              _myKey.currentState?.onWidgetChanged();
                              //_myKey2.currentState?.onWidgetChanged();
                              //_myKey3.currentState?.onWidgetChanged();

                              myjson == null
                                  ? []
                                  : myjson.forEach((value) {
                                      searchpositionName = searchpositionName +
                                          value["name"].toString();
                                    });
                              myjson2 == null
                                  ? []
                                  : myjson2.forEach((value) {
                                      searchpositionName2 =
                                          searchpositionName2 +
                                              value["name"].toString();
                                    });
                              myjson3 == null
                                  ? []
                                  : myjson3.forEach((value) {
                                      searchpositionName3 =
                                          searchpositionName3 +
                                              value["name"].toString();
                                    });
                              _pc1.close();
                            },
                            child: Container(
                              height: 80,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text("Kaydet"),
                              ),
                            ),
                          )
                        ])))))
      ],
    ));
  }
}

class MyWidget extends StatefulWidget {
  GlobalKey<MyCustomAllWidgetState> myKey;

  PanelController pc1;
  MyWidget({
    Key? key,
    required this.myKey,
    required this.pc1,
  }) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
          onPressed: () async {
            setState(() {
              widget.myKey.currentState?.initValuesFonction(myjson);
            });

            widget.pc1.open();
          },
          child: Icon(Icons.add),
        ),
        Align(
            alignment: Alignment.center,
            child: Text("ad " + searchpositionName)),
      ],
    );
  }
}

String searchpositionName = "";
String searchpositionName2 = "";
String searchpositionName3 = "";
List<Map<String, dynamic>> myList = [
  {"name": "Kotlin", "id": 0},
  {"name": "Flutter", "id": 1},
  {"name": "Java", "id": 2},
  {"name": "Android", "id": 3},
  {"name": "Nodejs", "id": 4},
  {"name": "Fortlan", "id": 5},
  {"name": "Kimya", "id": 6},
  {"name": "Fortlan", "id": 7},
  {"name": "Fortlan", "id": 8},
];
List myjson = [myList[0], myList[1]];
List myjson2 = [myList[3], myList[4]];
List myjson3 = [myList[4], myList[5]];
