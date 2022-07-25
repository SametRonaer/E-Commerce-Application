import 'package:alfa_application/data/model/second_category_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'second_category_state.dart';

class SecondCategoryCubit extends Cubit<SecondCategoryState> {
  SecondCategoryCubit() : super(SecondCategoryInitial()) {
    _secondCategoryCollection = _firestore.collection("SecondCategories");
    getAllSecondCategories();
  }

  final _firestore = FirebaseFirestore.instance;
  late CollectionReference _secondCategoryCollection;
  SecondCategoryModel? _selectedSecondCategory;
  List<SecondCategoryModel> _allSecondCategories = [];
  List<SecondCategoryModel> _filteredSecondCategories = [];

  List<SecondCategoryModel> get allSecondCategories => _allSecondCategories;
  List<SecondCategoryModel> get filteredSecondCategories =>
      _filteredSecondCategories;
  SecondCategoryModel? get selectedSecondCategory => _selectedSecondCategory;

  Future<void> getAllSecondCategories() async {
    emit(SecondCategoryLoading());
    _allSecondCategories.clear();
    QuerySnapshot querySnapshot = await _secondCategoryCollection.get();
    final allSecondCategoriesData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allSecondCategoriesData.forEach((employeeData) {
      SecondCategoryModel secondCategory =
          SecondCategoryModel.fromMap(employeeData as Map<String, dynamic>);
      _allSecondCategories.add(secondCategory);
    });
    emit(SecondCategoryLoaded());
  }

  Future<void> getSecondCategoryById({required String secondCategoryId}) async {
    emit(SecondCategoryLoading());
    DocumentSnapshot secondCategoryData =
        await _secondCategoryCollection.doc(secondCategoryId).get();
    SecondCategoryModel secondCategory = SecondCategoryModel.fromMap(
        secondCategoryData.data() as Map<String, dynamic>);
    _selectedSecondCategory = secondCategory;
    emit(SecondCategoryLoaded());
  }

  Future<void> addNewSecondCategory(SecondCategoryModel secondCategory) async {
    emit(SecondCategoryLoading());
    String secondCategoryId = DateTime.now().millisecondsSinceEpoch.toString();
    secondCategory.secondCategoryId = secondCategoryId;
    await _secondCategoryCollection
        .doc(secondCategoryId)
        .set(secondCategory.toMap());
    emit(SecondCategoryLoaded());
    ;
  }

  Future<void> deleteSecondCategory(String secondCategoryId) async {
    emit(SecondCategoryLoading());
    await _secondCategoryCollection.doc(secondCategoryId).delete();
    await getAllSecondCategories();
    emit(SecondCategoryLoaded());
  }

  Future<void> updateSecondCategory(
      {required Map<String, dynamic> newData,
      required String secondCategoryId}) async {
    emit(SecondCategoryLoading());
    await _secondCategoryCollection.doc(secondCategoryId).update(newData);
    emit(SecondCategoryLoaded());
  }

  setSelectedSecondCategory(SecondCategoryModel secondCategoryModel) {
    emit(SecondCategoryLoading());
    _selectedSecondCategory = secondCategoryModel;
    emit(SecondCategoryLoaded());
  }
}
