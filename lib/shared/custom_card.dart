import 'package:flutter/material.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_rectangle.dart';

class CustomCard extends StatelessWidget{
  
  final String title;
  final IconData icon;
  final String description;
  final bool? isClient;

  const CustomCard({
    required this.title,
    required this.icon,
    required this.description,
    this.isClient = true,
    super.key}
  );

  @override
  Widget build(BuildContext context) {
    return CustomRectangle(
      padding: const EdgeInsets.all(20),
      width: 360,
      color: isClient! ? Colors.white : kDarkGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Icon(
                  icon,
                  color: isClient! ? kPrimaryColor : kSoftGold,
                  size: 45,
                ),
              )
            ],
          ),
          Text(
            description,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      )
    );
  }

}
