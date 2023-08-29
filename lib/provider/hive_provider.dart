import 'package:flutter/cupertino.dart';
import 'package:ihe_mgbako_inverter/controllers/hive_controller.dart';
import 'package:ihe_mgbako_inverter/model/database_model.dart';
import '../controllers/boxes.dart';

class HiveProvider extends ChangeNotifier {
  HiveController hiveController = HiveController();
  List<DatabaseModel> _databaseList = [];
  get getDatabaseList => _databaseList;
  double _totalWattage = 0;
  get totalWattage => _totalWattage;

  void setDatabaseList() {
    _databaseList = Boxes.getDatabase().values.toList().cast<DatabaseModel>();
  }

  void totalWatt(double totalWatt) {
    _totalWattage = totalWatt;
    totalWattage;
    notifyListeners();
  }

  void getData() {
    Boxes.getDatabase();
    notifyListeners();
  }

  addData(String appliance, String quantity, String power) {
    hiveController.addData(appliance, quantity, power);
    Boxes.getDatabase();
    _databaseList = Boxes.getDatabase().values.toList().cast<DatabaseModel>();
    notifyListeners();
  }

  editData(DatabaseModel databaseModel, String appliance, String quantity,
      String power) {
    hiveController.editData(databaseModel, appliance, quantity, power);
    _databaseList = Boxes.getDatabase().values.toList().cast<DatabaseModel>();
    Boxes.getDatabase();
    notifyListeners();
  }

  deleteData(DatabaseModel databaseModel) {
    hiveController.deleteData(databaseModel);
    _databaseList = Boxes.getDatabase().values.toList().cast<DatabaseModel>();
    Boxes.getDatabase();
    notifyListeners();
  }
}
