import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/dashboard/dashboard_addcategories.dart';
import 'package:admin_flutter/dashboard/dashboard_categoriesPage.dart';
import 'package:admin_flutter/dashboard/dashboard_updateCategory.dart';
import 'package:admin_flutter/model/categories_model.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:flutter/material.dart';

class Category_Page extends StatefulWidget {
  @override
  _Category_PageState createState() => _Category_PageState();
}

class _Category_PageState extends State<Category_Page> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  final _categoryImageController = TextEditingController();
  final _categoryIdController = TextEditingController();
  APIService apiService;
  String sharetoken;
  int delCategory;
  int categoryId;
  bool isApiCallProgress = false;
  @override
  void initState(){
    super.initState();
    apiService = new APIService();
    AdminPreferences.instance
      .getStringValue('token')
      .then((value) => setState((){
        sharetoken = value;
    }));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: _fetchCategoryData(),
    );
  }

  Widget _fetchCategoryData(){
    return FutureBuilder<Category>(
        future: apiService.listCategory(sharetoken),
        builder: (BuildContext context, AsyncSnapshot<Category> snapshot){
          if(snapshot.hasData){
            return _showListCategory(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
    );
  }


  Widget _showListCategory(Category category){
    return SingleChildScrollView(
      child: Column(
        children: [
          // -------------------------- Header ---------------------- //
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10.0),
              ),
              height: 100.0,
              width: 800.0,
              margin: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'List Categories',
                    style: (
                        TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0
                        )),
                  ),
                  SizedBox(width: 80.0,),
                  // ------------- Add Category ----------------------
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardAddCategories()));
                      },
                      child: Row(
                        children: [
                          Text(
                            'Add Category',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  // ------------- Edit Category ----------------------
                  ButtonTheme(
                    minWidth: 200.0,
                    height: 100.0,
                    child: ElevatedButton(
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('Edit Category'),
                              content: Stack(
                                // ignore: deprecated_member_use
                                overflow: Overflow.visible,
                                children: [
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _categoryIdController,
                                            decoration: InputDecoration(hintText: 'Category ID'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _categoryNameController,
                                            decoration: InputDecoration(hintText: 'Category Name'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _categoryImageController,
                                            decoration: InputDecoration(hintText: 'Category Image URL'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          // ignore: deprecated_member_use
                                          child: RaisedButton(
                                            child: Text('Edit'),
                                            onPressed: (){
                                              APIService apiService = new APIService();
                                              apiService.updateCategories(_categoryNameController.text,_categoryImageController.text,int.parse(_categoryIdController.text),sharetoken)
                                                  .then((value) {
                                                    if (value.success == 1){
                                                      return showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext context){
                                                          return AlertDialog(
                                                            content: Text('Edit Successful!!, Click Ok to return'),
                                                            actions: [
                                                              TextButton(onPressed: (){
                                                                Navigator.push( context, MaterialPageRoute( builder: (context) => DashBoardCategories()), ).then((value) => setState(() {}));
                                                              },
                                                              child: const Text('OK'),
                                                              )
                                                            ]
                                                          );
                                                        }
                                                      );
                                                  } else {
                                                    final snackBar = SnackBar(content: Text(
                                                      value.message.toString(),
                                                      style: TextStyle(color: Colors.black),
                                                    ),
                                                      backgroundColor: Colors.white,
                                                    );
                                                    // ignore: deprecated_member_use
                                                  }
                                                }
                                              );
                                            }
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            'Edit Category',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.app_registration)
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
          SizedBox(height: 60.0,),
          // ----------------------- List Categories -----------------
          GridView.builder(
            shrinkWrap: true,
            itemCount: category.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4),
            itemBuilder: (context, index) {
              var data = category.data[index];
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(right: 4.0),
                              width: 150.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0,5),
                                        blurRadius: 15.0
                                    )
                                  ]
                              ),
                              child: Image.network(
                                data.categoryImage.toString(),
                                height: 100.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6.0,),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(
                                    data.categoryName.toString(),
                                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:Text(
                                    data.categoryId.toString(),
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: (){
                           apiService.deleteCategory(sharetoken, data.categoryId).then((value) => {
                             if(value.success == 1) {
                             Navigator.push( context, MaterialPageRoute( builder: (context) => DashBoardCategories()), ).then((value) => setState(() {}))
                             }
                           });
                            },
                          child: Text('Delete', style: TextStyle(color: Colors.white),),
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                        ),
                        TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardUpdateCategories()));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ],
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
