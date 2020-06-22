import 'package:app_flat/pages/ajout_bien1.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:international_phone_input/international_phone_input.dart';

class AjoutBien extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AjoutBienState();
}

class _AjoutBienState extends State<AjoutBien> {
  String nomhebergement = '';
  String email = '';
  String telephone = '';
  String ville = '';
  String adresse = '';
  String codepostle = '';

  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  List<String> _types = [
    "Sélectionné un hébergement",
    "Appartement",
    "Bateau",
    "Hôtel",
    "Maison d'hôte",
    "Maison",
    "Suite",
    "Tente",
    "Villa",
    "Bungalow"
  ];
  String _type = "Sélectionné un hébergement";

  void typeBien(String value) {
    setState(() {
      _type = value;
    });
  }

  List<String> _pays = [
    "Choisir un pays",
    "Algérie",
    "Égypte",
    "Libye",
    "MAldive",
    "Belgique",
    "Paris",
    "Italie",
    "Maroc",
    "Seychelles",
    "Tchad",
    "Tunisie"
  ];
  String _pay = "Choisir un pays";
  void pays(String value) {
    setState(() {
      _pay = value;
    });
  }

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      confirmedNumber = internationalizedPhoneNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un hébergement'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blueGrey[50], Colors.teal[200]])),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nom d hébergement',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (val) =>
                    val.isEmpty ? "Entrer le nom de l'hébergement" : null,
                onChanged: (val) => nomhebergement = val,
                textInputAction: TextInputAction.next,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(5),
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: new DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _type,
                          items: _types.map(
                            (String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String value) {
                            typeBien(value);
                          },
                        ),
                      ));
                },
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Entrer le mail' : null,
                onChanged: (val) => email = val,
                textInputAction: TextInputAction.next,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(5),
              child: new TextFormField(
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  labelText: 'Téléphone',
                ),
                validator: (val) => val.isEmpty ? 'Entrer le téléphone' : null,
                onChanged: (val) => telephone = val,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
              ),
              /*  InternationalPhoneInput(
                      onPhoneNumberChange: onPhoneNumberChange,
                      initialPhoneNumber: phoneNumber,
                      initialSelection: phoneIsoCode,
                      enabledCountries: ['+216', '+1']),*/
            ),
            new Padding(
              padding: const EdgeInsets.all(5),
              child: FormField(
                builder: (FormFieldState state) {
                  return InputDecorator(
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: new DropdownButtonHideUnderline(
                        child: DropdownButton(
                          value: _pay,
                          items: _pays.map(
                            (String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                          onChanged: (String value) {
                            pays(value);
                          },
                        ),
                      ));
                },
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Adresse',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (val) => val.isEmpty ? "Entrer l'adresse" : null,
                onChanged: (val) => adresse = val,
                textInputAction: TextInputAction.next,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'ville',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (val) => val.isEmpty ? 'Entrer la ville' : null,
                onChanged: (val) => ville = val,
                textInputAction: TextInputAction.next,
              ),
            ),
            new Padding(
              padding: const EdgeInsets.all(5),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Code Postal',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (val) =>
                    val.isEmpty ? 'Entrer le code postal' : null,
                onChanged: (val) => codepostle = val,
                textInputAction: TextInputAction.next,
              ),
            ),
            RaisedButton(
              child: Text("Suivant"),
              color: Colors.teal[100],
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new AjoutBien1();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
