import 'package:flutter/material.dart';
import 'package:reis_project/shared/colors.dart';

class CustomDropdown extends StatefulWidget {
  final ValueChanged<String> changed;

  const CustomDropdown({required this.changed, super.key});

  
  @override
  CustomDropdownState createState() => CustomDropdownState();
}

class CustomDropdownState extends State<CustomDropdown> {

  String _selectedState = "CE";

  final List<String> _states = [
    'AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA',
    'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN',
    'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 52),
          child: DropdownButtonFormField(
            value: _selectedState,
            decoration: const InputDecoration(
              labelText: "UF",
              labelStyle: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
              border: InputBorder.none,
              isDense: true
            ),
            items: _states.map((String state) {
              return DropdownMenuItem(
                value: state,
                child: Text(state)
              );
            }).toList(), 
            onChanged: (String? newValue) {
              if(newValue != null) {
                setState(() {
                  _selectedState = newValue;
                });

                widget.changed(newValue);
              }
            }
          ),
        )
      ],
    );
  }
}
