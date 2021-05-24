import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/setting_bloc.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/screen/weather_screen.dart';
import 'package:weather_app/states/theme_state.dart';
import 'bloc/them_bloc.dart';
import 'bloc/weather_bloc_observer.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = WeatherBlocObserver();
  final WeatherRepository weatherRepository = WeatherRepository(
      httpClient: http.Client()
  );
  runApp(BlocProvider<ThemeBloc>(
    create:(context) =>ThemeBloc(),
    child: BlocProvider<SettingsBloc>(
      create: (context) =>SettingsBloc(),
      child: MyApp(weatherRepository: weatherRepository),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const MyApp({Key key, this.weatherRepository}) : assert(weatherRepository != null),  super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState){
        return MaterialApp(
          home: BlocProvider(
            create: (context) => WeatherBloc(weatherRepository: weatherRepository),
            child: WeatherScreen(),
          ),
        );
      },
    );
  }
}
