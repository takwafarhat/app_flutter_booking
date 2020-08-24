import 'package:app_flat/pages/filtre/popular_filter_list.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app_flat/pages/chamber/hotel_app_theme.dart';

class AjoutChambre extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new AjoutChambreState();
}

class AjoutChambreState extends State<AjoutChambre> {
  String type = '';
  File _image;
  List<String> _types = [
    "Sélectionner un type",
    "Chambre familiale",
    "Chambre double",
    "Chambre avec lit jumeaux",
    "Chambre avec lit jumeaux, vue mer",
    "Chambre double, vue mer",
    "Chambre simple",
    "suites"
  ];
  String _type = "Sélectionner un type";

  void typeBien(String value) {
    setState(() {
      _type = value;
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
        new Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Numéro de Chambre disponible ",
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (val) =>
                val.isEmpty ? " Entrer le nombre de Chambre" : null,
            onChanged: (val) => type = val,
            textInputAction: TextInputAction.next,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Prix/nuit",
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (val) => val.isEmpty ? " Entrer le prix/nuit" : null,
            onChanged: (val) => type = val,
            textInputAction: TextInputAction.next,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.all(10),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Description",
              border: new OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            validator: (val) => val.isEmpty ? " Entrer le prix/nuit" : null,
            onChanged: (val) => type = val,
            textInputAction: TextInputAction.next,
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 10),
          child: Column(
            children: <Widget>[
              Container(
                // margin: const EdgeInsets.all(30.0),
                //padding: const EdgeInsets.all(5.0),
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width * .8,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                        child: Row(
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
                              onPressed: () async {
                                var image = await ImagePicker.pickImage(
                                    source: ImageSource.gallery);

                                setState(() {
                                  _image = image;
                                  print('Image Path $_image');
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        popularFilter(),
      ],
    );
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

class ChamberAddBottomSheet extends StatefulWidget {
  final Function(int, int, int) onApplyClick;
  final Function onCancelClick;

  const ChamberAddBottomSheet({
    this.onApplyClick,
    this.onCancelClick,
  });
  @override
  _ChamberAddBottomSheetState createState() => _ChamberAddBottomSheetState();
}

class _ChamberAddBottomSheetState extends State<ChamberAddBottomSheet> {
  List<Widget> list = [AjoutChambre()];
  int x = 1;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    list.clear();
    for (var i = 0; i < x; i++) {
      list.add(Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                AjoutChambre(),
                Padding(
                  padding: const EdgeInsets.only(left: 200.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.teal[200],
                    ),
                    onPressed: () async {
                      setState(() {
                        x--;
                      });
                    },
                  ),
                ),
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
            onPressed: () {},
          ),
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
            child: Column(
              children: <Widget>[
                Column(children: list),
                Padding(
                  padding: const EdgeInsets.only(left: 70, top: 15, bottom: 15),
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
                            x++;
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
    );
  }
}
