import 'package:app_flat/pages/chamber/calendar_popup_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class Reserverchamber extends StatefulWidget {
  @override
  _ReserverchamberState createState() => _ReserverchamberState();
}

class _ReserverchamberState extends State<Reserverchamber> {
  String _selectedDate1;
  String _selectedDate2;
  String _selectedTime;
  String _selectedDateTime;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 3));
  int _ncham = 0;
  int _nadult = 0;
  int _nEnf = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blueGrey[50], Colors.teal[200]])),
        ),
        title: Text(
          "Reserver la chambre ",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 18, bottom: 16),
                child: getTimeDateUI(),
              ),
            ],
          )),
    );
  }

  Widget date() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => _showDatePicker1(),
                  color: Colors.white,
                  child: Text(
                    " Check-in \n ${_selectedDate1 ?? "Selected Date"}",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => _showDatePicker2(),
                  color: Colors.white,
                  child: Text(
                    " check-out \n ${_selectedDate2 ?? "Selected Date"}",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showDatePicker1() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 1, 1),
        maxTime: DateTime(3000, 12, 31), onConfirm: (date) {
      setState(() {
        _selectedDate1 = DateFormat("dd-MM-yyyy").format(date);
      });
    }, locale: LocaleType.en);
  }

  _showDatePicker2() {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 1, 1),
        maxTime: DateTime(3000, 12, 31), onConfirm: (date) {
      setState(() {
        _selectedDate2 = DateFormat("dd-MM-yyyy").format(date);
      });
    }, locale: LocaleType.en);
  }

  _showTimePicker() {
    DatePicker.showTimePicker(context, showTitleActions: true,
        onConfirm: (time) {
      setState(() {
        _selectedTime = DateFormat("HH:mm:ss").format(time);
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  _showDateTimePicker() {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime(1980, 1, 1),
        maxTime: DateTime(3000, 12, 31), onConfirm: (dateTime) {
      setState(() {
        print(dateTime);
        _selectedDateTime = DateFormat("yyyy-MM-dd  HH-mm-ss").format(dateTime);
      });
    });
  }

  Widget getTimeDateUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        onTap: () {
                          // FocusScope.of(context).requestFocus(FocusNode());
                          // setState(() {
                          //   isDatePopupOpen = true;
                          // });
                          showDemoDialog(context: context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Check-in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                '${DateFormat("dd, MMM, yyyy").format(startDate)} ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Container(
                      color: Colors.transparent,
                      child: InkWell(
                        focusColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.grey.withOpacity(0.2),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        onTap: () {
                          showDemoDialog(context: context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Check-out',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                ' ${DateFormat("dd, MMM, yyyy").format(endDate)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w100,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(
                          height: 8,
                        ),
                        new Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Hébergement',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.8)),
                            ),
                            Text('   '),
                            new FlatButton(
                              onPressed: minusCham,
                              child: new Icon(
                                Icons.expand_more,
                                color: Colors.black,
                                size: 15,
                              ),
                              // backgroundColor: Colors.white,
                              // mini: true,
                            ),
                            new Text('$_ncham',
                                style: new TextStyle(fontSize: 15.0)),
                            new FlatButton(
                              onPressed: addCH,
                              child: new Icon(Icons.expand_less,
                                  size: 15, color: Colors.black),
                              // backgroundColor: Colors.white,
                              // mini: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Adulte',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.8)),
                            ),
                            Text('\t         \t     \t'),
                            new FlatButton(
                              onPressed: minusADULT,
                              child: new Icon(
                                Icons.expand_more,
                                color: Colors.black,
                                size: 15,
                              ),
                              // backgroundColor: Colors.white,
                              // mini: true,
                            ),
                            new Text('$_nadult',
                                style: new TextStyle(fontSize: 15.0)),
                            new FlatButton(
                              onPressed: addADULT,
                              child: new Icon(Icons.expand_less,
                                  size: 15, color: Colors.black),
                              // backgroundColor: Colors.white,
                              // mini: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Row(
            children: <Widget>[
              Container(
                color: Colors.transparent,
                child: InkWell(
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  splashColor: Colors.grey.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                  onTap: () {
                    // FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 8, top: 4, bottom: 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Enfants',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.8)),
                            ),
                            Text('\t            \t'),
                            new FlatButton(
                              onPressed: minusEnf,
                              child: new Icon(
                                Icons.expand_more,
                                color: Colors.black,
                                size: 15,
                              ),
                              // backgroundColor: Colors.white,
                              // mini: true,
                            ),
                            new Text('$_nEnf',
                                style: new TextStyle(fontSize: 15.0)),
                            new FlatButton(
                              onPressed: addENF,
                              child: new Icon(Icons.expand_less,
                                  size: 15, color: Colors.black),
                              // backgroundColor: Colors.white,
                              // mini: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 80, left: 200),
          child: RaisedButton(
            child: Text("Reserver"),
            color: Colors.teal[200],
            onPressed: () {},
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
          ),
        ),
      ]),
    );
  }

  void addCH() {
    setState(() {
      _ncham++;
    });
  }

  void addADULT() {
    setState(() {
      _nadult++;
    });
  }

  void addENF() {
    setState(() {
      _nEnf++;
    });
  }

  void minusCham() {
    setState(() {
      if (_ncham != 0) _ncham--;
    });
  }

  void minusADULT() {
    setState(() {
      if (_nadult != 0) _nadult--;
    });
  }

  void minusEnf() {
    setState(() {
      if (_nEnf != 0) _nEnf--;
    });
  }

  void showDemoDialog({BuildContext context}) {
    showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) => CalendarPopupView(
        barrierDismissible: true,
        minimumDate: DateTime.now(),
        //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
        initialEndDate: endDate,
        initialStartDate: startDate,
        onApplyClick: (DateTime startData, DateTime endData) {
          setState(() {
            if (startData != null && endData != null) {
              startDate = startData;
              endDate = endData;
            }
          });
        },
        onCancelClick: () {},
      ),
    );
  }
}
/*Divider(),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    " ${_selectedTime ?? "Selected Time"}",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                  RaisedButton(
                    onPressed: () => _showTimePicker(),
                    child: Text("Show Time Picker"),
                  ),
                  Divider(),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    " ${_selectedDateTime ?? "Selected Date and Time"}",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                  ),
                  RaisedButton(
                    onPressed: () => _showDateTimePicker(),
                    child: Text("Show Date and Time Picker"),
                  ),*/
