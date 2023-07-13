import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uper_app/layout/home_screen.dart';
import 'package:uper_app/models/user_profile.dart';
import 'package:uper_app/modules/login/bloc/states.dart';
import 'package:uper_app/modules/register/bloc/states.dart';
import 'package:uper_app/shared/components/components.dart';



class UperAppLogInCubit extends Cubit<UperAppLogInStates> {
  UperAppLogInCubit() : super(UperAppLogInInitialStates());

  static UperAppLogInCubit get(context) => BlocProvider.of(context);


  //password
  Icon passSuffixIcon = const Icon(
    Icons.visibility_outlined, color: Colors.indigo,);
  bool obscurePassword = true;

  void changeVisibilityOfEye() {
    obscurePassword = !obscurePassword;
    if (obscurePassword) {
      passSuffixIcon = Icon(Icons.remove_red_eye, color: Colors.indigo,);
    } else if (!obscurePassword) {
      passSuffixIcon =
          Icon(Icons.visibility_off_outlined, color: Colors.indigo,);
    }
    emit(UperAppLogInChangeEyeStates());
  }

  //login
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  void signIn() {
    emit(UperAppLogInLoadingStates());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ).then((value) async {
      var x = value;
      emit(UperAppLogInSuccessStates(x.user!.uid));
    }).catchError((onError) {
      emit(UperAppLogInErrorStates(onError.toString()));
    });
  }
}
