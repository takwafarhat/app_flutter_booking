import 'package:app_flat/models/apartmentTile.dart';
import 'package:app_flat/models/apartment_model.dart';
import 'package:flutter/material.dart';
import 'package:app_flat/utils/database.dart';

class ApartmentList extends StatefulWidget {
  /*final ApartmentModel apart;
  ApartmentList({this.apart});*/

  @override
  _ApartmentListState createState() => _ApartmentListState();
}

class _ApartmentListState extends State<ApartmentList> {
  @override
  Widget build(BuildContext context) {
    
    // final hotels = Provider.of<List<ApartmentModel>>(context);
  final hotel =DatabaseService().hotels;


    return StreamBuilder(
      stream: hotel,
      
      builder: (context, snapshot) {
         List<ApartmentModel> myHotels = snapshot.data;
        return ListView.builder(
          itemCount: myHotels.length,
      itemBuilder: (context, index) {
        return ApartmentTile(apartmentModel: myHotels[index]);
      },
    );
      }
      ,
    
      
      );
   /* */
  }
}
