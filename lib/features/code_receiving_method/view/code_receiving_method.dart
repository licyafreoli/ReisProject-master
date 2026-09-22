import 'package:flutter/material.dart';
import 'package:reis_project/features/contact_input/view/email_input_screen.dart';
import 'package:reis_project/features/contact_input/view/email_whats_input_screen.dart';
import 'package:reis_project/features/contact_input/view/whats_input_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';

class CodeReceivingMethod extends StatelessWidget {
  const CodeReceivingMethod({super.key});
  

  @override
  Widget build(BuildContext context) {

    void nextStep(Widget widget) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
            child: Column(
            children: <Widget>[
              Image.asset('images/logo.png', height: 100),
              const SizedBox(height: 20),
              CustomRectangle(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    const Icon(
                      Icons.comment_rounded,
                      color: kPrimaryColor,
                      size: 60,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Como deseja receber o código?",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: kPrimaryColor,
                      thickness: 2.5,
                      height: 20,
                    ),

                    const SizedBox(height: 8),
                    const Text(
                      "Selecione o meio que deseja receber o seu código de autenticação",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: "Whatsapp", 
                      onPressed: () => nextStep(const PhoneNumberScreen())
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: "E-mail", 
                      onPressed: () => nextStep(const EmailInputScreen())
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      text: "Whatsapp e E-mail", 
                      onPressed: () => nextStep(const EmailWhatsInputScreen())
                    ),
                    const SizedBox(height: 20),
                    /*const Text(
                      "Um código de 4 dígitos será enviado para contato@reismarcasepatentes.com e depois poderá ser repassado para você\n",
                      textAlign: TextAlign.center,
                      style:  TextStyle(fontSize: 12),
                    ),*/
                    const Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "Um código de 4 dígitos será enviado para "
                          ),
                          TextSpan(
                            text: "contato@reismarcasepatentes.com",
                            style: TextStyle(
                              color: kGoldColor,
                            )
                          ),
                          TextSpan(
                            text:" e depois poderá ser repassado para você"
                          )
                        ]
                      )
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}