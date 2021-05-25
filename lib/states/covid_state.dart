import 'package:equatable/equatable.dart';
import 'package:weather_app/model/covit_model.dart';

abstract class CovidState extends Equatable {
  const CovidState();
}

class CovidInitial extends CovidState {
  const CovidInitial();
  @override
  List<Object> get props => [];
}

class CovidLoading extends CovidState {
  const CovidLoading();
  @override
  List<Object> get props => null;
}

class CovidLoaded extends CovidState {
  final CovidModel covidModel;
  const CovidLoaded(this.covidModel);
  @override
  List<Object> get props => [covidModel];
}

class CovidError extends CovidState {
  final String message;
  const CovidError(this.message);
  @override
  List<Object> get props => [message];
}