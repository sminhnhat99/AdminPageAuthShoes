class UpdateProductResponseModel{
  final int success;
  final String message;

  UpdateProductResponseModel({this.success,this.message});
  factory UpdateProductResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return UpdateProductResponseModel(
      success: json["success"] != null ? json["success"] : "",
      message: json["message"] != null ? json["message"]: "",
    );
  }
}
