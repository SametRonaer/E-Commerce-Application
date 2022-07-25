import 'package:bloc/bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  Future<void> saveUserData(String email, String password) async {
    final box = GetStorage();
    await box.write("email", email);
    await box.write("password", password);
    print(email);
  }

  Future<void> deleteUserData() async {
    final box = GetStorage();
    await box.remove("email");
    await box.remove("password");
  }

  Map<String, String> getUserData() {
    final box = GetStorage();
    String? email = box.read("email");
    String? password = box.read("password");
    return {"email": email ?? "", "password": password ?? ""};
  }
}
