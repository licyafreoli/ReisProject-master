import 'package:flutter/material.dart';
import 'package:reis_project/features/home/model/user_type.dart';
import 'package:reis_project/shared/colors.dart';
import 'package:reis_project/shared/custom_card.dart';

class HomeScreen extends StatelessWidget {

  final UserType userType;

  const HomeScreen({
    required this.userType,
    super.key
  });

  bool _isClient () {
    return userType == UserType.client;
  }

  bool _isCollaborator () {
    return userType == UserType.collaborator;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: _isClient() ? kSoftGold : kPrimaryColor,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: _isClient() ? kPrimaryColor : kSoftGold,
          )
        )
      ), 
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Início",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),

              CustomCard(
                title: _isClient() ? "5" : 
                _isCollaborator () ? "CEO" : "Jurídico", 
                icon: _isClient() ? Icons.list_alt_rounded : 
                Icons.person_outlined, 
                description:  _isClient() ? "Atualizações sobre seu processo" : 
                _isCollaborator () ? "Tipo de Colaborador" :
                "Tipo de Parceiro",
                isClient: _isClient(),
              ),

              const SizedBox(height: 20),

              CustomCard(
                title: _isClient() ? "7" : 
                _isCollaborator () ? "5" : "6",
                icon: _isClient() ? Icons.calendar_today_rounded :
                Icons.groups_outlined, 
                description: _isClient() ? "Meses para o fim do contrato" : 
                "Quantidade de Clientes",
                isClient: _isClient(),
              ),

              const SizedBox(height: 20),
              
              CustomCard(
                title: _isClient() ? "5" : 
                _isCollaborator () ? "3" : "4",
                icon: _isClient() ? Icons.layers_outlined :
                Icons.group_add_outlined, 
                description:  _isClient() ? "Quantidade de processos" : 
                "Atualização de Clientes",
                isClient: _isClient(),
              ),

              const SizedBox(height: 20),

              CustomCard(
                title: "3",
                icon: Icons.check_box_outlined, 
                description: "Processos finalizados",
                isClient: _isClient(),
              ),

            ],
          ),
        ),
      )
    );
  }

}