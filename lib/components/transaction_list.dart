import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Limitando a altura do ListView
      height: 300,
      // Exibição otimizada de itens, exibindo na tela somente a quantidade indicada no itemCount
      child: transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nenhuma transação cadastrada!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  elevation: 5,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                            child: Text(
                          'R\$ ${tr.value}',
                          style: const TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    title: Text(
                      tr.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    subtitle: Text(DateFormat('d MMM y').format(tr.date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: const Text('Excluir transação'),
                                  content: const Text('Tem certeza?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Não')),
                                    TextButton(
                                        onPressed: () {
                                          onRemove(tr.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Sim'))
                                  ],
                                ));
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
