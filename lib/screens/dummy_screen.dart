import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/category_model.dart';
import 'package:alfa_application/data/model/collection_model.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/employee_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/general_cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/general_cubits/employee_cubit/cubit/employee_cubit.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({Key? key}) : super(key: key);
  static const routeName = "/dummyScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            return BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context.read<AuthCubit>().signInUser(
                                  "samet@gmail.com", "Samet.123", context);
                            },
                            child: Text("Sign In")),
                        SizedBox(height: 50),
                        ElevatedButton(
                            onPressed: () {
                              context.read<EmployeeCubit>().getAllEmployees();
                            },
                            child: Text("Get All Employees")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<AuthCubit>().addNewUser(
                                  EmployeeModel(
                                      employeePhone: "",
                                      userType: UserTypes.Employee.toString(),
                                      employeeEmail: "samet@hotmail.com",
                                      employeePassword: "Samet.123",
                                      employeeName: "Samet",
                                      employeeSurName: "Ronaer",
                                      employeeCode: "sa",
                                      employeeId: "",
                                      employeeImageUrl: "Deneme",
                                      employeeStatus: "1"));
                            },
                            child: Text("Add New Employee")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<EmployeeCubit>()
                                  .deleteEmployee("1647020119895");
                            },
                            child: Text("Delete Employee")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<EmployeeCubit>().updateEmployee(
                                  newData: {"employeeName": "Mesut"},
                                  employeeId: "1647020119895");
                            },
                            child: Text("Update Employee")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<EmployeeCubit>()
                                  .getEmployeeById(employeeId: "1647020119895");
                            },
                            child: Text("Get Employee By Id")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<EmployeeCubit>().getEmployeesByEmail(
                                  email: "samet@hotmail.com");
                            },
                            child: Text("Get Employees By Email")),
                        SizedBox(height: 200),
                        ElevatedButton(
                            onPressed: () {
                              context.read<CustomersCubit>().getAllCustomers();
                            },
                            child: Text("Get All Customers")),
                        ElevatedButton(
                            onPressed: () {
                              // context.read<AuthCubit>().addNewUser(CustomerModel(
                              //     customerCartProducts: [],
                              //     userType: UserTypes.Customer.toString(),
                              //     userName: "Onur",
                              //     userSurName: "İyidir",
                              //     userEmail: "gurnet@gurnet.com.tr",
                              //     userPassword: "Onur.123",
                              //     userId: "",
                              //     customeCode: "12",
                              //     customeGroup: "Standart",
                              //     customerAdress:
                              //         "Cumhuriyet Mah. Avrupa Cad. Beykent Keleş Plaza Kat:4 No: 67 - 68",
                              //     customerCity: "İstanbul",
                              //     customerCompanyMailAdress:
                              //         "gurnet@gurnet.com.tr",
                              //     customerCompanyMobilePhoneNumber:
                              //         "+905448726622",
                              //     customerCompanyPhoneNumber: "+902128726622",
                              //     customerCompanyTitle: "Project Manager",
                              //     customerCompanyWebsite: "www.gurnet.com",
                              //     customerCountry: "Turkey",
                              //     customerId: "123",
                              //     customerMobilePhoneNumber: "+05326060034",
                              //     customerPhoneNumber: "",
                              //     customerCompanyName: "Gürnet",
                              //     customerImageUrl: "",
                              //     customerFavoriteProductIds: [],
                              //     customerTransactions: []));
                            },
                            child: Text("Add New Customer")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CustomersCubit>()
                                  .deleteCustomer("1646975458295");
                            },
                            child: Text("Delete Customer")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<CustomersCubit>().updateCustomer(
                                  newData: {"customerCompanyName": "Microsoft"},
                                  userId: "1646975458295");
                            },
                            child: Text("Update Customer")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CustomersCubit>()
                                  .getCustomerById(customerId: "1646975539378");
                            },
                            child: Text("Get Customer By Id")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<CustomersCubit>()
                                  .getCustomersByCompanyName(
                                      companyName: "Google");
                            },
                            child: Text("Get Customers By CompanyName")),
                        SizedBox(height: 200),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TransactionsCubit>()
                                  .getAllTransactions();
                            },
                            child: Text("Get All Transactions")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TransactionsCubit>()
                                  .addNewTransacation(
                                      transaction: TransactionModel(
                                          transactionDetails: [],
                                          productsInfo: ["21 Ayar | 123gr"],
                                          customerId: "124",
                                          transactionId: "",
                                          transactionDate:
                                              DateTime.now().toString(),
                                          transactionTotalAmount: "2380",
                                          transactionProductIds: [
                                            "12",
                                            "15",
                                            "17"
                                          ],
                                          transactionStatus: 1));
                            },
                            child: Text("Add New Transaction")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TransactionsCubit>()
                                  .updateTransaction(
                                      newData: {"transactionStatus": "Paid"},
                                      transactionId: "1646876934875");
                            },
                            child: Text("Update Transaction")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TransactionsCubit>()
                                  .deleteTransaction(
                                      transactionId: "1646876952512");
                            },
                            child: Text("Delete Transaction")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TransactionsCubit>()
                                  .getTransactionsByCustomerId(
                                      customerId: "124");
                            },
                            child: Text("Get Transactions By Customer Id")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TransactionsCubit>()
                                  .getTransactionsByStatus(status: 1.0);
                            },
                            child: Text("Get Transactions By Status")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<TransactionsCubit>()
                                  .getTransactionById(
                                      transactionId: "1646876934875");
                            },
                            child: Text("Get Transaction By Id")),
                        SizedBox(height: 200),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().getAllCollections();
                            },
                            child: Text("Get all collections")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .getCollectionByCollectionId(
                                      collectionId: "3j6Oraktm5ocVXoBrf4V");
                            },
                            child: Text("Get CollectionById")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .getCollectionByCollectionTitle(
                                      collectionTitle: "Elit");
                            },
                            child: Text("Get Collection ByTitle")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().addNewCollection(
                                  collection: CollectionModel(
                                      collectionId: "1",
                                      collectionTitle: "Işıltı",
                                      collectionDescription:
                                          "Collection description",
                                      collectionImageUrl:
                                          "https://imgcdn.hediyehanem.com/Image/1024x1024/ProductImages/144125-1-favori-3-sirali-suyolu-tasli-altin-set-afcd8.jpg"));
                            },
                            child: Text("Add New Collection")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().updateCollection(
                                  newData: {"collectionTitle": "Mine"},
                                  collectionId: "1646874526489");
                            },
                            child: Text("Update Colleciton")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().deleteCollection(
                                  collectionId: "1646874526489");
                            },
                            child: Text("Delete Collection")),
                        SizedBox(height: 200),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().getAllCategories();
                            },
                            child: Text("Get all categories")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().addNewCategory(
                                  category: CategoryModel(
                                      categoryId: "2",
                                      categoryTitle: "Kelepçe",
                                      categoryImageUrl:
                                          "https://i01.sozcucdn.com/wp-content/uploads/2020/07/09/iecrop/altin4_16_9_1594271595.jpg"));
                            },
                            child: Text("Add new category")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().updateCategory(
                                  newData: {"categoryImageUrl": "Deneme2"},
                                  categoryId: "Deneme");
                            },
                            child: Text("Update category")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .deleteCategory(categoryId: "Deneme");
                            },
                            child: Text("Delete category")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .getCategoryByCategoryId(
                                      categoryId: "1646868835063");
                            },
                            child: Text("Get category by id")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .getCategoryByCategoryTitle(
                                      categoryTitle: "Kolyeler");
                            },
                            child: Text("Get category by title")),
                        SizedBox(height: 200),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().getAllProducts();
                            },
                            child: Text("Get all products")),
                        ElevatedButton(
                            onPressed: () {
                              context.read<ProductsCubit>().addNewProduct(
                                  product: ProductModel(
                                      productColorType:
                                          ProductColours.Gold.toString(),
                                      goldPercent: ProductGoldPercents
                                          .TwentyFour.toString(),
                                      productWeight: 10,
                                      productHeight: 10,
                                      productWidth: 2,
                                      productRadius: 15,
                                      productId: "2",
                                      collectionId: "2",
                                      categoryId: "1",
                                      productTitle: "Kelepce13"));
                            },
                            child: Text("Add New Product")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .updateProduct(productId: "2", newData: {
                                "productGoldPercent": [1, 2]
                              });
                            },
                            child: Text("Update Product")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .deleteProduct(productId: "Deneme2");
                            },
                            child: Text("Delete Product")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .getProductWithId(productId: "1646792797375");
                            },
                            child: Text("Get Product With Id")),
                        ElevatedButton(
                            onPressed: () {
                              // context
                              //     .read<ProductsCubit>()
                              //     .getProductsWithCategoryId(categoryId: "1");
                            },
                            child: Text("Get Products With CategoryId")),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<ProductsCubit>()
                                  .getProductsWithCollectionId(
                                      collectionId: "2");
                            },
                            child: Text("Get Products With CollectionId")),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
