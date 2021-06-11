import 'package:admin_flutter/ProgressHUD.dart';
import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/constants.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:flutter/material.dart';

class UpdateCategoryPage extends StatefulWidget {
  @override
  _UpdateCategoryPageState createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _categoryNameController = TextEditingController();
  final _categoryImageController = TextEditingController();
  final _categoryIdController = TextEditingController();
  APIService apiService;
  String getsharetoken;
  bool isApiCallProgress = false;
  String sharetoken;
  @override
  void initState() {
    super.initState();
    AdminPreferences.instance
        .getStringValue('token')
        .then((value) => setState((){
      sharetoken = value;
    }));
  }
  @override
  Widget build(BuildContext context){
    return ProgressHUD(
      child: _updateCategory(context),
      inAsyncCall: isApiCallProgress,
      opacity: 0.3,
    );
  }

  Widget _updateCategory(BuildContext context) {
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
                            controller: _categoryIdController,
                            decoration: InputDecoration(hintText: 'Category ID'),
                          ),
                        ),
                          flex: 2,
                        ),
                        SizedBox(width: 40.0,),
                        Expanded(child: Container(
                          child: TextFormField(
                            controller: _categoryNameController,
                            decoration: InputDecoration(hintText: 'Category Name'),
                          ),
                        ),
                          flex: 2,
                        ),
                        ]
                    ),
                        Expanded(
                          child: Container(
                            child: TextFormField(
                              controller: _categoryImageController,
                              decoration: InputDecoration(hintText: 'Category Image URL'),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.0,),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.tightFor(width: 200.0, height:60.0 ),
                            child: GestureDetector(
                              child: ElevatedButton(
                                onPressed: () {
                                    // Call API
                                    APIService apiService = new APIService();
                                    apiService.updateCategories(_categoryNameController.text,_categoryImageController.text,int.parse(_categoryIdController.text),sharetoken)
                                        .then((value) {
                                      setState(() {
                                        isApiCallProgress = false;
                                      });
                                      if(value != null) {
                                        setState(() {
                                          isApiCallProgress = false;
                                          print(value.success);
                                          print(value.message);
                                        });
                                        if (value.success == 1){
                                          final snackBar = SnackBar(
                                            content: Text("Create Successful"),
                                          );
                                          setState(() {

                                          });
                                        } else {
                                          final snackBar = SnackBar(content: Text(
                                            value.message.toString(),
                                            style: TextStyle(color: Colors.black),
                                          ),
                                            backgroundColor: Colors.white,
                                          );
                                          // ignore: deprecated_member_use
                                          _scaffoldKey.currentState.showSnackBar(snackBar);
                                        }
                                      }
                                    });
                                  },
                                child: Text('Update'),
                              ),
                            ),
                          ),)
                      ],
                    )
                ),
              ),
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
