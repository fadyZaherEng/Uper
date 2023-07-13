class UserProfile
{
  dynamic name,phone,email,uid,address;
  UserProfile({required this.address,required this.name,
    required this.phone,required this.email,required this.uid});

  UserProfile.fromJson(Map<String,dynamic>?json)
  {
    name=json!['name'];
    phone=json['phone'];
    email=json['email'];
    uid=json['uid'];
    address=json['address'];
  }
  Map<String,dynamic> toMap(){
    return{
      'phone':phone,
      'uid':uid,
      'email':email,
      'name':name,
      'address':address,
    };
  }
}