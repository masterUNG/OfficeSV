// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/show_text.dart';

class ShowForm extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool? sccuText;
  const ShowForm({
    Key? key,
    required this.label,
    required this.iconData,
    this.sccuText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: 250,
      height: 40,
      child: TextFormField(obscureText: sccuText ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 4),
          prefixIcon: Icon(
            iconData,
            color: MyConstant.dark,
          ),
          label: ShowText(label: label),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.dark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: MyConstant.light),
          ),
        ),
      ),
    );
  }
}
