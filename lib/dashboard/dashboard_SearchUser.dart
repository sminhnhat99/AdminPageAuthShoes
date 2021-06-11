import 'package:admin_flutter/dashboard/dashboard_categoriesPage.dart';
import 'package:admin_flutter/dashboard/dashboard_order.dart';
import 'package:admin_flutter/dashboard/dashboard_user.dart';
import 'package:admin_flutter/pages/searchProduct.dart';
import 'package:admin_flutter/pages/searchUser.dart';
import 'package:flutter/material.dart';

class DashboardSearchUser extends StatefulWidget {
  int userId;
  DashboardSearchUser({this.userId});
  @override
  _DashboardSearchUserState createState() => _DashboardSearchUserState();
}

class _DashboardSearchUserState extends State<DashboardSearchUser> {
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
                        onTap: () {},
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
                        tileColor: Colors.blue,
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.people, color: Colors.white54,),
                        title: Text(
                          'Users List',
                          style: TextStyle(color: Colors.white),
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
                child: SearchUserPage(userId: this.widget.userId,),
              ),
                  flex: 5
              )
            ],
          ),
        )
    );
  }
}
