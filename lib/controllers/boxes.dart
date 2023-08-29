import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:ihe_mgbako_inverter/model/database_model.dart';

class Boxes {
  static Box<DatabaseModel> getDatabase() => Hive.box('database');
}
