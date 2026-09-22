import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reis_project/shared/colors.dart';

class LoginTextField extends StatefulWidget {

  final String title;
  final String hintText;
  final TextInputType keyboardType;
  final bool? isPassword;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final TextEditingController controller;
  final EdgeInsets? paddingTitle;
  final EdgeInsets? padding;
  final bool? isDark;
  
  const LoginTextField({
    required this.title, 
    required this.hintText, 
    required this.keyboardType, 
    required this.controller,
    this.isPassword = false,
    this.prefixIcon,
    this.inputFormatters,
    this.validator,
    this.paddingTitle,
    this.padding,
    this.isDark = false,
    super.key
  });

  @override
  LoginTextFieldState createState() => LoginTextFieldState();
}

class LoginTextFieldState extends State<LoginTextField> {

  bool _isHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  OutlineInputBorder _outlinedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        color: widget.isDark! ? kSoftGold : kPrimaryColor,
        width: widget.isDark! ? 1 : 2
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: widget.paddingTitle ?? const EdgeInsets.only(left: 36),
          child: Text(
            widget.title,
            style: TextStyle(
              color: widget.isDark! ? kSoftGold : kPrimaryColor,
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Padding(
          padding: widget.padding ?? const EdgeInsets.only(left: 36, top: 12, right: 36),
          child: TextFormField(
            style: TextStyle(
              color: widget.isDark! ? Colors.white : kPrimaryColor
            ),
            cursorColor: widget.isDark! ? kSoftGold : kPrimaryColor,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.isPassword! ? _isHidden : false,
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: 20, 
                top: 14,
                bottom: 14
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isPassword! 
                ? IconButton(
                  onPressed: _togglePasswordView, 
                  icon: Icon(
                    _isHidden ? Icons.visibility_off_outlined :
                    Icons.visibility_outlined,
                    color: kHintTextColor,
                  )
                ) : null,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: widget.isDark! ? kSoftGold : kHintTextColor,
                fontWeight: FontWeight.normal
              ),
              filled: true,
              fillColor: widget.isDark! ? kDarkGray : Colors.white,
              enabledBorder: _outlinedBorder(),
              focusedBorder: _outlinedBorder(),
              errorBorder: _outlinedBorder(),
              focusedErrorBorder: _outlinedBorder()
            ),
            validator: widget.validator ?? (value) {
              if(value == null || value.trim().isEmpty) {
                return "Campo Obrigatório";
              }
            
              return null;
            },
          ),
        )
      ],
    );
  }
}