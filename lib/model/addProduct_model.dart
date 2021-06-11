class AddProductResponseModel {
  final int success;
  final String data;

  AddProductResponseModel({this.success,this.data});
  factory AddProductResponseModel.fromJson(Map<dynamic, dynamic> json) {
    return AddProductResponseModel(
      success: json["success"] != null ? json["success"] : "",
      data: json["data"] != null ? json["data"]: "",
    );
  }
}

class AddProductRequestModel {
  String brandName;
  String productName;
  String description;
  int productPrice;
  String imageUrl;
  String categoryName;
  AddProductRequestModel({
    this.brandName,
    this.productName,
    this.description,
    this.productPrice,
    this.imageUrl,
    this.categoryName,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'brandName': null,
      'productName': productName.trim(),
      'description': description.trim(),
      'productPrice': productPrice,
      'imageUrl': imageUrl.trim(),
      'categoryName': categoryName.trim()
    };
    return map;
  }

}