
import 'package:chicle_app_empleados/domain/entities/customer.dart' show Customer;
import 'package:chicle_app_empleados/domain/filters/filters.dart';

abstract class CustomerRepository {
  // Obtener todos los clientes
  Future<List<Customer>> getAll(CustomerFilter filter);
  // Crear un cliente
  Future<Customer> create(Customer customer);
  // Actualizar un cliente
  Future<Customer> update(Customer customer);
}