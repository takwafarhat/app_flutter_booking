import 'package:app_flat/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'Login/LoginScreen.dart';

void main() => runApp(LocaVacance());

class LocaVacance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.id, //LoginSignupPage.id,
      routes: {
        LoginSignupPage.id: (context) => LoginSignupPage(),
        HomePage.id: (context) => HomePage(),
      },
    );
  }
}
// import 'dart:html';

// import 'package:app_flat/pages/home_page.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'Login/LoginScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

// import 'dart:io';
// import 'package:path/path.dart' as Path;

// void main() => runApp(LocaVacance());

// class LocaVacance extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
//   // @override
//   // Widget build(BuildContext context) {
//   //   return MaterialApp(
//   //     initialRoute: HomePage.id, //LoginSignupPage.id,
//   //     routes: {
//   //       LoginSignupPage.id: (context) => LoginSignupPage(),
//   //       HomePage.id: (context) => HomePage(),
//   //     },
//   //   );
//   // }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//   File _image;
//   String _uploadedFileURL;
//   bool isLoading = false;
//   Future chooseFile() async {
//     await ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
//       setState(() {
//         _image = image;
//       });
//     });
//   }

//   Future uploadFile() async {
//     setState(() {
//       isLoading = true;
//     });
//     StorageReference storageReference = FirebaseStorage.instance
//         .ref()
//         .child('hotels/${Path.basename(_image.path)}}');
//     StorageUploadTask uploadTask = storageReference.putFile(_image);
//     await uploadTask.onComplete;
//     print('File Uploaded');
//     storageReference.getDownloadURL().then((fileURL) {
//       setState(() {
//         _uploadedFileURL = fileURL;
//         isLoading = false;
//       });
//     });
//   }

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firestore File Upload'),
//       ),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             Container(
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Column(
//                       children: <Widget>[
//                         Text('Selected Image'),
//                         _image != null
//                             ? Image.file(
//                                 _image,
//                                 // height: 150,
//                                 height: 150,
//                                 width: 150,
//                               )
//                             : Container(
//                                 child: Center(
//                                   child: Text(
//                                     "No Image is Selected",
//                                   ),
//                                 ),
//                                 height: 150,
//                               ),
//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Text('Uploaded Image'),
//                         _uploadedFileURL != null
//                             ? Image.network(
//                                 _uploadedFileURL,
//                                 height: 150,
//                                 width: 150,
//                               )
//                             : Container(
//                                 child: Center(
//                                   child: Text(
//                                     "No Image is Selected",
//                                   ),
//                                 ),
//                                 height: 150,
//                               ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             _image != null
//                 ? isLoading
//                     ? CircularProgressIndicator()
//                     : RaisedButton(
//                         child: Text('Upload Image'),
//                         onPressed: uploadFile,
//                         color: Colors.red,
//                       )
//                 : Container()
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: chooseFile,
//         tooltip: 'Pick Image',
//         child: Icon(Icons.add_a_photo),
//       ),
//     );
//   }

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
