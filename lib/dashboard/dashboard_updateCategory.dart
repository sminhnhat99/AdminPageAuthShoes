import 'package:admin_flutter/dashboard/dashboard_admin.dart';
import 'package:admin_flutter/pages/updateCategory_page.dart';
import 'package:flutter/material.dart';

class DashBoardUpdateCategories extends StatefulWidget {
  @override
  _DashBoardUpdateCategoriesState createState() => _DashBoardUpdateCategoriesState();
}

class _DashBoardUpdateCategoriesState extends State<DashBoardUpdateCategories> {
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

                        },
                        tileColor: Colors.blue,
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.people, color: Colors.white54,),
                        title: Text(
                          'Categories List',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ListTile(
                        onTap: () {

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
                        hoverColor: Colors.blueAccent,
                        horizontalTitleGap: 0.0,
                        leading: Icon(Icons.assignment, color: Colors.white54),
                        title: Text(
                          'Orders Lists',
                          style: TextStyle(color: Colors.white54),

                        ),
                      )
                    ],
                  )
              ),
              Expanded(child: Container(
                child: UpdateCategoryPage(),
              ),
                  flex: 5
              )
            ],
          ),
        )
    );
  }
}
