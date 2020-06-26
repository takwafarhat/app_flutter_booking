import 'package:app_flat/core/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

import '../models/apartment_model.dart';

class DetailPage extends StatefulWidget {
  final ApartmentModel myHotel;
  DetailPage({@required this.myHotel});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var _pageController = PageController();
  var _currentIndex = 0;
  var _maxLines = 3;

  @override
  Widget build(BuildContext context) {
    print("= pictures =  " + widget.myHotel.pictures.toString());
    print("les avis sont " + widget.myHotel.avis.toString());
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
                  padding: EdgeInsets.only(left: 120, top: 15),
                  child: Icon(
                    Icons.phone,
                    color: Colors.green,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
    return DraggableScrollableSheet(
        expand: true,
        initialChildSize: 0.6,
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
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Icon(Icons.drag_handle, color: Colors.black38),
                  ),
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
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5,
                          left: 20,
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
                      Padding(
                        padding: EdgeInsets.only(
                          left: 120,
                          top: 5,
                          bottom: 10,
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
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
                            ]),
                      ),
                    ],
                  ),
                  Padding(
                    //padding: EdgeInsets.symmetric(vertical: 8.0),
                    padding: EdgeInsets.only(top: 10, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        RatingBar(
                          onRatingUpdate: (v) {},
                          initialRating: widget.myHotel.etoile.toDouble(),
                          itemSize: 12,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          "${widget.myHotel.nbCommentaires.toInt()} reviews",
                          style: TextStyle(color: Colors.black87, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: DefaultTabController(
                        length: 4, // Added
                        initialIndex: 0,
                        child: Scaffold(
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.white,
                            flexibleSpace: SafeArea(
                              child: TabBar(
                                  //unselectedLabelColor: Colors.black,
                                  labelColor: Colors.teal,
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
                            ),
                          ),
                          body: TabBarView(children: [
//             any widget can work very well here <3

                            new Container(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, bottom: 10),
                                    child: Text("Description : ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          height: 1.5,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                                      child: Text(
                                          _maxLines == 3
                                              ? "Read more"
                                              : "Read less",
                                          style: TextStyle(
                                            //fontWeight: FontWeight.bold,
                                            color: AppColors.stylecolor,
                                            height: 1.5,
                                          )),
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10, left: 20.0),
                                            child: Text("l'hébergeur : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  height: 1.5,
                                                )),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 170),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.teal[100],
                                                    width: 2),
                                              ),
                                              padding: EdgeInsets.all(5),
                                              child: CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    widget.myHotel.imageProp),
                                                maxRadius: 30,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        InkWell(
                                          child: Container(
                                            child: Text(
                                              widget.myHotel.user,
                                            ),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return alert;
                                              },
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            new Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20),
                                      child: Text("Avis",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.stylecolor,
                                            height: 1.5,
                                          )),
                                    ),
                                    ...widget.myHotel.avis.map(
                                      (avis) {
                                        return Text(
                                          avis,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            new Container(
                              color: Colors.blueAccent,
                              child: Center(
                                child: Text(
                                  'Hi from Hospital',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            new Container(
                              color: Colors.blueAccent,
                              child: Center(
                                child: Text(
                                  'Hi from Hospital',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  /* SizedBox(height: 50),
                      Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
                      child:
                          Text(_maxLines == 3 ? "Read more" : "Read less",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.stylecolor,
                                height: 1.5,
                              )),
                    ),
                  ),*/
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 20,
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {},
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
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

  // Row _buildWidgetSize(String name, int size) {
  //   return Row(
  //     children: <Widget>[
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text(
  //             name,
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 16,
  //             ),
  //           ),
  //           Text("${widget.data.sizeLivingRoom} sqft",
  //               style: TextStyle(
  //                 color: Colors.black38,
  //                 height: 1.5,
  //                 fontSize: 16,
  //               ))
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget _buildImageSlider(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.myHotel.pictures.length,
        itemBuilder: (context, index) {
          return Image.network(
            widget.myHotel.pictures[index],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }

  Widget _buildWidgetIndicator(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .35),
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
              "${widget.myHotel.prix.toInt()}",
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
}
