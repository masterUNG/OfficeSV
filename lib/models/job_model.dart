import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class JobModel {

  final String id;
  final String nameRecord;
  final String jobName;
  final String detailJob;
  final String factoryKey;
  final String agree;
  final String item;
  final String addDate;
  final String qRcode;
  final String pathImage;
  JobModel({
    required this.id,
    required this.nameRecord,
    required this.jobName,
    required this.detailJob,
    required this.factoryKey,
    required this.agree,
    required this.item,
    required this.addDate,
    required this.qRcode,
    required this.pathImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nameRecord': nameRecord,
      'jobName': jobName,
      'detailJob': detailJob,
      'factoryKey': factoryKey,
      'agree': agree,
      'item': item,
      'addDate': addDate,
      'qRcode': qRcode,
      'pathImage': pathImage,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: (map['id'] ?? '') as String,
      nameRecord: (map['nameRecord'] ?? '') as String,
      jobName: (map['jobName'] ?? '') as String,
      detailJob: (map['detailJob'] ?? '') as String,
      factoryKey: (map['factoryKey'] ?? '') as String,
      agree: (map['agree'] ?? '') as String,
      item: (map['item'] ?? '') as String,
      addDate: (map['addDate'] ?? '') as String,
      qRcode: (map['qRcode'] ?? '') as String,
      pathImage: (map['pathImage'] ?? '') as String,
    );
  }

  factory JobModel.fromJson(String source) => JobModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
