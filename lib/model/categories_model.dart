class Category {
  List<CategoryDetail> data;

  Category({this.data});

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(data: (json['data'] as List).map((i) => CategoryDetail.fromJson(i)).toList());
  }

}

class CategoryDetail {
  final int categoryId;
  final String categoryName;
  final String categoryImage;

  CategoryDetail({this.categoryId,this.categoryName,this.categoryImage});

  factory CategoryDetail.fromJson(Map<String, dynamic> json) {
    return CategoryDetail(categoryId: json['categoryId'], categoryName: json['categoryName'], categoryImage: json['categoryImage']);
  }
}