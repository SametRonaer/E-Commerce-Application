import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  Future<void> sendPasswordToChange(String password)async{
    emit(ChangePasswordLoading());
    await Future.delayed(Duration(seconds: 3));
    emit(ChangePasswordSuccess());
  }
}
