import 'package:flutter/material.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_button.dart';

class CommunicationTwoScreen extends StatefulWidget {
  const CommunicationTwoScreen({super.key});

  @override
  State<CommunicationTwoScreen> createState() => _CommunicationTwoScreenState();
}

class _CommunicationTwoScreenState extends State<CommunicationTwoScreen> {
  final TextEditingController _messageController = TextEditingController();

  Future<bool> _onWillPop() async {
    bool? shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kDarkGray,
        title: const Text(
          'Tem certeza que deseja sair?',
          style: TextStyle(color: kSoftGold),
        ),
        content: const Text(
          'As alterações não serão salvas.',
          style: TextStyle(color: kSoftGold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancelar', style: TextStyle(color: kSoftGold)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sair', style: TextStyle(color: kSoftGold)),
          ),
        ],
      ),
    );
    return shouldExit ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Botão voltar com ícone
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color(0xFFD1B072)),
                        onPressed: () async {
                          bool exit = await _onWillPop();
                          if (exit) {
                            Navigator.of(context).pop(true);
                          }
                        },
                      ),
                      const Text(
                        'Voltar',
                        style: TextStyle(
                          color: Color(0xFFD1B072),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 6),
                          blurRadius: 6,
                        )
                      ],
                    ),
                    child: SizedBox(
                      height: 600,
                      child: TextField(
                        controller: _messageController,
                        expands: true,
                        maxLines: null,
                        minLines: null,
                        textAlignVertical: TextAlignVertical.top,
                        keyboardType: TextInputType.multiline,
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                        cursorColor: const Color(0xFFD1B072),
                        decoration: InputDecoration(
                          hintText: "Mensagem",
                          hintStyle: const TextStyle(
                            color: Color(0xFFD1B072),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: const EdgeInsets.all(16.0),
                          filled: true,
                          fillColor: const Color(0xFF444343),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: CustomButton(
                        isClient: false,
                        text: "Enviar",
                        onPressed: () async {
                          final mensagem = _messageController.text.trim();

                          if (mensagem.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: kDarkGray,
                                content: const Text(
                                  'Digite uma mensagem antes de enviar.',
                                  style: TextStyle(color: kSoftGold),
                                ),
                              ),
                            );
                            return;
                          }

                          final resultado = await showDialog<bool>(
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
                                        "Mensagem personalizada enviada com sucesso!",
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
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text("OK", style: TextStyle(color: kSoftGold)),
                                  ),
                                ],
                              );
                            },
                          );

                          if (resultado == true) {
                            Navigator.of(context).pop(true); // Voltar para a tela anterior
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}