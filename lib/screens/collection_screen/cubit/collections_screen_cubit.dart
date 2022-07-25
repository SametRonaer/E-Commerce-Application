import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'collections_screen_state.dart';

class CollectionsScreenCubit extends Cubit<CollectionsScreenState> {
  CollectionsScreenCubit() : super(CollectionsScreenInitial());
}
