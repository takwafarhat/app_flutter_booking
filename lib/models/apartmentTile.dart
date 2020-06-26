import 'package:app_flat/models/apartment_model.dart';
import 'package:flutter/material.dart';

class ApartmentTile extends StatelessWidget {
  final ApartmentModel apartmentModel;

  ApartmentTile({this.apartmentModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            title: Text(apartmentModel.nom),
            subtitle: Text(apartmentModel.description),
            ),
      ),
    );
  }
}
