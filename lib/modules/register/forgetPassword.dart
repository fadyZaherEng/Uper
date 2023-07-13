import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:uper_app/modules/login/login_screen.dart';
import 'package:uper_app/modules/register/bloc/cubit.dart';
import 'package:uper_app/shared/components/components.dart';
import 'package:uper_app/shared/network/local/cashe_helper.dart';

class ForgetPasswordScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();

  void submit() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim())
        .then((value) {
          showToast(message: "we have sent you an email to recover password,please check your email", state:ToastState.SUCCESS);
    },).catchError((onError){
      showToast(message: onError.toString(), state: ToastState.ERROR);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      height: 20,
                    ),
                    const Text("Forget Password",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                    const SizedBox(height: 20,),
                    defaultTextForm(
                        context: context,
                        onChanged: (val) {},
                        type: TextInputType.emailAddress,
                        Controller: emailController,
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
                      height: 30,
                    ),
                    MaterialButton(
                      height: 50,
                      minWidth: double.infinity,
                      onPressed: () {
                        //register
                        if (formKey.currentState!.validate()) {
                          submit();
                          FocusScope.of(context).unfocus();
                        }
                      },
                      color: HexColor('180040'),
                      child: const Text(
                        'Send Reset Password',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            navigateToWithReturn(context, LogInScreen());
                          },
                          child: const Text("Sign In"),
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
  }
}
