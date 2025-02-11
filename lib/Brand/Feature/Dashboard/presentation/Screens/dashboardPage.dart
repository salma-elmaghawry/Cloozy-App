import 'package:cloozy/Brand/Feature/Dashboard/data/repository/dashboard_repo.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/controller/cubits/daily_sales/daily_sales_cubit.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/controller/cubits/visitors_nums/visitors_num_cubit.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/recent_orders.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/daily_sales_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/sold_catergories_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/visitors_number_card.dart';
import 'package:cloozy/Core/common/app_dialogs.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

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
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: bgColor,
          title: CustomHeadline(
            title: "Dashboard",
            fontSize: 26,
          ),
          actions: [
            IconButton(icon: Icon(Icons.settings, size: 28), onPressed: () {}),
            IconButton(
                icon: Icon(Icons.notifications, size: 28), onPressed: () {}),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(
                height: 5,
              ),
              CustomTextformfield(
                controller: search,
                label: "Search",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    "assets/icons/search.svg",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomHeadline(
                title: "Metrics",
                fontSize: 24,
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<DailySalesCubit, DailySalesState>(
                builder: (context, state) {
                  if (state is DailySalesLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  } else if (state is DailySalesLoaded) {
                    return DailySalesCard(
                        dailySales: state.dailySales.todaySales,
                        percentageChange: state.dailySales.percentageChange);
                  } else if (state is DailySalesError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(context, state.message);
                    });
                    return _buildErrorPlaceholder();
                  }
                  return _buildLoadingIndicator();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<VisitorsNumCubit, VisitorsNumState>(
                builder: (context, state) {
                  if (state is VisitorsNumLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: primaryColor,
                    ));
                  } else if (state is VisitorsNumLaoded) {
                    return VisitorsNumberCard(
                      totoalVisitors: state.visitorsNum.viewCount,
                      percentage: state.visitorsNum.percentage_change,
                      
                      
                    );
                  } else if (state is VisitorsNumError) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showErrorDialog(context, state.message);
                    });
                    return _buildErrorPlaceholder();
                  }
                  return _buildErrorPlaceholder();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SoldCatergoriesCard(),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomHeadline(title: "Recent Orders", fontSize: 26),
                  TextButton(
                    onPressed: () {},
                    child: Text("See all >",
                        style: TextStyle(fontSize: 16, color: Colors.blue)),
                  ),
                ],
              ),
              SizedBox(height: 15),
              RecentOrders(),
              SizedBox(height: 15),
              CustomHeadline(title: "Recent Payments", fontSize: 26),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildLoadingIndicator() => Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CircularProgressIndicator(color: primaryColor),
      ),
    );

Widget _buildErrorPlaceholder() => Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      ),
    );
