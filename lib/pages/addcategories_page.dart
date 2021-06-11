import 'package:admin_flutter/ProgressHUD.dart';
import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/constants.dart';
import 'package:admin_flutter/dashboard/dashboard_categoriesPage.dart';
import 'package:admin_flutter/model/addCategories_model.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:flutter/material.dart';

class AddCategories extends StatefulWidget {
  @override
  _AddCategoriesState createState() => _AddCategoriesState();
}

class _AddCategoriesState extends State<AddCategories> {

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _categoryNameController = TextEditingController();
  final _categoryImageController = TextEditingController();
  APIService apiService;
  String getsharetoken;
  AdminPreferences adminprefs;
  AddCategoriesRequestModel addCategoriesRequestModel;
  bool isApiCallProgress = false;
  String sharetoken;

  @override
  void initState() {
    super.initState();
    addCategoriesRequestModel = new AddCategoriesRequestModel();
    AdminPreferences.instance
        .getStringValue('token')
        .then((value) => setState((){
      sharetoken = value;
    }));
  }

  @override
  Widget build(BuildContext context){
    return ProgressHUD(
      child: _uiAddCate(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }
  Widget _uiAddCate(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Text(
              'Add Categories',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.0
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
                        Expanded(child: Container(
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return 'Category Name cannot empty!';
                              }
                              return null;
                            },
                            controller: _categoryNameController,
                            decoration: InputDecoration(hintText: 'Category Name'),
                          ),
                        ),
                          flex: 2,
                        ),
                        SizedBox(width: 40.0,),
                        Expanded(child: Container(
                          child: TextFormField(
                            validator: (value) {
                              if(value == null || value.isEmpty){
                                return 'Category Image cannot empty!';
                              }
                              return null;
                            },
                            controller: _categoryImageController,
                            decoration: InputDecoration(hintText: 'Category Image'),
                          ),
                        ),
                          flex: 2,
                        ),
                      ],
                    ),
                    SizedBox(height: 60.0,),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 350.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(width: 200.0, height:60.0 ),
                            child: ElevatedButton(
                              onPressed: () {
                                if(validateAndSave()){
                                  setState(() {
                                    isApiCallProgress = true;
                                  });

                                  // Call API
                                  APIService apiService = new APIService();
                                  addCategoriesRequestModel.categoryName = _categoryNameController.value.text;
                                  addCategoriesRequestModel.categoryImage = _categoryImageController.value.text;
                                  apiService.addCategories(addCategoriesRequestModel, sharetoken)
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
                                      if (value.success == 1){
                                        return showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: Text('Create Successful!! Click OK to return'),
                                              actions: [
                                                TextButton(onPressed: (){
                                                  Navigator.push( context, MaterialPageRoute( builder: (context) => DashBoardCategories()), ).then((value) => setState(() {}));
                                                }, child: const Text('OK'))
                                              ],
                                            );
                                          }
                                        );
                                      } else {
                                        final snackBar = SnackBar(content: Text(
                                          value.data.toString()
                                          ,
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
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ConstrainedBox(
                              constraints: BoxConstraints.tightFor(width: 200.0, height:60.0 ),
                              child: ElevatedButton(
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            )
                        )
                      ],
                    ),
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
