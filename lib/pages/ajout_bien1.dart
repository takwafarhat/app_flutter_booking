import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_flat/pages/filtre/popular_filter_list.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'chamber/hotel_app_theme.dart';
//import 'package:flutter_multiselect/flutter_multiselect.dart';

class AjoutBien1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _AjoutBienState();
}

class _AjoutBienState extends State<AjoutBien1> {
  TimeOfDay _heureIn = TimeOfDay.now();
  TimeOfDay _heureOut = TimeOfDay.now();
  String hdescription = '';
  File _image;

  _pickTime1() async {
    TimeOfDay t = await showTimePicker(context: context, initialTime: _heureIn);
    if (t != null)
      setState(() {
        _heureIn = t;
      });
  }

  _pickTime2() async {
    TimeOfDay t =
        await showTimePicker(context: context, initialTime: _heureOut);
    if (t != null)
      setState(() {
        _heureOut = t;
      });
  }

  List<PopularFilterListData> equipmentFilterListData =
      PopularFilterListData.equipementFList;
  bool _isChecked = true;
  String _currText = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HotelAppTheme.buildLightTheme().backgroundColor,
      child: Scaffold(
          backgroundColor: Colors.transparent,
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
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        buildPaddingHeure(),
                        const Divider(
                          height: 1,
                        ),
                        popularFilter(),
                        description(),
                        uploadPhoto(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Padding buildPaddingHeure() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Check-In",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                        color: Colors.black26.withOpacity(0.8)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    ' ${_heureIn.hour}:${_heureIn.minute}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              onTap: () {
                _pickTime1();
              },
            ),
          ),
          Container(
            height: 74,
            width: 1,
            color: HotelAppTheme.buildLightTheme().dividerColor,
          ),
          Expanded(
            child: InkWell(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Check-out",
                    style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                        color: Colors.black26.withOpacity(0.8)),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '${_heureOut.hour}:${_heureOut.minute}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              onTap: () {
                _pickTime2();
              },
            ),
          )
        ],
      ),
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

  Widget uploadPhoto() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            // margin: const EdgeInsets.all(30.0),
            //padding: const EdgeInsets.all(5.0),
            height: MediaQuery.of(context).size.height / 7,
            width: MediaQuery.of(context).size.width * .9,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Ajouter des images de l'hébergement ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.camera,
                      color: Colors.teal[200],
                    ),
                    onPressed: () {
                      getImage();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
  }

  Widget description() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Description',
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onChanged: (val) => hdescription = val,
          textInputAction: TextInputAction.next,
        ),
      ]),
    );
  }
}
