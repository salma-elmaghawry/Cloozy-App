import 'package:bloc/bloc.dart';
import 'package:cloozy/Brand/Feature/Dashboard/data/repository/dashboard_repo.dart';
import 'package:cloozy/Brand/Feature/orders/data/models/orders_model.dart';
import 'package:equatable/equatable.dart';

part 'order_cubit_state.dart';

class OrdersCubit extends Cubit<OrderState> {
  OrdersCubit(this.dashboardRepo) : super(OrderCubitInitial());
  final DashboardRepo dashboardRepo;
  Future<void> fetchOrders(String token) async {
    emit(OrderLoading());
    try {
      final ordersList = await dashboardRepo.fetchOrders(token);
      emit(OrderLoaded(ordersList));
      
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
