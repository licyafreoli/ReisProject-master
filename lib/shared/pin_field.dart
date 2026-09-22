import 'package:flutter/material.dart';

class PinInput extends StatefulWidget {
  const PinInput({super.key});
  @override
  PinInputState createState() => PinInputState();
}

class PinInputState extends State<PinInput> {
  final int pinLength = 4;
  late List<FocusNode> focusNodes;
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    focusNodes = List.generate(pinLength, (index) => FocusNode());
    controllers = List.generate(pinLength, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget buildPinField(int index) {
    return Container(
      width: 45,
      height: 45,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: TextField(
          controller: controllers[index],
          focusNode: focusNodes[index],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 1,
          style: const TextStyle(fontSize: 24),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: "",
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              if (index + 1 < pinLength) {
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              } else {
                FocusScope.of(context).unfocus();
              }
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) => buildPinField(index)),
    );
  }
}
