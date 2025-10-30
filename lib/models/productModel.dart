import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'productModel.g.dart';


@HiveType(typeId: 3)
class ProductModel extends HiveObject {

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  double price;

  @HiveField(3)
  bool available;

  // Propiedades opcionales
  @HiveField(4) // Asegúrate de usar un nuevo HiveField index
  String? description;  // Opcional, puede ser null

  @HiveField(5) // Asegúrate de usar un nuevo HiveField index
  String? image;     // Opcional, puede ser null

  ProductModel({
    String? id,
    required this.name,
    required this.price,
    required this.available,
    this.description, // Son opcionales en el constructor
    this.image,    // Son opcionales en el constructor
  }) : this.id = id ?? const Uuid().v4(); // Asigna el ID proporcionado o genera uno nuevo
}