import 'package:app_flat/core/const.dart';
import 'package:app_flat/pages/chamber/ReserverChamber.dart';
import 'package:app_flat/pages/chamber/calendar_popup_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChamberBottomSheet extends StatefulWidget {
  @override
  _ChamberBottomSheetState createState() => _ChamberBottomSheetState();
}

class _ChamberBottomSheetState extends State<ChamberBottomSheet> {
  final String title = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 3));
  int _ncham = 0;
  int _nadult = 0;
  int _nEnf = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        posionned(),
        getTimeDateUI(),
      ],
    ));
  }

  Widget posionned() {
    var _theme = Theme.of(context);
    var fullWidth = MediaQuery.of(context).size.width;
    return Positioned(
        bottom: 0,
        left: 0,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: _theme.dialogBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSizes.widgetBorderRadius),
                topRight: Radius.circular(AppSizes.widgetBorderRadius),
              )),
          width: fullWidth,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(AppSizes.sidePadding),
                child: Container(
                  width: 60,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.darkGray,
                    borderRadius: BorderRadius.circular(AppSizes.imageRadius),
                  ),
                ),
              ),
              title != ''
                  ? Text(title, style: _theme.textTheme.display1)
                  : Container(),
            ],
          ),
        ));
  }

  Widget getTimeDateUI() {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    child: Container(
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
                            left: 10,
                            right: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Check-in',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.teal),
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
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
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
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Check-out',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.teal,
                                  )),
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
      Row(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 8, top: 4, bottom: 4),
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
                    new Text('$_ncham', style: new TextStyle(fontSize: 15.0)),
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
        ],
      ),
      const Divider(
        height: 1,
      ),
      Row(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20, right: 8, top: 4, bottom: 4),
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
        ],
      ),
      const Divider(
        height: 1,
      ),
      Row(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 8, top: 4, bottom: 4),
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
                    new Text('$_nEnf', style: new TextStyle(fontSize: 15.0)),
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
        ],
      ),
      RaisedButton(
        child: Text("Reserver"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.teal)),
        color: Colors.teal[100],
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return Reserverchamber();
          }));
        },
      ),
    ]);
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

class AppSizes {
  static const int splashScreenTitleFontSize = 48;
  static const int titleFontSize = 34;
  static const double sidePadding = 10;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 25;
  static const double imageRadius = 8;
  static const double linePadding = 4;
  static const double widgetBorderRadius = 34;
  static const double textFieldRadius = 4.0;
  static const EdgeInsets bottomSheetPadding =
      EdgeInsets.symmetric(horizontal: 16, vertical: 10);
  static const app_bar_size = 56.0;
  static const app_bar_expanded_size = 180.0;
  static const tile_width = 148.0;
  static const tile_height = 276.0;
}
