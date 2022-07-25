import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../data/model/customer_model.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final _firestore = FirebaseFirestore.instance;
  late CollectionReference _customersCollection;
  CustomerModel? _selectedCustomer;
  CustomerModel? _customerProfile;
  List<CustomerModel> _allCustomers = [];
  List<CustomerModel> _filteredCustomers = [];

  List<CustomerModel> get allCustomers => _allCustomers;
  List<CustomerModel> get filteredCustomers => _filteredCustomers;
  CustomerModel? get selectedCustomer => _selectedCustomer;
  CustomerModel? get customerProfile => _customerProfile;

  CustomersCubit() : super(CustomersInitial()) {
    _customersCollection = _firestore.collection("Customers");
  }

  Future<void> getAllCustomers() async {
    emit(CustomersLoading());
    _allCustomers.clear();
    QuerySnapshot querySnapshot = await _customersCollection.get();
    final allTransactionsData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allTransactionsData.forEach((customerData) {
      CustomerModel customer =
          CustomerModel.fromMap(customerData as Map<String, dynamic>);
      _allCustomers.add(customer);
    });

    emit(CustomersLoaded());
  }

  setSelectedCustomer(CustomerModel customer) {
    emit(CustomersLoading());
    _selectedCustomer = customer;
    emit(CustomersLoaded());
  }

  setCustomerProfile(CustomerModel customer) {
    emit(CustomersLoading());
    _customerProfile = customer;
    emit(CustomersLoaded());
  }

  Future<void> addNewCustomer(CustomerModel customer) async {
    emit(CustomersLoading());
    String customerId = DateTime.now().millisecondsSinceEpoch.toString();
    customer.userId = customerId;
    try {
      await _customersCollection.doc(customerId).set(customer.toMap());
    } catch (e) {
      print(e);
    }
    emit(CustomersLoaded());
  }

  Future<void> deleteCustomer(String customerId) async {
    emit(CustomersLoading());
    await _customersCollection.doc(customerId).delete();
    await getAllCustomers();
    emit(CustomersLoaded());
  }

  Future<void> updateCustomer(
      {required Map<String, dynamic> newData, required String userId}) async {
    emit(CustomersLoading());
    await _customersCollection.doc(userId).update(newData);
    emit(CustomersLoaded());
  }

  Future<void> getCustomerById({required String customerId}) async {
    emit(CustomersLoading());
    DocumentSnapshot customerData =
        await _customersCollection.doc(customerId).get();
    CustomerModel customer =
        CustomerModel.fromMap(customerData.data() as Map<String, dynamic>);
    _selectedCustomer = customer;
    print(_selectedCustomer!.customerCompanyName);
    emit(CustomersLoaded());
  }

  Future<void> getCustomersByCompanyName({required String companyName}) async {
    _filteredCustomers.clear();
    emit(CustomersLoading());
    QuerySnapshot querySnapshot = await _customersCollection
        .where("customerCompanyName", isEqualTo: companyName)
        .get();
    final filteredCustomersData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredCustomersData.forEach((customerData) {
      CustomerModel customer =
          CustomerModel.fromMap(customerData as Map<String, dynamic>);
      _filteredCustomers.add(customer);
    });
    _filteredCustomers.forEach((element) => print(element.userId));
    emit(CustomersLoaded());
  }

  Future<void> getCustomersByEmail({required String email}) async {
    _filteredCustomers.clear();
    emit(CustomersLoading());
    QuerySnapshot querySnapshot =
        await _customersCollection.where("userEmail", isEqualTo: email).get();
    final filteredCustomersData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredCustomersData.forEach((customerData) {
      CustomerModel customer =
          CustomerModel.fromMap(customerData as Map<String, dynamic>);
      _filteredCustomers.add(customer);
    });
    emit(CustomersLoaded());
  }
}
