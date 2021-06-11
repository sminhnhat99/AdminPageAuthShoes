import 'package:admin_flutter/ProgressHUD.dart';
import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/constants.dart';
import 'package:admin_flutter/dashboard/dashboard_admin.dart';
import 'package:admin_flutter/model/addProduct_model.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final brandName = TextEditingController();
  final productName = TextEditingController();
  final description = TextEditingController();
  final productPrice = TextEditingController();
  final imageUrl = TextEditingController();
  final categoryName = TextEditingController();

  APIService apiService;
  String getsharetoken;
  AdminPreferences adminprefs;
  AddProductRequestModel addProductRequestModel;
  String sharetoken;


  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isApiCallProgress = false;
  @override
  void initState(){
    super.initState();
    addProductRequestModel = new AddProductRequestModel();
    AdminPreferences.instance
        .getStringValue('token')
        .then((value) => setState((){
          sharetoken = value;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiAddProduct(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _uiAddProduct(BuildContext context){
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Text(
              'Add Product',
              style: TextStyle(
                color: Colors.white,
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60.0,),
            Form(
              key: _formKey,
              child: Container(
                height: 500.0,
                decoration: BoxDecoration(
                  color: Color(0xFF2A2D3E),
                ),
                child: Column(
                  children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return 'Product Name cannot empty!!';
                                    }
                                    return null;
                                  },
                                  controller: productName,
                                  decoration: InputDecoration(hintText: 'Product Name'),
                                ),
                              ),
                              flex: 1,
                            ),
                            SizedBox(width: 40.0,),
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return 'Description cannot empty!!';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: description,
                                  decoration: InputDecoration(hintText: 'Description'),
                                ),
                              ),
                              flex: 4,
                            ),
                          ],
                        ),
                        SizedBox(height: 60.0,),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return 'Image URL cannot empty!!';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  controller: imageUrl,
                                  decoration: InputDecoration(hintText: 'Image URL'),
                                ),
                              ),
                              flex: 4,
                            ),
                            SizedBox(width: 40.0,),
                            Expanded(
                              child: Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if(value == null || value.isEmpty) {
                                      return 'Product price cannot empty!!';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.number,
                                  controller: productPrice,
                                  decoration: InputDecoration(hintText: 'Product Price'),
                                ),
                              ),
                              flex: 1,
                            ),
                          ],
                        ),
                        SizedBox(height: 60.0,),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if(value == null || value.isEmpty) {
                                  return 'Category Name cannot empty!!';
                                }
                                return null;
                              },
                              controller: categoryName,
                              decoration: InputDecoration(hintText: 'Category Name'),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(width: 200.0, height: 60.0),
                            child: Row(
                              children: [
                                ButtonTheme(
                                  minWidth: 200.0,
                                  height: 100.0,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(validateAndSave()){
                                        setState(() {
                                          isApiCallProgress = true;
                                        });

                                        // Call API
                                        APIService apiService = new APIService();
                                        addProductRequestModel.brandName = null;
                                        addProductRequestModel.productName = productName.value.text;
                                        addProductRequestModel.description = description.value.text;
                                        addProductRequestModel.productPrice = int.parse(productPrice.text);
                                        addProductRequestModel.imageUrl = imageUrl.value.text;
                                        addProductRequestModel.categoryName = categoryName.value.text;
                                        apiService.addProduct(addProductRequestModel, sharetoken)
                                              .then((value) {
                                                setState(() {
                                                  isApiCallProgress = false;
                                                });
                                                if(value != null) {
                                                  setState(() {
                                                    isApiCallProgress = false;
                                                    print(value.success);
                                                    print(value.data);
                                                  });
                                                  if(value.success == 1){
                                                    return showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            content: Text('Create Successful!! Click OK to return'),
                                                            actions: [
                                                              TextButton(onPressed: (){
                                                                Navigator.push( context, MaterialPageRoute( builder: (context) => DashboardAdmin()), ).then((value) => setState(() {}));
                                                              }, child: const Text('OK'))
                                                            ],
                                                          );
                                                        }
                                                    );
                                                  } else {
                                                    final snackBar = SnackBar(content: Text(
                                                      value.data.toString(),
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                      backgroundColor: Colors.white,
                                                    );
                                                    // ignore: deprecated_member_use
                                                    _scaffoldKey.currentState.showSnackBar(snackBar);
                                                  }
                                                }
                                        });
                                      }
                                    },
                                    child: Text('Add'),
                                  ),
                                ),
                                SizedBox(width: 60.0,),
                                ButtonTheme(
                                  minWidth: 200.0,
                                  height: 100.0,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel'),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }
    return false;
  }
}


