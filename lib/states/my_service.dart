import 'package:flutter/material.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/show_text.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(tileColor: Colors.red.withOpacity(0.25),
              leading: Icon(
                Icons.exit_to_app,
                size: 36,
                color: MyConstant.dark,
              ),
              title: ShowText(
                label: 'Sign Out',
                textStyle: MyConstant().h2Style(),
              ),
              subtitle: ShowText(label: 'ออกจาก Account และไปที่ Authen'),
            ),
          ],
        ),
      ),
    );
  }
}
