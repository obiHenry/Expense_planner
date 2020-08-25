import 'package:flutter/material.dart';
// import 'dart:html';

class ChartBar extends StatelessWidget {
  final String label;
  final double spentAmount;
  final double spentPecentage;

  ChartBar(this.label, this.spentAmount, this.spentPecentage);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        
        child: Column(
          children: [
            Container(
              height: constraints.maxHeight * 0.15,
              
            
              child: FittedBox(
                child: Text('\$${spentAmount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.6,
              width: 10,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1),
                        color: Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  FractionallySizedBox(
                    heightFactor: spentPecentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color:  Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height:constraints.maxHeight * 0.05,
            ),
            Container(
              height: constraints.maxHeight * 0.15,
              
              child: FittedBox(
                child: Text(label),
              ),
            ),
          ],
        ),
      );
    });
  }
}
