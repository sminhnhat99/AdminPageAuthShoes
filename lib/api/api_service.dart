import 'package:admin_flutter/model/active_model.dart';
import 'package:admin_flutter/model/addCategories_model.dart';
import 'package:admin_flutter/model/addProduct_model.dart';
import 'package:admin_flutter/model/categories_model.dart';
import 'package:admin_flutter/model/deleteCategories_model.dart';
import 'package:admin_flutter/model/deleteUser_model.dart';
import 'package:admin_flutter/model/findUser_model.dart';
import 'package:admin_flutter/model/searchProduct_model.dart';
import 'package:admin_flutter/model/updateCategories_model.dart';
import 'package:admin_flutter/model/updateProduct_model.dart';
import 'package:admin_flutter/model/updateUser_model.dart';
import 'package:admin_flutter/model/user_model.dart';
import 'package:admin_flutter/model/viewOrder_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:admin_flutter/model/login_model.dart';
import 'package:admin_flutter/model/product_model.dart';

class APIService {

  // ---------------------------------- LOGIN ---------------------------- //
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    String url = "http://localhost:3000/api/login";

    final response = await http.post(url, body: requestModel.toJson() );

    if(response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 401){
      return LoginResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load Data');
    }
  }

  //--------------------------- Categories -------------------------------- //

  Future<Category> listCategory(String token) async {

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    String url = "http://localhost:3000/Api/Category/GetAllCategory";
    final response = await http.get(url,headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return Category.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<AddCategoriesResponseModel> addCategories(AddCategoriesRequestModel addCategoriesRequestModel, String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final body = jsonEncode(addCategoriesRequestModel);
    String url = "http://localhost:3000/Api/Category/create?=";
    final response = await http.post(url, headers: headers, body: body);
    if(response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 401){
      return AddCategoriesResponseModel.fromJson(json.decode(response.body));
    }
    else {
      throw Exception('Failed to load Data');
    }
  }

  Future<DeleteCategory> deleteCategory(String token, int categoryId) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    String url = "http://localhost:3000/Api/Category/?categoryId=" + '$categoryId';
    final response = await http.delete(url,headers: headers);
    if(response.statusCode == 200 || response.statusCode == 401) {
      return DeleteCategory.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UpdateCategoriesResponseModel> updateCategories(String categoryName, String categoryImage,int categoryId, String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final body = {
      "categoryName" : categoryName,
      "categoryImage" : categoryImage,
      "categoryId": categoryId,
    };
    print(body);
    String url = "http://localhost:3000/api/Category/updateCategory";
    final response = await http.patch(url,headers: headers,body: jsonEncode(body));
    if(response.statusCode == 200 || response.statusCode == 401) {
      return UpdateCategoriesResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }


  // --------------------------------- Products ----------------------------//

  Future<Product> listProducts(String token) async {

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    String url = "http://localhost:3000/Api/Product/GetAllProduct";
    final response = await http.get(url,headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return Product.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<AddProductResponseModel> addProduct (AddProductRequestModel addProductRequestModel, String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final body = jsonEncode(addProductRequestModel);
    String url = "http://localhost:3000/Api/Product/Create";
    final response = await http.post(url, headers: headers, body: body);
    if(response.statusCode == 200 || response.statusCode == 400 || response.statusCode == 401){
      return AddProductResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Data');
    }

  }
  Future<SearchProduct> searchProducts(String token, String productName) async {

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    String url = "http://localhost:3000/Api/Product/SearchProduct/?productName=" + "$productName";
    final response = await http.get(url,headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return SearchProduct.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UpdateProductResponseModel> updateProduct(String token, String productName, int productPrice,int productId, String description, String imageUrl) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final body = {
      "productName" : productName.trim(),
      "productPrice" : productPrice,
      "productId" : productId,
      "description" : description.trim(),
      "imageUrl" : imageUrl.trim(),
    };
    print(body);
    String url = "http://localhost:3000/api/Product/updateProduct";
    final response = await http.patch(url,headers: headers,body: jsonEncode(body));
    if(response.statusCode == 200 || response.statusCode == 401) {
      return UpdateProductResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  // --------------------- Orders ---------------------------------//


  Future<Order> listOrder(String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    String url = "http://localhost:3000/Api/order/viewOrder";
    final response = await http.get(url,headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return Order.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<ActiveOrder> activeOrder(String token, String orderId) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    String url = "http://localhost:3000/Api/order/viewOrder";
    final body = {
      "orderId" : orderId.trim()
    };
    final response = await http.put(url, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200 || response.statusCode == 401) {
      return ActiveOrder.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }

  }

  // -------------------------- User ------------------------//

  Future<User> listUser(String token) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    String url = "http://localhost:3000/api/users/getUsers";
    final response = await http.get(url,headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401 || response.statusCode == 201) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }


  Future<DeleteUser> deleteUser(String token, int userId) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    String url = "http://localhost:3000/api/users/deleteUser?id=" + '$userId';
    final response = await http.delete(url,headers: headers);
    if(response.statusCode == 200 || response.statusCode == 401) {
      return DeleteUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<SearchUser> searchUser(String token, int userId) async {

    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };

    String url = "http://localhost:3000/api/users/getUserById?id=" + "$userId";
    print(url);
    print(token);
    final response = await http.get(url,headers: headers);
    if (response.statusCode == 200 || response.statusCode == 401) {
      return SearchUser.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<UpdateUserResponseModel> updateUser(String token, String userName, String phone, String email, String address, int userId) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    final body = {
      "userName": userName.trim(),
      "phone": phone.trim(),
      "email": email.trim(),
      "address": address.trim(),
      "Id": userId,
    };
    print(body);
    String url = "http://localhost:3000/api/users/updateUser";
    final response = await http.patch(url,headers: headers,body: jsonEncode(body));
    if(response.statusCode == 200 || response.statusCode == 401) {
      return UpdateUserResponseModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data!');
    }
  }

}