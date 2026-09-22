import 'package:flutter/material.dart';
import 'package:reis_project/features/register/model/user_data.dart';

class RegisterFormController {

  //Dados Pessoais
  final TextEditingController completeNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  late final String? state;
  final TextEditingController cityController = TextEditingController();
  final TextEditingController complementController = TextEditingController();

  //Senha
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatedPasswordController = TextEditingController();

  //Dados Empresariais
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController businessEmailController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  final TextEditingController businessPhoneController = TextEditingController();
  final TextEditingController businessStreetController = TextEditingController();
  final TextEditingController businessNumberController = TextEditingController();
  final TextEditingController businessCepController = TextEditingController();
  late final String? businessState;
  final TextEditingController businessCityController = TextEditingController();
  final TextEditingController businessComplementController = TextEditingController();

  PersonalData toPersonalData() {
    return PersonalData(
      completeName: completeNameController.text, 
      email: emailController.text, 
      cpf: cpfController.text, 
      phone: phoneController.text, 
      street: streetController.text, 
      number: numberController.text, 
      cep: cepController.text, 
      state: state ?? "", 
      city: cityController.text, 
      complement: complementController.text
    );
  }

  BusinessData toBusinessData() {
    return BusinessData(
      companyName: companyNameController.text, 
      email: businessEmailController.text, 
      cnpj: cnpjController.text, 
      phone: businessPhoneController.text, 
      street: businessStreetController.text, 
      number: businessNumberController.text, 
      cep: businessCepController.text, 
      state: businessState ?? "", 
      city: businessCityController.text, 
      complement: businessComplementController.text
    );
  }

  void dispose() {
    completeNameController.dispose();
    emailController.dispose();
    cpfController.dispose();
    phoneController.dispose();
    streetController.dispose();
    numberController.dispose();
    cepController.dispose();
    cityController.dispose();
    complementController.dispose();

    passwordController.dispose();
    repeatedPasswordController.dispose();

    companyNameController .dispose();
    businessEmailController.dispose();
    cnpjController.dispose();
    businessPhoneController.dispose();
    businessStreetController.dispose();
    businessNumberController.dispose();
    businessCepController.dispose();
    businessCityController.dispose();
    businessComplementController.dispose();

  }
}
