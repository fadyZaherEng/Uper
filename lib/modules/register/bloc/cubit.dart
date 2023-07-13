import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uper_app/layout/cubit/states.dart';
import 'package:uper_app/models/user_profile.dart';
import 'package:uper_app/modules/register/bloc/states.dart';
import 'package:uper_app/shared/components/components.dart';



class UperAppRegisterCubit extends Cubit<UperAppRegisterStates>
{
  UperAppRegisterCubit() : super(UperAppRegisterInitialStates());
  static UperAppRegisterCubit get(context)=>BlocProvider.of(context);


  //password
  Icon passSuffixIcon=const Icon(Icons.visibility_outlined,color: Colors.indigo,);
  Icon confirmPassSuffixIcon=const Icon(Icons.visibility_outlined,color: Colors.indigo,);
  bool obscurePassword=true;
  bool confirmObscurePassword=true;
  void changeVisibilityOfEye(String val){
    if(val=="pass"){
      obscurePassword=!obscurePassword;
    }
    if(val=="confirmPass"){
      confirmObscurePassword=!confirmObscurePassword;
    }
    if(obscurePassword){
      passSuffixIcon=Icon(Icons.remove_red_eye,color: Colors.indigo,);
    }else if(!obscurePassword) {
      passSuffixIcon=Icon(Icons.visibility_off_outlined,color: Colors.indigo,);
      }
    if(confirmObscurePassword){
      confirmPassSuffixIcon=Icon(Icons.remove_red_eye,color: Colors.indigo,);
    }else if(!confirmObscurePassword) {
      confirmPassSuffixIcon=Icon(Icons.visibility_off_outlined,color: Colors.indigo,);
    }
    emit(UperAppRegisterChangeEyeStates());
  }
  //password match
  String matchPasswordMassage="";
  void passwordMatch(String val,context){
    if ( UperAppRegisterCubit.get(context).passwordController.text!=val) {
      matchPasswordMassage='Password is Not Match';
      emit(UperAppRegisterInitialStates());
    }else{
      matchPasswordMassage="";
      emit(UperAppRegisterInitialStates());
    }

  }
  //register
  var addressController=TextEditingController();
  var passwordController=TextEditingController();
  var confirmPasswordController=TextEditingController();
  var emailController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  void signUp(){
    emit(UperAppRegisterLoadingStates());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
    ).then((value)async {
      var x=value;
       showToast(message: 'Create Account Loading ....', state: ToastState.WARNING);
      await storeDatabaseFirestore(value.user!.uid.toString()).then((value) {
        emit(UperAppRegisterSuccessStates(x.user!.uid.toString()));
      }).catchError((onError){
        emit(UperAppRegisterErrorStates(onError.toString()));
      });
    }).catchError((onError){
        emit(UperAppRegisterErrorStates(onError.toString()));
    });
  }

  Future storeDatabaseFirestore(String uid) {
    UserProfile profile=UserProfile(
        name: nameController.text,
        phone: phoneController.text,
        email: emailController.text,
        uid: uid,
       address: addressController.text,
    );
    CollectionReference users = FirebaseFirestore.instance.collection('users');
   return users.doc(uid).set(profile.toMap());
  }
}
