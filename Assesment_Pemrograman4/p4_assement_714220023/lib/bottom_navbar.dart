import 'package:flutter/material.dart';
import 'package:p4_assement_714220023/input_form.dart';
import 'main.dart';

class DynamicBottomNavbar extends StatefulWidget {
  const DynamicBottomNavbar({super.key});

  @override
  State<DynamicBottomNavbar> createState() => _DynamicBottomNavbarState();
}

class _DynamicBottomNavbarState extends State<DynamicBottomNavbar> {
  int _currentPageIndex = 0 ;

  final List<Widget> _pages = <Widget>[
    // const MydetailScreen(),
    const HollywoodScreen(),
    const MyInputform(), 
   
  
  ];
  void onTabTapped(int index){
    setState(() {
      _currentPageIndex = index ;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: onTabTapped,
        items: const[
           BottomNavigationBarItem(
            icon: Icon(Icons.home_max_rounded),
            label: 'Home',
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.add_to_photos_rounded),
            label: 'Add Actor',
          ),
        ],
        backgroundColor:  Colors.brown[300],
        selectedItemColor: const Color.fromARGB(145, 104, 49, 33),
        unselectedItemColor: Colors.white,
        
        
        ),
    );
  }
}