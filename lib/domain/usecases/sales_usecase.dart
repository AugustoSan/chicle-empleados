import '../entities/sales.dart';
import '../../data/data.dart';

class GetSales {
  final SalesRepositoryImpl repository;

  GetSales(this.repository);

  Future<List<Sales>> call() {
    return repository.getSales();
  }
}

class GetSale {
  final SalesRepositoryImpl repository;

  GetSale(this.repository);

  Future<Sales?> call(int id) {
    return repository.getSale(id);
  }
}

class AddSale {
  final SalesRepositoryImpl repository;

  AddSale(this.repository);

  Future<void> call(Sales product) {
    return repository.saveSale(product);
  }
}

class UpdateSale {
  final SalesRepositoryImpl repository;

  UpdateSale(this.repository);

  Future<void> call(int id, Sales product) {
    return repository.updateSale(id, product);
  }
}

class DeleteSale {
  final SalesRepositoryImpl repository;

  DeleteSale(this.repository);

  Future<void> call(int id) {
    return repository.deleteSale(id);
  }
}
