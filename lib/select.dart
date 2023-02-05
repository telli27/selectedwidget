import 'dart:convert';

import 'package:flutter/material.dart';

import 'Home.dart';

class MyCustomAllWidget extends StatefulWidget {
  bool? multiselect;
  Decoration decoration;
  TextEditingController? controller;
  Widget dropdownIcon;
  List<dynamic> items;
  String showDialogKeyListName;
  String? label;
  ValueChanged onChanged;
  bool menuMode;
  List<dynamic>? initialSelectedValues;
  bool prewiew;
  MyCustomAllWidget(
      {Key? key,
      this.multiselect,
      required this.decoration,
      this.controller,
      required this.dropdownIcon,
      required this.items,
      required this.showDialogKeyListName,
      this.label,
      required this.onChanged,
      required this.menuMode,
      this.initialSelectedValues,
      required this.prewiew})
      : super(key: key);

  @override
  State<MyCustomAllWidget> createState() => MyCustomAllWidgetState();
}

class MyCustomAllWidgetState extends State<MyCustomAllWidget> {
  List<dynamic> selectedList = [];
  List<dynamic> menuData = [];
  List<dynamic> mainDataListGroup = [];
  List<dynamic> newDataList = [];
  Color Bitonisblue = Color(0xFF001542);
  Color BitonisInput = Color(0xFFF7F7F7);
  final searchC = TextEditingController();
  String selectedItem = "";
  List<dynamic> previousSelectedList = [];
  List<dynamic> _initialSelectedValues = [];
  @override
  void initState() {
    super.initState();

    print("burası initState****************");
    if (widget.initialSelectedValues != null) {
      print("widget.initialSelectedValues!  " +
          widget.initialSelectedValues!.toString());
      _initialSelectedValues = widget.initialSelectedValues!;
      selectedList = _initialSelectedValues;
      print("heyyyyyyy");
    }
    if (widget.multiselect == true) {
      if (widget.initialSelectedValues != null) {
        print("widget.initialSelectedValues!  " +
            widget.initialSelectedValues!.toString());
        _initialSelectedValues = widget.initialSelectedValues!;
        selectedList = _initialSelectedValues;
        print("heyyyyyyy");
      }
    }
  }

  void onClear(List gelenListe) {
    //panelde dropdownlarda değişiklik yapıp paneldeki kaydet
    //butonuna basmadığı zaman son seçilenleri değil ,önceden seçilmiş olanları selectedListe atıyorum
    setState(() {
      if (gelenListe != null) {
        initValuesFonction(gelenListe);
      }
    });
  }

  void onWidgetChanged() {
    //dropdownlarda yeni itemlar seçildiğinde widget.onChanged fonksiyonunu çalıştırmıyorum
    //Sadede bu fonksiyon çalıştığı zaman bu kısım sayesinde widget ın onChanged methodu çalışmış oluyor
    if (selectedList != null) {
      if (widget.multiselect == false) {
        widget.onChanged(jsonEncode(selectedList[0]));
        //selectedList.clear();
      } else {
        widget.onChanged(jsonEncode(selectedList));
        //selectedList.clear();
      }
    }
  }

  void initValuesFonction(List<dynamic> gelenListe) {
    //panel kapaldığı zaman orjinal seçilmiş olanlar selected Liste atanır
    setState(() {
      selectedList = gelenListe;
    });
  }

//yaptım işlemiiiii
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Expanded(
                child: InkWell(
                    onTap: () async {
                      setState(() {});
                      menuData = widget.items;
                      newDataList = menuData;
                      mainDataListGroup = menuData;
                      _initialSelectedValues = [...selectedList];

                      var newSelectedValues = await showDialog<List<dynamic>>(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return MultiSelectDialog(
                            items: widget.items,
                            initialSelectedValues: _initialSelectedValues,
                            menuMode: widget.menuMode,
                            multiselect: widget.multiselect!,
                            showDialogKeyListName: widget.showDialogKeyListName,
                            onChanged: widget.onChanged,
                          );
                        },
                      );
                      // print("newSelectedValues $newSelectedValues");
                      if (newSelectedValues != null) {
                        setState(() {
                          selectedList = newSelectedValues;
                        });
                        if (widget.prewiew == false) {
                          onWidgetChanged();
                        }
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Text(
                            selectedList == null ? widget.label.toString() : "",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                          Container(
                              child: (widget.multiselect == true &&
                                      widget.multiselect != null)
                                  ? Container(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      height: 30,
                                      child: Expanded(
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: List.generate(
                                            selectedList.length,
                                            (index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 3, 5, 3),
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(5.0),
                                                      )),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.fromLTRB(
                                                              5, 2, 5, 2),
                                                      child: Text(
                                                          selectedList.isEmpty
                                                              ? ""
                                                              : selectedList[index]
                                                                      [widget
                                                                          .showDialogKeyListName]
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold))),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 3, 5, 3),
                                          child: Container(
                                            decoration: new BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                              Radius.circular(5.0),
                                            )),
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 2, 5, 2),
                                                child: Text(
                                                    selectedList.isEmpty
                                                        ? ""
                                                        : selectedList[0][widget
                                                                .showDialogKeyListName]
                                                            .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                          ),
                                        ),
                                      ),
                                    )),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {},
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: widget.dropdownIcon,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}

