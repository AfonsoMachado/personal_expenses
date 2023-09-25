import 'package:flutter/material.dart';
import 'package:personal_expenses/models/transaction.dart';

main() => runApp(const ExpansesApp());

class ExpansesApp extends StatelessWidget {
  const ExpansesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Tênis',
      value: 3190.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Tênis 2',
      value: 390.76,
      date: DateTime.now(),
    ),
  ];

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text('Gráfico'),
            ),
          ),
          Column(
            children: [
              ..._transactions.map((tr) {
                return Card(
                  child: Text(tr.title),
                );
              }).toList()
            ],
          )
        ],
      ),
    );
  }
}
