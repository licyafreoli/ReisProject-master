import 'package:flutter/material.dart';
import 'package:reis_project/features/register/view/register_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';

class FinishScreen extends StatefulWidget {
  const FinishScreen({super.key});

  @override
  FinishScreenState createState() => FinishScreenState();
}

class FinishScreenState extends State<FinishScreen> {
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
                      Icons.verified_user,
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
                      'Verificação concluída\n com sucesso!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20, fontFamily: 'Roboto', fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Você já pode fazer seu cadastro e ter \n acesso aos seus processos',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Por favor, faça seu cadastro',
                      style: TextStyle(fontSize: 12, color: Color(0xFFD79216)),
                    ),
                    const SizedBox(height: 30),
                    CustomButton(
                      text: "Cadastrar conta",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen()
                          )
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    
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
