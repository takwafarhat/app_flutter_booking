import 'package:flutter/material.dart';

class AjoutEquip extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AjoutEquipState();
}

class _AjoutEquipState extends State<AjoutEquip> {
  bool _isChecked = true;
  String _currText = '';

  List<String> text = [
    "Bar",
    "Salle de conseil",
    "Centre d'affaire",
    "Docteur en appel",
    "Casino",
    "Conférence et banquets",
    "Salle de conférence",
    "Gymnase/Club de santé",
    "Restaurant intérieur multi-cuisine",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un équippement'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blueGrey[50], Colors.teal[200]])),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Column(
              children: text
                  .map((t) => CheckboxListTile(
                        title: Text(t),
                        value: _isChecked,
                        onChanged: (val) {
                          setState(() {
                            _isChecked = val;
                            if (val == true) {
                              _currText = t;
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
