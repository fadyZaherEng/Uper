import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uper_app/layout/cubit/states.dart';
import 'package:uper_app/shared/network/local/cashe_helper.dart';

class UperCubit extends Cubit<UperAppStates>{
  UperCubit():super(InitialUperAppStates());
  static UperCubit get (BuildContext context) =>BlocProvider.of(context);

  //mode theme
  String modeName = 'Light Theme';
  Color? modeColor = Colors.white;
  ThemeMode modeType = ThemeMode.light;

  void modeChange() {
    if (modeName == 'Light Theme') {
      SharedHelper.save(value: "light", key: "mode");
      modeName = 'Dark Theme';
      modeColor = Colors.black;
      modeType = ThemeMode.dark;
    } else {
      SharedHelper.save(value: "dark", key: "mode");
      modeName = 'Light Theme';
      modeColor = Colors.white;
      modeType = ThemeMode.light;
    }
    emit(ChangeModeSuccessUperAppStates());
  }
}