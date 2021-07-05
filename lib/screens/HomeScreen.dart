import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AboutScreen.dart';
import 'AllTodos.dart';
import 'ActiveTodos.dart';
import 'CompletedTodos.dart';
import 'TodoScreen.dart';
import '../controllers/TabController.dart';
import '../controllers/TodoController.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    final MyTabController tabController = Get.put(MyTabController());

    return SafeArea(
      child: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text(
            'Todo List',
            style: TextStyle(fontFamily: 'Raleway'),
          ),
          bottom: TabBar(
            controller: tabController.controller,
            tabs: tabController.myTabs,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            child: Icon(Icons.add),
            onPressed: () {
              print('fab pressed');
              Get.to(() => TodoScreen(), arguments: '');
            }),
        body: TabBarView(
          controller: tabController.controller,
          children: [
            AllTodos(todoController: todoController),
            ActiveTodos(todoController: todoController),
            CompletedTodos(todoController: todoController)
          ],
        ),
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18.0),
                bottomRight: Radius.circular(20.0),
              ),
              color: Colors.orange,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Todo List',
                    style: TextStyle(
                        fontSize: 42.0,
                        color: Colors.white,
                        letterSpacing: 3.0),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            focusColor: Colors.orange,
            title: Row(
              children: [
                FaIcon(FontAwesomeIcons.info),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  'About',
                  style: TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            onTap: () {
              Get.to(AboutScreen());
            },
          ),
        ],
      ),
    );
  }
}
