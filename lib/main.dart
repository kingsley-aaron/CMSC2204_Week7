import 'package:flutter/material.dart';
import 'package:week7project/Models/globalcustomer.dart';

import 'Models/customer.dart';
import 'Views/EditCustomerPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Kingsley Week 7'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Customer> customers = [
    Customer(1001, 'Kingsley', 'Occasional'),
    Customer(1002, 'Castro', 'Spender'),
    Customer(1003, 'Smith', 'Frequent'),
    Customer(1004, 'Jones', 'Occasional'),
    Customer(1005, 'Krause', 'Saver'),
    Customer(1006, 'Hinks', 'Spender'),
    Customer(1007, 'Thompson', 'Frequent'),
    Customer(1008, 'Sanchez', 'Frequent'),
    Customer(1009, 'Torres', 'Saver'),
    Customer(1010, 'Hiltner', 'Occasional'),
  ];

  void _handleButtonPress(Customer customer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCustomer(customer: customer),
      ),
    ).then((updatedCustomer) {
      if (updatedCustomer != null) {
        setState(() {
          int index = GlobalCustomer()
              .customer
              .indexWhere((c) => c.Id == updatedCustomer.Id);
          if (index != -1) {
            GlobalCustomer().customer[index] = updatedCustomer;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: customers.map((customer) {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ID: ${customer.Id.toString()}',
                        style: TextStyle(fontSize: 16)),
                    Text('Name: ${customer.Name}',
                        style: TextStyle(fontSize: 16)),
                    Text('Description: ${customer.Description}'),
                    ElevatedButton(
                      onPressed: () => _handleButtonPress(customer),
                      child: Text("Edit Customer"),
                    ),
                    const Divider(),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
