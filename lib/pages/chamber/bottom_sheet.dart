import 'package:app_flat/pages/chamber/hotel_app_theme.dart';
import 'package:flutter/material.dart';

class ChamberBottomSheet extends StatefulWidget {
  final Function(int, int, int) onApplyClick;
  final Function onCancelClick;
  final int ncham;
  final int nadult;
  final int nEnf;
  const ChamberBottomSheet(
      {Key key,
      this.onApplyClick,
      this.onCancelClick,
      this.ncham,
      this.nadult,
      this.nEnf})
      : super(key: key);
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
  void initState() {
    if (widget.ncham != null) {
      _ncham = widget.ncham;
    }
    if (widget.nadult != null) {
      _nadult = widget.nadult;
    }
    if (widget.nEnf != null) {
      _nEnf = widget.nEnf;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            color: HotelAppTheme.buildLightTheme().backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(4, 4),
                  blurRadius: 8.0),
            ],
          ),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {},
            child: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Icon(Icons.person),
                              Text(
                                '\t Adultes',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                              Text('\t       \t'),
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
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(Icons.person),
                            Text(
                              '\t Enfants',
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 16, top: 8),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: HotelAppTheme.buildLightTheme().primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 8,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        try {
                          // animationController.reverse().then((f) {

                          // });
                          widget.onApplyClick(_ncham, _nadult, _nEnf);
                          Navigator.pop(context);
                        } catch (_) {}
                      },
                      child: Center(
                        child: Text(
                          'selectionner',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    ));
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
