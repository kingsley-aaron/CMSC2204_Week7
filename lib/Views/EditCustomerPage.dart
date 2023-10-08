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
    if (customer.Name != customerNameController.text ||
        customer.Description != customerDescriptionController.text) {
      setState(() {
        customer.Name = customerNameController.text;
        customer.Description = customerDescriptionController.text;
      });

      // Update the customer in the GlobalCustomer class
      int index =
          GlobalCustomer().customer.indexWhere((c) => c.Id == customer.Id);
      if (index != -1) {
        GlobalCustomer().customer[index] = customer;
      }
    }

    Navigator.pop(context, customer); // Pass the updated customer back
  }

  void _deleteItemPressed(Customer customerToDelete) {
    setState(() {
      int indexToDelete = GlobalCustomer()
          .customer
          .indexWhere((c) => c.Id == customerToDelete.Id);

      if (indexToDelete != -1) {
        // Remove the customer from the global customer list using the same instance
        GlobalCustomer().customer.removeAt(indexToDelete);
      }
    });

    Navigator.pop(context, customerToDelete); // Pass the deleted customer back
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _updateItemPressed,
                    child: Text("Update Customer"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _deleteItemPressed(customer);
                    },
                    child: Text("Delete"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
