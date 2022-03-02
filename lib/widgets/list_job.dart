import 'package:flutter/material.dart';
import 'package:officesv/widgets/show_button.dart';

class ListJob extends StatelessWidget {
  const ListJob({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('This is ListJob'),
      floatingActionButton: ShowButton(label: 'Add Job', pressFunc: () => Navigator.pushNamed(context, '/addJob')),
    );
  }
}
