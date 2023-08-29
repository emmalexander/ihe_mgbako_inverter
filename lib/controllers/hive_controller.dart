import 'package:flutter/foundation.dart';
import 'package:ihe_mgbako_inverter/controllers/boxes.dart';
import 'package:ihe_mgbako_inverter/model/database_model.dart';

class HiveController {
  //write method
  Future addData(String appliance, String quantity, String power) async {
    final database = DatabaseModel()
      ..appliance = appliance
      ..quantity = quantity
      ..power = power;

    final box = Boxes.getDatabase();
    box.add(database);
  }

  //read method

  //edit method
  void editData(DatabaseModel databaseModel, String appliance, String quantity,
      String power) {
    databaseModel.appliance = appliance;
    databaseModel.quantity = quantity;
    databaseModel.power = power;

    databaseModel.save();
  }

  //delete method
  void deleteData(DatabaseModel databaseModel) {
    databaseModel.delete();
  }
}
