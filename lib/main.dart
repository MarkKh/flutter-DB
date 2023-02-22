import 'package:db/providers/transaction_provider.dart';
import 'package:db/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'models/transactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) {
            return TransactionProvider();
          }))
        ],
        child: MaterialApp(
          title: 'DB Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'แอพบัญชี'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return FormScreen();
              }));
            },
            icon: Icon(Icons.add),
          )
        ]),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget? child) {
            var count = provider.transactions.length;
            if (count <= 0) {
              return Center(
                child: Text(
                  "No data",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: provider.transactions.length,
                  itemBuilder: ((context, index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                            child: FittedBox(
                          child: Text(data.amount.toString()),
                        )),
                        title: Text(data.title),
                        subtitle:
                            Text(DateFormat("dd/MM/yyy").format(data.date)),
                      ),
                    );
                  }));
            }
            ;
          },
        ));
  }
}
