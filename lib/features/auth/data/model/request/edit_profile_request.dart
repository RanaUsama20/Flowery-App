class EditProfileRequest
{
    String? firstName;
    String? lastName;
    String? email;
    String? phone;
    String? url;

  EditProfileRequest({ this.firstName,  this.lastName, this.email,  this.phone,  this.url});


    Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = {};

      if (firstName != null && firstName!.isNotEmpty) {
        data["firstName"] = firstName;
      }
      if (lastName != null && lastName!.isNotEmpty) {
        data["lastName"] = lastName;
      }
      if (email != null && email!.isNotEmpty) {
        data["email"] = email;
      }
      if (phone != null && phone!.isNotEmpty) {
        data["phone"] = phone;
      }
      return data;
    }

}

