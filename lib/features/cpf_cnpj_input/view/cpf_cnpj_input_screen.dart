import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reis_project/features/code_receiving_method/view/code_receiving_method.dart';
import 'package:reis_project/features/login/view/login_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';
import 'package:reis_project/shared/login_text_field.dart';

class CpfCnpjInputScreen extends StatefulWidget {
  const CpfCnpjInputScreen({super.key});

  @override
  CpfCnpjInputScreenState createState() => CpfCnpjInputScreenState();
}

class CpfCnpjInputScreenState extends State<CpfCnpjInputScreen> {
  final TextEditingController _cpfCnpjController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isCnpj = false;
  String? _accessType;

  void _invalidRegistration(String message) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Formulário Inválido",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error,
                color: kPrimaryColor,
                size: 100,
              ),
              Text(message)
            ],
          ),
          actions: [
            CustomButton(
              text: "Ok", 
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ],
        );
      }
    );
  }

  void _nextStep() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CodeReceivingMethod()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 30),
                Image.asset(
                  'images/logo.png', 
                  height: 100
                ),
                const SizedBox(height: 20),
                CustomRectangle(
                  width: 360,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LoginTextField(
                        paddingTitle: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(0),
                        title: "Insira seu CPF ou CNPJ", 
                        hintText: "CPF/CNPJ", 
                        keyboardType: TextInputType.number, 
                        isPassword: false, 
                        controller: _cpfCnpjController,
                        prefixIcon: const Icon(Icons.person_outline),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          isCnpj ? CnpjInputFormatter() : CpfInputFormatter()
                        ],
                        validator: (value) {
                          
                          if(emptyField(value)) {
                            return "Campo Obrigatório";
                          }

                          if(isCnpj) {
                            if(!UtilBrasilFields.isCNPJValido(value)) {
                              return "CNPJ inválido";
                            }
                          }

                          if(!UtilBrasilFields.isCPFValido(value)) {
                            return "CPF inválido";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Checkbox(
                            value: isCnpj,
                            activeColor: kPrimaryColor,
                            onChanged: (val) => setState(() {
                              isCnpj = val!;
                              _cpfCnpjController.clear();
                            }),
                          ),
                          const Text("CNPJ")
                        ],
                      ),
                      const SizedBox(height: 30),
                      const Text("Selecione o seu tipo de acesso"),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 7,
                        children: ["Cliente", "Colaborador", "Parceiro"]
                          .map((e) => FilterChip(
                                label: Text(e),
                                selected: _accessType == e,
                                onSelected: (val) {
                                  setState(() {
                                    _accessType = val ? e : null;
                                  });
                                },
                              ))
                          .toList(),
                      ),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(20),
                    child: Center(
                    child: CustomButton(
                      text: "Próximo", 
                      onPressed: _sendForm
                    ),
                  ),
                ),
                Padding(
                  padding: const  EdgeInsets.all(20),
                  child: RichText(
                    text: TextSpan(
                      text: "Já tem uma conta? ",
                      style: const TextStyle(
                        color: kPrimaryColor,
                        fontSize: 15
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Clique aqui",
                          style: const TextStyle(
                            color: kGoldColor,
                            fontSize: 15,
                            decoration: TextDecoration.underline,
                            decorationColor: kGoldColor,
                            decorationThickness: 1.5
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen()
                                )
                              );
                            }
                        ),
                      ]
                    ),
                  )
                )
              ],
            ),
          ),
        )
      )
    );
  }

  void _sendForm() {

    bool isTextFieldValid = _formKey.currentState!.validate();
    bool isAccessSelected = _accessType != null;


    if(isTextFieldValid && isAccessSelected) {
      _nextStep();
    } else {
      if(!isTextFieldValid && !isAccessSelected) {
        _invalidRegistration("Insira o seu CPF ou CNPJ e selecione o tipo de acesso");
      } else if (!isTextFieldValid) {
        _invalidRegistration("Insira o seu CPF ou CNPJ");
      } else {
        _invalidRegistration("Selecione o tipo de acesso");
      }
    }
  }

  bool emptyField(value){
    if(value == null || value.trim().isEmpty) {
      return true;
    }

    return false;
  }
}