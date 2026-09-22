import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:reis_project/features/login/view/login_screen.dart';
import 'package:reis_project/features/register/view/controller/register_form_controller.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_dropdown.dart';
import 'package:reis_project/shared/custom_rectangle.dart';
import 'package:reis_project/shared/register_text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  final RegisterFormController registerFormController = RegisterFormController();
  final bool _legalEntity = false;
  bool _accepted = false;
    
  void _registrationApproved() {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              "Conta criada com sucesso!",
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
                Icons.check_box_outlined,
                color: kPrimaryColor,
                size: 100,
              ),
              Text("Agora você pode realizar login")
            ],
          ),
          actions: [
            CustomButton(
              text: "Ok", 
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen()
                  )
                );
              }
            )
          ],
        );
      }
    );
  }

  void _invalidRegistration() {
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
              Text("Verifique todas as informações e se todos os campos estão preenchidos")
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

    List<Widget> passwordFields = [
      RegisterTextField(
        controller: registerFormController.passwordController,
        title: "Senha", 
        hintText: "Digite sua senha...", 
        keyboardType: TextInputType.visiblePassword,
        isPassword: true,
        isRequired: true,
        hasValidation: true,
      ),

      RegisterTextField(
        controller: registerFormController.repeatedPasswordController,
        title: "Repetir Senha", 
        hintText: "Repita sua senha...", 
        keyboardType: TextInputType.visiblePassword,
        isPassword: true,
        isRequired: true,
        validator: (value) {
          if(value == null || value.trim().isEmpty) {
            return "Campo Obrigatório";
          }

          if(registerFormController.passwordController.text != registerFormController.repeatedPasswordController.text) {
            return "Senhas diferentes";
          }

          return null;
        },
      )
    ];

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Image.asset(
                  "images/logo.png",
                  height: 70,
                ),
              ),
            ),

            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  "Cadastre-se",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            if(_legalEntity == true) ... [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomRectangle(
                        width: 350,
                        padding: const EdgeInsets.all(20),
                        child: _businessData(
                          title: "Dados Empresariais",
                          isRequired: true,
                          passwordFields: passwordFields
                        )
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomRectangle(
                        width: 350,
                        padding: const EdgeInsets.all(20),
                        child: _personalData(
                          title: "Dados Pessoais", 
                          isRequired: false
                        )
                      ),
                    )
                  ],
                ),
              )
            ] else ... [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                        child: CustomRectangle(
                        width: 350,
                        padding: const EdgeInsets.all(20),
                        child: _personalData(
                          title: "Dados Pessoais", 
                          isRequired: true,
                          passwordFields: passwordFields
                        )
                      ),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: CustomRectangle(
                        width: 350,
                        padding: const EdgeInsets.all(20),
                        child: _businessData(
                          title: "Dados Empresariais", 
                          isRequired: false
                        )
                      ),
                    )
                  ],
                )
              )
            ],

            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: _accepted, 
                    activeColor: kPrimaryColor,
                    onChanged: (bool? value) {
                      setState(() {
                        if(value != null) {
                          _accepted = value;
                        }
                      });
                    }
                  ),

                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Declaro que aceito as ",
                            style: TextStyle(
                              color: kPrimaryColor
                            )
                          ),
                          TextSpan(
                            text: "Políticas de Privacidade ",
                            style: TextStyle(
                              color: Color(0xFFD79216)
                            )
                          ),
                          TextSpan(
                            text: "e os ",
                            style: TextStyle(
                              color: kPrimaryColor
                            )
                          ),
                          TextSpan(
                            text: "Termos de Uso",
                            style: TextStyle(
                              color: Color(0xFFD79216)
                            )
                          ),
                        ]
                      )
                    )
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: CustomButton(
                text: "Cadastrar", 
                onPressed: _sendForm
              ),
            )
          ],
        )
      ),
    );
  }

  void _sendForm() {
    if(_formKey.currentState!.validate() && _accepted) {
      _registrationApproved();
    } else {
      _invalidRegistration();
    }
  }

  Widget _personalData({
    required String title, 
    required bool isRequired, 
    List<Widget>? passwordFields
  }) {
    
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Text(
            title,
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),

        RegisterTextField(
          controller: registerFormController.completeNameController,
          title: "Nome Completo",
          hintText: "Digite seu nome completo...",
          keyboardType: TextInputType.name,
          isRequired: isRequired
        ),

        RegisterTextField(
          controller: registerFormController.emailController,
          title: "Email",
          hintText: "Digite seu email...",
          keyboardType: TextInputType.emailAddress,
          isRequired: isRequired,
          hasValidation: true,
          validator: (value) {

            final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

            if(isRequired && (value == null || value.trim().isEmpty)) {
              return "Campo Obrigatório";
            }

            if(!regex.hasMatch(value) && !(value == null || value.trim().isEmpty)) {
              return "Email Inválido";
            }

            return null;
          },
        ),

        if(passwordFields != null) ...[
          ...passwordFields.map( (passwordField) =>
            passwordField
          )
        ],

        RegisterTextField(
          controller: registerFormController.phoneController,
          title: "Telefone",
          hintText: "Digite seu telefone...",
          keyboardType: TextInputType.phone,
          isRequired: isRequired,
          inputFormatters: [
            PhoneInputFormatter(
              defaultCountryCode: 'BR',
              allowEndlessPhone: false,
            )
          ],
          hasValidation: true,
          validator: (value) {

            final regex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');

            if(isRequired && (value == null || value.trim().isEmpty)) {
              return "Campo Obrigatório";
            }

            if(!regex.hasMatch(value) && !(value == null || value.trim().isEmpty)) {
              return "Número Inválido";
            }

            return null;
          },
        ),

        RegisterTextField(
          controller: registerFormController.cpfController,
          title: "CPF",
          hintText: "Digite seu CPF...",
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CpfInputFormatter()
          ],
          isRequired: isRequired,
          hasValidation: true,
          validator: (value) {
            
            if(isRequired && (value == null || value.trim().isEmpty)) {
              return "Campo Obrigatório";
            }

            if(!UtilBrasilFields.isCPFValido(value) && !(value == null || value.trim().isEmpty)) {
              return "CPF inválido";
            }

            return null;
          },
        ),

        Row(
          children: <Widget>[
            Expanded(
              child: RegisterTextField(
                controller: registerFormController.cepController,
                title: "CEP",
                hintText: "Digite seu CEP...",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter()
                ],
                keyboardType: TextInputType.number,
                isRequired: isRequired,
                hasValidation: true,
                validator: (value) {

                  if(isRequired && (value == null || value.trim().isEmpty)) {
                    return "Campo Obrigatório";
                  }

                  if(
                    value.length != 10 && 
                    !(value == null || value.trim().isEmpty)
                  ) {
                    return "CEP Inválido";
                  }

                  return null;
                },

              )
            ),
            Expanded(
              child: CustomDropdown(
                changed: (String value) {
                  registerFormController.state = value;
                },
              ),
            )
          ],
        ),

        RegisterTextField(
          controller: registerFormController.cityController,
          title: "Cidade",
          hintText: "Digite a sua cidade...",
          keyboardType: TextInputType.name,
          isRequired: isRequired
        ),

        RegisterTextField(
          controller: registerFormController.streetController,
          title: "Logradouro",
          hintText: "Digite seu logradouro...",
          keyboardType: TextInputType.name,
          isRequired: isRequired
        ),

        Row(
          children: [
            Flexible(
              flex: 3,
              child: RegisterTextField(
                controller: registerFormController.complementController,
                title: "Complemento",
                hintText: "Digite seu complemento...",
                keyboardType: TextInputType.name,
              )
            ),

            const SizedBox(
              width: 20,
            ),

            Flexible(
              flex: 1,
              child: RegisterTextField(
                controller: registerFormController.numberController,
                title: "Nº",
                hintText: "",
                keyboardType: TextInputType.number,
                isRequired: isRequired
              )
            )
          ],
        ),

      ],
    );
  }

  Widget _businessData({
    required String title, 
    required bool isRequired, 
    List<Widget>? passwordFields
  }) {
    
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 25),
          child: Text(
            title,
            style: const TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),

        RegisterTextField(
          controller: registerFormController.companyNameController,
          title: "Nome",
          hintText: "Digite o nome da empresa...",
          keyboardType: TextInputType.name,
          isRequired: isRequired,
        ),

        RegisterTextField(
          controller: registerFormController.businessEmailController,
          title: "Email",
          hintText: "Digite o email da empresa...",
          keyboardType: TextInputType.emailAddress,
          isRequired: isRequired,
          hasValidation: true,
          validator: (value) {

            final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

            if(isRequired && (value == null || value.trim().isEmpty)) {
              return "Campo Obrigatório";
            }

            if(!regex.hasMatch(value) && !(value == null || value.trim().isEmpty)) {
              return "Email Inválido";
            }

            return null;
          },
        ),

        if(passwordFields != null) ...[
          ...passwordFields.map( (passwordField) =>
            passwordField
          )
        ],

        RegisterTextField(
          controller: registerFormController.businessPhoneController,
          title: "Telefone",
          hintText: "Digite o telefone da empresa...",
          keyboardType: TextInputType.phone,
          isRequired: isRequired,
          inputFormatters: [
            PhoneInputFormatter(
              defaultCountryCode: 'BR',
              allowEndlessPhone: false,
            )
          ],
          hasValidation: true,
          validator: (value) {

            final regex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');

            if(isRequired && (value == null || value.trim().isEmpty)) {
              return "Campo Obrigatório";
            }

            if(!regex.hasMatch(value) && !(value == null || value.trim().isEmpty)) {
              return "Número Inválido";
            }

            return null;
          },
        ),

        RegisterTextField(
          controller: registerFormController.cnpjController,
          title: "CNPJ",
          hintText: "Digite seu CNPJ...",
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            CnpjInputFormatter()
          ],
          keyboardType: TextInputType.number,
          isRequired: isRequired,
          hasValidation: true,
          validator: (value) {
            if(isRequired && (value == null || value.trim().isEmpty)) {
              return "Campo Obrigatório";
            }

            if(!UtilBrasilFields.isCNPJValido(value) && !(value == null || value.trim().isEmpty)) {
              return "CNPJ Inválido";
            }

            return null;
          },
        ), 

        Row(
          children: <Widget>[
            Expanded(
              child: RegisterTextField(
                controller: registerFormController.businessCepController,
                title: "CEP",
                hintText: "Digite o CEP...",
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CepInputFormatter()
                ],
                keyboardType: TextInputType.number,
                isRequired: isRequired,
                hasValidation: true,
                validator: (value) {

                  if(isRequired && (value == null || value.trim().isEmpty)) {
                    return "Campo Obrigatório";
                  }

                  if(
                    value.length != 10 && 
                    !(value == null || value.trim().isEmpty)
                  ) {
                    return "CEP Inválido";
                  }

                  return null;
                },
              )
            ),
            Expanded(
              child: CustomDropdown(
                changed: (String value) {
                  registerFormController.businessState = value;
                },
              ),
            )
          ],
        ),

        RegisterTextField(
          controller: registerFormController.businessCityController,
          title: "Cidade",
          hintText: "Digite a cidade da empresa...",
          keyboardType: TextInputType.name,
          isRequired: isRequired,
        ),

        RegisterTextField(
          controller: registerFormController.businessStreetController,
          title: "Logradouro",
          hintText: "Digite o logradouro da empresa...",
          keyboardType: TextInputType.name,
          isRequired: isRequired
        ),

        Row(
          children: [
            Flexible(
              flex: 3,
              child: RegisterTextField(
                controller: registerFormController.businessComplementController,
                title: "Complemento",
                hintText: "Digite o complemento...",
                keyboardType: TextInputType.name,
              )
            ),

            const SizedBox(
              width: 20,
            ),

            Flexible(
              flex: 1,
              child: RegisterTextField(
                controller: registerFormController.businessNumberController,
                title: "Nº",
                hintText: "",
                keyboardType: TextInputType.number,
                isRequired: isRequired
              )
            )
          ],
        ),

      ],
    );
  }
}
