import 'package:flutter/material.dart';
import 'package:reis_project/features/finish/view/finish_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';
import 'package:reis_project/shared/pin_field.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset(
                "images/logo.png",
                height: 200,
                width: 200,
              ),
              
              CustomRectangle(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.mark_as_unread,
                      color: kPrimaryColor,
                      size: 70,
                    ),
                    const Divider(
                      color: kPrimaryColor,
                      thickness: 2.5,
                      height: 20,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Digite no campo abaixo o código de segurança enviado para o \nE-mail e/ou Whatsapp',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const PinInput(),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Verificar Código",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FinishScreen()
                          )
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Não recebi o código',
                      style: TextStyle(fontSize: 12, color: Color(0xFFD79216)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
