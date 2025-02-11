part of 'daily_sales_cubit.dart';

@immutable
sealed class DailySalesState extends Equatable {
  @override
  List<Object> get props => [];
}

final class DailySalesInitial extends DailySalesState {}

class DailySalesLoading extends DailySalesState {}

class DailySalesLoaded extends DailySalesState {
  final DailySalesModel dailySales;
  DailySalesLoaded(this.dailySales);

  @override
  List<Object> get props => [dailySales];
}

class DailySalesError extends DailySalesState {
  final String message;
  DailySalesError(this.message);

  @override
  List<Object> get props => [message];
}

class DailySalesAuthError extends DailySalesState {
  final String message;
   DailySalesAuthError(this.message);
    @override
  List<Object> get props => [message];
}
