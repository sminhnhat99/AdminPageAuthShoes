import 'package:admin_flutter/dashboard/dashboard_SearchProduct.dart';
import 'package:admin_flutter/dashboard/dashboard_addproduct.dart';
import 'package:admin_flutter/dashboard/dashboard_admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:admin_flutter/model/product_model.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _productPriceController = TextEditingController();
  final _productId = TextEditingController();
  final _productDescription = TextEditingController();
  final _productImageController = TextEditingController();
  APIService apiService;
  String sharetoken;
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
      child: _fetchData(),
    );
  }

  Widget _fetchData(){
    return FutureBuilder<Product>(
      future: apiService.listProducts(sharetoken),
      builder: (BuildContext context, AsyncSnapshot<Product> snapshot){
        if(snapshot.hasData){
          return _showListProduct(snapshot.data);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _showListProduct(Product products){
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
                    'Products',
                  style: (
                  TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0
                  )),
                ),
                SizedBox(width: 50.0,),
                // ------------- Add Products ----------------------
                ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DashBoardAddProduct()));
                    },
                    child: Row(
                      children: [
                        Text(
                          'Add',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                // ----------------- Search Products ---------------------
                ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  child: ElevatedButton(
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
                                          child: Text('Search by Name',),),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            validator: (value) {
                                              if(value == null || value.isEmpty) {
                                                return 'Product name cannot be empty!';
                                              }
                                              return null;
                                            },
                                            controller: _productNameController,
                                            decoration: InputDecoration(
                                              hintText: 'Product Name:',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ElevatedButton(
                                            child: Text('Search'),
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardSearch(productName: _productNameController.text,)));
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
                    },
                    child: Row(
                      children: [
                        Text(
                          'Search',
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(Icons.search)
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                // ------------------------- Edit ----------------------
                ButtonTheme(
                  minWidth: 200.0,
                  height: 100.0,
                  child:ElevatedButton(
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog(
                              title: Text('Edit Product'),
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
                                            controller: _productId,
                                            decoration: InputDecoration(hintText: 'Product ID'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _productNameController,
                                            decoration: InputDecoration(hintText: 'Product Name'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _productPriceController,
                                            decoration: InputDecoration(hintText: 'Product Price'),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _productDescription,
                                            decoration: InputDecoration(hintText: 'Description'),
                                            keyboardType: TextInputType.multiline,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _productImageController,
                                            decoration: InputDecoration(hintText: 'Product Image URL'),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          // ignore: deprecated_member_use
                                          child: RaisedButton(
                                              child: Text('Edit'),
                                              onPressed: (){
                                                APIService apiService = new APIService();
                                                apiService.updateProduct(sharetoken, _productNameController.text,int.parse(_productPriceController.text),
                                                  int.parse(_productId.text),_productNameController.text,_productImageController.text)
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
                                                                  Navigator.push( context, MaterialPageRoute( builder: (context) => DashboardAdmin()), ).then((value) => setState(() {}));
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
                          'Edit',
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
          // ----------------------- List Products -----------------------
          GridView.builder(
            shrinkWrap: true,
            itemCount: products.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:4),
            itemBuilder: (context, index) {
              var data = products.data[index];
              return GestureDetector(
                onTap: (){

                },
                child: Column(
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
                                data.imageUrl.toString(),
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
                                    data.productName.toString(),
                                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  subtitle:Text(
                                    'ID: ' + data.productId.toString(),
                                    style: TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  'Price:' + ' ' + '\$${data.productPrice}' + ' ' +  'USD',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                  ),
                                )
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
                            onPressed: (){},
                            child: Text('Delete', style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
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
}