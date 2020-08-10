import 'package:app_flat/models/apartment_model.dart';
import 'package:app_flat/pages/detail_page.dart';
import 'package:app_flat/utils/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mon hôtel préféré'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blueGrey[50], Colors.teal[200]])),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: DatabaseService().hotels,
                builder: (context, snapshot) {
                  List<ApartmentModel> myHotels = snapshot.data;

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: myHotels != null ? myHotels.length : 0,
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
                          child: myHotels[index].favoris == true
                              ? buildFavoris(context, myHotels[index])
                              : Container());
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFavoris(BuildContext context, ApartmentModel hotel) {
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
                        Row(
                          children: <Widget>[
                            Container(
                              width: 60.0,
                              height: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                  image: DecorationImage(
                                      image: NetworkImage(hotel.image),
                                      fit: BoxFit.cover)),
                            ),
                            SizedBox(width: 4.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(height: 5.0),
                                      Text(
                                        hotel.nom,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Quicksand',
                                            color: Colors.grey,
                                            fontSize: 12.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        child: Center(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                hotel.prix.toString(),
                                                style: TextStyle(
                                                    color: Colors.black87,
                                                    fontFamily: 'Quicksand',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                " /nuits",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
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
  }
}
