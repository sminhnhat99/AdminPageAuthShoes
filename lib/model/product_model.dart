class Product {
  List<ProductDetail> data;

  Product({this.data});

  factory Product.fromJson(Map<String,dynamic> json) {
    return Product(data: (json['data'] as List).map((i) => ProductDetail.fromJson(i)).toList());
  }

}

class ProductDetail {
  final int productId;
  final String productName;
  final String categoryName;
  final String description;
  final int productPrice;
  final String imageUrl;
  ProductDetail({this.productId,this.productName,this.categoryName,this.description,this.productPrice,this.imageUrl});

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(productId: json['productId'], productName: json['productName'], categoryName: json['categoryName'], description: json['description'], productPrice: json['productPrice'], imageUrl: json['imageUrl']);
  }
}

