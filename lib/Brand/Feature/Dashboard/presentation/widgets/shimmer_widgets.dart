import 'package:flutter/material.dart';
import 'package:redacted/redacted.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/daily_sales_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/visitors_number_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/sold_catergories_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/recent_orders.dart';

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