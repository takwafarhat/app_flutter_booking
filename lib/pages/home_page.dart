import 'package:app_flat/Login/profile.dart';
import 'package:app_flat/pages/ajout_bien.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../core/const.dart';
import '../models/apartment_model.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var data = ApartmentModel.list;
  //int _currentIndex = 0;
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
          "Fin your hotel",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.black38,
            ),
            onPressed: () {},
          ),
        ],
      ),
      drawer: new Drawer(
        child: ProfilePage(),
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.stylecolor,
        unselectedItemColor: Colors.black38,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.filter_list),
            title: Text("filter_list"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
        onTap: (index) {
          _currentIndex = index;
          setState(() {});
        },
      ),*/
      body: _bodyHome(context),
    );
  }

  Widget _bodyHome(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "55 result in your area",
            style: TextStyle(color: Colors.black38),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            data[index],
                          ),
                        ),
                      );
                    },
                    child: _buildItem(context, index));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
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
                  image: DecorationImage(
                    image: ExactAssetImage(
                        'assets/${data[index].images.first}.jpg'),
                    fit: BoxFit.cover,
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
                              child: Text("${data[index].name}",
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
              width: MediaQuery.of(context).size.width * .43,
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
                      Icon(
                        Icons.euro_symbol,
                        size: 18,
                      ),
                      Text(
                        "${data[index].price.toInt()}/",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "months",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "${data[index].sizeDesc}",
                    style: TextStyle(color: Colors.black38),
                  ),
                  Row(
                    children: <Widget>[
                      RatingBar(
                        onRatingUpdate: (v) {},
                        initialRating: data[index].review,
                        itemSize: 12,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Text(
                        "${data[index].reviewCount.toInt()}reviews",
                        style: TextStyle(color: Colors.black87, fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ...data[index].personImages.map(
                        (img) {
                          return Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: ExactAssetImage("assets/$img.jpg"),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                          );
                        },
                      ),
                      Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(
                            Radius.circular(50),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "23+",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      )
                    ],
                  ),
                  Wrap(
                    children: <Widget>[
                      ...data[index].features.map(
                        (feature) {
                          return Container(
                            padding: EdgeInsets.all(6),
                            margin: EdgeInsets.only(bottom: 6, right: 6),
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
