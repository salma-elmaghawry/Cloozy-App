part of 'visitors_num_cubit.dart';

sealed class VisitorsNumState extends Equatable {
  const VisitorsNumState();

  @override
  List<Object> get props => [];
}

final class VisitorsNumInitial extends VisitorsNumState {}
class  VisitorsNumLoading extends VisitorsNumState {}
class  VisitorsNumLaoded extends VisitorsNumState {
   final VisiotoreNumsModel visitorsNum;
  VisitorsNumLaoded(this.visitorsNum);

  @override
  List<Object> get props => [visitorsNum];
}
class  VisitorsNumError extends VisitorsNumState {
    final String message;
  VisitorsNumError(this.message);

  @override
  List<Object> get props => [message];
}


