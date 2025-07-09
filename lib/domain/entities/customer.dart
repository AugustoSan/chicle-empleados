class Customer {
  late String name;
  late String phone;
  late String? email;

  Customer({
    required this.name,
    required this.phone,
    this.email,
  });
  Customer.empty() {
    name = 'sin nombre';
    phone = 'sin telefono';
    email = 'sin email';
  }
}