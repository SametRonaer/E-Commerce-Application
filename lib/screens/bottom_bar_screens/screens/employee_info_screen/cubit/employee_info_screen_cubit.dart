import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'employee_info_screen_state.dart';

class EmployeeInfoScreenCubit extends Cubit<EmployeeInfoScreenState> {
  EmployeeInfoScreenCubit() : super(EmployeeInfoScreenInitial());
}
