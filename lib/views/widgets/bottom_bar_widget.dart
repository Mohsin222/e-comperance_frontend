import 'package:e_comperce_app/services/event_bus_services/event_bus_services.dart';
import 'package:e_comperce_app/views/auth/signup_screen.dart';
import 'package:e_comperce_app/views/home/home_screen.dart';
import 'package:e_comperce_app/views/product/user_orders.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends ConsumerState<CustomBottomNavigationBar> {

 int _currentIndex = 0;
    @override
  void initState() {
    super.initState();
    _bindAppMainBottomNavigationBarSetActiveTab();
  }

  @override
  void dispose() {
    super.dispose();
  }
    void _bindAppMainBottomNavigationBarSetActiveTab(){
      eventBus.on<AppMainBottomNavigationBarSetEvent>().listen((event) { 
         switch (event.appMainBottomNavigationBarType) {
        case AppMainBottomNavigationBarType.setHome:
          _currentIndex = 0;
          break;
        case AppMainBottomNavigationBarType.setBookingsList:
          _currentIndex = 1;
          break;
        case AppMainBottomNavigationBarType.setChatList:
          _currentIndex = 2;
          break;
        case AppMainBottomNavigationBarType.setFavouritesList:
          _currentIndex = 3;
          break;
        case AppMainBottomNavigationBarType.setSetting:
          _currentIndex = 4;
          break;
        default:
          _currentIndex = 0;
      }
        setState(() {});
      });
    }

 final List screens = <Widget>[
HomeScreen(),
 const Scaffold(body: Center(child: Text("2222"))),
   UserOrders(),
   const Scaffold(body: Center(child: Text("4444"))),
 const Scaffold(body: Center(child: Text("5555"))),
  ];
   var bottomNavTextStyle =
        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body:   screens[_currentIndex],
    
      bottomNavigationBar: Container(
        
          height: 0.1.sh,
            decoration: BoxDecoration(
            color: const Color(0xffFFFFFF),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.r), topLeft: Radius.circular(25.r)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xff000000).withOpacity(0.25),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
              mouseCursor: SystemMouseCursors.grab,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            // selectedItemColor: const Color(0xffFF494E),
            // unselectedItemColor: const Color(0xff757575),
            // selectedLabelStyle: bottomNavTextStyle,
             unselectedIconTheme: IconThemeData(
    color: Colors.deepOrangeAccent,
  ),
  unselectedItemColor: Colors.deepOrangeAccent,
             selectedItemColor: Colors.amberAccent,
  selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            selectedIconTheme: IconThemeData(color: Colors.amberAccent),
            elevation: 0,
               onTap: (value) {
            setState(() {
                _currentIndex = value;
              });
            },
              backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.shifting,
            items: const [  BottomNavigationBarItem(
      icon: Icon(Icons.home),
     label: 'Home',
      ),
        BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.gift_alt_fill),
        label: 'Products',
      ),
        BottomNavigationBarItem(
        icon:Icon( CupertinoIcons.cart),
        label: 'Calls',
      ),
        BottomNavigationBarItem(
        icon:Icon( CupertinoIcons.profile_circled),
        label: 'Profile',
      ),
      ],
          )),
    );
  }
}