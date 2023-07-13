abstract class UperAppRegisterStates{}

class UperAppRegisterInitialStates extends UperAppRegisterStates{}
class UperAppRegisterLoadingStates extends UperAppRegisterStates{}
class UperAppRegisterSuccessStates extends UperAppRegisterStates{
  String uid;

  UperAppRegisterSuccessStates(this.uid);
}
class UperAppRegisterErrorStates extends UperAppRegisterStates{
  String error;
  UperAppRegisterErrorStates(this.error);
}

class UperAppRegisterChangeEyeStates extends UperAppRegisterStates{}
class UperAppRegisterChangeImageStates extends UperAppRegisterStates{}
//image
class UperAppRegisterImageSuccessStates extends UperAppRegisterStates{}
class UperAppRegisterImageErrorStates extends UperAppRegisterStates{}