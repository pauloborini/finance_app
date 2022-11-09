import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;
  final Color colorBar;

  const ChartBar(
      {Key? key,
      required this.label,
      required this.value,
      required this.percentage,
      required this.colorBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
                height: constraints.maxHeight * 0.16,
                child: FittedBox(child: Text(value.toStringAsFixed(2)))),
            SizedBox(
              height: constraints.maxHeight * 0.02,
            ),
            SizedBox(
              height: constraints.maxHeight * 0.66,
              width: 15,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: constraints.maxHeight * 0.66,
                    width: 15,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        border: Border.all(color: colorBar, width: 1.0),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      height: constraints.maxHeight * 0.66,
                      width: 15,
                      decoration: BoxDecoration(
                          color: colorBar,
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.02),
            SizedBox(
                height: constraints.maxHeight * 0.14,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
