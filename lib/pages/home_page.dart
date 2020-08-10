import 'package:app_flat/Login/profile.dart';
import 'package:app_flat/models/apartment_model.dart';
import 'package:app_flat/pages/Equipement.dart';
import 'package:app_flat/pages/ajout_bien.dart';
import 'package:app_flat/pages/chamber/calendar_popup_view.dart';
import 'package:app_flat/pages/filtre/filters_screen.dart';
import 'package:app_flat/pages/filtre/popular_filter_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:app_flat/utils/database.dart';
import 'package:app_flat/pages/detail_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:app_flat/pages/filtre/hotel_app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  final RangeValues minMaxPrixFilter;
  final List<PopularFilterListData> listnomEquip;
  final List<PopularFilterListData> listnomHeberg;
  HomePage({this.minMaxPrixFilter, this.listnomEquip, this.listnomHeberg});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StorageReference photosReference =
      FirebaseStorage.instance.ref().child("hotels");
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 3));
  List<ApartmentModel> myHotels = [];
  List<Equipement> myEquipments = [];

  final tabs = [
    Center(child: Text("Home")),
    Center(child: Text("filter_list")),
    Center(child: Text("Profile")),
  ];
  Widget callPage(int currenIindex) {
    switch (currenIindex) {
      case 0:
        return this._bodyHome(context);
      case 1:
        return AjoutBien();
      case 2:
        return ProfilePage();
        break;
      default:
        return this._bodyHome(context);
    }
  }

  void initState() {
    super.initState();
    // print(" listed" + widget.listnomEquip.toString());
    // if (widget.minMaxPrixFilter != null) {
    //   getHotels(widget.minMaxPrixFilter);
    // }
    if (widget.listnomEquip != null) {
      getHotelsByEquipement(widget.listnomEquip);
    }
  }

  // RangeValues _values = const RangeValues(0, 1000);

  Future<void> getHotels(RangeValues minMaxPrixFilter) async {
    await DatabaseService().getHotels().then((value) {
      value.forEach((element) {
        if ((element.prix >= minMaxPrixFilter.start) &&
            (element.prix <= minMaxPrixFilter.end)) {
          myHotels.add(element);
          print(element.prix.toString());
        }
        setState(() {});
      });
    });
  }

  Future<void> getHotelsByEquipement(
      List<PopularFilterListData> listnomEquip) async {
    print('inside getHotelsByEquipement');
    listnomEquip.forEach((d) {
      print("Selected  " + d.titleTxt);
    });
    List<String> hotelsIds = [];

    await DatabaseService().getEquipements().then((value) {
      value.forEach((element) {
        listnomEquip.forEach((filteredElement) {
          if (element.nom.toUpperCase() ==
              filteredElement.titleTxt.toUpperCase()) {
            hotelsIds.add(element.idHotel);
            print('hotel  = ' + element.idHotel);
          }
        });
      });
      print('hotelsIds  = ' + hotelsIds.toString());

      hotelsIds.forEach((element) {
        DatabaseService().getHotelById(element).then((value) {
          myHotels.add(value.first);
          print("le nom " + value.first.nom);
          setState(() {});
        });
      });
    });
  }

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
          "Loca Vacances",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.black38,
            ),
            onPressed: () {
              Navigator.push<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => FiltersScreen(),
                    fullscreenDialog: true),
              );
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: ProfilePage(),
      ),
      body: _bodyHome(context),
    );
  }

  Widget _bodyHome(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          getSearchBarUI(),
          Expanded(
            child: widget.minMaxPrixFilter == null
                ? StreamBuilder(
                    stream: DatabaseService().hotels,
                    builder: (context, snapshot) {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount:
                            snapshot.data != null ? snapshot.data.length : 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    myHotel: snapshot.data[index],
                                  ),
                                ),
                              );
                            },
                            child: _buildItem(context, snapshot.data[index]),
                          );
                        },
                      );
                    },
                  )
                : ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: myHotels.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                myHotel: myHotels[index],
                              ),
                            ),
                          );
                        },
                        child: _buildItem(context, myHotels[index]),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
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

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10, top: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: HotelAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: HotelAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Rechercher ...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: HotelAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Container(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: HotelAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, ApartmentModel hotel) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 250,
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  image: new DecorationImage(
                    image: NetworkImage(hotel.image),
                  ),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 7, spreadRadius: 1, color: Colors.black12)
                  ],
                ),
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black87,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: 12,
                        left: 40,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width * .25,
                              child: Text(hotel.nom,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  )))
                        ],
                      ),
                    ),
                  )
                ]),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: MediaQuery.of(context).size.width * .45,
              height: 200,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 7,
                    spreadRadius: 1,
                    color: Colors.black12,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "A partir de ",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.euro_symbol,
                        size: 15,
                      ),
                      Text(
                        "${hotel.prix.toInt()}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "/nuit",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${hotel.address}",
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 13,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      RatingBar(
                        onRatingUpdate: (v) {},
                        initialRating: hotel.etoile.toDouble(),
                        itemSize: 12,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      // Text(
                      //   "${hotel.avis.length.toInt()} reviews",
                      //   style: TextStyle(color: Colors.black87, fontSize: 10),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
// Row(
//   children: <Widget>[
//     Container(
//       width: 25,
//       height: 25,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: ExactAssetImage("assets/1.jpg"),
//         ),
//         borderRadius: BorderRadius.all(
//           Radius.circular(50),
//         ),
//       ),
//     ),
//     Container(
//       width: 25,
//       height: 25,
//       decoration: BoxDecoration(
//         color: Colors.black26,
//         borderRadius: BorderRadius.all(
//           Radius.circular(50),
//         ),
//       ),
//       child: Center(
//         child: Text(
//           "23+",
//           style: TextStyle(fontSize: 10),
//         ),
//       ),
//     )
//   ],
// ),
/*Wrap(
                              children: <Widget>[
                                ...myHotels[index].features.map(
                                  (feature) {
                                    return Container(
                                      padding: EdgeInsets.all(6),
                                      margin:
                                          EdgeInsets.only(bottom: 6, right: 6),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        color: AppColors.stylecolor,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),*/
// void showDemoDialog1({BuildContext context}) {
//   showDialog<dynamic>(
//     context: context,
//     builder: (BuildContext context) => ChamberBottomSheet(
//       onApplyClick: (int nbCham, int nbAdlt, int nbEnf) {
//         setState(() {
//           _ncham = nbCham;
//           _nadult = nbAdlt;
//           _nEnf = nbEnf;
//         });
//       },
//       onCancelClick: () {},
//     ),
//   );
// }
