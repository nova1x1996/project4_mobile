import 'package:flutter/material.dart';
import 'package:project_hk4_mobile/const/const.dart';

class cpn_category extends StatelessWidget {
  const cpn_category({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: colorBoderInput)),
          child: Column(
            children: [
              Icon(
                Icons.health_and_safety,
                size: 45,
                color: colorPrimary,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Doctors",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: labelInput,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: colorBoderInput)),
          child: Column(
            children: [
              Icon(
                Icons.health_and_safety,
                size: 45,
                color: colorPrimary,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Doctors",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: labelInput,
                    fontSize: 18),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: colorBoderInput)),
          child: Column(
            children: [
              Icon(
                Icons.health_and_safety,
                size: 45,
                color: colorPrimary,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Doctors",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: labelInput,
                    fontSize: 18),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
