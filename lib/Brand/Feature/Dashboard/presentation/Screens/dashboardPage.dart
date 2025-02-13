import 'package:cloozy/Brand/Feature/Dashboard/data/repository/dashboard_repo.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/controller/cubits/daily_sales/daily_sales_cubit.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/controller/cubits/top_soled/top_soled_cubit.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/controller/cubits/top_soled/top_soled_state.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/controller/cubits/visitors_nums/visitors_num_cubit.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/recent_orders.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/daily_sales_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/sold_catergories_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/visitors_number_card.dart';
import 'package:cloozy/Brand/Feature/orders/presentation/controllers/cubits/order_cubit/order_cubit_cubit.dart';
import 'package:cloozy/Brand/Feature/orders/presentation/screens/orders_page.dart';
import 'package:cloozy/Core/common/app_dialogs.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redacted/redacted.dart';

class Dashboardpage extends StatelessWidget {
  final String token;
  Dashboardpage({super.key, required this.token});
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              DailySalesCubit(DashboardRepo())..fetchDailySales(token),
        ),
        BlocProvider(
          create: (context) =>
              VisitorsNumCubit(DashboardRepo())..fetchVistorsNum(token),
        ),
        BlocProvider(
          create: (context) =>
              TopSoledCubit(DashboardRepo())..fetchTopSoldData(token),
        ),
        BlocProvider(
          create: (context) => OrdersCubit(DashboardRepo())..fetchOrders(token),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: bgColor,
          title: CustomText(
            title: 'Dashboard',
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),
              CustomTextformfield(
                controller: search,
                label: "Search",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    "assets/icons/search.svg",
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              CustomText(
                title: 'Metrics',
                fontFamily: "Poppins",
                fontSize: 22,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<DailySalesCubit, DailySalesState>(
                builder: (context, state) {
                  if (state is DailySalesLoading) {
                    shimmerDailySalesCard(context);
                  } else if (state is DailySalesLoaded) {
                    return DailySalesCard(
                        dailySales: state.dailySales.todaySales,
                        percentageChange: state.dailySales.percentageChange);
                  } else if (state is DailySalesError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(context, state.message);
                    });
                    shimmerDailySalesCard(context);
                  }
                  return shimmerDailySalesCard(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<VisitorsNumCubit, VisitorsNumState>(
                builder: (context, state) {
                  if (state is VisitorsNumLoading) {
                    shimmerVisitorNumCard(context);
                  } else if (state is VisitorsNumLaoded) {
                    return VisitorsNumberCard(
                      totoalVisitors: state.visitorsNum.viewCount,
                      percentage: state.visitorsNum.percentage_change,
                    );
                  } else if (state is VisitorsNumError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(context, state.message);
                    });
                    shimmerVisitorNumCard(context);
                  }
                  return shimmerVisitorNumCard(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<TopSoledCubit, TopSoledState>(
                builder: (context, state) {
                  if (state is TopSoldLoading) {
                    shimmerSoldCategoryCard(context);
                  } else if (state is TopSoldLoaded) {
                    return SoldCatergoriesCard(
                      name: state.topSoldList.first.name,
                      percentage: state.topSoldList.first.percentage.toString(),
                      topSold: state.topSoldList,
                    );
                  } else if (state is TopSoldError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(context, state.message);
                    });
                    return shimmerSoldCategoryCard(context);
                  }
                  return shimmerSoldCategoryCard(context);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: 'Recent Orders',
                    fontFamily: "Poppins",
                    fontSize: 22,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrdersPage(token: token),
                        ),
                      );
                    },
                    child: const Text(
                      "See all >",
                      style: TextStyle(
                        fontSize: 16,
                        color: blueCOlor,
                        decoration: TextDecoration.underline,
                        decorationColor: blueCOlor, // Change underline color
                        decorationThickness: 2,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              BlocBuilder<OrdersCubit, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    shimmerRecentOrdersCard(context);
                  } else if (state is OrderLoaded) {
                    if (state.orders.isNotEmpty) {
                      return RecentOrders(
                        ordersList: state.orders,
                      );
                    } else {
                      return const Center(child: Text("No orders available"));
                    }
                  } else if (state is OrderError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(context, state.message);
                    });
                    shimmerRecentOrdersCard(context);
                  }
                  return shimmerRecentOrdersCard(context);
                },
              ),
              const SizedBox(height: 15),
              CustomText(
                title: 'Recent Payments',
                fontFamily: "Poppins",
                fontSize: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget shimmerSoldCategoryCard(dynamic context) => SoldCatergoriesCard(
      name: "",
      percentage: "",
      topSold: [],
    ).redacted(context: context, redact: true);

Widget shimmerVisitorNumCard(dynamic context) => VisitorsNumberCard(
      totoalVisitors: 0,
      percentage: "",
      isRedacted: true,
    ).redacted(context: context, redact: true);

Widget shimmerDailySalesCard(dynamic context) => DailySalesCard(
      dailySales: 0.0,
      percentageChange: " ",
      isRedacted: true,
    ).redacted(context: context, redact: true);
Widget shimmerRecentOrdersCard(dynamic context) =>
    RecentOrders(ordersList: []).redacted(context: context, redact: true);
