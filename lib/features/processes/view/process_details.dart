import 'package:flutter/material.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_rectangle.dart';

class ProcessDetailsScreen extends StatelessWidget {
  final String title;
  final String status;
  final String startDate;
  final bool? isClient;

  const ProcessDetailsScreen({
    required this.title,
    required this.status,
    required this.startDate,
    this.isClient = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          scaffoldBackgroundColor: isClient! ? kSoftGold : kPrimaryColor,
          textTheme: TextTheme(
            bodyMedium: TextStyle(
              color: isClient! ? kPrimaryColor : kSoftGold
            )
          ),
          scrollbarTheme: ScrollbarThemeData(
            thumbColor: MaterialStatePropertyAll(
              isClient! ? kPrimaryColor : kSoftGold
            ),
            trackColor: MaterialStatePropertyAll(
              isClient! ? kPrimaryColor.withOpacity(0.2) : 
              kSoftGold.withOpacity(0.2)
            )
          )
        ),
        child: Scaffold(
          body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      "Detalhes do Processo",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  CustomRectangle(
                    color: isClient! ? Colors.white : kDarkGray,
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          status,
                          style: TextStyle(
                            color: isClient! ? Colors.grey.shade700 : kSoftGold,
                            fontSize: 14
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          startDate,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(
                              color:
                                  isClient! ? Colors.grey.shade300 : kSoftGold),
                        ),
                        Container(
                          height: 320,
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: isClient!
                                    ? Colors.grey.shade300
                                    : kSoftGold),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Scrollbar(
                            thumbVisibility: true,
                            trackVisibility: true,
                            thickness: 6,
                            radius: const Radius.circular(8),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildDetailRow('Nº do Processo', 'XXXXXXXXX'),
                                  _buildDetailRow('Marca', 'XXXXXXXXX'),
                                  _buildDetailRow('Situação', 'XXXXXXXXX'),
                                  _buildDetailRow('Apresentação', 'XXXXXXXXX'),
                                  _buildDetailRow('Natureza', 'XXXXXXXXX'),
                                  _buildDetailRow('Nº Classe', 'XXXXXXXXX'),
                                  _buildDetailRow(
                                      'Especificação da classe', 'XXXXXXXXX'),
                                  _buildDetailRow('Titular (es)', 'XXXXXXXXX'),
                                  _buildDetailRow(
                                      'Representante legal (Procurador)',
                                      'XXXXXXXXX'),
                                  _buildDetailRow(
                                      'Data de Depósito', 'XXXXXXXXX'),
                                  _buildDetailRow(
                                      'Data de Concessão', 'XXXXXXXXX'),
                                  _buildDetailRow(
                                      'Data de Vigência', 'XXXXXXXXX'),
                                  _buildDetailRow('Prazo Ordinário', 'XXXXXXXXX'),
                                  _buildDetailRow(
                                      'Prazo Extraordinário', 'XXXXXXXXX'),
                                  _buildDetailRow('Petições', 'XXXXXXXXX'),
                                  _buildDetailRow('Publicações', 'XXXXXXXXX'),
                                ],
                              ),
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
              fontSize: 14, color: isClient! ? kPrimaryColor : kSoftGold),
          children: [
            TextSpan(
                text: '$label: ',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
