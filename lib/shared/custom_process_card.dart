import 'package:flutter/material.dart';
import 'package:reis_project/features/processes/view/process_details.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_rectangle.dart';

class CustomProcessCard extends StatelessWidget {

  final String title;
  final int processNumber;
  final String status;
  final String startDate;
  final bool? isClient;

  const CustomProcessCard({
    required this.title,
    required this.processNumber,
    required this.status,
    required this.startDate,
    this.isClient = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: <Widget>[
          CustomRectangle(
            bordeusRadius: 20,
            color: isClient! ? Colors.white : kDarkGray,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  '$title | Nº $processNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(status),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    color: isClient! ? Colors.grey.shade300 : kSoftGold
                  ),
                ),
                InkWell(
                  onTap: () {

                    showModalBottomSheet(
                      context: context, 
                      isScrollControlled: true,
                      builder: (context) => DraggableScrollableSheet(
                        initialChildSize: 0.85,
                        maxChildSize: 0.95,
                        minChildSize: 0.5,
                        expand: false,
                        builder: (context, scrollController) {
                          return ProcessDetailsScreen(
                            title: title,
                            status: status,
                            startDate: startDate,
                            isClient: isClient,
                          );
                        }
                      )
                    );
                    /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProcessDetailsScreen(
                          title: title,
                          status: status,
                          startDate: startDate,
                          isClient: isClient,
                        ),
                      ),
                    );*/
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isClient! ? Colors.grey.shade400 : kSoftGold
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Início em: $startDate',),
                        const SizedBox(height: 2),
                        const Text(
                          'Clique aqui para ver detalhes',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )
    );
  }
}
