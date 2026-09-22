import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reis_project/features/cpf_cnpj_input/view/cpf_cnpj_input_screen.dart';
import 'package:reis_project/features/navigation/view/main_navigation_screen.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/login_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});


  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final String _cpf = "624.687.963-22";
  final String _password = "123admin";
  final TextEditingController _cpfCnpjController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isCnpj = false;

  void _displayDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text("Autenticado"),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.verified_user_rounded,
                color: kPrimaryColor,
                size: 100,
              ),
              Text('Usuário autenticado com sucesso')
            ],
          ),
          actions: [
            CustomButton(
              text: "Ok", 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen()
                  )
                );
              }
            )
          ],
        );
      }
    );
  }

  void _invalidLogin() {
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
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error,
                color: kPrimaryColor,
                size: 100,
              ),
              Text("Login Incorreto")
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const  EdgeInsets.only(top: 16),
                  child: Image.asset(
                    "images/logo.png",
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 40),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              LoginTextField(
                controller: _cpfCnpjController,
                title: "CPF/CNPJ", 
                hintText: "CPF/CNPJ", 
                keyboardType:  TextInputType.number, 
                prefixIcon: const Icon(
                  Icons.person_outline,
                  color: kHintTextColor
                ),
                isPassword: false,
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

                  if(!isCnpj && value != _cpf) {
                    return "CPF incorreto";
                  }

                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.only(left: 36, top: 12),
                child: Row(
                  children: [
                    Checkbox(
                      value: isCnpj,
                      activeColor: kPrimaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          if(value != null) {
                            isCnpj = value;
                          }
                        });
                      },
                    ),
                    const Text("CNPJ")
                  ],
                )
              ),
              const SizedBox(height: 20),
              LoginTextField(
                controller: _passwordController,
                title: "Senha", 
                hintText: "Senha", 
                keyboardType:  TextInputType.name, 
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: kHintTextColor
                ),
                isPassword: true,
                validator: (value) {

                  if(emptyField(value)) {
                    return "Campo Obrigatório";
                  }

                  if(value != _password) {
                    return "Senha incorreta";
                  }

                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.only(top: 26, right: 36, bottom: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Esqueceu a senha?",
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 12
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: CustomButton(
                  text: "Entrar",
                  onPressed: _sendForm,
                )
              ),
              Padding(
                padding: const  EdgeInsets.all(32),
                child: RichText(
                  text: TextSpan(
                    text: "Não tem uma conta? ",
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
                                builder: (context) => const CpfCnpjInputScreen()
                              )
                            );
                          }
                      ),
                    ]
                  ),
                )
              )
            ] 
          ),
        )
      )
    );
  }

  void _sendForm() {
    if(_formKey.currentState!.validate()) {
      _displayDialog();
    } else {
      _invalidLogin();
    }
  }

  bool emptyField(value){
    if(value == null || value.trim().isEmpty) {
      return true;
    }

    return false;
  }
}