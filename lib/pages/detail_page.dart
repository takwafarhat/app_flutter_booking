import 'package:app_flat/core/const.dart';
import 'package:app_flat/models/chambre.dart';
import 'package:app_flat/pages/Avis/Avis.dart';
import 'package:app_flat/pages/Avis/product_review_and_rating_screen.dart';
import 'package:app_flat/pages/Equipement.dart';
import 'package:app_flat/pages/Map/my_map.dart';
import 'package:app_flat/pages/chamber/DetailsChambre.dart';
import 'package:app_flat/utils/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';
import '../models/apartment_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailPage extends StatefulWidget {
  final ApartmentModel myHotel;
  DetailPage({@required this.myHotel});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _pageController = PageController(viewportFraction: 1, keepPage: false);
  var _currentIndex = 0;
  var _maxLines = 3;
  bool isFav;
  List<Chambre> myChambers = [];
  List<Avis> mesAvis = [];
  List<Equipement> myEquipments = [];

  @override
  void initState() {
    super.initState();
    print('myHotel address' + widget.myHotel.address);

    // print('myHotel geopoint' + widget.myHotel.position.latitude.toString());
    getChambers(widget.myHotel.id);
    isFav = widget.myHotel.favoris;
    getAvis(widget.myHotel.id);
    getEquipement(widget.myHotel.id);
  }

  Future<void> getChambers(hid) async {
    await DatabaseService().getChamberByHotelId(hid).then((value) {
      value.forEach((element) {
        myChambers.add(element);
        // print(element.equipement.toString());
      });
      setState(() {});
    });
  }

  Future<void> getAvis(hid) async {
    await DatabaseService().getavisByHotelId(hid).then((value) {
      value.forEach((element) {
        mesAvis.add(element);
      });
      setState(() {});
    });
  }

  Future<void> getEquipement(hid) async {
    await DatabaseService().getEquipementByHotelId(hid).then((value) {
      value.forEach((element) {
        print(element.nom.toString());
        myEquipments.add(element);
      });
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page.round();
      });
    });

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildWidgetButtonClose(context),
          _buildWidgetPrice(),
          _buildImageSlider(context),
          _buildWidgetIndicator(context),
          _buildWidgetScroll()
        ],
      ),
    );
  }

  Widget _buildWidgetScroll() {
    return DraggableScrollableSheet(
        expand: true,
        initialChildSize: 0.7,
        maxChildSize: 1,
        minChildSize: 0.5,
        builder: (context, controller) {
          return SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /*Center(
                       child: Icon(Icons.drag_handle, color: Colors.black38),
                     ),*/
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20),
                    child: Text(
                      widget.myHotel.nom,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: Colors.teal,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 10,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    widget.myHotel.ville,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    bottom: 10,
                                  ),
                                  child: Text(","),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                    left: 10,
                                    bottom: 10,
                                  ),
                                  child: Text(
                                    widget.myHotel.pays,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            )
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
                                Icon(
                                  Icons.euro_symbol,
                                  size: 16,
                                  color: Colors.black,
                                ),
                                Text(
                                  "${widget.myHotel.prix.toInt()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "/nuits",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 10),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: DefaultTabController(
                        length: 4,
                        child: Column(
                          children: <Widget>[
                            TabBar(
                                labelColor: Colors.teal,
                                indicatorColor: Colors.teal,
                                unselectedLabelColor: Color(0xFFa4a1a1),
                                indicatorSize: TabBarIndicatorSize.label,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                                tabs: [
                                  Tab(
                                    text: ('Details'),
                                  ),
                                  Tab(
                                    text: 'Avis',
                                  ),
                                  Tab(
                                    text: 'Chambres',
                                  ),
                                  Tab(
                                    text: 'Map',
                                  ),
                                ]),
                            Expanded(
                              child: TabBarView(
                                children: [
                                  SingleChildScrollView(child: _buildDetails()),
                                  _buildAvis(),
                                  _buildChambre(),
                                  _buildMap()
                                ],
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
          );
        });
  }

  Widget _buildImageSlider(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: widget.myHotel.pictures.length,
      itemBuilder: (context, index) {
        return Stack(children: <Widget>[
          Image.network(
            widget.myHotel.pictures[index],
            fit: BoxFit.fill,
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: GestureDetector(
                child: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: isFav == false ? Colors.grey : Colors.red,
                    ),
                    onPressed: () async {
                      setState(() {
                        isFav = !isFav;
                      });
                      await Firestore.instance
                          .collection("hotels")
                          .document(widget.myHotel.id)
                          .updateData(<String, dynamic>{'favoris': isFav});
                      print('done');
                    }),
              ),
            ),
          ),
        ]);
      },
    );
  }

  Widget _buildWidgetIndicator(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .25),
        child: SliderIndicator(
          length: widget.myHotel.pictures.length,
          activeIndex: _currentIndex,
          indicator: Icon(
            Icons.radio_button_unchecked,
            color: Colors.white,
            size: 10,
          ),
          activeIndicator: Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
            size: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetButtonClose(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.only(right: 24, top: 45),
        child: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
    );
  }

  Container _buildWidgetPrice() {
    return Container(
      margin: EdgeInsets.only(left: 24, top: 50),
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(
          Radius.circular(25),
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.euro_symbol,
              size: 16,
              color: Colors.white,
            ),
            Text(
              "${widget.myHotel.prix.toString()}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "nuits",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ]),
    );
  }

  Widget _buildDetails() {
    Future<void> _launched;

    Future<void> _launch(String number) async {
      if (await canLaunch(number.toString())) {
        await launch(number.toString());
      } else {
        throw 'Could not launch $number';
      }
    }

    AlertDialog alert = AlertDialog(
      title: Text(widget.myHotel.user),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(widget.myHotel.email),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(widget.myHotel.telephone.toString()),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 100, top: 15),
                  child: IconButton(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      setState(() {
                        _launched =
                            _launch(widget.myHotel.telephone.toString());
                      });
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    return Container(
      // height: MediaQuery.of(context).size.height,
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 10),
            child: Text("Description : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              widget.myHotel.description,
              maxLines: _maxLines,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                height: 1.5,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_maxLines == 3) {
                    _maxLines = 10;
                  } else {
                    _maxLines = 3;
                  }
                });
              },
              child: Text(_maxLines == 3 ? "Read more" : "Read less",
                  style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: AppColors.stylecolor,
                    height: 1.5,
                  )),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("l'hébergeur : ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          height: 1.5,
                        )),
                    const SizedBox(height: 8),
                    InkWell(
                      child: Text(
                        widget.myHotel.user,
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.teal[100], width: 2),
                    ),
                    padding: EdgeInsets.all(5),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.myHotel.imageProp),
                      maxRadius: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("CHECK IN",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Text(
                            widget.myHotel.hentree,
                          ),
                          Text(
                            " PM",
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
                      Text("CHECK OUT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Text(
                            widget.myHotel.hsortie,
                          ),
                          Text(
                            " AM",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 15, bottom: 20, top: 20),
            child: Text("Equipement : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                )),
          ),
          const SizedBox(height: 8),

          GestureDetector(
            onTap: () {
              print("le nb des equip " + myEquipments.length.toString());
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                controller: PageController(
                  initialPage: 0,
                  viewportFraction: 0.2,
                ),
                itemExtent: 70,
                scrollDirection: Axis.horizontal,
                itemCount: myEquipments.length,
                itemBuilder: (context, index) {
                  return Image.network(
                    myEquipments[index].photo,
                    fit: BoxFit.contain,
                    width: 150,
                    height: 150,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAvis() {
    AlertDialog dialog = new AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: EdgeInsets.only(top: 10.0),
      content: Container(
        width: 260.0,
        height: 230.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // dialog top
            new Expanded(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Note",
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SmoothStarRating(
                    color: Colors.amber,
                    borderColor: Colors.grey,
                    allowHalfRating: true,
                  )
                ],
              ),
            ),

            // dialog centre
            new Expanded(
              child: new Container(
                  child: new TextFormField(
                decoration: new InputDecoration(
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: new EdgeInsets.only(
                      left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                  hintText: ' Ajouter votre avis',
                  hintStyle: new TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12.0,
                    fontFamily: 'helvetica_neue_light',
                  ),
                ),
              )),
              flex: 2,
            ),

            // dialog bottom
            new Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                      bottomRight: Radius.circular(32.0)),
                ),
                child: Text(
                  "Rate Product",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: ApartmentModelReviewRatingScreen(
          avisList: mesAvis,
        )),
      ],

      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     showDialog(
      //       context: context,
      //       builder: (BuildContext context) {
      //         return dialog;
      //       },
      //     );
      //   },
      //   label: Text('Ajouter Avis'),
      //   backgroundColor: Colors.teal,
      // ),
    );
  }

  Widget _buildChambre() {
    return myChambers.length != 0
        ? ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: myChambers.length,
            itemBuilder: (context, index) {
              return Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Card(
                              elevation: 3,
                              child: Column(
                                children: <Widget>[
                                  _buildCardChambre(index),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            })
        : Container();
  }

  Row _buildCardChambre(int index) {
    return Row(
      children: <Widget>[
        Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            image: DecorationImage(
                image: NetworkImage(myChambers[index].pictures[0]),
                fit: BoxFit.cover),
          ),
        ),
        SizedBox(width: 4.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            _buildInfoChambre(index),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Text(
                          myChambers[index].prix.toString(),
                          style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Quicksand',
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.euro_symbol,
                          size: 10,
                        ),
                        Text(
                          " /nuits",
                          style: TextStyle(color: Colors.black, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 35.0),
                Container(
                  child: FlatButton(
                    color: Colors.teal[200],
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsChambre(
                              hotelID: widget.myHotel.id,
                              myChambers: myChambers[index],
                            ),
                          ));
                    },
                    textColor: Colors.white,
                    child: Text(
                      'Details',
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Container _buildInfoChambre(int index) {
    return Container(
      width: MediaQuery.of(context).size.width * .6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            myChambers[index].type,
            maxLines: _maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),
          Row(
            children: <Widget>[
              Icon(
                Icons.people_outline,
                color: Colors.grey,
              ),
              Text(
                '   Tarif pour deux adultes',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.grey,
                    fontSize: 12.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return MyMap(
      hotelPosition: widget.myHotel.position,
    );
  }
}
