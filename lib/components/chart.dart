import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/components/chart_bar.dart';
import 'package:personal_expenses/models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart(this.recentTransactions, {super.key});

  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      // Pegando os dias da semana
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double amount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        bool sameDay = recentTransactions[i].date.day == weekDay.day;
        bool sameMonth = recentTransactions[i].date.month == weekDay.month;
        bool sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          amount += recentTransactions[i].value;
        }
      }

      // Pegando a primeira letra do dia da semana
      return {'day': DateFormat.E().format(weekDay)[0], 'value': amount};
    });
  }

  double get _weekAmount {
    return groupedTransactions.fold(
        0.0, (sum, tr) => sum + (tr['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;

    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((tr) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: tr['day'] as String,
                      value: tr['value'] as double,
                      percentage: (tr['value'] as double) / _weekAmount,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
