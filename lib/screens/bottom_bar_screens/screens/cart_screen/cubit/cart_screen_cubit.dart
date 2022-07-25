import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/general_cubits/notification_cubit/cubit/notification_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../data/model/customer_model.dart';
import '../../../../../data/model/product_model.dart';
import '../../../../../data/model/transaction_model.dart';
import '../../../../../general_cubits/transactions_cubit/cubit/transactions_cubit.dart';

part 'cart_screen_state.dart';

class CartScreenCubit extends Cubit<CartScreenState> {
  CartScreenCubit() : super(CartScreenInitial());

  Future<void> completeTransaction(BuildContext context) async {
    ProfileCubit profileCubit = context.read<ProfileCubit>();
    List<ProductModel> cartProducts = profileCubit.customerCartProducts;
    List<String> productsPhysicalInfoList = _getProductsInfoList(cartProducts);
    List<String> productIds = [];
    cartProducts.forEach((element) {
      productIds.add(element.productId!);
    });
    if (cartProducts.length == 0) {
      return;
    }
    String customerName =
        "${profileCubit.userProfile!.name} ${profileCubit.userProfile!.surName}";

    await BlocProvider.of<TransactionsCubit>(context).addNewTransacation(
        transaction: TransactionModel(
            customerName: customerName,
            transactionDetails: [],
            transactionId: "1",
            transactionDate: DateTime.now().toString(),
            transactionTotalAmount: "",
            transactionProductIds: productIds,
            customerId: (profileCubit.userProfile as CustomerModel).userId,
            transactionStatus: 0,
            productsInfo: productsPhysicalInfoList));
    await profileCubit.clearCartProducts();
    context.read<NotificationCubit>().sendNotificationToEmployees(
        context: context, customerName: customerName);
  }

  List<String> _getProductsInfoList(List<ProductModel> products) {
    List<String> productData = [];
    products.forEach((element) {
      String weight = kGetWeightLabelOfProduct(element.productWeight!);
      String percent = kGetGoldPercentLabelOfProduct(element.goldPercent!);
      productData.add("$percent | $weight");
    });
    return productData;
  }
}
