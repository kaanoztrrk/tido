import '../user_model/user_model.dart';

class OtpRouteArguments {
  final UserModel userModel;
  final String password;

  OtpRouteArguments({required this.userModel, required this.password});
}
