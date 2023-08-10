import 'package:flutter/foundation.dart';
import 'package:table_calendar/table_calendar.dart';


class Event {
  final String title;
  Event({required this.title});

  String toString() => this.title;
}