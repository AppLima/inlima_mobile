import 'package:flutter/material.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import 'package:inlima_mobile/models/usuario.dart';
import '../sos/sos_page.dart';
import '../complaint/complaint_page.dart'; // Import for Complaint Page
import '../survey/survey.dart'; // Import for Survey Page
import '../../configs/colors.dart';
import '../search/search_page.dart';
import '../../components/lateral_bar.dart';

class HomeAdminPage extends StatefulWidget {

  const HomeAdminPage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeAdminPage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    SearchPage(), // Complaint page
    SOSPage(), // SOS page
    SurveyPage(), // Placeholder for Historial
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Pass the key to Scaffold
      appBar: InLimaAppBar(
        scaffoldKey: _scaffoldKey, // Pass the scaffoldKey to the InLimaAppBar
      ),
      drawer: LateralBar(),
      body: Stack(
        children: [
          _pages[_selectedIndex]
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Buscar quejas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Crear sondeo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Ver sondeos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColorInlima, // Highlighted color for the selected tab
        unselectedItemColor: AppColors.lightGreyInlima, // White icons for unselected tabs
        backgroundColor: AppColors.blackInlima, // Dark blue background for navbar
        onTap: _onItemTapped, // Tap handler to switch tabs
      ),
    );
  }
}