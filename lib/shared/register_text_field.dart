import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reis_project/shared/colors.dart';

class RegisterTextField extends StatefulWidget {

  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isPassword;
  final FormFieldValidator? validator;
  final bool? isRequired;
  final bool? hasValidation;

  const RegisterTextField({
    required this.controller,
    required this.title,
    required this.hintText,
    required this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.isPassword = false,
    this.isRequired = false,
    this.hasValidation = false,
    super.key
  });

  @override
  RegisterTextFieldState createState() => RegisterTextFieldState();
}

class RegisterTextFieldState extends State<RegisterTextField> {

  bool _isHidden = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(0),
          child: Text(
            widget.isRequired! ? "${widget.title} *": widget.title,
            style: const TextStyle(
              color: kPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            obscureText: widget.isPassword! ? _isHidden : false,
            decoration: InputDecoration(
              suffixIcon: widget.isPassword!
              ? IconButton(
                onPressed: () {
                  setState(() {
                    _isHidden = !_isHidden;
                  });
                }, 
                icon: Icon(
                  _isHidden ? Icons.visibility_off_outlined : 
                  Icons.visibility_outlined,
                  color: kHintTextColor,
                )
              ) : null,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: kHintTextColor,
                fontSize: 12
              )
            ),
            validator: widget.isRequired! || widget.hasValidation! ? 
            widget.validator ?? (value) {
              if(value == null || value.trim().isEmpty) {
                return "Campo Obrigatório";
              }

              return null;
            } : null,
          ),
        )
      ],
    );
  }
}
