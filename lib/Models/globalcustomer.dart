import 'customer.dart';

class GlobalCustomer {
  static final GlobalCustomer _item = GlobalCustomer._instance();

  factory GlobalCustomer() {
    return _item;
  }

  GlobalCustomer._instance();

  List<Customer> customer = [];
}
