import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amountSpend;
  final double percentageOfTotalAmountSpend;

  ChartBar(this.label, this.amountSpend, this.percentageOfTotalAmountSpend);


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      FittedBox(child: Text('₹${amountSpend.toString()}')),
      SizedBox(height: 5),
      Container(
        height: 100,
        width: 10,
        child: Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
          Container(
            decoration: BoxDecoration(color: Color.fromRGBO(220, 220, 220, 1), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: 1)),
            ),

          Container(
            height: percentageOfTotalAmountSpend * 100,
            decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey, width: 1))
            ),

          Container(
            alignment: AlignmentDirectional.center,
            child: FittedBox(
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Text(
                    (percentageOfTotalAmountSpend*100).toStringAsFixed(2) + '%',
                    style: TextStyle(fontWeight: FontWeight.bold)))
            ),
          ),
          
        ]),),
      SizedBox(height: 5),
      Text(label),
    ],);
  }
}