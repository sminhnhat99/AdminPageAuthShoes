class UpdateUserResponseModel{
  final int success;
  final String message;

  UpdateUserResponseModel({this.success,this.message});
  factory UpdateUserResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return UpdateUserResponseModel(
      success: json["success"] != null ? json["success"] : "",
      message: json["message"] != null ? json["message"]: "",
    );
  }

}
