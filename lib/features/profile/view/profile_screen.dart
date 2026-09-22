import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reis_project/shared/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final bool? isClient;

  const CustomButton({
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.isClient = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: isClient! ? Colors.white : kSoftGold, size: 20),
        label: Text(
          text,
          style: TextStyle(
            color: isClient! ? Colors.white : kSoftGold,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isClient!
              ? (backgroundColor ?? const Color(0xFF424242))
              : kDarkGray,
          disabledBackgroundColor:
              isClient! ? Colors.grey.shade400 : kDarkGray.withAlpha(100),
          disabledForegroundColor:
              isClient! ? Colors.white70 : kSoftGold.withAlpha(100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
            side: isClient!
                ? BorderSide.none
                : const BorderSide(color: kSoftGold, width: 1.5),
          ),
          elevation: 2,
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  final bool? isClient;

  const ProfileScreen({this.isClient = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        scaffoldBackgroundColor: isClient! ? kSoftGold : kPrimaryColor,
        textTheme: TextTheme(
            bodyMedium:
                TextStyle(color: isClient! ? kPrimaryColor : kSoftGold)),
        appBarTheme: AppBarTheme(
          backgroundColor: isClient! ? kSoftGold : kPrimaryColor,
          elevation: 0,
          iconTheme:
              IconThemeData(color: isClient! ? kPrimaryColor : kSoftGold),
          titleTextStyle: TextStyle(
              color: isClient! ? kPrimaryColor : kSoftGold,
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'Meu perfil',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                color: isClient! ? kPrimaryColor : kSoftGold,
              ),
            ),
            bottom: TabBar(
              labelColor: isClient! ? kPrimaryColor : kSoftGold,
              unselectedLabelColor: isClient! ? kPrimaryColor : kSoftGold,
              indicatorColor: isClient! ? kPrimaryColor : kSoftGold,
              tabs: const [
                Tab(text: 'Dados empresariais'),
                Tab(text: 'Dados pessoais'),
              ],
            ),
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert,
                    color: isClient! ? kPrimaryColor : kSoftGold),
                color: isClient! ? Colors.white : kDarkGray,
                onSelected: (value) {},
                itemBuilder: (BuildContext context) {
                  return <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      enabled: false,
                      child: Text('Menu',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isClient! ? Colors.black : kSoftGold)),
                    ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'Ajuda',
                      child: Text('Ajuda',
                          style: TextStyle(
                              color: isClient! ? kPrimaryColor : kSoftGold)),
                    ),
                    PopupMenuItem<String>(
                      value: 'Política de Privacidade',
                      child: Text('Política de Privacidade',
                          style: TextStyle(
                              color: isClient! ? kPrimaryColor : kSoftGold)),
                    ),
                    PopupMenuItem<String>(
                      value: 'Sair',
                      child: Text('Sair',
                          style: TextStyle(
                              color: isClient! ? kPrimaryColor : kSoftGold)),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: TabBarView(
            children: [
              BusinessDataTab(isClient: isClient),
              PersonalDataTab(isClient: isClient),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileTextField extends StatelessWidget {
  final String title;
  final bool enabled;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final bool? isCpfOrCnpj;
  final bool? isClient;

  const ProfileTextField({
    super.key,
    required this.title,
    required this.enabled,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.isCpfOrCnpj = false,
    this.isClient = true,
  });

  @override
  Widget build(BuildContext context) {
    Color getFillColor() {
      if (!isClient!) {
        return kDarkGray;
      }
      // Lógica para cliente
      if (isCpfOrCnpj! || !enabled) {
        return Colors.grey.shade200;
      }
      return Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: isClient! ? kPrimaryColor : kSoftGold,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            enabled: isCpfOrCnpj! ? false : enabled,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              filled: true,
              fillColor: getFillColor(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: isClient! ? Colors.grey : kSoftGold),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: isClient! ? Colors.grey : kSoftGold),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                    color: isClient! ? Colors.grey : kSoftGold.withAlpha(150)),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 2),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            style: TextStyle(
              color: isClient! ? kPrimaryColor :
              !isClient! && enabled && !isCpfOrCnpj! ? Colors.white :
              kSoftGold
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileDropdown extends StatelessWidget {
  final bool enabled;
  final String value;
  final Function(String?) onChanged;
  final bool? isClient;

  const ProfileDropdown({
    super.key,
    required this.enabled,
    required this.value,
    required this.onChanged,
    this.isClient = true,
  });

  final List<String> _states = const [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];

  @override
  Widget build(BuildContext context) {
    Color getFillColor() {
      if (!isClient!) {
        return kDarkGray;
      }
      // Lógica para cliente
      return enabled ? Colors.white : Colors.grey.shade200;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "UF",
          style: TextStyle(
            color: isClient! ? kPrimaryColor : kSoftGold,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
        value: value,
        dropdownColor: isClient! ? Colors.white : kDarkGray,
        style: TextStyle(color: isClient! ? kPrimaryColor : kSoftGold),
        icon: const Icon(Icons.arrow_drop_down), // Ícone padrão
        iconEnabledColor: isClient! ? Colors.grey.shade800 : Colors.grey.shade400, // cor quando ATIVADO
        iconDisabledColor: isClient! ? Colors.grey.shade400 : Colors.grey.shade800, // cor quando DESATIVADO
        decoration: InputDecoration(
          filled: true,
          fillColor: getFillColor(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: isClient! ? Colors.grey : kSoftGold),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: isClient! ? Colors.grey : kSoftGold),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(color: isClient! ? Colors.grey : kSoftGold.withAlpha(150)),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: _states.map((String state) {
          return DropdownMenuItem(
            value: state,
            child: Text(
              state,
              style: TextStyle(
                color: isClient! ? kPrimaryColor :
                !isClient! && enabled ? Colors.white :
                kSoftGold
              ),
            ),
          );
        }).toList(),
        onChanged: enabled ? onChanged : null,
        disabledHint: Text(
          value,
          style: TextStyle(
            color: isClient! ? kPrimaryColor :
            !isClient! && enabled ? Colors.white :
            kSoftGold
          ),
        ),
      ),


      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? color;

  const ProfileButton({
    super.key,
    required this.text,
    this.onPressed,
    this.color = kPrimaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: onPressed == null ? Colors.grey : color,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// NOVO WIDGET LOCAL
class ProfileCustomRectangle extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool? isClient;

  const ProfileCustomRectangle({
    required this.child,
    this.padding,
    this.isClient = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isClient! ? Colors.white : kDarkGray,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}

class BusinessDataTab extends StatefulWidget {
  final bool? isClient;
  const BusinessDataTab({required this.isClient, super.key});

  @override
  State<BusinessDataTab> createState() => _BusinessDataTabState();
}

class _BusinessDataTabState extends State<BusinessDataTab>
    with AutomaticKeepAliveClientMixin<BusinessDataTab> {
  @override
  bool get wantKeepAlive => true;

  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  late TextEditingController _nomeController;
  late TextEditingController _cnpjController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _cepController;
  late TextEditingController _cidadeController;
  late TextEditingController _bairroController;
  late TextEditingController _logradouroController;
  late TextEditingController _numeroController;
  late TextEditingController _complementoController;
  String _uf = 'CE';

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: 'NovaTech Solutions');
    _cnpjController = TextEditingController(text: '36.536.148/0001-92');
    _emailController =
        TextEditingController(text: 'contato@empresaexemplo.com.br');
    _telefoneController = TextEditingController(text: '(85) 99999-8888');
    _cepController = TextEditingController(text: '60170-002');
    _cidadeController = TextEditingController(text: 'Fortaleza');
    _bairroController = TextEditingController(text: 'Meireles');
    _logradouroController = TextEditingController(text: 'Avenida Beira Mar');
    _numeroController = TextEditingController(text: '1234');
    _complementoController = TextEditingController(text: 'Andar 10');
  }

  @override
  void dispose() {
    _cnpjController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cepController.dispose();
    _cidadeController.dispose();
    _bairroController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Dados salvos com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
      child: ProfileCustomRectangle(
        // USO DO NOVO WIDGET
        isClient: widget.isClient,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          widget.isClient! ? Colors.grey.shade200 : kPrimaryColor,
                      radius: 30,
                      child: Icon(
                        Icons.apartment,
                        size: 40,
                        color: widget.isClient! ? kPrimaryColor : kSoftGold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nomeController.text,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  widget.isClient! ? kPrimaryColor : kSoftGold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _emailController.text,
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  widget.isClient! ? kPrimaryColor : kSoftGold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Nome',
                enabled: _isEditing,
                controller: _nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                isCpfOrCnpj: true,
                title: 'CNPJ',
                enabled: _isEditing,
                controller: _cnpjController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CnpjInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!UtilBrasilFields.isCNPJValido(value)) {
                    return 'CNPJ inválido';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'E-mail',
                enabled: _isEditing,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Telefone',
                enabled: _isEditing,
                controller: _telefoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: ProfileTextField(
                        isClient: widget.isClient,
                        title: 'CEP',
                        enabled: _isEditing,
                        controller: _cepController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter()
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(width: 16),
                  Expanded(
                      flex: 2,
                      child: ProfileDropdown(
                        isClient: widget.isClient,
                        enabled: _isEditing,
                        value: _uf,
                        onChanged: (value) {
                          setState(() {
                            _uf = value!;
                          });
                        },
                      )),
                ],
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Cidade',
                enabled: _isEditing,
                controller: _cidadeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Bairro',
                enabled: _isEditing,
                controller: _bairroController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Logradouro',
                enabled: _isEditing,
                controller: _logradouroController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: ProfileTextField(
                    isClient: widget.isClient,
                    title: 'Número',
                    enabled: _isEditing,
                    controller: _numeroController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      flex: 2,
                      child: ProfileTextField(
                        isClient: widget.isClient,
                        title: 'Complemento',
                        enabled: _isEditing,
                        controller: _complementoController,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isClient: widget.isClient,
                      text: 'EDITAR',
                      icon: Icons.edit,
                      onPressed: () => setState(() => _isEditing = true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      isClient: widget.isClient,
                      text: 'SALVAR',
                      icon: Icons.check_circle_outline,
                      onPressed: _isEditing ? _saveForm : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PersonalDataTab extends StatefulWidget {
  final bool? isClient;
  const PersonalDataTab({required this.isClient, super.key});

  @override
  State<PersonalDataTab> createState() => _PersonalDataTabState();
}

class _PersonalDataTabState extends State<PersonalDataTab>
    with AutomaticKeepAliveClientMixin<PersonalDataTab> {
  @override
  bool get wantKeepAlive => true;

  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  late TextEditingController _nomeController;
  late TextEditingController _cpfController;
  late TextEditingController _emailController;
  late TextEditingController _telefoneController;
  late TextEditingController _cepController;
  late TextEditingController _cidadeController;
  late TextEditingController _bairroController;
  late TextEditingController _logradouroController;
  late TextEditingController _numeroController;
  late TextEditingController _complementoController;
  String _uf = 'SP';

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: 'Fulano de Tal');
    _cpfController = TextEditingController(text: '624.687.963-22');
    _emailController = TextEditingController(text: 'fulano.tal@email.com');
    _telefoneController = TextEditingController(text: '(11) 98765-4321');
    _cepController = TextEditingController(text: '01001-000');
    _cidadeController = TextEditingController(text: 'Ceará');
    _bairroController = TextEditingController(text: 'Meireles');
    _logradouroController = TextEditingController(text: 'Avenida Beira Mar');
    _numeroController = TextEditingController(text: '1234');
    _complementoController = TextEditingController(text: 'Andar 10');
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _cpfController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _cepController.dispose();
    _cidadeController.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isEditing = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Dados salvos com sucesso!',
            style: TextStyle(
              color: widget.isClient! ? Colors.white : kSoftGold
            ),
          ),
          backgroundColor: widget.isClient! ? Colors.green : kDarkGray,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
      child: ProfileCustomRectangle(
        // USO DO NOVO WIDGET
        isClient: widget.isClient,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor:
                          widget.isClient! ? Colors.grey.shade200 : kPrimaryColor,
                      radius: 30,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: widget.isClient! ? kPrimaryColor : kSoftGold,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _nomeController.text,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color:
                                  widget.isClient! ? kPrimaryColor : kSoftGold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _emailController.text,
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  widget.isClient! ? kPrimaryColor : kSoftGold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Nome Completo',
                enabled: _isEditing,
                controller: _nomeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                isCpfOrCnpj: true,
                title: 'CPF',
                enabled: _isEditing,
                controller: _cpfController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  if (!UtilBrasilFields.isCPFValido(value)) {
                    return 'CPF inválido';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'E-mail',
                enabled: _isEditing,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Telefone',
                enabled: _isEditing,
                controller: _telefoneController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  TelefoneInputFormatter()
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      flex: 3,
                      child: ProfileTextField(
                        isClient: widget.isClient,
                        title: 'CEP',
                        enabled: _isEditing,
                        controller: _cepController,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CepInputFormatter()
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      )),
                  const SizedBox(width: 16),
                  Expanded(
                      flex: 2,
                      child: ProfileDropdown(
                        isClient: widget.isClient,
                        enabled: _isEditing,
                        value: _uf,
                        onChanged: (value) {
                          setState(() {
                            _uf = value!;
                          });
                        },
                      )),
                ],
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Cidade',
                enabled: _isEditing,
                controller: _cidadeController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Bairro',
                enabled: _isEditing,
                controller: _bairroController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              ProfileTextField(
                isClient: widget.isClient,
                title: 'Logradouro',
                enabled: _isEditing,
                controller: _logradouroController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                      child: ProfileTextField(
                    isClient: widget.isClient,
                    title: 'Número',
                    enabled: _isEditing,
                    controller: _numeroController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  )),
                  const SizedBox(width: 16),
                  Expanded(
                      flex: 2,
                      child: ProfileTextField(
                        isClient: widget.isClient,
                        title: 'Complemento',
                        enabled: _isEditing,
                        controller: _complementoController,
                      )),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isClient: widget.isClient,
                      text: 'EDITAR',
                      icon: Icons.edit,
                      onPressed: () => setState(() => _isEditing = true),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomButton(
                      isClient: widget.isClient,
                      text: 'SALVAR',
                      icon: Icons.check_circle_outline,
                      onPressed: _isEditing ? _saveForm : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
