import 'package:flutter/material.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_process_card.dart';

class ProcessScreen extends StatelessWidget {

  final bool? isClient;

  const ProcessScreen({
    this.isClient = true,
    super.key
  });

 @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: isClient! ? kSoftGold : kPrimaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: isClient! ? kPrimaryColor : kSoftGold,
          )
        )
      ), 
      child: Scaffold(
        body: SingleChildScrollView(
          child:  Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    isClient! ? "Meus processos" : "Meus Clientes",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                ),

                CustomProcessCard(
                  title: "Marca X", 
                  processNumber: 123456789, 
                  status: "Aguardando pagamento da concessão (em prazo ordinário)", 
                  startDate: "02/05/2024",
                  isClient: isClient,
                )
              ],
            ),
          ),
        )
      )
    );
  }

}