import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:alfa_application/constants/app_general_methods.dart';
import 'package:alfa_application/constants/image_paths.dart';
import 'package:alfa_application/data/model/customer_model.dart';
import 'package:alfa_application/data/model/transaction_model.dart';
import 'package:alfa_application/screens/order_progress_screen/cubit/order_progress_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;
import 'package:url_launcher/url_launcher.dart';

import '../data/model/product_model.dart';
import '../general_cubits/transactions_cubit/cubit/transactions_cubit.dart';

class ReportPdfPage extends StatelessWidget {
  late TransactionModel _currentTransaction;
  late CustomerModel _currentCustomer;
  late List<ProductModel> products;
  var logoImage;
  List<pw.Widget> productList = [];

  ReportPdfPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    products = context.read<OrderProgressCubit>().orderProducts;
    _getScreenInfo(context);
    return TextButton.icon(
        style: TextButton.styleFrom(
            primary: Colors.black, padding: EdgeInsets.all(0)),
        onPressed: () {
          context.read<OrderProgressCubit>().getWaitingScreenForPdf();

          _generatePdf(context);
        },
        icon: Icon(Icons.picture_as_pdf),
        label: Text("Take Pdf Report"));
  }

  _openPdf(String path) {
    OpenFile.open(path);
  }

  _generatePdf(BuildContext bcontext) async {
    PdfPageFormat format = PdfPageFormat.a4;
    final doc = pw.Document(pageMode: PdfPageMode.outlines);

    logoImage = pw.MemoryImage(
      (await rootBundle.load(kAlfaLogoGold)).buffer.asUint8List(),
    );

    await _getOrdersList();

    if (!kIsWeb) {
      doc.addPage(
        pw.MultiPage(
          footer: (context) {
            print("Here1 pdf");
            return pw.Padding(
                padding: pw.EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                child: pw.Column(children: [
                  pw.Divider(thickness: 1.4),
                  pw.SizedBox(height: 4),
                  pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text("www.alfagold.com.tr",
                            style: pw.TextStyle(
                                fontSize: 10, fontWeight: pw.FontWeight.bold)),
                        pw.Text(
                            "${context.pageNumber} / ${context.pagesCount}"),
                      ]),
                ]));
          },
          pageTheme: pw.PageTheme(
            pageFormat: format.copyWith(
              marginBottom: 0,
              marginLeft: 0,
              marginRight: 0,
              marginTop: 0,
            ),
            orientation: pw.PageOrientation.portrait,
          ),
          build: (context) {
            print("Here2 pdf");
            return [
              pw.Padding(
                  padding: const pw.EdgeInsets.only(
                    left: 30,
                    right: 30,
                    bottom: 10,
                    top: 30,
                  ),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        _getTopLogoBar(),
                        pw.Divider(thickness: 1.4, color: PdfColors.black),
                        _getOrderAndCustomerDetailArea(bcontext),
                        pw.Divider(thickness: 1.4, color: PdfColors.black),
                        _getOrderNoteField(),
                        pw.Divider(thickness: 1.4, color: PdfColors.black),
                        pw.SizedBox(height: 10),
                        ...productList

                        //   _getTotalArea(),
                      ]))
            ];
          },
        ),
      );
    }

    print("Here 5");

    if (kIsWeb) {
      print("Web pdf");
      // final file = File("document.pdf");
      // Uint8List pdfInBytes = await doc.save();
      // print("Launched");
      await launchUrl(Uri.parse("https://www.google.com"));
      // final blob = html.Blob([pdfInBytes], 'application/pdf');
      // final url = html.Url.createObjectUrlFromBlob(blob);
      // final anchor = html.document.createElement('a') as html.AnchorElement
      //   ..href =
      //       '${Uri.dataFromString(url, mimeType: 'text/plain', encoding: utf8)}'
      //   ..style.display = 'none'
      //   ..download = 'document.pdf';
      // html.document.body!.children.add(anchor);
      // anchor.click();
    } else {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      final file = File('${appDocDirectory.path}/report.pdf');
      await file.writeAsBytes(await doc.save());
      _openPdf('${appDocDirectory.path}/deneme.pdf');
    }
  }

  _getTopLogoBar() {
    // final alfaLogo = await rootBundle.loadString(kAlfaLogoGoldSvg);
    print("here3 pdf");
    String employeeName = "";
    String orderDate = "";
    String orderStatus = "";
    if (_currentTransaction.transactionDetails.length > 0) {
      employeeName =
          _currentTransaction.transactionDetails.last.employeeNameWhoEdit;
      orderDate = _currentTransaction.transactionDate;
      orderDate = kGetFormattedDate(DateTime.parse(orderDate), true);
      orderStatus = kTransactionProgressStepLabels[
          _currentTransaction.transactionStatus.toInt()];
      employeeName = kRemoveTurkishCharacters(employeeName);
      orderStatus = kRemoveTurkishCharacters(orderStatus);
    }

    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Container(
            height: 70,
            width: 90,
            child: pw.Image(logoImage),
          ),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text(employeeName),
            pw.SizedBox(height: 4),
            pw.Text(orderDate),
            pw.SizedBox(height: 4),
            pw.Text(orderStatus,
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            // pw.Image(pw.RawImage(bytes: imageBytes, width: 100, height: 100))
          ]),
        ]);
  }

  _getOrderAndCustomerDetailArea(BuildContext context) {
    print("Here4 pdf");
    String customerName = kRemoveTurkishCharacters(_currentCustomer.name);
    String customerSurname = kRemoveTurkishCharacters(_currentCustomer.surName);
    String companyName =
        kRemoveTurkishCharacters(_currentCustomer.customerCompanyName ?? "");
    String country =
        kRemoveTurkishCharacters(_currentCustomer.customerCountry ?? "");
    String city = kRemoveTurkishCharacters(_currentCustomer.customerCity ?? "");
    String address =
        kRemoveTurkishCharacters(_currentCustomer.customerAdress ?? "");
    String mobilePhone = kRemoveTurkishCharacters(
        _currentCustomer.customerCompanyMobilePhoneNumber ?? "");
    String phone = kRemoveTurkishCharacters(
        _currentCustomer.customerCompanyPhoneNumber ?? "");
    String email = kRemoveTurkishCharacters(
        _currentCustomer.customerCompanyMailAdress ?? "");
    String postCode = kRemoveTurkishCharacters("25888");

    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("$customerName\n$customerSurname",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 4),
            pw.Text(kGetCustomerTypeLabel(_currentCustomer.customeGroup ?? ""),
                style: pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 12),
            pw.Text(
                _currentCustomer.customerMobilePhoneNumber ??
                    _currentCustomer.customerPhoneNumber ??
                    "",
                style: pw.TextStyle(fontSize: 10)),
            pw.SizedBox(height: 4),
            pw.Text(_currentCustomer.userEmail,
                style: pw.TextStyle(fontSize: 10)),
          ]),
          pw.SizedBox(width: 10),
          pw.SizedBox(
              width: 130,
              child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(companyName,
                        style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                            decoration: pw.TextDecoration.underline)),
                    pw.SizedBox(height: 4),
                    pw.Text(country, style: pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 4),
                    pw.Text(city, style: pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 8),
                    pw.Text(address,
                        style: pw.TextStyle(fontSize: 10),
                        softWrap: true,
                        maxLines: 6),
                    pw.Text(_currentCustomer.postCode ?? "",
                        style: pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 8),
                    pw.Text(phone, style: pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 4),
                    pw.Text(mobilePhone, style: pw.TextStyle(fontSize: 10)),
                    pw.SizedBox(height: 12),
                    pw.Text(email, style: pw.TextStyle(fontSize: 10)),
                  ])),
          pw.SizedBox(width: 10),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text(_currentTransaction.transactionId,
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                    decoration: pw.TextDecoration.underline)),
            _getProductNameList(context),
            pw.SizedBox(height: 20),
            pw.Divider(thickness: 2, color: PdfColors.black),
            _getTotalWeightLabel(context),
            pw.Divider(thickness: 2, color: PdfColors.black),
          ]),
          pw.SizedBox(width: 10),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            pw.Text("ACTIONS",
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                    decoration: pw.TextDecoration.underline)),
            pw.SizedBox(height: 4),
            _getActionsList(),
          ]),
          pw.SizedBox(width: 10),
        ]);
  }

  _getOrderNoteField() {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 5),
          pw.Text("ORDER NOTES:",
              style:
                  pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 12)),
          pw.SizedBox(height: 5),
          pw.Text(_currentTransaction.transactionNote ?? "",
              style: pw.TextStyle(fontSize: 12)),
          pw.SizedBox(height: 10),
        ]);
  }

  _getOrderListTile(
      {required ProductModel productModel,
      required pw.MemoryImage? image,
      required int index}) {
    return pw.Column(children: [
      pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text("$index.",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(width: 5),
                  pw.Container(
                      height: 75,
                      width: 65,
                      color: PdfColors.grey300,
                      child: image != null ? pw.Image(image) : null),
                  pw.SizedBox(width: 10),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(productModel.productTitle ?? "",
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        pw.Text(productModel.productCode ?? ""),
                        pw.SizedBox(height: 5),
                        pw.SizedBox(
                            width: 200,
                            child: pw.Text(
                              productModel.productDescriptionTurkish ??
                                  productModel.productDescriptionEnglish ??
                                  "",
                              softWrap: true,
                              style: pw.TextStyle(fontSize: 10),
                              maxLines: 4,
                            )),
                      ])
                ]),
            pw.Row(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (productModel.goldPercent != null)
                      pw.Text(
                          kGetGoldPercentLabelOfProduct(
                              productModel.goldPercent!),
                          style: pw.TextStyle(
                              fontSize: 12, fontWeight: pw.FontWeight.bold)),
                    if (productModel.productColorType != null)
                      pw.Text(
                        kGetColorLabelOfProduct(
                            productModel.productColorType.toString()),
                      ),
                  ]),
              pw.SizedBox(width: 20),
              pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (productModel.productWeight != null)
                      pw.Text(
                          kGetWeightLabelOfProduct(productModel.productWeight!),
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    if (productModel.productHeight != null)
                      pw.Text(
                          "Length : ${kGetHeightLabelOfProduct(productModel.productHeight!)}",
                          style: pw.TextStyle(fontSize: 10)),
                    if (productModel.productWidth != null)
                      pw.Text(
                          "Width : ${kGetWidthLabelOfProduct(productModel.productWidth!)}",
                          style: pw.TextStyle(fontSize: 10)),
                    if (productModel.productRadius != null)
                      pw.Text(
                          "Radius : ${kGetRadiusLabelOfProduct(productModel.productRadius!)}",
                          style: pw.TextStyle(fontSize: 10)),
                  ]),
              // pw.SizedBox(width: 20),
              // pw.Column(
              //     mainAxisAlignment: pw.MainAxisAlignment.start,
              //     crossAxisAlignment: pw.CrossAxisAlignment.start,
              //     children: [
              //       pw.Text("6 PCS.",
              //           style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              //       pw.Text("256,00 gr", style: pw.TextStyle(fontSize: 10)),
              //     ]),
            ]),
          ]),
      pw.SizedBox(height: 10),
      pw.Divider(thickness: 0.7, color: PdfColors.black),
      pw.SizedBox(height: 10),
    ]);
  }

  _getOrdersList() async {
    int counter = 0;
    productList.clear();
    await Future.forEach(products, (element) async {
      pw.MemoryImage? productImage;
      counter++;
      if ((element as ProductModel).productImageList != null &&
          (element as ProductModel).productImageList!.first != null) {
        productImage = pw.MemoryImage(await _getImageBytes(
            (element as ProductModel).productImageList!.first));
      }
      productList.add(_getOrderListTile(
          productModel: element, image: productImage, index: counter));
    });
  }

  _getTotalArea() {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "TOTAL",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(width: 10),
          pw.Column(children: [
            pw.Row(children: [
              pw.Text("3 PCS 22K",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(
                "185,00 g.",
              ),
            ]),
            pw.Row(children: [
              pw.Text("3 PCS 22K",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(
                "185,00 g.",
              ),
            ]),
            pw.Row(children: [
              pw.Text("3 PCS 22K",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(
                "185,00 g.",
              ),
            ]),
            pw.SizedBox(height: 4),
            pw.Divider(thickness: 0.7),
            pw.SizedBox(height: 4),
            pw.Row(children: [
              pw.Text("10 PCS 22K",
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text(
                "1885,00 g.",
              ),
            ]),
          ]),
        ]);
  }

  void _getScreenInfo(BuildContext context) {
    if (context.read<OrderProgressCubit>().transactionCustomer != null) {
      _currentCustomer =
          context.read<OrderProgressCubit>().transactionCustomer!;
      _currentTransaction =
          context.read<TransactionsCubit>().selectedTransaction!;
    }
  }

  _getProductNameList(BuildContext context) {
    int counter = 0;
    final orderList = products.map((e) {
      counter++;
      return pw.Row(children: [
        pw.Text(
            "$counter. ${kGetGoldPercentLabelOfProduct(e.goldPercent ?? '')}",
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        pw.Text("   ${e.productWeight.toString()} gr.",
            style: pw.TextStyle(fontSize: 10))
      ]);
    }).toList();
    return pw.Column(children: orderList);
  }

  _getTotalWeightLabel(BuildContext context) {
    double totalWeight = 0.0;
    products.forEach((element) {
      totalWeight += element.productWeight ?? 0;
    });

    return pw.Column(children: [
      pw.Container(height: 1, width: 80, color: PdfColors.black),
      pw.SizedBox(height: 4),
      pw.Row(children: [
        pw.Text("TOTAL ",
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
        pw.Text("$totalWeight gr", style: pw.TextStyle(fontSize: 10))
      ]),
    ]);
  }

  _getActionsList() {
    final actionList = _currentTransaction.transactionDetails.map((e) {
      String orderLabel = kTransactionProgressStepLabels[e.transactionType!];
      orderLabel = kRemoveTurkishCharacters(orderLabel);
      orderLabel = orderLabel.replaceAll("\n", " ");
      String dateLabel = kGetFormattedDate(e.editDate, true);

      return pw.Padding(
          padding: pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(dateLabel, style: pw.TextStyle(fontSize: 8)),
                pw.SizedBox(width: 3),
                pw.Text(orderLabel, style: pw.TextStyle(fontSize: 8)),
              ]));
    }).toList();
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start, children: actionList);
  }

  Future<Uint8List> _getImageBytes(String url) async {
    http.Response response = await http.get(
      Uri.parse(url),
    );
    return response.bodyBytes;
  }
}
