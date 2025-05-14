import '../entities/business.dart';

abstract class BusinessRepository {
  Future<void> initialize();
  Future<Business?> loadBusiness();
  Future<void> saveBusiness(Business config);
}