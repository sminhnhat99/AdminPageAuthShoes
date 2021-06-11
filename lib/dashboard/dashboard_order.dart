import 'package:admin_flutter/dashboard/dashboard_admin.dart';
import 'package:admin_flutter/dashboard/dashboard_categoriesPage.dart';
import 'package:admin_flutter/dashboard/dashboard_user.dart';
import 'package:admin_flutter/pages/order_page.dart';
import 'package:flutter/material.dart';

class DashboardOrder extends StatefulWidget {
  @override
  _DashboardOrderState createState() => _DashboardOrderState();
}

class _DashboardOrderState extends State<DashboardOrder> {
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
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardAdmin()));
                        },
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.list, color: Colors.white54,),
                        title: Text(
                          'Product List',
                          style: TextStyle(color: Colors.white54),
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
                        onTap: () {},
                        tileColor: Colors.blue,
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.assignment, color: Colors.white54),
                        title: Text(
                          'Orders Lists',
                          style: TextStyle(color: Colors.white),

                        ),
                      )
                    ],
                  )
              ),
              Expanded(child: Container(
                child: OrderPage(),
              ),
                  flex: 5
              )
            ],
          ),
        )
    );
  }
}
