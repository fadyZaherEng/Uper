import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:uper_app/layout/home_screen.dart';
import 'package:uper_app/modules/login/login_screen.dart';
import 'package:uper_app/modules/register/bloc/cubit.dart';
import 'package:uper_app/modules/register/bloc/states.dart';
import 'package:uper_app/modules/register/forgetPassword.dart';
import 'package:uper_app/shared/components/components.dart';
import 'package:uper_app/shared/network/local/cashe_helper.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UperAppRegisterCubit(),
      child: BlocConsumer<UperAppRegisterCubit, UperAppRegisterStates>(
        listener: (context, state) {
          if (state is UperAppRegisterSuccessStates) {
            showToast(
                message: 'Create Account Successfully',
                state: ToastState.SUCCESS);
            SharedHelper.save(value: state.uid, key: 'uid');
            navigateToWithoutReturn(context, const HomeScreen());
          }
          if (state is UperAppRegisterErrorStates) {
            showToast(message: state.error.toString(), state: ToastState.ERROR);
          }
        },
        builder: (context, state) {
          String mode = SharedHelper.get(key: "mode") ?? "light";
          String image = "";
          if (mode == "dark") {
            image = "assets/images/3.jpg";
          } else {
            image = "assets/images/1.jpg";
          }
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Image.asset(
                            image,
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: MediaQuery.sizeOf(context).height * 0.3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultTextForm(
                              context: context,
                              onChanged: (val) {},
                              type: TextInputType.text,
                              Controller: UperAppRegisterCubit.get(context)
                                  .nameController,
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.indigo,
                              ),
                              text: 'Name',
                              validate: (val) {
                                if (val.toString().isEmpty) {
                                  return 'Please Enter Your Username';
                                }
                              },
                              onSubmitted: (val) {}),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextForm(
                              context: context,
                              onChanged: (val) {},
                              type: TextInputType.emailAddress,
                              Controller: UperAppRegisterCubit.get(context)
                                  .emailController,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.indigo,
                              ),
                              text: 'Email',
                              validate: (val) {
                                if (val.toString().isEmpty) {
                                  return 'Please Enter Your Email Address';
                                } else if (EmailValidator.validate(val) == true) {
                                  return null;
                                }
                              },
                              onSubmitted: (val) {}),
                          const SizedBox(
                            height: 10,
                          ),
                          IntlPhoneField(
                            showCountryFlag: true,
                            dropdownIcon: const Icon(
                              Icons.arrow_drop_down,
                              color: Colors.indigo,
                            ),
                            decoration: InputDecoration(
                              counterText: "",
                              label: const Text("Phone"),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              filled: true,
                            ),
                            controller:
                                UperAppRegisterCubit.get(context).phoneController,
                            style: Theme.of(context).textTheme.bodyText2,
                            onChanged: (val) {},
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextForm(
                              context: context,
                              onChanged: (val) {},
                              type: TextInputType.text,
                              Controller: UperAppRegisterCubit.get(context)
                                  .addressController,
                              prefixIcon: const Icon(
                                Icons.home,
                                color: Colors.indigo,
                              ),
                              text: 'Address',
                              validate: (val) {
                                if (val.toString().isEmpty) {
                                  return 'Please Enter Your Address';
                                }
                              },
                              onSubmitted: (val) {}),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextForm(
                            context: context,
                            onChanged: (val) {},
                            type: TextInputType.visiblePassword,
                            Controller: UperAppRegisterCubit.get(context)
                                .passwordController,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.indigo,
                            ),
                            text: 'Password',
                            validate: (val) {
                              if (val.toString().isEmpty) {
                                return 'Password is Very Short';
                              }
                            },
                            obscure:
                                UperAppRegisterCubit.get(context).obscurePassword,
                            onSubmitted: (val) {},
                            suffixIcon: IconButton(
                                onPressed: () {
                                  UperAppRegisterCubit.get(context)
                                      .changeVisibilityOfEye("pass");
                                },
                                icon: UperAppRegisterCubit.get(context)
                                    .passSuffixIcon),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          defaultTextForm(
                            context: context,
                            onChanged: (val) {
                              if (formKey.currentState!.validate()) {
                                UperAppRegisterCubit.get(context)
                                    .passwordMatch(val!, context);
                                return UperAppRegisterCubit.get(context)
                                    .matchPasswordMassage;
                              }
                            },
                            type: TextInputType.visiblePassword,
                            Controller: UperAppRegisterCubit.get(context)
                                .confirmPasswordController,
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.indigo,
                            ),
                            text: 'Confirm Password',
                            validate: (val) {
                              if (val.toString().isEmpty) {
                                return "Password must not be Empty";
                              }
                              if (UperAppRegisterCubit.get(context)
                                      .passwordController
                                      .text !=
                                  val) {
                                return 'Password is Not Match';
                              }
                            },
                            obscure: UperAppRegisterCubit.get(context)
                                .confirmObscurePassword,
                            onSubmitted: (val) {},
                            suffixIcon: IconButton(
                                onPressed: () {
                                  UperAppRegisterCubit.get(context)
                                      .changeVisibilityOfEye("confirmPass");
                                },
                                icon: UperAppRegisterCubit.get(context)
                                    .confirmPassSuffixIcon),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {
                              //register
                              if (formKey.currentState!.validate()) {
                                UperAppRegisterCubit.get(context).signUp();
                                FocusScope.of(context).unfocus();
                              }
                            },
                            color: HexColor('180040'),
                            child: const Text(
                              'REGISTER NOW',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateToWithReturn(context, ForgetPasswordScreen());
                            },
                            child:const Text("Forget Password"),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                            const Text("Have an account?"),
                            TextButton(
                              onPressed: () {
                                navigateToWithReturn(context, LogInScreen());
                              },
                              child:const Text("Sign In"),
                            ),
                          ],),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
