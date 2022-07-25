import 'package:alfa_application/data/model/employee_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final _firestore = FirebaseFirestore.instance;
  late CollectionReference _employeesCollection;
  EmployeeModel? _selectedEmployee;
  List<EmployeeModel> _allEmployees = [];
  List<EmployeeModel> _filteredEmployees = [];

  List<EmployeeModel> get allEmployees => _allEmployees;
  List<EmployeeModel> get filteredEmployees => _filteredEmployees;
  EmployeeModel? get selectedEmployee => _selectedEmployee;

  EmployeeCubit() : super(EmployeeInitial()) {
    _employeesCollection = _firestore.collection("Employees");
  }

  Future<void> getAllEmployees() async {
    emit(EmployeeLoading());
    _allEmployees.clear();
    QuerySnapshot querySnapshot = await _employeesCollection.get();
    final allEmployeesData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    allEmployeesData.forEach((employeeData) {
      EmployeeModel employee =
          EmployeeModel.fromMap(employeeData as Map<String, dynamic>);
      _allEmployees.add(employee);
    });
    _allEmployees.forEach(
      (element) => print(element.employeeName),
    );
    emit(EmployeeLoaded());
  }

  Future<void> getEmployeeById({required String employeeId}) async {
    emit(EmployeeLoading());
    DocumentSnapshot employeeData =
        await _employeesCollection.doc(employeeId).get();
    EmployeeModel employee =
        EmployeeModel.fromMap(employeeData.data() as Map<String, dynamic>);
    _selectedEmployee = employee;
    print(_selectedEmployee!.employeeName);
    emit(EmployeeLoaded());
  }

  Future<void> getEmployeesByEmail({required String email}) async {
    _filteredEmployees.clear();
    emit(EmployeeLoading());
    QuerySnapshot querySnapshot = await _employeesCollection
        .where("employeeEmail", isEqualTo: email)
        .get();
    final filteredEmployeesData =
        querySnapshot.docs.map((doc) => doc.data()).toList();
    filteredEmployeesData.forEach((employeeData) {
      EmployeeModel employee =
          EmployeeModel.fromMap(employeeData as Map<String, dynamic>);
      _filteredEmployees.add(employee);
    });
    _filteredEmployees.forEach((element) => print(element.employeeName));
    emit(EmployeeLoaded());
  }

  Future<void> addNewEmployee(EmployeeModel employee) async {
    emit(EmployeeLoading());
    String employeeId = DateTime.now().millisecondsSinceEpoch.toString();
    employee.employeeId = employeeId;
    await _employeesCollection.doc(employeeId).set(employee.toMap());
    emit(EmployeeLoaded());
  }

  Future<void> deleteEmployee(String employeeId) async {
    emit(EmployeeLoading());
    await _employeesCollection.doc(employeeId).delete();
    await getAllEmployees();
    emit(EmployeeLoaded());
  }

  Future<void> updateEmployee(
      {required Map<String, dynamic> newData,
      required String employeeId}) async {
    emit(EmployeeLoading());
    await _employeesCollection.doc(employeeId).update(newData);
    emit(EmployeeLoaded());
  }

  setSelectedEmployee(EmployeeModel employeeModel) {
    emit(EmployeeLoading());
    _selectedEmployee = employeeModel;
    emit(EmployeeLoaded());
  }
}
