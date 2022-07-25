import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_list_screen_state.dart';

class ProductsListScreenCubit extends Cubit<ProductsListScreenState> {
  ProductsListScreenCubit() : super(ProductsListScreenInitial());
}
