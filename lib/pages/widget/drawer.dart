import 'package:aiia/url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class customdrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.indigo,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('image/logo.jpg'),
            ),
            accountName: Text(
              "WELCOME",
              style: TextStyle(fontFamily: 'ShantellSans', fontSize: 20),
            ),
            accountEmail: Text(""),
            onDetailsPressed: () {},
            decoration: BoxDecoration(
              color: Colors.indigo[800],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.0),
                bottomRight: Radius.circular(40.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    spreadRadius: 5),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.white,
            ),
            title: Text(
              'HomePage',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              print("clicked");
              UrlLauncher naver = new UrlLauncher(
                  url: "https://www.naver.com"); //http 또는 https를 꼭 넣어야함/
              await naver.launch();
            },
            // onTap: () {
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) {
            //       return Member();
            //     }),
            //   );
            // },
          ),
          // Member
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            title: Text(
              'Settings',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              print("clicked");
              UrlLauncher naver = new UrlLauncher(
                  url: "https://www.naver.com"); //http 또는 https를 꼭 넣어야함/
              await naver.launch();
            },
            // onTap: (){
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) {
            //       return AccountUsed();
            //     }),
            //   );
            //
            // },
          ),
          //account used
          ListTile(
            leading: Icon(
              Icons.link_rounded,
              color: Colors.white,
            ),
            title: Text(
              'SNS',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () async {
              print("clicked");
              UrlLauncher naver = new UrlLauncher(
                  url: "https://www.naver.com"); //http 또는 https를 꼭 넣어야함/
              await naver.launch();
            },
          ),
          //Homepage
        ],
      ),
    );
  }
}
