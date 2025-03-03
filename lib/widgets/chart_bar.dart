import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  const ChartBar(                 //-----> because this constructor doesn't need rebuilds, and all properties are finals, we can
    this.label,                  // add const here as well, and thus improve performance, slightly !!
    this.spendingAmount, 
    this.spendingPctOfTotal
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(                      // forces it's child into the available space, even shrinks the text !
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}'      // to round off the decimals
                ) 
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),                         // used as spacing
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label)
              )
            ),
          ],
        );
      },
    );
  }
}
