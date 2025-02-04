class UserModel {
  String? name;
  String? dateOfBirth;
  String? gender;
  String? email;
  String? mobileNumber;
  String? country;
  String? state;
  String? city;
  String? yatraName;
  bool? initiated;
  String? initiatedName;
  String? spiritualMaster;
  String? intitiationDate;
  String? maritalStatus;
  String? profilePictureUrl;
  int? id;

  UserModel(
      {this.name,
      this.dateOfBirth,
      this.gender,
      this.email,
      this.mobileNumber,
      this.country,
      this.state,
      this.city,
      this.yatraName,
      this.initiated,
      this.initiatedName,
      this.spiritualMaster,
      this.intitiationDate,
      this.maritalStatus,
      this.profilePictureUrl,
      this.id});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    yatraName = json['yatra_name'];
    initiated = json['initiated'];
    initiatedName = json['initiated_name'];
    spiritualMaster = json['spiritual_master'];
    intitiationDate = json['intitiation_date'];
    maritalStatus = json['marital_status'];
    profilePictureUrl = json['profile_picture_url'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['yatra_name'] = yatraName;
    data['initiated'] = initiated;
    data['initiated_name'] = initiatedName;
    data['spiritual_master'] = spiritualMaster;
    data['intitiation_date'] = intitiationDate;
    data['marital_status'] = maritalStatus;
    data['profile_picture_url'] = profilePictureUrl;
    data['id'] = id;
    return data;
  }
}
