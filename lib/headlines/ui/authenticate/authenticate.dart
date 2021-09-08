import 'package:flutter/material.dart';
import 'package:headlines/headlines/ui/authenticate/login_route.dart';
import 'package:headlines/headlines/ui/authenticate/signup_route.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> 
with SingleTickerProviderStateMixin {
  TabController tabController;
    
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    // tabController.addListener(tabChanged);
  }
  
  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }
  
  void tabChanged() {
    if (tabController.indexIsChanging) {
      
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          SignInWidget(),
          
          SignUpWidget()
        ]
      ),
      bottomNavigationBar: TabBar(
        controller: tabController,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.black38,
        tabs: <Widget>[
          Tab(
            text: 'Login',
            // icon: Icon(Icons.login_rounded)
          ),
          Tab(
            text: 'Sign Up',
            // icon: Icon(Icons.edit)
          )
        ]
      )
    );
  }
}
