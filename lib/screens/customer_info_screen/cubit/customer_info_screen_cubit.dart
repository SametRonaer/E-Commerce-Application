import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'customer_info_screen_state.dart';

class CustomerInfoScreenCubit extends Cubit<CustomerInfoScreenState> {
  CustomerInfoScreenCubit() : super(CustomerInfoScreenInitial());
}
