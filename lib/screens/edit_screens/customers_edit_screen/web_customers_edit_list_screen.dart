import 'package:alfa_application/extensions/screen_size_context.dart';
import 'package:alfa_application/general_cubits/customers_cubit/cubit/customers_cubit.dart';
import 'package:alfa_application/screens/edit_screens/customers_edit_screen/customer_add_edit_screens/ui/web_customer_add_screen_ui.dart';
import 'package:alfa_application/screens/web_screens/cubit/web_home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/web_customer_edit_list_tile.dart';

class WebCustomersEditListScreen extends StatelessWidget {
  WebCustomersEditListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<CustomersCubit>().getAllCustomers();
    return BlocBuilder<CustomersCubit, CustomersState>(
      builder: (context, state) {
        return Scaffold(
            body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: Colors.white),
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "CUSTOMERS",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<WebHomeCubit>()
                          .switchCurrentScreen(WebCustomerAddScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Icons.add_circle_outline, size: 35),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Divider(thickness: 0.7, color: Colors.grey.shade700),
              SizedBox(
                  height: context.screenHeight / 1.45,
                  width: double.infinity,
                  child: ListView.builder(
                      itemBuilder: (_, i) => WebCustomerEditListTile(
                          customerModel:
                              context.read<CustomersCubit>().allCustomers[i]),
                      itemCount:
                          context.read<CustomersCubit>().allCustomers.length)),
            ],
          ),
        ));
      },
    );
  }
}
