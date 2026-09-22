import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:reis_project/features/verification/view/verification_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';
import 'package:reis_project/shared/login_text_field.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({super.key});

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _formKey = GlobalKey<FormState>();
  String? telefone;

  bool emptyField(String? value) => value == null || value.trim().isEmpty;

  final TextEditingController whatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36),
            child: Column(
              children: [
                const SizedBox(height: 32),

                Image.asset(
                  'images/logo.png',
                  height: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.business, size: 100),
                ),

                const SizedBox(height: 48),

                CustomRectangle(
                  width: 350,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.phone,
                        size: 65,
                      ),
                      
                      const SizedBox(height: 16),

                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 3,
                        ),
                      ),

                      const SizedBox(height: 32),

                      const Text(
                        'Insira seu número',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Campo telefone com LoginTextField (sem título duplicado)
                      LoginTextField(
                        padding: const EdgeInsets.all(0),
                        controller: whatsController,
                        title: '',
                        hintText: 'Número do WhatsApp',
                        keyboardType: TextInputType.phone,
                        isPassword: false,
                        prefixIcon:
                            const Icon(Icons.phone_outlined, color: kPrimaryColor),
                        validator: (value) {
                          if (emptyField(value)) return 'Campo obrigatório';
                          
                          final regex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');

                          if(!regex.hasMatch(value!) && !emptyField(value)) {
                            return "Número Inválido";
                          }

                          return null;
                        },
                        inputFormatters: [
                          PhoneInputFormatter(
                            defaultCountryCode: 'BR',
                            allowEndlessPhone: false,
                          )
                        ],
                      ),

                      const SizedBox(height: 36),
                    ],
                  )
                ),

                const SizedBox(height: 36),

                const Text(
                  'O código lhe será repassado em breve pela empresa.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFFFFB400),
                  ),
                ),

                const SizedBox(height: 28),

                CustomButton(
                  text: 'Próximo',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VerificationScreen()
                        )
                      );
                    } else {
                      print('Formulário inválido');
                    }
                  },
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
