
import 'package:cloozy/Brand/Feature/Dashboard/data/repository/dashboard_repo.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/controller/cubits/top_soled/top_soled_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopSoledCubit extends Cubit<TopSoledState> {
  TopSoledCubit(this.dashboardRepo) : super(TopSoledInitial());
  final DashboardRepo dashboardRepo;
  Future<void> fetchTopSoldData(String token) async {
    emit(TopSoldLoading());
    try {
      final topSoldList = await dashboardRepo.fetchTopSold(token);
      emit(TopSoldLoaded(topSoldList));
    } catch (e) {
      emit(TopSoldError(e.toString()));
    }
  }
}