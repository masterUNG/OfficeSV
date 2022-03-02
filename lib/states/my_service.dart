import 'package:flutter/material.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/information.dart';
import 'package:officesv/widgets/list_job.dart';
import 'package:officesv/widgets/read_qr_code.dart';
import 'package:officesv/widgets/show_image.dart';
import 'package:officesv/widgets/show_text.dart';
import 'package:officesv/widgets/show_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String? nameLogin;
  var titles = <String>[
    'List Job',
    'Read QR code',
    'Information',
    'Show WebView',
  ];

  var iconDatas = <IconData>[
    Icons.filter_1,
    Icons.filter_2,
    Icons.filter_3,
    Icons.filter_4,
  ];

  var bodys = <Widget>[
    const ListJob(),
    const ReadQRcode(),
    const Information(),
    const ShowWebView(),
  ];

  int indexBodys = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findName();
  }

  Future<void> findName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      var result = preferences.getStringList('data');
      nameLogin = result![1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Column(
              children: [
                newHeader(),
                newMenu(
                  title: titles[0],
                  iconData: iconDatas[0],
                  index: 0,
                ),
                newMenu(
                  title: titles[1],
                  iconData: iconDatas[1],
                  index: 1,
                ),
                newMenu(
                  title: titles[2],
                  iconData: iconDatas[2],
                  index: 2,
                ),
                newMenu(
                  title: titles[3],
                  iconData: iconDatas[3],
                  index: 3,
                ),
              ],
            ),
            newSignOut(), 
          ],
        ),
      ),
      body: bodys[indexBodys],
    );
  }

  ListTile newMenu(
          {required String title,
          required IconData iconData,
          required int index}) =>
      ListTile(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            indexBodys = index;
          });
        },
        leading: Icon(
          iconData,
          color: MyConstant.dark,
        ),
        title: ShowText(
          label: title,
          textStyle: MyConstant().h2Style(),
        ),
      );

  UserAccountsDrawerHeader newHeader() {
    return UserAccountsDrawerHeader(
        currentAccountPicture: const ShowImage(),
        decoration: MyConstant().painBox(),
        accountName: ShowText(
          label: nameLogin ?? '',
          textStyle: MyConstant().h2Style(),
        ),
        accountEmail: const ShowText(label: 'พนักงาน'));
  }

  Column newSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.clear().then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, '/authen', (route) => false));
          },
          tileColor: Colors.red.withOpacity(0.25),
          leading: Icon(
            Icons.exit_to_app,
            size: 36,
            color: MyConstant.dark,
          ),
          title: ShowText(
            label: 'Sign Out',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: const ShowText(label: 'ออกจาก Account และไปที่ Authen'),
        ),
      ],
    );
  }
}
