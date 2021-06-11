import 'package:admin_flutter/dashboard/dashboard_categoriesPage.dart';
import 'package:admin_flutter/dashboard/dashboard_order.dart';
import 'package:admin_flutter/dashboard/dashboard_user.dart';
import 'package:admin_flutter/pages/searchProduct.dart';
import 'package:flutter/material.dart';

class DashboardSearch extends StatefulWidget {
  String productName;
  DashboardSearch({this.productName});
  @override
  _DashboardSearchState createState() => _DashboardSearchState();
}

class _DashboardSearchState extends State<DashboardSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Row(
            children: [
              Expanded(
                  child: Column(
                    children: [
                      DrawerHeader(child: FlutterLogo()),
                      ListTile(
                        tileColor: Colors.blue,
                        onTap: () {},
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.list, color: Colors.white54,),
                        title: Text(
                          'Product List',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardCategories()));
                        },
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.account_tree, color: Colors.white54,),
                        title: Text(
                          'Categories List',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardUser()));
                        },
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.people, color: Colors.white54,),
                        title: Text(
                          'Users List',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardOrder()));
                        },
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.assignment, color: Colors.white54),
                        title: Text(
                          'Orders List',
                          style: TextStyle(color: Colors.white54),

                        ),
                      )
                    ],
                  )
              ),
              Expanded(child: Container(
                child: SearchProductPage(productName: this.widget.productName,),
              ),
                  flex: 5
              )
            ],
          ),
        )
    );
  }
}
