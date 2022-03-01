import 'package:flutter/material.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/show_button.dart';
import 'package:officesv/widgets/show_form.dart';
import 'package:officesv/widgets/show_image.dart';
import 'package:officesv/widgets/show_text.dart';

class Authen extends StatelessWidget {
  const Authen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newImage(),
              newAppName(),
              newUser(),
              newPassword(),
              ShowButton(label: 'Login',)
            ],
          ),
        ),
      ),
    );
  }

  ShowForm newPassword() {
    return ShowForm(
              label: 'Password :',
              iconData: Icons.lock_outline,
              sccuText: true,
            );
  }

  ShowForm newUser() {
    return ShowForm(
              label: 'User :',
              iconData: Icons.perm_identity,
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
}
