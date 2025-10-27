import 'package:chicle_app_empleados/models/models.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'categoryModel.g.dart';




@HiveType(typeId: 6)
class CategoryModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<ProductModel> items;


  CategoryModel({
    String? id,
    required this.name,
    required this.items,
  }) : this.id = id ?? const Uuid().v4(); // Asigna el ID proporcionado o genera uno nuevo
}