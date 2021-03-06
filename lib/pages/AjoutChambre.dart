import 'package:app_flat/pages/home_page.dart';

import 'package:app_flat/pages/Equipement.dart';
import 'package:app_flat/pages/EquipementChambre.dart';
import 'package:app_flat/pages/filtre/popular_filter_list.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:app_flat/models/chambre.dart';
import 'package:app_flat/pages/chamber/hotel_app_theme.dart';
import 'dart:async';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:app_flat/models/apartment_model.dart';
import 'package:app_flat/utils/database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path/path.dart' as Path;

class ChamberAddBottomSheet extends StatefulWidget {
  final Function(int, int, int) onApplyClick;
  final Function onCancelClick;
  final Map<String, dynamic> form;

  const ChamberAddBottomSheet({
    this.onApplyClick,
    this.onCancelClick,
    @required this.form,
  });

  @override
  _ChamberAddBottomSheetState createState() => _ChamberAddBottomSheetState();
}

class _ChamberAddBottomSheetState extends State<ChamberAddBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApartmentModel myHotel;
  List<PopularFilterListData> listEquipHeberg = [];
  List<Widget> list = [];

  String type = '';
  List<int> mychambersListpositions = [0];
  List<Chambre> myChambers = [];
  int count = 1;
  File _imageCouv;
  List<File> hotelPictures = [];
  Map<String, dynamic> myForm = {};

  @override
  void initState() {
    super.initState();
    myForm = widget.form;

    listEquipHeberg = myForm["equipement"];
    _imageCouv = myForm['photoCouverture'];
    hotelPictures = myForm['hotelPictures'];
    print('hotelPictures files == \t' + hotelPictures.toString());
    print("photoCouverture \t " + _imageCouv.toString());
  }

  delete() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('myChmbers length== \t' + myChambers.length.toString());
    list.clear();
    for (var i = 0; i < count; i++) {
      list.add(Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                AjoutChambre(
                    deleteCallback: delete,
                    saveCallback: (val) => setState(() {
                          myChambers.add(val);
                        })),
              ],
            ),
          ),
          const Divider(
            height: 5,
            color: Colors.black,
          ),
        ],
      ));
    }

    return Scaffold(
      key: _scaffoldKey,

      //backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Détails de la chambre'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[Colors.blueGrey[50], Colors.teal[200]])),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () async {
                if (list.length == myChambers.length) {
                  _formKey.currentState.save();

                  if (_formKey.currentState.validate()) {
                    String documentId =
                        DateTime.now().microsecondsSinceEpoch.toString();
                    String hotelPic = '';
                    hotelPic = await uploadImage(_imageCouv);

                    List<String> hotelPicss = [];

                    hotelPictures.forEach((element) async {
                      String pic = await uploadImage(element);
                      print('PIIIIIIIIIIIIIIIC ====    ' + pic);
                      setState(() {
                        hotelPicss.add(pic);
                      });
                      print(
                          'hotelPics ====    ' + hotelPicss.length.toString());
                    });
                    Timer(Duration(seconds: 3), () async {
                      myHotel = ApartmentModel(
                        nom: myForm["nom"],
                        typeHotel: myForm['type'],
                        pays: myForm["pay"],
                        telephone: myForm['telephone'],
                        email: myForm['email'],
                        address: myForm['adresse'],
                        ville: myForm['ville'],
                        etoile: myForm["etoile"],
                        image: hotelPic,
                        hentree: myForm["heureIn"].toString(),
                        hsortie: myForm["heureOut"].toString(),
                        description: myForm["description"],
                        pictures: hotelPicss,
                        prix: myForm["prix"],
                      );

                      await DatabaseService().addHotel(myHotel, documentId);
                      myChambers.forEach((element) async {
                        int index = myChambers.indexOf(element);

                        Chambre myChamber = Chambre(
                            description: element.description,
                            idhotel: documentId,
                            prix: element.prix,
                            nbChambredispo: element.nbChambredispo,
                            type: element.type,
                            equip: element.equip);

                        String chamberId =
                            DateTime.now().microsecondsSinceEpoch.toString() +
                                index.toString();

                        await DatabaseService()
                            .addChambre(myChamber, chamberId);

                        myChamber.equip.forEach((element) async {
                          if (element.isSelected == true) {
                            EquipementChambre equiCh = EquipementChambre(
                                nom: element.titleTxt,
                                idChamber: chamberId,
                                photo: element.photo);

                            await DatabaseService()
                                .addEquipementChamber(equiCh);
                          }
                        });
                      });

                      listEquipHeberg.forEach((element) async {
                        if (element.isSelected == true) {
                          Equipement equiheberg = Equipement(
                              nom: element.titleTxt,
                              idHotel: documentId,
                              photo: element.photo);

                          await DatabaseService()
                              .addEquipement(equiheberg)
                              .then((value) => {
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                    )
                                  });
                        }
                      });

                      print(myForm);
                    });
                  }
                } else {
                  _scaffoldKey.currentState.showSnackBar(
                      SnackBar(content: Text('Yay! A SnackBar!')));
                }
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: HotelAppTheme.buildLightTheme().backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(4, 4),
                  blurRadius: 8.0),
            ],
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Column(children: list),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 70, top: 15, bottom: 15),
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Icon(
                            Icons.add,
                            color: Colors.teal,
                            size: 18,
                          ),
                        ),
                        InkWell(
                          child: Text('Ajouter un autre type de chambre'),
                          onTap: () {
                            setState(() {
                              count++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String> uploadImage(File file) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('hotels/${Path.basename(file.path)}}');

    StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;

    print('File Uploaded');
    String myImageUrl = '';
    await storageReference.getDownloadURL().then((fileURL) {
      myImageUrl = fileURL;
    });
    return myImageUrl;
  }
  // Future<void> camera() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);

  //   setState(() {
  //     _image = image;
  //     print('Image Path $_image');
  //   });
  // }

}

typedef void Callback(Chambre chambre);

class AjoutChambre extends StatefulWidget {
  final Callback saveCallback;
  final Function() deleteCallback;
  AjoutChambre({this.saveCallback, this.deleteCallback});
  @override
  _AjoutChambreState createState() => _AjoutChambreState();
}

class _AjoutChambreState extends State<AjoutChambre> {
  List<Asset> images = List<Asset>();
  File _image;

  String prix;
  String descriptionCh = '';
  List<String> _types = [
    "Chambre familiale",
    "Chambre double",
    "Chambre avec lit jumeaux",
    "Chambre avec lit jumeaux, vue mer",
    "Chambre double, vue mer",
    "Chambre simple",
    "suites"
  ];
  String _type = "Chambre familiale";

  List<int> nbch = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int _nbch = 1;
  void typeBien(String value) {
    setState(() {
      _type = value;
    });
  }

  bool onpressed = false;
  void nbCham(int value) {
    setState(() {
      _nbch = value;
    });
  }

  List<PopularFilterListData> equipmentFilterListData =
      PopularFilterListData.equipementChamberList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
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
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 15),
                              ),
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
        Padding(
          padding: const EdgeInsets.only(top: 8.0, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text("Nombre de chambre disponible"),
            ],
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
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
                        value: _nbch,
                        items: nbch.map(
                          (int value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(
                                '${value}',
                                style: TextStyle(fontSize: 15),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (int value) {
                          nbCham(value);
                        },
                      ),
                    ));
              },
            ),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(5),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Prix/nuit",
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            keyboardType: TextInputType.phone,
            validator: (val) => val.isEmpty ? " Entrer le prix/nuit" : null,
            onChanged: (val) => prix = val,
            textInputAction: TextInputAction.next,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(5),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Description",
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            textAlign: TextAlign.start,
            maxLines: 3,
            validator: (val) => val.isEmpty ? " Entrer le prix/nuit" : null,
            onChanged: (val) => descriptionCh = val,
            textInputAction: TextInputAction.next,
          ),
        ),
        popularFilter(),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 10),
          child: Column(
            children: <Widget>[
              Container(
                // margin: const EdgeInsets.all(30.0),
                //padding: const EdgeInsets.all(5.0),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width * .9,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Ajouter une photo de chambre ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
                                      gallerie();
                                    },
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 200,
                                  width: 400,
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(child: buildGridView()),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.teal[200],
              ),
              onPressed: () {
                widget.deleteCallback();
              },
            ),
            IconButton(
              icon: Icon(
                onpressed == false ? Icons.save : Icons.check,
                color: Colors.teal[200],
              ),
              onPressed: () {
                if (onpressed == false) {
                  widget.saveCallback(Chambre(
                    equip: equipmentFilterListData,
                    type: _type,
                    nbChambredispo: _nbch,
                    prix: double.parse(prix),
                    description: descriptionCh,
                  ));
                  onpressed = true;
                  print("done");
                } else {
                  print("deja selectionné ");
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return Container(
          width: 150,
          height: 150,
          child: AssetThumb(
            asset: asset,
            width: 150,
            height: 150,
          ),
        );
      }),
    );
  }

  Future<void> gallerie() async {
    List<Asset> image = List<Asset>();
    image = await MultiImagePicker.pickImages(
        maxImages: 10, enableCamera: true, selectedAssets: images);

    setState(() {
      images = image;

      // print('Image Path $_image');
    });
  }

  Widget popularFilter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          child: Text(
            'Equippement',
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width > 360 ? 18 : 16,
                fontWeight: FontWeight.normal),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16, left: 16),
          child: Column(
            children: getPList(),
          ),
        ),
        const SizedBox(
          height: 8,
        )
      ],
    );
  }

  List<Widget> getPList() {
    final List<Widget> noList = <Widget>[];

    int count = 0;
    const int columnCount = 2;
    for (int i = 0; i < equipmentFilterListData.length / columnCount; i++) {
      final List<Widget> listUI = <Widget>[];

      for (int i = 0; i < columnCount; i++) {
        try {
          final PopularFilterListData date = equipmentFilterListData[count];

          listUI.add(Expanded(
            child: Row(
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    onTap: () {
                      setState(() {
                        date.isSelected = !date.isSelected;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            date.isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: date.isSelected
                                ? HotelAppTheme.buildLightTheme().primaryColor
                                : Colors.grey.withOpacity(0.6),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            date.titleTxt,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
          count += 1;
        } catch (e) {
          print(e);
        }
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }
}
