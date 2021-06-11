class AddCategoriesResponseModel{
  final int success;
  final int data;

  AddCategoriesResponseModel({this.success,this.data});
  factory AddCategoriesResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return AddCategoriesResponseModel(
      success: json["success"] != null ? json["success"] : "",
      data: json["data"] != null ? json["data"]: "",
    );
  }

}

class AddCategoriesRequestModel {
  String categoryName;
  String categoryImage;

  AddCategoriesRequestModel({
    this.categoryName,
    this.categoryImage
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'categoryName': categoryName.trim(),
      'categoryImage': categoryImage.trim(),
    };
    return map;
  }

}