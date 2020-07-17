import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:app_flat/pages/payement/payement.dart';

class Reserverchamber extends StatefulWidget {
  @override
  _ReserverchamberState createState() => _ReserverchamberState();
}

class _ReserverchamberState extends State<Reserverchamber> {
  List<String> _pays = [
    "Algérie",
    "Égypte",
    "Libye",
    "Maldive",
    "Belgique",
    "Paris",
    "Italie",
    "Maroc",
    "Seychelles",
    "Tchad",
    "Tunisie"
  ];
  String _pay = "Tunisie";
  void pays(String value) {
    setState(() {
      _pay = value;
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
          "Reserver la chambre ",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: formulaireReservation(),
      ),
    );
  }

  Widget formulaireReservation() {
    return ListView(children: <Widget>[
      TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          hintText: 'Nom',
          labelText: 'Nom',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
      Padding(padding: EdgeInsets.all(10.0)),
      TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
          labelText: 'Email',
          hintText: 'Email',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
      Padding(padding: EdgeInsets.all(10.0)),
      TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'Adresse',
          hintText: 'Adresse',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
      Padding(padding: EdgeInsets.all(10.0)),
      TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'ville',
          hintText: 'Ville',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
      Padding(padding: EdgeInsets.all(10.0)),
      TextFormField(
        maxLines: 1,
        decoration: new InputDecoration(
          labelText: 'Numéro de portable',
          hintText: 'Numéro de portable',
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
      Padding(padding: EdgeInsets.all(10.0)),
      new FormField(
        builder: (FormFieldState state) {
          return InputDecorator(
            decoration: InputDecoration(
              labelText: 'pays',
            ),
            child: new DropdownButtonHideUnderline(
              child: new DropdownButton(
                value: _pay,
                isDense: true,
                items: _pays.map((String value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (String value) {
                  pays(value);
                },
              ),
            ),
          );
        },
      ),
      Padding(padding: EdgeInsets.all(20.0)),
      RaisedButton(
        child: Text("Etape Suivante"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.teal[100],
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return null;
          }));
        },
      ),
    ]);
  }
}
