import '../entities/order.dart';
import '../../data/data.dart';

class GetAllOrdersUseCase{
  final OrderRepositoryImpl repository;

  GetAllOrdersUseCase(this.repository);

  Future<List<Order>> call() {
    return repository.getAllOrders();
  }
}

class GetAllOrdersByUserUseCase{
  final OrderRepositoryImpl repository;

  GetAllOrdersByUserUseCase(this.repository);

  Future<List<Order>> call(String userId) {
    return repository.getOrdersByUser(userId);
  }
}

class GetOrderByIdUseCase {
  final OrderRepositoryImpl repository;

  GetOrderByIdUseCase(this.repository);

  Future<Order?> call(String id) {
    return repository.getOrder(id);
  }
}

class AddOrderUseCase {
  final OrderRepositoryImpl repository;

  AddOrderUseCase(this.repository);

  Future<void> call(Order order) {
    return repository.saveOrder(order);
  }
}

class UpdateOrderUseCase {
  final OrderRepositoryImpl repository;

  UpdateOrderUseCase(this.repository);

  Future<void> call(String id, Order order) {
    return repository.updateOrder(id, order);
  }
}

class DeleteSaleUseCase {
  final OrderRepositoryImpl repository;

  DeleteSaleUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteOrder(id);
  }
}
