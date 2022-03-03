import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:officesv/models/job_model.dart';
import 'package:officesv/utility/my_constant.dart';
import 'package:officesv/widgets/show_button.dart';
import 'package:officesv/widgets/show_progress.dart';
import 'package:officesv/widgets/show_text.dart';

class ListJob extends StatefulWidget {
  const ListJob({
    Key? key,
  }) : super(key: key);

  @override
  State<ListJob> createState() => _ListJobState();
}

class _ListJobState extends State<ListJob> {
  bool load = true;
  var jobModels = <JobModel>[];
  var listItems = <List<bool>>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readAllJob();
  }

  Future<void> readAllJob() async {
    String path = 'https://www.androidthai.in.th/sv/getAllJobUng.php';
    await Dio().get(path).then((value) {
      for (var item in json.decode(value.data)) {
        JobModel jobModel = JobModel.fromMap(item);

        String itemStr = jobModel.item;
        itemStr = itemStr.substring(1, itemStr.length - 1);
        List<String> itemStrs = itemStr.split(',');
        var items = <bool>[];

        for (var item in itemStrs) {
          if (item.trim() == 'true') {
            items.add(true);
          } else {
            items.add(false);
          }
        }

        listItems.add(items);
        jobModels.add(jobModel);
      }

      setState(() {
        load = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: load
          ? const ShowProgress()
          : LayoutBuilder(builder: (context, constraints) {
              return ListView.builder(
                itemCount: jobModels.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => detailDialog(jobModels[index], index),
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.5 - 8,
                          height: constraints.maxWidth * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              jobModels[index].pathImage,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: constraints.maxWidth * 0.5,
                          height: constraints.maxWidth * 0.4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ShowText(
                                  label: jobModels[index].jobName,
                                  textStyle: MyConstant().h2Style(),
                                ),
                                ShowText(label: jobModels[index].detailJob),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      floatingActionButton: ShowButton(
          label: 'Add Job',
          pressFunc: () => Navigator.pushNamed(context, '/addJob')),
    );
  }

  Future<void> detailDialog(JobModel jobModel, int index) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: Image.network(jobModel.pathImage),
          title: ShowText(
            label: jobModel.jobName,
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowText(label: 'Agree : ${jobModel.agree}'),
        ),
        content: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ShowText(
              label: 'Item :',
              textStyle: MyConstant().h2Style(),
            ),
            listItems[index][0] ? ShowText(label: 'Doramon') : SizedBox() ,
             listItems[index][1] ? ShowText(label: 'Nopita') : SizedBox() ,
              listItems[index][2] ? ShowText(label: 'Sunako') : SizedBox() ,
          ],
        ),
      ),
    );
  }
}
