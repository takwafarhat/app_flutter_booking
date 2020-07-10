import 'package:app_flat/models/chambre.dart';
import 'package:app_flat/pages/chamber/ReserverChamber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_indicator/flutter_slider_indicator.dart';

class DetailsChambre extends StatefulWidget {
  final Chambre myChambers;
  DetailsChambre({@required this.myChambers});
  @override
  _DetailsChambrState createState() => _DetailsChambrState();
}

class _DetailsChambrState extends State<DetailsChambre> {
  var _pageController = PageController();
  var _currentIndex = 0;
  var _maxLines = 3;

  @override
  Widget build(BuildContext context) {
    _pageController.addListener(() {
      setState(() {
        _currentIndex = _pageController.page.round();
      });
    });
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
          "Details Chambres",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(children: <Widget>[
        _buildImageSlider(context),
        _buildWidgetIndicator(context),
        _detailsChambre(context),
      ]),
      floatingActionButton: new FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Reserverchamber(),
            ),
          );
        },
        label: const Text("Selectionner"),
        backgroundColor: Colors.teal[300],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  Widget _buildImageSlider(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      child: PageView.builder(
        controller: _pageController,
        itemCount: widget.myChambers.pictures.length,
        itemBuilder: (context, index) {
          return Container(
            child: Stack(children: <Widget>[
              Image.network(
                widget.myChambers.pictures[index],
                fit: BoxFit.cover,
              ),
            ]),
          );
        },
      ),
    );
  }

  Widget _buildWidgetIndicator(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .25),
        child: SliderIndicator(
          length: widget.myChambers.pictures.length,
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

  Widget _detailsChambre(BuildContext context) {
    return DraggableScrollableSheet(
        expand: true,
        initialChildSize: 0.65,
        builder: (context, controller) {
          return SingleChildScrollView(
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
              child: Column(
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 20, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.myChambers.type,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.people_outline,
                                    color: Colors.teal,
                                  ),
                                  Text(
                                    '   Tarif pour deux adultes.',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.black,
                                        fontSize: 12.0),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    widget.myChambers.prix.toString(),
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 10, top: 15),
                    child: Row(
                      children: <Widget>[
                        Text("Description des chambres : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              height: 1.5,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      widget.myChambers.description,
                      maxLines: _maxLines,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 15, bottom: 10, top: 15),
                      child: Row(
                        children: <Widget>[
                          Text('Les equippements : ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                height: 1.5,
                              )),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 10, top: 15),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * .9,
                          child: ListView.builder(
                            controller: PageController(
                              initialPage: 0,
                              viewportFraction: 0.2,
                            ),
                            itemExtent: 70,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.myChambers.equipement.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                widget.myChambers.equipement[index],
                                fit: BoxFit.contain,
                                width: 100,
                                height: 100,
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.only(top: 40, left: 200),
                    child: RaisedButton(
                      child: Text("Selectionner"),
                      color: Colors.teal[300],
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Reserverchamber(),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        });
  }
}
