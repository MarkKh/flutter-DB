import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:db/models/transaction.dart';
import 'package:db/providers/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  // controller

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Form Screen"),
        ),
        body: Form(
          key: formKey,
          child: Column(children: [
            TextFormField(
              decoration: const InputDecoration(labelText: "ชื่อรายการ"),
              autofocus: true,
              controller: titleController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return "กรุณากรอกข้อมูล";
                }
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: "ราคา"),
              keyboardType: TextInputType.number,
              controller: amountController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return "กรุณากรอกข้อมูล";
                }
                var price = double.parse(str);
                if (price < 0) {
                  return "กรุณากรอกราคาที่มากกว่า 0";
                }
              },
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var title = titleController.text;
                  var amount = amountController.text;

                  //เตรียมข้อมูล
                  Transaction statement = Transaction(
                      title: title,
                      amount: double.parse(amount),
                      date: DateTime.now()); //object

                  // call provider
                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);
                  Navigator.pop(context);
                }
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.purple),
              ),
              child: const Text("เพิ่มข้อมูล"),
            )
          ]),
        ));
  }
}
