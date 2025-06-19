import '../domain.dart';

abstract class SalesRepository {
  Future<List<Sales>> getSales();
  Future<Sales?> getSale(int id);
  Future<int> saveSale(Sales sales);
  Future<int> updateSale(int id, Sales sale);
  Future<int> deleteSale(int id);
}