class MultiSelectDialog extends StatefulWidget {
  final List<dynamic> items;
  final List<dynamic> initialSelectedValues;
  String showDialogKeyListName;
  bool multiselect;
  bool menuMode;
  ValueChanged onChanged;

  MultiSelectDialog({
    Key? key,
    required this.items,
    required this.initialSelectedValues,
    required this.showDialogKeyListName,
    required this.multiselect,
    required this.menuMode,
    required this.onChanged,
  }) : super(key: key);

  @override
  _MultiSelectDialogState createState() => _MultiSelectDialogState();
}

class _MultiSelectDialogState extends State<MultiSelectDialog> {
  List<dynamic> _selectedValues = [];
  final searchC = TextEditingController();
  List<dynamic> menuData = [];
  List<dynamic> mainDataListGroup = [];
  List<dynamic> newDataList = [];
  List<dynamic> initiaList = [];
  bool state = false;
  @override
  void initState() {
    _selectedValues = [...widget.initialSelectedValues];
    mainDataListGroup = [...widget.items];
    newDataList = [...widget.items];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        child: Scrollbar(
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: (() {
                          setState(() {});
                          Navigator.of(context).pop();
                        }),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color:Colors.blue,
                          ),
                        )),
                  ),
                  Visibility(
                      visible: widget.menuMode == true ? true : false,
                      child: searchBox(setState)),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: widget.items.isEmpty ||
                              newDataList == [] ||
                              newDataList == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              padding: EdgeInsets.zero,
                              itemCount: newDataList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return TextButton(
                                    style: TextButton.styleFrom(
                                        primary: Colors.blue,
                                        padding: EdgeInsets.all(8),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap),
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                      child: Row(
                                        children: [
                                          Visibility(
                                            visible: widget.multiselect == true
                                                ? true
                                                : false,
                                            child: SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: Checkbox(
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  value:
                                                      _selectedValues.contains(
                                                          newDataList[index]),
                                                  activeColor:
                            Colors.blue,
                                                  onChanged: (newValue) {
                                                    if (_selectedValues
                                                        .contains(newDataList[
                                                            index])) {
                                                      setState(() {
                                                        _selectedValues.remove(
                                                            newDataList[index]);
                                                      });
                                                    } else {
                                                      setState(() {
                                                        _selectedValues.add(
                                                            newDataList[index]);
                                                      });
                                                    }
                                                  }),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Text(
                                              newDataList[index][widget
                                                      .showDialogKeyListName]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onPressed: () {
                                      if (widget.multiselect == true) {
                                        if (_selectedValues
                                            .contains(newDataList[index])) {
                                          setState(() {
                                            _selectedValues
                                                .remove(newDataList[index]);
                                          });
                                        } else {
                                          setState(() {
                                            _selectedValues
                                                .add(newDataList[index]);
                                          });
                                        }
                                      } else {
                                        if (widget.menuMode == true) {
                                          if (searchC.text.isEmpty) {
                                            _selectedValues = [
                                              newDataList[index]
                                            ];

                                            //    widget.onChanged(_selectedValues[0]);
                                            Navigator.pop(
                                                context, _selectedValues);
                                          } else {
                                            print("bakkk");
                                            _selectedValues = [
                                              newDataList[index]
                                            ];
                                            // widget.onChanged(_selectedValues[0]);
                                            setState(() {});

                                            Navigator.pop(
                                                context, _selectedValues);
                                          }
                                        } else {
                                          _selectedValues = [
                                            newDataList[index]
                                          ];
                                          // widget.onChanged(_selectedValues[0]);
                                          setState(() {});
                                          Navigator.pop(
                                              context, _selectedValues);
                                        }
                                      }
                                    });
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  indent: 15,
                                  endIndent: 15,
                                  color: Colors.grey,
                                );
                              },
                            ),
                    ),
                  ),
                  Visibility(
                      visible: widget.multiselect == true ? true : false,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          child: Container(
                              color: Colors.transparent,
                              width: MediaQuery.of(context).size.width - 30,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      padding: EdgeInsets.only(bottom: 10),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width -
                                          30,
                                      child: TextButton(
                                        onPressed: () {
                                          
                                        },
                                        child: Text("Kaydet"),)))),
                          onTap: () {
                            var sendList = [];

                            for (int i = 0; i < menuData.length; i++) {
                              if (_selectedValues.contains(menuData[i])) {
                                sendList.add(widget.items[i]);
                              }
                            }
                            //   widget.onChanged(sendList);

                            Navigator.pop(context, _selectedValues);

                            setState(() {});
                          },
                        ),
                      )),
                ],
              )),
        ),
      ),
    );
  }

  searchBox(StateSetter setState) {
    return Visibility(
      visible: true,
      child: SizedBox(
        height: 70,
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
          child: Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 247, 247, 247),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchC,
                decoration:
                    InputDecoration(hintText: "Ara", border: InputBorder.none),
                onChanged: (v) {
                  searchItem(v);
                  setState(() {});
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  searchItem(String value) {
    List<dynamic> list = [];
    List<dynamic> k = [];
    setState(() {
      if (value.isEmpty) {
        newDataList = widget.items;
      } else {
        for (var map in mainDataListGroup) {
          for (var key in map.keys) {
            if (map[key]
                .toLowerCase()
                .toString()
                .contains(value.toLowerCase().toString())) {
              list.add(map);
              newDataList = list;
            }
          }
        }
      }
    });
  }
}
