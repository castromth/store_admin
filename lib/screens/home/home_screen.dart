import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:store_admin/screens/home/blocs/user_bloc.dart';
import 'package:store_admin/screens/home/tabs/users_tab.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        backgroundColor: Colors.pinkAccent,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white54,
        onTap: (p){
          _pageController.animateToPage(p, duration: Duration(milliseconds: 300), curve: Curves.ease);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Clientes"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Pedidos"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Produtos"),
        ],
      ),
      body: SafeArea(
        child: BlocProvider(
          blocs: [Bloc((i) => _userBloc)],
          child: PageView(
            controller: _pageController,
            onPageChanged: (p){
              setState(() {
                _page = p;
              });
            },
            children: [
              UsersTab(),
              Container(color: Colors.green),
              Container(color: Colors.yellow)
            ],
          ),
        ),
      ),
    );
  }
}
