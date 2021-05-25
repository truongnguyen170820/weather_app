import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/event/covid_event.dart';
import 'package:weather_app/repositories/api_repository.dart';
import 'package:weather_app/states/covid_state.dart' ;

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  final ApiRepository _apiRepository = ApiRepository();

  CovidBloc() : super(null) ;
  @override
  CovidState get initialState => CovidInitial();

  @override
  Stream<CovidState> mapEventToState(
      CovidEvent event,
      ) async* {
    if (event is GetCovidList) {
      try {
        yield CovidLoading();
        final mList = await _apiRepository.fetchCovidList();
        yield CovidLoaded(mList);
        if (mList.error != null) {
          yield CovidError(mList.error);
        }
      } on NetworkError {
        yield CovidError("Failed to fetch data. is your device online?");
      }
    }
  }
}