import 'package:flutter/material.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import 'package:inlima_mobile/models/usuario.dart';
import '../sos/sos_page.dart';
import '../complaint/complaint_page.dart'; // Import for Complaint Page
import '../survey/survey.dart'; // Import for Survey Page
import '../../configs/colors.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    ComplaintPage(), // Complaint page
    SOSPage(), // SOS page
    SurveyPage(), // Survey page
    Center(child: Text('Historial')), // Placeholder for Historial
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const InLimaAppBar(),
      body: Stack(
        children: [
          _pages[_selectedIndex]
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Quejas/Sugerencias',
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
        unselectedItemColor: AppColors.lightGreyInlima, // White icons for unselected tabs
        backgroundColor: AppColors.blackInlima, // Dark blue background for navbar
        onTap: _onItemTapped, // Tap handler to switch tabs
      ),
    );
  }
}
