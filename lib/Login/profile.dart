import 'package:app_flat/pages/ajout_bien.dart';
import 'package:app_flat/pages/home_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white70, Colors.teal[100]],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.teal[100], width: 2),
                        ),
                        padding: EdgeInsets.all(8),
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/amir.jpg'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  " Amir",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.teal[200]),
                ),
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 200),
                color: Colors.white12,
                child: ListView(
                  children: <Widget>[
                    HomePage1(),
                    Reservation(),
                    Favorite(),
                    Offre(),
                    AjouterBien(),
                    MAJ(),
                    TC(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
            ),
          ),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.menu,
                        color: Colors.teal[100],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Home ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.teal[200],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Reservation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
            ),
          ),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.teal[100],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Reservation ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.teal[200],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: InkWell(
        onTap: () => {HomePage()},
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.teal[100],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Favorite',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Offre extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: InkWell(
        onTap: () => {HomePage()},
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.teal[100],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Offre',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AjouterBien extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AjoutBien(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade100),
            ),
          ),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Icon(
                        Icons.home,
                        color: Colors.teal[100],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        'Ajouter un bien ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.teal[200],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MAJ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: InkWell(
        onTap: () => {HomePage()},
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.build,
                      color: Colors.teal[100],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Mise a jour du bien',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      child: InkWell(
        onTap: () => {HomePage()},
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Icon(
                      Icons.settings,
                      color: Colors.teal[100],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Terme et condition ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_right,
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
