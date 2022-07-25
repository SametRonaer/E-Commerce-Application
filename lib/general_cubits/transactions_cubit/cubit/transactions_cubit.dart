import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  final _firestore = FirebaseFirestore.instance;
  late CollectionReference _transactionsCollection;

  TransactionModel? _selectedTransaction;
  List<TransactionModel> _allTransactions = [];
  List<TransactionModel> _filteredTransactions = [];

  List<TransactionModel> get allTransactions => _allTransactions;
  List<TransactionModel> get filteredTransactions => _filteredTransactions;
  TransactionModel? get selectedTransaction => _selectedTransaction;

  setSelectedTransaction(TransactionModel transactionModel) {
    _selectedTransaction = transactionModel;
    emit(TransactionsLoaded());
  }

  TransactionsCubit() : super(TransactionsInitial()) {
    _transactionsCollection = _firestore.collection("Transactions");
  }

  Future<void> getAllTransactions() async {
    emit(TransactionsLoading());
    QuerySnapshot querySnapshot = await _transactionsCollection.get();
    _allTransactions.clear();
    final allTransactionsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allTransactionsData.forEach((transactionData) {
      TransactionModel transaction =
          TransactionModel.fromMap(transactionData as Map<String, dynamic>);
      _allTransactions.add(transaction);
    });
    _allTransactions.forEach(
      (element) => print(element.transactionStatus),
    );

    emit(TransactionsLoaded());
  }

  Future<void> getTransactionsByCustomerId({required String customerId}) async {
    emit(TransactionsLoading());
    QuerySnapshot querySnapshot = await _transactionsCollection
        .where("customerId", isEqualTo: customerId)
        .get();
    _filteredTransactions.clear();
    final filteredTransactionsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredTransactionsData.forEach((productData) {
      TransactionModel transaction =
          TransactionModel.fromMap(productData as Map<String, dynamic>);
      _filteredTransactions.add(transaction);
    });
    _filteredTransactions
        .forEach((element) => print(element.transactionStatus));
    _filteredTransactions.sort((a, b) => (DateTime.parse(a.transactionDate)
            .microsecondsSinceEpoch)
        .compareTo(DateTime.parse(b.transactionDate).microsecondsSinceEpoch));
    _filteredTransactions = _filteredTransactions.reversed.toList();
    emit(TransactionsLoaded());
  }

  Future<void> getTransactionsByStatus({required double status}) async {
    emit(TransactionsLoading());
    QuerySnapshot querySnapshot = await _transactionsCollection
        .where("transactionStatus", isEqualTo: status)
        .get();
    _filteredTransactions.clear();
    final filteredTransactionsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredTransactionsData.forEach((productData) {
      TransactionModel transaction =
          TransactionModel.fromMap(productData as Map<String, dynamic>);
      _filteredTransactions.add(transaction);
    });
    _filteredTransactions
        .forEach((element) => print(element.transactionStatus));
    _filteredTransactions.sort((a, b) => (DateTime.parse(a.transactionDate)
            .microsecondsSinceEpoch)
        .compareTo(DateTime.parse(b.transactionDate).microsecondsSinceEpoch));
    _filteredTransactions = _filteredTransactions.reversed.toList();
    print("Length is ${_filteredTransactions.length}");
    emit(TransactionsLoaded());
  }

  Future<void> getTransactionById({required String transactionId}) async {
    emit(TransactionsLoading());
    DocumentSnapshot transactionData =
        await _transactionsCollection.doc(transactionId).get();
    TransactionModel transaction = TransactionModel.fromMap(
        transactionData.data() as Map<String, dynamic>);
    _selectedTransaction = transaction;
    print(_selectedTransaction!.customerId);
    emit(TransactionsLoaded());
  }

  Future<void> addNewTransacation(
      {required TransactionModel transaction}) async {
    emit(TransactionsLoading());
    String transactionId = DateTime.now().millisecondsSinceEpoch.toString();
    transaction.transactionId = transactionId;
    await _transactionsCollection.doc(transactionId).set(transaction.toMap());
    emit(TransactionsLoaded());
  }

  Future<void> updateTransaction(
      {required Map<String, dynamic> newData,
      required String transactionId}) async {
    emit(TransactionsLoading());
    await _transactionsCollection.doc(transactionId).update(newData);
    await getAllTransactions();
    emit(TransactionsLoaded());
  }

  Future<void> deleteTransaction({required String transactionId}) async {
    emit(TransactionsLoading());
    await _transactionsCollection.doc(transactionId).delete();
    emit(TransactionsLoaded());
  }
}
