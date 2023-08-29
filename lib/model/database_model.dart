import 'package:hive/hive.dart';
part 'database_model.g.dart';

@HiveType(typeId: 0)
class DatabaseModel extends HiveObject {
  @HiveField(0)
  late String appliance;
  @HiveField(1)
  late String quantity;
  @HiveField(2)
  late String power;
}
