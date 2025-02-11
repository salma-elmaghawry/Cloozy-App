import 'package:bloc/bloc.dart';
import 'package:cloozy/Brand/Feature/Dashboard/data/models/daily_sales_model.dart';
import 'package:cloozy/Brand/Feature/Dashboard/data/repository/dashboard_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'daily_sales_state.dart';

class DailySalesCubit extends Cubit<DailySalesState> {
  final DashboardRepo dashboardRepo;
  DailySalesCubit(this.dashboardRepo) : super(DailySalesInitial());
  void fetchDailySales(String token) async {
    emit(DailySalesLoading());
    try {
      final dailySales = await dashboardRepo.fetchDailySales(token);
      emit(DailySalesLoaded(dailySales));
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      if (message.contains('Unauthenticated') ||
          message.contains('Session expired')) {
        emit(DailySalesAuthError(message));
      } else {
        emit(DailySalesError(message));
      }
    }
  }
}
