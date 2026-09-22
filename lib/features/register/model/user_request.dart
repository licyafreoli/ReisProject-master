import 'package:reis_project/features/home/model/user_type.dart';
import 'package:reis_project/features/register/model/user_data.dart';

class UserRequest {
  final String password;
  final UserType registrationType;
  final PersonalData? personalData;
  final BusinessData? businessData;
  

  const UserRequest({
    required this.password,
    required this.registrationType,
    this.personalData,
    this.businessData
  });
}
