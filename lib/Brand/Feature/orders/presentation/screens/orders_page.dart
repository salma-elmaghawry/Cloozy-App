import 'package:cloozy/Brand/Feature/orders/data/models/orders_model.dart';
import 'package:cloozy/Brand/Feature/Dashboard/data/repository/dashboard_repo.dart';
import 'package:cloozy/Brand/Feature/orders/presentation/controllers/cubits/order_cubit/order_cubit_cubit.dart';
import 'package:cloozy/Core/common/app_dialogs.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class OrdersPage extends StatelessWidget {
  final String token;
  OrdersPage({super.key, required this.token});

  final TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(DashboardRepo())..fetchOrders(token),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: bgColor,
          title: CustomText(
            title: 'Orders',
            fontFamily: "Poppins",
            fontSize: 26,
          ),
          actions: [
            IconButton(
                icon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SvgPicture.asset(
                    setting,
                    height: 30,
                    width: 30,
                  ),
                ),
                onPressed: () {}),
            IconButton(
                icon: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                      child: SvgPicture.asset(
                    notiofication,
                    height: 30,
                    width: 30,
                  )),
                ),
                onPressed: () {}),
          ],
        ),
        body: BlocBuilder<OrdersCubit, OrderState>(
          builder: (context, state) {
            if (state is OrderLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            } else if (state is OrderLoaded) {
              if (state.orders.isNotEmpty) {
                state.orders;
              } else {
                return const Center(child: Text("No orders available"));
              }
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextformfield(
                            controller: search,
                            label: "Search",
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: SvgPicture.asset(
                                "assets/icons/search.svg",
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                  child: SvgPicture.asset(
                                filter,
                                height: 30,
                                width: 30,
                              )),
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                  child: SvgPicture.asset(
                                filter,
                                height: 30,
                                width: 30,
                              )),
                            ),
                            onPressed: () {}),
                      ],
                    ),
                    // Table Header
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: const Row(
                        children: [
                          Text("ID",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(width: 30),
                          Text("Cost",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(width: 55),
                          Text("Date",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                          SizedBox(width: 80),
                          Text("Status",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),

                    Expanded(
                      child: ListView(
                        children: state.orders.map((order) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Colors.grey.shade300)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("#${order.id}",
                                    style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold)),
                                Text("\$${order.totalPrice.toStringAsFixed(2)}",
                                    style: const TextStyle(fontSize: 14)),
                                Text(order.createdAt,
                                    style: const TextStyle(fontSize: 14)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: getStatusColor(order.status)
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    order.status,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is OrderError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showErrorDialog(context, state.message);
              });
              return _buildErrorPlaceholder();
            }
            return _buildErrorPlaceholder();
          },
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

Widget _buildLoadingIndicator() => const Center(
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );

Widget _buildErrorPlaceholder() => Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
