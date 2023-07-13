import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uper_app/layout/home_screen.dart';
import 'package:uper_app/modules/login/bloc/cubit.dart';
import 'package:uper_app/modules/login/bloc/states.dart';
import 'package:uper_app/modules/register/register.dart';
import 'package:uper_app/shared/components/components.dart';
import 'package:uper_app/shared/network/local/cashe_helper.dart';

class LogInScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UperAppLogInCubit(),
      child: BlocConsumer<UperAppLogInCubit, UperAppLogInStates>(
        listener: (context, state) {
          if (state is UperAppLogInSuccessStates) {
            showToast(
                message: 'Sign In Successfully ....',
                state: ToastState.WARNING);
            navigateToWithoutReturn(context, const HomeScreen());
            SharedHelper.save(value: state.uid, key: 'uid');
          }
          if (state is UperAppLogInErrorStates) {
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
            onTap: () {
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
                            height: 40,
                          ),
                          defaultTextForm(
                              context: context,
                              onChanged: (val) {},
                              type: TextInputType.emailAddress,
                              Controller: UperAppLogInCubit.get(context)
                                  .emailController,
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Colors.indigo,
                              ),
                              text: 'Email',
                              validate: (val) {
                                if (val.toString().isEmpty) {
                                  return 'Please Enter Your Email Address';
                                } else if (EmailValidator.validate(val) ==
                                    true) {
                                  return null;
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
                            Controller: UperAppLogInCubit.get(context)
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
                            UperAppLogInCubit.get(context).obscurePassword,
                            onSubmitted: (val) {},
                            suffixIcon: IconButton(
                                onPressed: () {
                                  UperAppLogInCubit.get(context)
                                      .changeVisibilityOfEye();
                                },
                                icon: UperAppLogInCubit.get(context)
                                    .passSuffixIcon),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: double.infinity,
                            onPressed: () {
                              //login
                              if (formKey.currentState!.validate()) {
                                UperAppLogInCubit.get(context).signIn();
                                FocusScope.of(context).unfocus();
                              }
                            },
                            color: HexColor('180040'),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Doesn\'t have an account?"),
                              const SizedBox(
                                width: 5,
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateToWithReturn(
                                      context, RegisterScreen());
                                },
                                child: const Text("Register"),
                              ),
                            ],
                          ),
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
