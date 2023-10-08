import 'package:flutter/material.dart';

import '../Models/globalcustomer.dart';
import '../Models/customer.dart';

class EditCustomer extends StatefulWidget {
  final Customer customer;

  const EditCustomer({Key? key, required this.customer}) : super(key: key);

  @override
  State<EditCustomer> createState() => _EditCustomerState(customer);
}

class _EditCustomerState extends State<EditCustomer> {
  _EditCustomerState(item);

  late Customer customer = widget.customer;

  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    customerNameController.text = customer.Name;
    customerDescriptionController.text = customer.Description;
  }

  void _updateItemPressed() {
    Customer currentCustomer = GlobalCustomer()
        .customer
        .firstWhere((index) => index.Id == customer.Id);

    if (currentCustomer.Name != customerNameController.text ||
        currentCustomer.Description != customerDescriptionController.text) {
      currentCustomer.Name = customerNameController.text;
      currentCustomer.Description = customerDescriptionController.text;
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Edit Customer Page"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: customerNameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: customerDescriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              ElevatedButton(
                onPressed: _updateItemPressed,
                child: Text("Update Customer"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
