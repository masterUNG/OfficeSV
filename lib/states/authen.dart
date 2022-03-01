import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:officesv/models/user_model.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/utility/my_dialog.dart';
import 'package:officesv/widgets/show_button.dart';
import 'package:officesv/widgets/show_form.dart';
import 'package:officesv/widgets/show_image.dart';
import 'package:officesv/widgets/show_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: MyConstant().painBox(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                newImage(),
                newAppName(),
                newUser(),
                newPassword(),
                newLogin()
              ],
            ),
          ),
        ),
      ),
    );
  }

  ShowButton newLogin() {
    return ShowButton(
      label: 'Login',
      pressFunc: () {
        print('user = $user, password = $password');

        if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
          print('Have Space');
          MyDialog(context: context)
              .normalDialot('Have Space', 'Please Fill Every Blank');
        } else {
          print('No Space');
          processCheckAuthen();
        }
      },
    );
  }

  ShowForm newPassword() {
    return ShowForm(
      label: 'Password :',
      iconData: Icons.lock_outline,
      sccuText: true,
      changeFunc: (String string) {
        password = string.trim();
      },
    );
  }

  ShowForm newUser() {
    return ShowForm(
      label: 'User :',
      iconData: Icons.perm_identity,
      changeFunc: (String string) {
        user = string.trim();
      },
    );
  }

  ShowText newAppName() {
    return ShowText(
      label: MyConstant.appName,
      textStyle: MyConstant().h1Style(),
    );
  }

  SizedBox newImage() {
    return const SizedBox(
      width: 250,
      child: ShowImage(),
    );
  }

  Future<void> processCheckAuthen() async {
    String path =
        'https://www.androidthai.in.th/sv/getUserWhereUserUng.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) async {
      print('value from Server ==> $value');
      if (value.toString() == 'null') {
        MyDialog(context: context)
            .normalDialot('User False', 'No $user in my Database');
      } else {
        var result = json.decode(value.data);
        print('result = $result');
        for (var item in result) {
          print('item ==> $item');
          UserModel userModel = UserModel.fromMap(item);
          if (password == userModel.password) {
            var value = <String>[];
            value.add(userModel.id);
            value.add(userModel.name);
            value.add(userModel.user);

            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            preferences.setStringList('data', value).then((value) {
               Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false);
            });

           
          } else {
            MyDialog(context: context).normalDialot(
                'Password False', 'Please Try Again Password False');
          }
        }
      }
    });
  }
}
