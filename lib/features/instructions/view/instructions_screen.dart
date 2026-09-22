import 'package:flutter/material.dart';
import 'package:reis_project/features/cpf_cnpj_input/view/cpf_cnpj_input_screen.dart';
import 'package:reis_project/shared/custom_button.dart';
import 'package:reis_project/shared/custom_rectangle.dart';

class WelcomeInstructionsScreen extends StatelessWidget {
  const WelcomeInstructionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              'images/logo.png',
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20),
          CustomRectangle(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Seja Bem-vindo(a) à REIS",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Para acessar, siga os passos:",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildInstructionStep(
                  stepNumber: 1,
                  title: "Identifique-se:",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Pessoa Física",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: ": Insira seu CPF"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4),
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                          children: [
                            TextSpan(
                              text: "Pessoa Jurídica",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: ": Insira seu CNPJ e marque a caixinha."),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildInstructionStep(
                  stepNumber: 2,
                  title: "Selecione o tipo de acesso:",
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Cliente", style: _contentTextStyle()),
                      Text("Colaborador", style: _contentTextStyle()),
                      Text("Parceiro", style: _contentTextStyle()),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildInstructionStep(
                  stepNumber: 3,
                  title: "Código de Segurança:",
                  content: const Text(
                    "Escolha onde receber seu código de autenticação (E-mail ou Whatsapp).",
                  ),
                ),
                const SizedBox(height: 16),
                _buildInstructionStep(
                  title: "Atenção:",
                  content: const Text(
                    "O código será primeiramente validado internamente pela REIS e, em seguida, enviado para você",
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "Ao validar o código, você poderá realizar cadastro.",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomButton(
                text: "Próximo",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CpfCnpjInputScreen()
                    )
                  );
                }
              )
            ),
          ],
        ),
      )
    );
  }

  Widget _buildInstructionStep({
    int? stepNumber,
    required String title,
    required Widget content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
        stepNumber != null ? "$stepNumber. $title" : title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),

        const SizedBox(height: 4),
        content,
      ],
    );
  }

  TextStyle _contentTextStyle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );
  }
}
