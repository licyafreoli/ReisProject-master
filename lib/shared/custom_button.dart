import 'package:flutter/material.dart';
import 'package:reis_project/shared/colors.dart';

//Botão Customizado
class CustomButton extends StatelessWidget {

  final String text;
  final VoidCallback onPressed;
  final bool? isClient;

  const CustomButton({
    required this.text,
    required this.onPressed,
    this.isClient = true,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 269,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          elevation: 0,
          shape: !isClient! ? const StadiumBorder(
            side: BorderSide(
              color: kSoftGold,
              width: 1.5,
            ),
          ) : null,
        ),
        onPressed: onPressed, 
        child: Text(
          text,
          style: TextStyle(
            color: isClient! ? Colors.white : kSoftGold,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        )
      ),
    );
  }
  
}