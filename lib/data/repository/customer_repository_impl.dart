import 'package:hive/hive.dart';
import '../../domain/domain.dart';
import 'package:chicle_app_empleados/models/customerModel.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final Box<CustomerModel> box;

  CustomerRepositoryImpl(this.box);

  @override
  Future<void> initialize() async {
    print('Initializing customer repository');
    if (box.isNotEmpty) return;
    await box.add(CustomerModel(
      name: 'Público en general',
      phone: '0000000000',
      email: 'publico@general.com',
    ));
  }

  @override
  Future<List<Customer>> getAll(CustomerFilter filter) async {
    print('Getting all customers');
    if (box.isEmpty) return [];
    print('Customers: ${box.values}');
    
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
    final model = CustomerModel(
      name: customer.name,
      phone: customer.phone,
      email: customer.email,
    );
    await box.add(model);
    return customer;
  }

  @override
  Future<Customer> update(Customer customer) async {
    final model = CustomerModel(
      name: customer.name,
      phone: customer.phone,
      email: customer.email,
    );
    await box.putAt(0, model);
    return customer;
  }
}
