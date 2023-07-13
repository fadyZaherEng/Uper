import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:uper_app/bloc_observer/observer.dart';
import 'package:uper_app/layout/cubit/cubit.dart';
import 'package:uper_app/layout/cubit/states.dart';
import 'package:uper_app/modules/register/register.dart';
import 'package:uper_app/modules/splash/splash_screen.dart';
import 'package:uper_app/shared/network/local/cashe_helper.dart';
import 'package:uper_app/shared/styles/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  await SharedHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (ctx)=>UperCubit()),
      ],
      child: BlocConsumer<UperCubit,UperAppStates>(
        listener: (ctx,state){},
        builder: (ctx,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme(),
            darkTheme: darkTheme(),
            themeMode: ThemeMode.system,
            home: Sizer(
              builder: (a, b, c) =>
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: MaterialApp(
                      debugShowCheckedModeBanner: false,
                      darkTheme: darkTheme(),
                      theme: lightTheme(),
                      themeMode: SharedHelper.get(key: "mode")!=null&&SharedHelper.get(key: "mode")=="dark"?ThemeMode.dark:ThemeMode.light,
                      home: startScreen(),
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }

  Widget startScreen() {
    if (SharedHelper.get(key: 'uid') != null) {
      return SplashScreen('home');
    }
    return SplashScreen('login');
  }

}