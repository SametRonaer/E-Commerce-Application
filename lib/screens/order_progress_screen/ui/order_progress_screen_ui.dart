import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/enums.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/product_model.dart';
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/general_cubits/profile_cubit/cubit/profile_cubit.dart';
import 'package:alfa_application/general_cubits/transactions_cubit/cubit/transactions_cubit.dart';
import 'package:alfa_application/screens/order_progress_screen/cubit/order_progress_cubit.dart';
import 'package:alfa_application/widgets/app_bottom_navigation_bar.dart';
import 'package:alfa_application/widgets/custom_app_button.dart';
import 'package:alfa_application/widgets/custom_text_field.dart';
import 'package:alfa_application/widgets/fake_dropdown_button.dart';
import 'package:alfa_application/widgets/pdf_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:universal_html/js.dart';

import '../../../widgets/order_progress_cell.dart';

class OrderProgressScreen extends StatelessWidget {
  OrderProgressScreen({Key? key}) : super(key: key);
  late OrderProgressCubit _orderProgressCubit;
  CustomerModel? _currentCustomer;
  late TransactionModel _currentTransaction;
  static const routeName = "/order-progres-screen";
  bool isFirstBuild = true;
  late bool _isCustomer;

  late String _statusLabel;
  TextStyle _titleTextStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  TextStyle _subTitleTextStyle =
      TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  TextStyle _smallTextStyle = TextStyle(fontSize: 12);
  TextEditingController _orderNoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _setScreenInfo(context);
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        return BlocBuilder<OrderProgressCubit, OrderProgressState>(
          builder: (context, state) {
            _getScreenInfo(context);
            return SafeArea(
              child: Stack(
                children: [
                  Scaffold(
                    bottomNavigationBar:
                        AppBottomNavigationBar(Colors.grey.shade300),
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      centerTitle: true,
                      backgroundColor: Colors.black,
                      title: Text(
                        "Order Progress".tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    body: Column(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                )),
                            padding: EdgeInsets.all(12),
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 10),
                                          if (!_isCustomer) _getPdfButton(),
                                          if (_isCustomer)
                                            _getCancelButton(context),
                                          if (_currentCustomer != null)
                                            _getCustomerDataArea(context),
                                          SizedBox(height: 25),
                                          _getStatusButtonField(context),
                                          SizedBox(height: 25),
                                          _getActionsArea(context),
                                          SizedBox(height: 25),
                                          _getProductsArea(context),
                                          SizedBox(height: 25),
                                          if (!_isCustomer)
                                            _getNoteArea(context),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 100),
                                    // FittedBox(
                                    //   child: OrderProgressCell(
                                    //       stepTitle: "Order Placed",
                                    //       stepDescription:
                                    //           "Your order #167304 was placed for delicery.",
                                    //       stepDate: "9:35 AM"),
                                    // ),
                                    // OrderProgressCell(
                                    //     stepTitle: "Order Placed",
                                    //     stepDescription:
                                    //         "Your order #167304 was placed for delicery.",
                                    //    ),
                                    // OrderProgressCell(
                                    //     stepTitle: "Order Placed",
                                    //     stepDescription:
                                    //         "Your order #167304 was placed for delicery.",
                                    //     stepDate: "9:35 AM"),
                                    // OrderProgressCell(
                                    //   stepTitle: "Order Placed",
                                    //   // stepDescription: "Your order #167304 was placed for delicery.",
                                    //   stepDate: "9:35 AM",
                                    //   isLastStep: true,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state is OrderProgressLoading) kGetLoadingScreen(),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Align _getPdfButton() {
    return Align(
      alignment: Alignment.topLeft,
      child: ReportPdfPage(),
    );
  }

  Row _getCustomerDataArea(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${_currentCustomer!.name}\n${_currentCustomer!.surName}",
                style: _titleTextStyle,
              ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.customeCode ?? "",
                style: _smallTextStyle,
              ),
              if (!_isCustomer)
                Column(
                  children: [
                    SizedBox(height: 6),
                    Text(
                      "Premium Customer",
                      style: _smallTextStyle,
                    ),
                  ],
                ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.customerMobilePhoneNumber ?? "",
                maxLines: 6,
                softWrap: true,
                style: _smallTextStyle,
              ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.userEmail,
                style: _smallTextStyle,
              ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.customerPhoneNumber ?? "",
                maxLines: 6,
                softWrap: true,
                style: _smallTextStyle,
              ),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _currentCustomer!.customerCompanyName ?? "",
                maxLines: 4,
                softWrap: true,
                style: _titleTextStyle.copyWith(
                    decoration: TextDecoration.underline),
              ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.customerCountry ?? "",
                style: _smallTextStyle,
              ),
              SizedBox(height: 6),
              Text(
                "${_currentCustomer!.customerCity}",
                style: _smallTextStyle,
              ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.customerAdress ?? "",
                maxLines: 6,
                softWrap: true,
                style: _smallTextStyle,
              ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.customerCompanyPhoneNumber ?? "",
                maxLines: 6,
                softWrap: true,
                style: _smallTextStyle,
              ),
              SizedBox(height: 6),
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: FittedBox(
                  child: Text(
                    _currentCustomer!.customerCompanyWebsite ?? "",
                    style: _smallTextStyle,
                  ),
                ),
              ),
              SizedBox(height: 6),
              Text(
                _currentCustomer!.customerCompanyMailAdress ?? "",
                style: _smallTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _getStatusButtonField(BuildContext context) {
    print("Curee ${_currentTransaction.transactionStatus}");
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: context.read<ProfileCubit>().isCustomer!
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text("${'OrderStatus'.tr}:", style: _titleTextStyle),
        ),
        (!_isCustomer && _currentTransaction.transactionStatus != 6.0)
            ? GestureDetector(
                onTap: () => _getStatusBottomSheet(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _statusLabel,
                        style: TextStyle(fontSize: 14),
                      ),
                      Icon(Icons.keyboard_arrow_down),
                    ],
                  ),
                  height: 40,
                  width: context.width / 1.8,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.grey.shade400,
                        width: 1.5,
                      )),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  kTransactionProgressStepLabels[
                          _currentTransaction.transactionStatus.toInt()]
                      .replaceAll("\n", " "),
                  style: _subTitleTextStyle.copyWith(fontSize: 13),
                ),
              )
      ],
    );
  }

  _getStatusBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (_) {
          return Container(
            height: context.screenHeight / 1.5,
            child: Column(
              children: [
                ListTile(
                  title: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Select")),
                  trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Divider(color: Colors.black),
                Container(
                  height: context.screenHeight / 1.9,
                  width: double.infinity,
                  child: ListView.builder(
                    itemBuilder: (_, i) {
                      return _getStatusTile(
                          kTransactionProgressStepLabels[i], i, context);
                    },
                    itemCount: kTransactionProgressStepLabels.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _getStatusTile(String status, int index, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<OrderProgressCubit>()
            .updateOrderStatus(index.toDouble(), context);
        _statusLabel = kTransactionProgressStepLabels[index];
        Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              status,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(
              thickness: 0.7,
              height: 25,
            ),
          ],
        ),
      ),
    );
  }

  void _setScreenInfo(BuildContext context) {
    _orderProgressCubit = context.read<OrderProgressCubit>();
    _orderProgressCubit.getOrderProducts(context);
    _orderProgressCubit.getTransactionCustomer(context);
    _isCustomer = context.read<ProfileCubit>().isCustomer ?? false;
  }

  void _getScreenInfo(BuildContext context) {
    _currentCustomer = _orderProgressCubit.transactionCustomer;
    _currentTransaction =
        context.read<TransactionsCubit>().selectedTransaction!;

    _statusLabel = kTransactionProgressStepLabels[context
        .read<TransactionsCubit>()
        .selectedTransaction!
        .transactionStatus
        .toInt()];
    if (isFirstBuild) {
      _orderNoteController.text = _currentTransaction.transactionNote ?? "";
    }
    isFirstBuild = false;
  }

  Widget _getActionsArea(BuildContext context) {
    List<Widget> transactionDetails = _currentTransaction.transactionDetails
        .map((e) => _getTransactionActionTile(e))
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${'Actions'.tr}:", style: _titleTextStyle),
        SizedBox(height: 8),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: transactionDetails,
        ),
      ],
    );
  }

  Widget _getTransactionActionTile(
      TransactionDetailModel transactionDetailModel) {
    String transactionType = "";
    if (transactionDetailModel.transactionType != null) {
      transactionType = kTransactionProgressStepLabels[
          transactionDetailModel.transactionType!];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check,
              size: 20,
            ),
            Text('OrderStatusChangedTo'.tr),
            Text(transactionType.replaceAll("\n", ""),
                style: _subTitleTextStyle),
          ],
        ),
        SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text('by'.tr),
                  Text(
                    transactionDetailModel.employeeNameWhoEdit,
                    style: _subTitleTextStyle,
                  ),
                ],
              ),
              Text(
                kGetFormattedDate(transactionDetailModel.editDate, true),
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }

  Widget _getProductsArea(BuildContext context) {
    List<ProductModel> products =
        context.read<OrderProgressCubit>().orderProducts;
    List<Widget> productTiles =
        products.map((e) => _getProductTile(e)).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("products".tr, style: _titleTextStyle),
        SizedBox(height: 8),
        Column(
          children: productTiles,
        ),
        SizedBox(height: 8),
        Text('total'.tr, style: _titleTextStyle),
        Text(_getTotalWeightLabelOfProducts(products))
      ],
    );
  }

  Widget _getProductTile(ProductModel productModel) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: Image.network(productModel.productImageList!.first),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(productModel.productTitle ?? "",
                    style: _subTitleTextStyle),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${'productCode'.tr}: ", style: _subTitleTextStyle),
                    Text("${productModel.productCode.toString()}"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${'weight'.tr}: ", style: _subTitleTextStyle),
                    Text("${productModel.productWeight.toString()} gr"),
                  ],
                ),
              ],
            ),
          ],
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }

  _getTotalWeightLabelOfProducts(List<ProductModel> products) {
    double totalWeight = 0;
    products.forEach((element) {
      totalWeight += element.productWeight!;
    });

    return "${totalWeight.toString()} gr";
  }

  _getNoteArea(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Order note:", style: _titleTextStyle),
        CustomTextField(
          isLargeFied: true,
          controller: _orderNoteController,
        ),
        CustomAppButton.black(
            buttonName: "Save Note",
            buttonFunction: () {
              context.read<OrderProgressCubit>().saveOrderNote(
                  context: context,
                  note: _orderNoteController.text,
                  transactionId: _currentTransaction.transactionId);
            })
      ],
    );
  }

  _getCancelButton(BuildContext context) {
    return _currentTransaction.transactionStatus == 6.0
        ? Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text("${'cancelled'.tr}",
                  style: _titleTextStyle.copyWith(color: Colors.grey.shade400)),
            ),
          )
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => _showCancelDialogBar(context),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.cancel),
                  SizedBox(width: 4),
                  Text(
                    'cancelOrder'.tr,
                    style: _titleTextStyle.copyWith(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
  }

  _showCancelDialogBar(BuildContext context) {
    Get.defaultDialog(
      title: "${'cancelOrder'.tr}!",
      middleText: "Are you sure to cancel this order?".tr,
      confirm: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          alignment: Alignment.center,
          height: 28,
          width: context.screenWidth / 6,
          color: Colors.black,
          child: Text(
            "no".tr,
            style: TextStyle(
                fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      cancel: GestureDetector(
        onTap: () async {
          _orderProgressCubit.cancelOrderStatus(context);
          Navigator.of(context).pop();
        },
        child: Container(
            alignment: Alignment.center,
            height: 28,
            width: context.screenWidth / 6,
            color: Colors.red.shade400,
            child: Text(
              "Yes".tr,
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            )),
      ),
    );
  }
}
