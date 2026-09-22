import 'package:flutter/material.dart';
import 'package:reis_project/features/verification/view/verification_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';
import 'package:reis_project/shared/login_text_field.dart';

class EmailInputScreen extends StatefulWidget {
  const EmailInputScreen({super.key});

  @override
  State<EmailInputScreen> createState() => _EmailInputScreenState();
}

class _EmailInputScreenState extends State<EmailInputScreen> {
  final _formKey = GlobalKey<FormState>();

  bool emptyField(String? value) => value == null || value.trim().isEmpty;

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 32),
              Center(
                child: Image.asset(
                  'images/logo.png',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.business, size: 100),
                ),
              ),
              const SizedBox(height: 32),
              CustomRectangle(
                height: 350,
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Icon(
                          Icons.mark_email_unread_sharp, // ícone atualizado
                          size: 60,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 3,
                        ),
                      ),
                      const Text(
                        'Insira seu e-mail',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: kPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: 32),
                      LoginTextField(
                        padding: const EdgeInsets.all(0),
                        controller: emailController,
                        title: '',
                        hintText: 'Digite seu e-mail',
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        prefixIcon:
                            const Icon(Icons.email_outlined, color: kPrimaryColor),
                        validator: (value) {
                          if (emptyField(value)) return 'Campo obrigatório';
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                            return 'E-mail inválido';
                          }
                          return null;
                        },
                      ),
                    ],
                ),
                )
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 36),
                child: Text(
                  'O código lhe será repassado em breve pela empresa.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFB400),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: CustomButton(
                  text: "Próximo",
                  onPressed: sendForm,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void sendForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerificationScreen()
        )
      );
    } else {
      print("Formulário inválido");
    }
  }
}
