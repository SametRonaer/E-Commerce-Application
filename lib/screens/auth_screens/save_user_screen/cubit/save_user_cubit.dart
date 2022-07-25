import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'save_user_state.dart';

class SaveUserCubit extends Cubit<SaveUserState> {
  SaveUserCubit() : super(SaveUserInitial());
}
