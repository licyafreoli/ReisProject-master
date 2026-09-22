import 'package:flutter/material.dart';
import 'package:reis_project/features/verification/view/verification_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';
import 'package:reis_project/shared/login_text_field.dart';

class EmailWhatsInputScreen extends StatefulWidget {
  const EmailWhatsInputScreen({super.key});

  @override
  State<EmailWhatsInputScreen> createState() => _EmailWhatsInputScreenState();
}

class _EmailWhatsInputScreenState extends State<EmailWhatsInputScreen> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? telefone;

  bool emptyField(String? value) => value == null || value.trim().isEmpty;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController whatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 32),

              Center(
                child: SizedBox(
                  height: 100,
                  child: Image.asset(
                    'images/logo.png',
                    errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.business, size: 100),
                  ),
                )
              ),

              const SizedBox(height: 32),

              CustomRectangle(
                width: 350,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Icon(
                          Icons.mark_email_unread_sharp, // ícone atualizado
                          size: 60,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    
                    LoginTextField(
                      paddingTitle: const EdgeInsets.only(bottom: 7),
                      padding: const EdgeInsets.all(0),
                      controller: emailController,
                      title: 'Email',
                      hintText: 'Digite seu Email',
                      keyboardType: TextInputType.emailAddress,
                      isPassword: false,
                      prefixIcon:
                          const Icon(Icons.email_outlined, color: kPrimaryColor),
                      validator: (value) {
                        if (emptyField(value)) {
                          return 'Campo obrigatório';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                          return 'E-mail inválido';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Divider(
                        color: kPrimaryColor,
                        thickness: 3,
                      ),
                    ),

                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Icon(
                          Icons.phone, // ícone atualizado
                          size: 60,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),

                    // Campo: Telefone
                    LoginTextField(
                      paddingTitle: const EdgeInsets.only(bottom: 7),
                      padding: const EdgeInsets.all(0),
                      controller: whatsController,
                      title: 'Número',
                      hintText: 'Insira seu número do WhatsApp',
                      keyboardType: TextInputType.phone,
                      isPassword: false,
                      prefixIcon:
                          const Icon(Icons.phone_outlined, color: kPrimaryColor),
                      validator: (value) {
                        if (emptyField(value)) {
                          return 'Campo obrigatório';
                        }

                        final regex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');

                        if(!regex.hasMatch(value!) && !emptyField(value)) {
                          return "Número Inválido";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 32),
                  ],
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

              const SizedBox(height: 16),

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
      _formKey.currentState!.save();
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
