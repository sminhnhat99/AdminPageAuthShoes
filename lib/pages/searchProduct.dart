import 'package:admin_flutter/constants.dart';
import 'package:admin_flutter/dashboard/dashboard_SearchProduct.dart';
import 'package:admin_flutter/dashboard/dashboard_addproduct.dart';
import 'package:admin_flutter/model/searchProduct_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:admin_flutter/model/product_model.dart';

class SearchProductPage extends StatefulWidget {
  String productName;
  SearchProductPage({this.productName});
  @override
  _SearchProductPageState createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {
  APIService apiService;
  String sharetoken;
  final _productNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    print(this.widget.productName);
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
   return FutureBuilder<SearchProduct>(
     future: apiService.searchProducts(sharetoken, this.widget.productName),
     builder: (BuildContext context, AsyncSnapshot<SearchProduct> snapshot){
       if(snapshot.hasData){
         return _showFindProduct(snapshot.data);
       }
       return Center(
         child: CircularProgressIndicator(),
       );
     }
   );
  }
  Widget _showFindProduct(SearchProduct searchProduct){
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
                    'List Products',
                    style: (
                        TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0
                        )),
                  ),
                  SizedBox(width: 80.0,),
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
                            'Add Products',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 30.0,),
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
                                                  return 'User ID cannot be empty!';
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
                            'Search Products',
                            style: TextStyle(
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Icon(Icons.search)
                        ],
                      ),
                    ),
                  )
                ],
              )
          ),
          SizedBox(height: 60.0,),
          // ----------------------- List Products -----------------------
          GridView.builder(
            shrinkWrap: true,
            itemCount: searchProduct.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:4),
            itemBuilder: (context, index) {
              var data = searchProduct.data[index];
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
                                    data.categoryName.toString(),
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  'Price:' + ' ' + '\$${data.productPrice}' + ' ' +  'USD',
                                  style: TextStyle(
                                    color: Colors.redAccent,
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
                        SizedBox(width: 8.0,),
                        TextButton(
                          onPressed: (){},
                          child: Text('Update'),
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