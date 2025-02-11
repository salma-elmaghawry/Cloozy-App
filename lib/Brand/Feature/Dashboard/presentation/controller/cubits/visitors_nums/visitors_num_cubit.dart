import 'package:bloc/bloc.dart';
import 'package:cloozy/Brand/Feature/Dashboard/data/models/visitore_number_model.dart';
import 'package:cloozy/Brand/Feature/Dashboard/data/repository/dashboard_repo.dart';
import 'package:equatable/equatable.dart';

part 'visitors_num_state.dart';

class VisitorsNumCubit extends Cubit<VisitorsNumState> {
  VisitorsNumCubit(this.dashboardRepo) : super(VisitorsNumInitial());
  final DashboardRepo dashboardRepo;
 
  void fetchVistorsNum(String token) async {
    emit(VisitorsNumLoading());
    try {
      final visitorNums = await dashboardRepo.fetchVisitorsNumbers(token);
      emit(VisitorsNumLaoded(visitorNums ));
    } catch (e) {
      final message = e.toString().replaceAll('Exception: ', '');
      if (message.contains('Unauthenticated') ||
          message.contains('Session expired')) {
        emit(VisitorsNumError(message));
      } else {
        emit(VisitorsNumError(message));
      }
    }
  }
}
