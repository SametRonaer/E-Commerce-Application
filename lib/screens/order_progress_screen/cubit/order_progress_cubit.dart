import 'dart:developer';

import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/notification_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/general_cubits/auth_cubit/cubit/auth_cubit.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/general_cubits/notification_cubit/cubit/notification_cubit.dart';
import 'package:alfa_application/general_cubits/products_cubit/cubit/products_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/screens/bottom_bar_screens/screens/employee_home_screen/cubit/employee_home_screen_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'order_progress_state.dart';

class OrderProgressCubit extends Cubit<OrderProgressState> {
  OrderProgressCubit() : super(OrderProgressInitial());
  List<ProductModel> _orderProducts = [];
  List<ProductModel> get orderProducts => _orderProducts;
  CustomerModel? _transactionCustomer;
  CustomerModel? get transactionCustomer => _transactionCustomer;

  Future<void> updateOrderStatus(double statusId, BuildContext context) async {
    emit(OrderProgressLoading());
    List<dynamic> transactionDetails = context
        .read<TransactionsCubit>()
        .selectedTransaction!
        .transactionDetails
        .map((e) => e.toMap())
        .toList();
    transactionDetails.add(TransactionDetailModel(
      transactionType: statusId.toInt(),
      employeeNameWhoEdit:
          '${context.read<ProfileCubit>().userProfile!.name} ${context.read<ProfileCubit>().userProfile!.surName}',
      employeeIdWhoEdit: "121323",
      editDate: DateTime.now(),
    ).toMap());
    String transactionId =
        context.read<TransactionsCubit>().selectedTransaction!.transactionId;
    await context.read<TransactionsCubit>().updateTransaction(newData: {
      "transactionStatus": statusId,
      "transactionDetails": transactionDetails
    }, transactionId: transactionId);
    await _addNotificationToCustomer(
        context, kTransactionProgressStepLabels[statusId.toInt()]);
    await context.read<NotificationCubit>().sendNotificationToUser(
        userFcm: _transactionCustomer!.fcm,
        title: "Order Status Updated",
        message: kTransactionProgressStepLabels[statusId.toInt()]);
    await context.read<TransactionsCubit>().getAllTransactions();
    await context.read<EmployeeHomeScreenCubit>().refreshOrders(context);
    await context
        .read<TransactionsCubit>()
        .getTransactionById(transactionId: transactionId);
    emit(OrderProgressLoaded());
  }

  Future<void> getOrderProducts(BuildContext context) async {
    _orderProducts.clear();
    List<String> productIds = context
        .read<TransactionsCubit>()
        .selectedTransaction!
        .transactionProductIds
        .map((e) => e.toString())
        .toList();

    await Future.forEach(productIds, (element) async {
      await context
          .read<ProductsCubit>()
          .getProductWithId(productId: element.toString());
      ProductModel productModel =
          context.read<ProductsCubit>().selectedProduct!;
      _orderProducts.add(productModel);
    });

    emit(OrderProgressLoaded());
  }

  Future<ProductModel> _getOrderProductModel(
      String id, BuildContext context) async {
    ProductsCubit _productsCubit = context.read<ProductsCubit>();
    await _productsCubit.getProductWithId(productId: id);
    final productData = _productsCubit.selectedProduct;
    return productData!;
  }

  Future<void> _addNotificationToCustomer(
      BuildContext context, String newStatus) async {
    String notificationContent = "Order staus updated to $newStatus";
    final notification =
        NotificationModel(content: notificationContent, date: DateTime.now());
    List<dynamic> notifications = _transactionCustomer!.notifications ?? [];
    notifications = [
      notification.toMap(),
      ...notifications.map((e) => e.toMap())
    ];
    int unreadMessages = _transactionCustomer!.unreadMessages ?? 0;
    await context.read<CustomersCubit>().updateCustomer(newData: {
      "notifications": notifications,
      "unreadMessages": ++unreadMessages
    }, userId: transactionCustomer!.userId);
  }

  Future<void> getTransactionCustomer(BuildContext context) async {
    String customerId =
        await context.read<TransactionsCubit>().selectedTransaction!.customerId;
    await context
        .read<CustomersCubit>()
        .getCustomerById(customerId: customerId);
    _transactionCustomer = context.read<CustomersCubit>().selectedCustomer;
    emit(OrderProgressLoaded());
  }

  Future<void> getWaitingScreenForPdf() async {
    emit(OrderProgressLoading());
    await Future.delayed(Duration(seconds: 10));
    emit(OrderProgressLoaded());
  }

  Future<void> saveOrderNote(
      {required BuildContext context,
      required String note,
      required String transactionId}) async {
    emit(OrderProgressLoading());
    await context.read<TransactionsCubit>().updateTransaction(
        newData: {'transactionNote': note}, transactionId: transactionId);
    emit(OrderProgressLoaded());
  }

  Future<void> cancelOrderStatus(BuildContext context) async {
    emit(OrderProgressLoading());
    String customerName =
        '${context.read<ProfileCubit>().userProfile!.name} ${context.read<ProfileCubit>().userProfile!.surName}';
    List<dynamic> transactionDetails = context
        .read<TransactionsCubit>()
        .selectedTransaction!
        .transactionDetails
        .map((e) => e.toMap())
        .toList();
    transactionDetails.add(TransactionDetailModel(
      transactionType: 6,
      employeeNameWhoEdit: customerName,
      employeeIdWhoEdit: "121323",
      editDate: DateTime.now(),
    ).toMap());
    String transactionId =
        context.read<TransactionsCubit>().selectedTransaction!.transactionId;
    await context.read<TransactionsCubit>().updateTransaction(newData: {
      "transactionStatus": 6.0,
      "transactionDetails": transactionDetails
    }, transactionId: transactionId);
    context.read<NotificationCubit>().sendNotificationToEmployees(
        customerName: customerName,
        context: context,
        title: "Sipariş İptal Edildi",
        message: "$customerName isimli kullanıcı siparişini iptal etti");
    await context.read<TransactionsCubit>().getAllTransactions();
    await context.read<EmployeeHomeScreenCubit>().refreshOrders(context);
    await context
        .read<TransactionsCubit>()
        .getTransactionById(transactionId: transactionId);
    emit(OrderProgressLoaded());
  }
}
