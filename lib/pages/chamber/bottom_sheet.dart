import 'package:app_flat/models/apartment_model.dart';
import 'package:app_flat/models/chambre.dart';
import 'package:app_flat/pages/chamber/hotel_app_theme.dart';
import 'package:app_flat/utils/database.dart';
import 'package:flutter/material.dart';

class ChamberBottomSheet extends StatefulWidget {
  final Function(int, int, int) onApplyClick;
  final Function onCancelClick;
  final String myHotel;

  const ChamberBottomSheet({
    this.onApplyClick,
    this.onCancelClick,
    this.myHotel,
  });
  @override
  _ChamberBottomSheetState createState() => _ChamberBottomSheetState();
}

class _ChamberBottomSheetState extends State<ChamberBottomSheet> {
  final String title = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 3));
  int ncham = 1;
  int x = 1;

  List<Widget> list = [];
  List<Chambre> myChambers = [];

  Future<void> getChambers(hid) async {
    await DatabaseService().getChamberByHotelId(hid).then((value) {
      value.forEach((element) {
        myChambers.add(element);
      });
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getChambers(widget.myHotel);
  }

  @override
  Widget build(BuildContext context) {
    list.clear();
    for (var i = 0; i < x; i++) {
      list.add(Column(
        children: <Widget>[
          AjouterChambre(
            id: i,
            nbCH: i + 1,
          ),
          const Divider(
            height: 1,
          ),
        ],
      ));
    }
    return Center(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Column(children: list),
                Padding(
                  padding: const EdgeInsets.only(left: 150, top: 15),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Icon(
                          Icons.add,
                          color: Colors.teal,
                          size: 18,
                        ),
                      ),
                      InkWell(
                        child: Text('Ajouter une chambre'),
                        onTap: () {
                          setState(() {
                            print(myChambers.length);
                            if (x < myChambers.length) x++;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class AjouterChambre extends StatefulWidget {
  final int id;
  final int nbCH;

  AjouterChambre({@required this.id, this.nbCH});
  @override
  _AjouterChambreState createState() => _AjouterChambreState();
}

class _AjouterChambreState extends State<AjouterChambre> {
  int _ncham = 1;
  int _nadult = 2;
  int _nEnf = 0;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20),
        child: Row(
          children: <Widget>[
            Text(' CHAMBRE ${widget.nbCH}'),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                      Text('    \t'),
                      new Text('$_nadult',
                          style: new TextStyle(fontSize: 15.0)),
                      Text(
                        '\t Adultes',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                          child: Container(
                            width: 28,
                            height: 28,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.teal,
                                size: 28,
                              ),
                            ),
                          ),
                          onTap: minusADULT),
                      Text('\t  \t'),
                      InkWell(
                        child: Container(
                          width: 28,
                          height: 28,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.2)),
                            ),
                            child: Icon(
                              Icons.add,
                              color: Colors.teal,
                              size: 28,
                            ),
                          ),
                        ),
                        onTap: addADULT,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 20, bottom: 15),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.person,
                        color: Colors.teal,
                      ),
                      Text('    \t'),
                      new Text('$_nEnf', style: new TextStyle(fontSize: 15.0)),
                      Text(
                        '\t Enfants',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      InkWell(
                          child: Container(
                            width: 28,
                            height: 28,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                              ),
                              child: Icon(
                                Icons.remove,
                                color: Colors.teal,
                                size: 28,
                              ),
                            ),
                          ),
                          onTap: minusEnf),
                      Text('\t  \t'),
                      InkWell(
                          child: Container(
                            width: 28,
                            height: 28,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.teal,
                                size: 28,
                              ),
                            ),
                          ),
                          onTap: addENF),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
/*     Padding(
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
              ),
           */
