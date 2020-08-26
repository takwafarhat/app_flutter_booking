import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_flat/pages/filtre/popular_filter_list.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'chamber/hotel_app_theme.dart';
import 'package:app_flat/pages/AjoutChambre.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
//import 'package:flutter_multiselect/flutter_multiselect.dart';

class AjoutBien1 extends StatefulWidget {
  final Map<String, dynamic> form;

  const AjoutBien1({@required this.form});

  @override
  State<StatefulWidget> createState() => new _AjoutBienState();
}

class _AjoutBienState extends State<AjoutBien1> {
  TimeOfDay _heureIn = TimeOfDay.now();
  TimeOfDay _heureOut = TimeOfDay.now();
  String hdescription = '';
  File _image;
  List<Asset> images = List<Asset>();
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

  Map<String, dynamic> myForm = {};
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    myForm = widget.form;
    print("form" + myForm.toString());
  }

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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        buildPaddingHeure(),
                        const Divider(
                          height: 1,
                        ),
                        popularFilter(),
                        description(),
                        uploadPhoto(),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 16, top: 8),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.teal[200],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24.0)),
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
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(24.0)),
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  _formKey.currentState.save();
                                  if (_formKey.currentState.validate()) {
                                    //print("_heureIn" + _heureIn.toString());
                                    myForm["heureIn"] =
                                        _heureIn.hour.toString() +
                                            ':' +
                                            _heureIn.minute.toString();
                                    myForm["heureOut"] =
                                        _heureOut.hour.toString() +
                                            ':' +
                                            _heureOut.minute.toString();
                                    myForm["description"] = hdescription;
                                    myForm["equipement"] =
                                        equipmentFilterListData;
                                    myForm["les photos de l'hôtel"] = images;

                                    print(myForm);

                                    equipmentFilterListData.forEach((element) {
                                      print(element.isSelected);
                                    });

                                    // print(myForm.toString());

                                    Navigator.of(context).push(
                                        MaterialPageRoute<Null>(
                                            builder: (BuildContext context) {
                                      return new ChamberAddBottomSheet(
                                        form: myForm,
                                      );
                                    }));
                                  }
                                  //   Navigator.of(context).push(
                                  //       MaterialPageRoute<Null>(
                                  //           builder: (BuildContext context) {
                                  //     return new ChamberAddBottomSheet(
                                  //       form: myForm,
                                  //     );
                                  //   }));
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
    return new Padding(
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
                      "Ajouter les photos de l'hébergement",
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
                                  // showDialog(
                                  //     context: context,
                                  //     builder: (BuildContext) {
                                  //       return AlertDialog(
                                  //         shape: RoundedRectangleBorder(
                                  //             borderRadius:
                                  //                 BorderRadius.all(
                                  //                     Radius.circular(20))),
                                  //         title: Text(
                                  //           "Telecharget l'image ",
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .title,
                                  //           textAlign: TextAlign.center,
                                  //         ),
                                  //         content: Container(
                                  //           width: 100.0,
                                  //           height: 100.0,
                                  //           decoration: new BoxDecoration(
                                  //             shape: BoxShape.rectangle,
                                  //             color: const Color(0xFFFFFF),
                                  //             borderRadius:
                                  //                 new BorderRadius.all(
                                  //                     new Radius.circular(
                                  //                         32.0)),
                                  //           ),
                                  //           child: SingleChildScrollView(
                                  //             child: ListBody(
                                  //               children: <Widget>[
                                  //                 Padding(
                                  //                   padding:
                                  //                       const EdgeInsets
                                  //                           .all(8.0),
                                  //                   child: RaisedButton(
                                  //                     child:
                                  //                         Text("Galerie"),
                                  //                     color:
                                  //                         Colors.teal[200],
                                  //                     colorBrightness:
                                  //                         Brightness.dark,
                                  //                     onPressed: () {
                                  //                       gallerie();
                                  //                     },
                                  //                     shape: RoundedRectangleBorder(
                                  //                         borderRadius:
                                  //                             BorderRadius
                                  //                                 .circular(
                                  //                                     20.0)),
                                  //                   ),
                                  //                 ),
                                  //                 // Padding(
                                  //                 //   padding:
                                  //                 //       const EdgeInsets
                                  //                 //           .all(8.0),
                                  //                 //   child: RaisedButton(
                                  //                 //     child: Text("Camera"),
                                  //                 //     color:
                                  //                 //         Colors.teal[200],
                                  //                 //     colorBrightness:
                                  //                 //         Brightness.dark,
                                  //                 //     onPressed: () {
                                  //                 //       camera();
                                  //                 //     },
                                  //                 //     shape: RoundedRectangleBorder(
                                  //                 //         borderRadius:
                                  //                 //             BorderRadius
                                  //                 //                 .circular(
                                  //                 //                     20.0)),
                                  //                 //   ),
                                  //                 // )
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     });
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

  Widget description() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Description',
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          maxLines: 3,
          onChanged: (val) => hdescription = val,
          textInputAction: TextInputAction.next,
          validator: (val) => val.isEmpty ? 'Entrer la description ' : null,
        ),
      ]),
    );
  }
}
