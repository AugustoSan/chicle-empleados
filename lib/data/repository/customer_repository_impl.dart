import 'package:hive/hive.dart';
import '../../domain/domain.dart';
import '../../models/consumerModel.dart';

class ConsumerRepositoryImpl implements CustomerRepository {
  final Box<ConsumerModel> box;

  ConsumerRepositoryImpl(this.box);

  @override
  Future<List<Customer>> getAll(CustomerFilter filter) async {
    if (box.isEmpty) return [];
    
    // obtenemos todos los registros
    final models = box.values.toList();

    // mapeamos todos los registros a objetos customer
    final customers = models.map((m) => Customer(
      name: m.name,
      phone: m.phone,
      email: m.email,
    )).toList();

    // aplicamos el filtro
    if (filter.name != null) {
      customers.retainWhere((c) => c.name.toLowerCase().contains(filter.name!.toLowerCase()));
    }
    if (filter.phone != null) {
      customers.retainWhere((c) => c.phone.toLowerCase().contains(filter.phone!.toLowerCase()));
    }
    if (filter.email != null) {
      customers.retainWhere((c) => c.email!.toLowerCase().contains(filter.email!.toLowerCase()));
    }

    return customers;
  }

  @override
  Future<Customer> create(Customer customer) async {
    final model = ConsumerModel(
      name: customer.name,
      phone: customer.phone,
      email: customer.email,
    );
    await box.add(model);
    return customer;
  }

  @override
  Future<Customer> update(Customer customer) async {
    final model = ConsumerModel(
      name: customer.name,
      phone: customer.phone,
      email: customer.email,
    );
    await box.putAt(0, model);
    return customer;
  }
}
