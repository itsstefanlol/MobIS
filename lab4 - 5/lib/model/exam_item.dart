import 'package:flutter/foundation.dart';

class ExamItem {
  final String id;
  final String naslov;
  final DateTime datum;


  ExamItem({
    required this.id,
    required this.naslov,
    required this.datum,
  });
}
