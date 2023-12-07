//transaction.dart

//1. import package
import 'package:hive/hive.dart';

//2. generate model using part and g
part 'surahmodel.g.dart';

@HiveType(typeId: 1)
class SurahModel extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late int id;

  @HiveField(2)
  late String status;

  @HiveField(3)
  late int currentAyah;
}