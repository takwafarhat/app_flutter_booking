import 'package:app_flat/pages/ajout_bien1.dart';
import 'package:country_code_picker/country_code_picker.dart' as cPicker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  final myController = TextEditingController();

  List<String> _types = [
    "Sélectionné un hébergement",
    "Appartement",
    "Hotel",
    "Maison d'hôte",
  ];
  String _type = "Sélectionné un hébergement";

  void typeBien(String value) {
    setState(() {
      _type = value;
    });
  }

  final _formKey = GlobalKey<FormState>();
  // void onPhoneNumberChange(
  //     String number, String internationalizedPhoneNumber, String isoCode) {
  //   setState(() {
  //     phoneNumber = number;
  //     phoneIsoCode = isoCode;
  //   });
  // }

  // onValidPhoneNumber(
  //     String number, String internationalizedPhoneNumber, String isoCode) {
  //   setState(() {
  //     confirmedNumber = internationalizedPhoneNumber;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    myController.text = 'Tunisie';
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(5),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Nom de l'hébergement",
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
                child: Container(
                  height: MediaQuery.of(context).size.height / 11,
                  child: FormField(
                    validator: (val) =>
                        val.isEmpty ? "Entrer le nom de l'hébergement" : null,
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
              ),
              new Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: cPicker.CountryCodePicker(
                        onChanged: (c) {
                          print(c.name);
                          myController.text = c.name;
                        },
                        initialSelection: 'tn',
                        alignLeft: false,
                        hideMainText: true,
                        showCountryOnly: true,
                        flagWidth: 60,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      padding: EdgeInsets.only(left: 10),
                      child: TextFormField(
                        // initialValue: 'Tunisie',
                        controller: myController,
                        enabled: false,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      // margin: EdgeInsets.all(10),
                      child: cPicker.CountryCodePicker(
                        // onChanged: print,
                        onChanged: (c) {
                          print(c.name);
                        },
                        initialSelection: 'tn',
                        alignLeft: false,
                        //hideMainText: true,
                        showCountryOnly: true,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: new TextFormField(
                        cursorColor: Theme.of(context).primaryColor,
                        decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          hintText: "Téléphone",
                        ),
                        keyboardType: TextInputType.phone,
                        onTap: () {},

                        validator: (val) =>
                            val.isEmpty ? 'Entrer le téléphone' : null,
                        onChanged: (val) => telephone = val,
                        //keyboardType: TextInputType.phone,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  //width: MediaQuery.of(context).size.width,
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
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
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 16, top: 8),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.teal[200],
                    borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        blurRadius: 8,
                        offset: const Offset(4, 4),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(24.0)),
                      highlightColor: Colors.transparent,
                      onTap: () {
                        _formKey.currentState.save();
                        if (_formKey.currentState.validate()) {
                          print(" le nom de l'héber" + nomhebergement);
                          print(" le pays " + myController.text);
                        }
                        // Navigator.of(context).push(MaterialPageRoute<Null>(
                        //     builder: (BuildContext context) {
                        //   return new AjoutBien1();
                        // }));
                      },
                      child: Center(
                        child: Text(
                          'Selectionner',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // RaisedButton(
              //   child: Text("Suivant"),
              //   color: Colors.teal[100],
              //   onPressed: () {
              //     Navigator.of(context).push(
              //         MaterialPageRoute<Null>(builder: (BuildContext context) {
              //       return new AjoutBien1();
              //     }));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
