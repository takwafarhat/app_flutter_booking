import 'package:app_flat/pages/ajout_bien1.dart';
import 'package:country_code_picker/country_code_picker.dart' as cPicker;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';

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

  // String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  final myController = TextEditingController();
  File _image;
  List<String> _types = [
    "Appartement",
    "Hotel",
    "Maison d'hôte",
  ];
  String _type = "Hotel";

  void typeBien(String value) {
    setState(() {
      _type = value;
    });
  }

  List<int> etoile = [
    1,
    2,
    3,
    4,
    5,
  ];
  int _etoile = 5;
  void nBetoile(int value) {
    setState(() {
      _etoile = value;
    });
  }

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> myForm = {};

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

  Widget uploadPhoto() {
    return new Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            // margin: const EdgeInsets.all(30.0),
            //padding: const EdgeInsets.all(5.0),
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Ajouter la photo de couverture de l'hébergement",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                child: new SizedBox(
                                    width: 100.0,
                                    height: 100.0,
                                    child: (_image != null)
                                        ? Image.file(
                                            _image,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.asset('assets/logo.jpg')),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.teal[200],
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        title: Text(
                                          "Telecharget l'image ",
                                          style:
                                              Theme.of(context).textTheme.title,
                                          textAlign: TextAlign.center,
                                        ),
                                        content: Container(
                                          width: 150.0,
                                          height: 150.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            color: const Color(0xFFFFFF),
                                            borderRadius: new BorderRadius.all(
                                                new Radius.circular(32.0)),
                                          ),
                                          child: SingleChildScrollView(
                                            child: ListBody(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: RaisedButton(
                                                    child: Text("Galerie"),
                                                    color: Colors.teal[200],
                                                    colorBrightness:
                                                        Brightness.dark,
                                                    onPressed: () {
                                                      gallerie();
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: RaisedButton(
                                                    child: Text("Camera"),
                                                    color: Colors.teal[200],
                                                    colorBrightness:
                                                        Brightness.dark,
                                                    onPressed: () {
                                                      camera();
                                                    },
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0)),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          ],
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Container(
                        //     height: 200,
                        //     width: 400,
                        //     child: Column(
                        //       children: <Widget>[
                        //         Expanded(),
                        //       ],
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> gallerie() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;

      // print('Image Path $_image');
    });
  }

  Future<void> camera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;

      // print('Image Path $_image');
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
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text("Classement"),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  height: MediaQuery.of(context).size.height / 11,
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
                              value: _etoile,
                              items: etoile.map(
                                (int value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text('${value}'),
                                  );
                                },
                              ).toList(),
                              onChanged: (int value) {
                                nBetoile(value);
                              },
                            ),
                          ));
                    },
                  ),
                ),
              ),
              uploadPhoto(),
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
                          print("m phone" + telephone);
                          print("la photo" + _image.toString());
                          myForm['nom'] = nomhebergement;
                          myForm['type'] = _type;
                          myForm["pay"] = myController.text;
                          myForm['telephone'] = telephone;
                          myForm['email'] = email;
                          myForm['adresse'] = adresse;
                          myForm['ville'] = ville;
                          myForm["image"] = _image;
                          myForm["etoile"] = _etoile;

                          myForm['photoCouverture'] = _image;
                          print(myForm.toString());
                          Navigator.of(context).push(MaterialPageRoute<Null>(
                              builder: (BuildContext context) {
                            return new AjoutBien1(
                              form: myForm,
                            );
                          }));
                        }
                        // Navigator.of(context).push(MaterialPageRoute<Null>(
                        //     builder: (BuildContext context) {
                        //   return new AjoutBien1(
                        //     form: myForm,
                        //   );
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
