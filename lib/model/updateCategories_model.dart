class UpdateCategoriesResponseModel{
  final int success;
  final String message;

  UpdateCategoriesResponseModel({this.success,this.message});
  factory UpdateCategoriesResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return UpdateCategoriesResponseModel(
      success: json["success"] != null ? json["success"] : "",
      message: json["message"] != null ? json["message"]: "",
    );
  }

}
