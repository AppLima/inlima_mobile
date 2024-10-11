import 'package:flutter/material.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import 'package:inlima_mobile/models/usuario.dart';
import '../sos/sos_page.dart';
import '../complaint/complaint_page.dart'; // Import for Complaint Page
import '../survey/survey.dart'; // Import for Survey Page
import '../../configs/colors.dart';
import '../historic/historic_page.dart';
import '../../components/lateral_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // GlobalKey for controlling the Scaffold

  final List<Widget> _pages = [
    ComplaintPage(), // Complaint page
    SOSPage(), // SOS page
    SurveyPage(), // Survey page
    HistoricPage(), // Historic page
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
          _pages[_selectedIndex], // Display the currently selected page
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Quejas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: 'SOS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: 'Sondeos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColorInlima, // Highlighted color for the selected tab
        unselectedItemColor: AppColors.tertiaryColorInlima, // White icons for unselected tabs
        backgroundColor: AppColors.beigeColor, // Dark blue background for navbar
        onTap: _onItemTapped, // Tap handler to switch tabs
      ),
    );
  }
}
