import 'package:flutter/material.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';
import 'package:reis_project/features/communication/view/communication_two_screen.dart';
import 'package:reis_project/shared/login_text_field.dart';

class CommunicationScreen extends StatefulWidget {
  const CommunicationScreen({super.key});

  @override
  State<CommunicationScreen> createState() => _CommunicationScreenState();
}

class _CommunicationScreenState extends State<CommunicationScreen> {
  String? selectedSegment = 'Todos';
  String? selectedStep = 'Protocolo';
  bool personalizeMessage = false;
  final TextEditingController areaOfActivity = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Comunicação',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFFD1B072),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomRectangle(
                padding: const EdgeInsets.all(20),
                color: kDarkGray,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Text(
                        'Segmentação',
                        style: TextStyle(
                          color: Color(0xFFD1B072),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Segmento',
                      style: TextStyle(
                          color: Color(0xFFD1B072),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedSegment,
                      dropdownColor: kDarkGray,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kDarkGray,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD1B072)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD1B072)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      iconEnabledColor: const Color(0xFFD1B072),
                      style: const TextStyle(color: Color(0xFFD1B072), fontSize: 16),
                      items: [
                        'Todos',
                        'Produto',
                        'Fabricação',
                        'Comércio',
                        'Serviço',
                      ].map((segment) {
                        return DropdownMenuItem<String>(
                          value: segment,
                          child: Text(segment),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSegment = value;
                        });
                      },
                    ),
                    const SizedBox(height: 38),
                    LoginTextField(
                      padding: const EdgeInsets.all(0),
                      paddingTitle: const EdgeInsets.only(bottom: 7),
                      title: "Área de Atuação",
                      hintText: "Ex: Supermercado",
                      keyboardType: TextInputType.text,
                      controller: areaOfActivity,
                      isDark: true,
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Etapa do Processo',
                      style: TextStyle(
                          color: Color(0xFFD1B072),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedStep,
                      dropdownColor: kDarkGray,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: kDarkGray,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD1B072)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFFD1B072)),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      iconEnabledColor: const Color(0xFFD1B072),
                      style: const TextStyle(color: Color(0xFFD1B072), fontSize: 16),
                      items: [
                        'Protocolo',
                        'Exame formal',
                        'Oposição',
                        'Exame de mérito',
                        'Deferimento do pedido'
                      ].map((segment) {
                        return DropdownMenuItem<String>(
                          value: segment,
                          child: Text(segment),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedStep = value;
                        });
                      },
                    ),
                    const SizedBox(height: 40),
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: const Color(0xFFD1B072),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: personalizeMessage,
                            onChanged: (bool? value) {
                              setState(() {
                                personalizeMessage = value ?? false;
                              });
                              if (personalizeMessage) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CommunicationTwoScreen(),
                                  ),
                                ).then((value) {
                                  if (value == true) {
                                    setState(() {
                                      personalizeMessage = false;
                                    });
                                  }
                                });
                              }
                            },
                            activeColor: const Color(0xFFD1B072),
                            checkColor: kDarkGray,
                            side: const BorderSide(
                              color: Color(0xFFD1B072),
                              width: 2,
                            ),
                            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Personalizar a mensagem',
                            style: TextStyle(
                              color: Color(0xFFD1B072),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: CustomButton(
                    isClient: false,
                    text: "Enviar",
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: kDarkGray,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: const Row(
                              children: [
                                Icon(Icons.check_box, color: kSoftGold),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    "Mensagem enviada com sucesso!",
                                    style: TextStyle(
                                      color: kSoftGold,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text("OK", style: TextStyle(color: kSoftGold)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
