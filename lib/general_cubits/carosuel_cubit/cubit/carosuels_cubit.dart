import 'package:alfa_application/data/model/carosuel_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'carosuels_state.dart';

class CarosuelsCubit extends Cubit<CarosuelsState> {
  CarosuelsCubit() : super(CarosuelsInitial()) {
    _carosuelsCollection = _firestore.collection("Carosuels");
    getAllCarosuels();
  }

  final _firestore = FirebaseFirestore.instance;
  late CollectionReference _carosuelsCollection;
  CarosuelModel? _selectedCarosuel;
  List<CarosuelModel> _allCarosuels = [];
  List<CarosuelModel> _filteredCarosuels = [];

  List<CarosuelModel> get allCarosuels => _allCarosuels;
  List<CarosuelModel> get filteredCarosuels => _filteredCarosuels;
  CarosuelModel? get selectedCarosuel => _selectedCarosuel;

  Future<void> getAllCarosuels() async {
    emit(CarosuelsLoading());
    _allCarosuels.clear();
    QuerySnapshot querySnapshot = await _carosuelsCollection.get();
    final allCarosuelsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allCarosuelsData.forEach((carosuelData) {
      CarosuelModel carosuel =
          CarosuelModel.fromMap(carosuelData as Map<String, dynamic>);
      _allCarosuels.add(carosuel);
    });
    emit(CarosuelsLoaded());
  }

  // Future<void> getSecondCarosuelById({required String secondCategoryId}) async {
  //  emit(CarosuelsLoading());
  //   DocumentSnapshot secondCategoryData =
  //       await _carosuelsCollection.doc(secondCategoryId).get();
  //   SecondCategoryModel secondCategory = SecondCategoryModel.fromMap(
  //       secondCategoryData.data() as Map<String, dynamic>);
  //   _selectedCarosuel = secondCategory;
  //    emit(CarosuelsLoaded());
  // }

  Future<void> addNewCarosuel(CarosuelModel carosuel) async {
    emit(CarosuelsLoading());
    String carosuelId = DateTime.now().millisecondsSinceEpoch.toString();
    carosuel.carosuelId = carosuelId;
    await _carosuelsCollection.doc(carosuelId).set(carosuel.toMap());
    emit(CarosuelsLoaded());
  }

  Future<void> deleteCarosuel(String carosuelId) async {
    emit(CarosuelsLoading());
    await _carosuelsCollection.doc(carosuelId).delete();
    await getAllCarosuels();
    emit(CarosuelsLoaded());
  }

  // Future<void> updateCarosuel(
  //     {required Map<String, dynamic> newData,
  //     required String secondCategoryId}) async {
  //  emit(CarosuelsLoading());
  //   await _carosuelsCollection.doc(secondCategoryId).update(newData);
  //  emit(CarosuelsLoaded());
  // }

  // setSelectedSecondCategory(SecondCategoryModel secondCategoryModel) {
  //   emit(CarosuelsLoading());
  //   _selectedCarosuel = secondCategoryModel;
  //    emit(CarosuelsLoaded());
  // }
}
