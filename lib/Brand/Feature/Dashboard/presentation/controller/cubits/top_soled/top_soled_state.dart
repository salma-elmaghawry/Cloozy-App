import 'package:cloozy/Brand/Feature/Dashboard/data/models/top_sold_model.dart';
import 'package:equatable/equatable.dart';

sealed class TopSoledState extends Equatable {
  const TopSoledState();

  @override
  List<Object> get props => [];
}

final class TopSoledInitial extends TopSoledState {}
class TopSoldLoading extends TopSoledState {}
class TopSoldLoaded extends TopSoledState {
  final List<TopSoldModel> topSoldList;
  TopSoldLoaded(this.topSoldList);
}
class TopSoldError extends TopSoledState {
  final String message;
  TopSoldError(this.message);
}