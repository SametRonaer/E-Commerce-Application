import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'products_edit_list_state.dart';

class ProductsEditListCubit extends Cubit<ProductsEditListState> {
  ProductsEditListCubit() : super(ProductsEditListInitial());
}
