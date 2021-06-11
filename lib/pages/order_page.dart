import 'package:admin_flutter/api/api_service.dart';
import 'package:admin_flutter/dashboard/dashboard_order.dart';
import 'package:admin_flutter/model/viewOrder_model.dart';
import 'package:admin_flutter/share_token.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
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
        print('List Order' + ' ' + value);
    }));
  }
  @override

  Widget build(BuildContext context) {
    return Container(
      child: _fetchOrderData(),
    );
  }

  Widget _fetchOrderData(){
    return FutureBuilder<Order>(
        future: apiService.listOrder(sharetoken),
        builder: (BuildContext context, AsyncSnapshot<Order> snapshot){
          if(snapshot.hasData){
            return _showListOrder(snapshot.data);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  Widget _showListOrder(Order order){
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
                    'List Orders',
                    style: (
                        TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 40.0
                        )),
                  ),
                  SizedBox(width: 80.0,),
                ],
              )
          ),
          SizedBox(height: 60.0,),
          // ----------------------- List Categories -----------------
          GridView.builder(
            shrinkWrap: true,
            itemCount: order.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:4),
            itemBuilder: (context, index) {
              var data = order.data[index];
              String status = data.status;
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
                                    'User ID:' + ' ' + data.userId.toString(),

                                  ),
                                  subtitle: Text(
                                    'Total Price:' + ' ' + data.totalPrice.toString(),
                                    style: TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ),
                                Text(
                                  '${data.status}',
                                  style: TextStyle(
                                      color: (status == "expired") ? Colors.redAccent : Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          apiService.activeOrder(sharetoken, data.orderId).then((value) => {
                                            if(value.success == 1){
                                              print(value.message),
                                              Navigator.push( context, MaterialPageRoute( builder: (context) => DashboardOrder()), ).then((value) => setState(() {}))
                                            }
                                          });
                                        },
                                        child: Text('Active')),
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
