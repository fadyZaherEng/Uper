abstract class UperAppLogInStates{}

class UperAppLogInInitialStates extends UperAppLogInStates{}
class UperAppLogInLoadingStates extends UperAppLogInStates{}
class UperAppLogInSuccessStates extends UperAppLogInStates{
  String uid;

  UperAppLogInSuccessStates(this.uid);
}
class UperAppLogInErrorStates extends UperAppLogInStates{
  String error;
  UperAppLogInErrorStates(this.error);
}

class UperAppLogInChangeEyeStates extends UperAppLogInStates{}
class UperAppLogInChangeImageStates extends UperAppLogInStates{}
//image
class UperAppLogInImageSuccessStates extends UperAppLogInStates{}
class UperAppLogInImageErrorStates extends UperAppLogInStates{}