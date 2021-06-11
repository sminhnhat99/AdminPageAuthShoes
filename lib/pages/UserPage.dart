import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/dashboard/dashboard_SearchUser.dart';
import 'package:admin_flutter/dashboard/dashboard_user.dart';
import 'package:admin_flutter/model/findUser_model.dart';
import 'package:admin_flutter/model/user_model.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  APIService apiService;
  String sharetoken;
  final _idController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _userPhoneController = TextEditingController();
  final _userEmailController = TextEditingController();
  final _userAddressController = TextEditingController();
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
      child: _fetchUserData(),
    );
  }

  Widget _fetchUserData(){
    return FutureBuilder(
      future: apiService.listUser(sharetoken),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot){
        if(snapshot.hasData){
          return _showListUser(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _showListUser(User user){
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
                    'List Users',
                    style: (
                        TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0
                        )),
                  ),
                  SizedBox(width: 80.0,),
                  IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.search),
                      onPressed: (){
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Stack(
                                // ignore: deprecated_member_use
                                overflow: Overflow.visible,
                                children: [
                                  Positioned(
                                    right: -40.0,
                                    top: -40.0,
                                    child: InkResponse(
                                      onTap: (){
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(padding: EdgeInsets.all(8.0),
                                        child: Text('Search by ID',),),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (value) {
                                              if(value == null || value.isEmpty) {
                                                return 'User ID cannot be empty!';
                                              }
                                              return null;
                                            },
                                            controller: _idController,
                                            decoration: InputDecoration(
                                              hintText: 'User ID:',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            child: Text('Search'),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardSearchUser(userId: int.parse(_idController.text),)));
                                            },
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
                      }
                  ),
                  IconButton(
                      color: Colors.blue,
                      icon: Icon(Icons.app_registration),
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Stack(
                                  // ignore: deprecated_member_use
                                  overflow: Overflow.visible,
                                  children: [
                                    Positioned(
                                      right: -40.0,
                                      top: -40.0,
                                      child: InkResponse(
                                        onTap: (){
                                          Navigator.of(context).pop();
                                        },
                                        child: CircleAvatar(
                                          child: Icon(Icons.close),
                                          backgroundColor: Colors.red,
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
                                              controller: _idController,
                                              decoration: InputDecoration(hintText: 'User ID'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: _userNameController,
                                              decoration: InputDecoration(hintText: 'User Name'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: _userAddressController,
                                              decoration: InputDecoration(hintText: 'User Address'),
                                              keyboardType: TextInputType.multiline,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: _userPhoneController,
                                              decoration: InputDecoration(hintText: 'User Phone Number'),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: TextFormField(
                                              controller: _userEmailController,
                                              decoration: InputDecoration(hintText: 'User Email'),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                              child: Text('Edit'),
                                              onPressed: (){
                                                APIService apiService = new APIService();
                                                apiService.updateUser(sharetoken,_userNameController.text,_userPhoneController.text,_userEmailController.text,_userAddressController.text,int.parse(_idController.text))
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
                                                                  Navigator.push( context, MaterialPageRoute( builder: (context) => DashboardUser()), ).then((value) => setState(() {}));
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
                                              },
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
                      }
                  ),
                ],
              )
          ),
          SizedBox(height: 60.0,),
          // ----------------------- List Categories -----------------
          GridView.builder(
            shrinkWrap: true,
            itemCount: user.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4),
            itemBuilder: (context, index) {
              var data = user.data[index];
              return GestureDetector(
                onTap: (){

                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: Text(
                                'User name:' + ' ' + data.userName.toString(),

                              ),
                              subtitle: Text(
                                'Email: ' + ' ' + data.email.toString(),
                                style: TextStyle(fontSize: 12, color: Colors.white),
                              ),
                            ),
                            Text(
                              '${data.Id}',
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: (){
                                      apiService.deleteUser(sharetoken, data.Id).then((value) => {
                                        if(value.success == 1){
                                          setState((){

                                          })
                                        }
                                      });
                                    },
                                    child: Text('Delete', style: TextStyle(color: Colors.white),),
                                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),),
                                const SizedBox(width: 8.0,),

                              ],
                            )
                          ]
                      ),
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
}
