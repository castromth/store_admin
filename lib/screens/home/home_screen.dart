import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:store_admin/screens/home/blocs/orders_bloc.dart';
import 'package:store_admin/screens/home/blocs/user_bloc.dart';
import 'package:store_admin/screens/home/tabs/orders_tab.dart';
import 'package:store_admin/screens/home/tabs/products_tab.dart';
import 'package:store_admin/screens/home/tabs/users_tab.dart';




class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _page = 0;
  UserBloc _userBloc;
  OrdersBloc _ordersBloc;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
    _ordersBloc = OrdersBloc();
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
          blocs: [Bloc((i) => _userBloc), Bloc((i) => _ordersBloc)],
          child: PageView(
            controller: _pageController,
            onPageChanged: (p){
              setState(() {
                _page = p;
              });
            },
            children: [
              UsersTab(),
              OrdersTab(),
              ProductsTab()
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFloating(),
    );
  }

  Widget _buildFloating(){
    switch(_page){
      case 0:
        return null;
      case 1:
        return SpeedDial(
          child: Icon(Icons.sort),
          backgroundColor: Colors.pinkAccent,
          overlayOpacity: 0.4,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(Icons.arrow_downward, color: Colors.pinkAccent),
              backgroundColor: Colors.white,
              label: "Concluidos Abaixo",
              labelStyle: TextStyle(fontSize: 14),
              onTap: (){
                _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
              }
            ),
            SpeedDialChild(
                child: Icon(Icons.arrow_upward, color: Colors.pinkAccent),
                backgroundColor: Colors.white,
                label: "Concluidos Abaixo",
                labelStyle: TextStyle(fontSize: 14),
                onTap: (){
                  _ordersBloc.setOrderCriteria(SortCriteria.READY_LAST);
                }
            )
          ],
        );
    }
  }
}
