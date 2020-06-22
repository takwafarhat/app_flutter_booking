import 'package:flutter/material.dart';
import 'package:app_flat/pages/ajouter_un_equipement.dart';
//import 'package:flutter_multiselect/flutter_multiselect.dart';

class AjoutBien1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AjoutBienState();
}

class _AjoutBienState extends State<AjoutBien1> {
  TimeOfDay _heureIn = TimeOfDay.now();
  TimeOfDay _heureOut = TimeOfDay.now();

  _pickTime() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: _heureIn);
    if (t != null)
      setState(() {
        _heureIn = t;
      });
  }

  List<String> text = [
    "Bar",
    "Salle de conseilo",
    "Centre d'affaire",
    "Docteur en appel"
  ];
  bool _isChecked = true;
  String _currText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(5),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child:
                Text("heure d'arrivé:   ${_heureIn.hour}:${_heureIn.minute}"),
            onPressed: _pickTime,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(5),
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Text(
                "heure de sortie:   ${_heureOut.hour}:${_heureOut.minute}"),
            onPressed: _pickTime,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(5),
          child: FormField(
            builder: (FormFieldState state) {
              return RaisedButton(
                child: Text("Equipement d'hébergement"),
                color: Colors.teal[100],
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute<Null>(builder: (BuildContext context) {
                    return new AjoutEquip();
                  }));
                },
              );
            },
          ),
        ),
      ]),
    ));
  }
}
/*void _showDialog(){
  showDialog(
  context: context,
  builder: (BuildContext context) => CustomDialog(
        title: "Success",
        description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        buttonText: "Okay",
      ),
);
}
*/
