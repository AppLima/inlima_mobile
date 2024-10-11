import 'package:flutter/material.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import 'package:inlima_mobile/models/usuario.dart';
import '../sos/sos_page.dart';
import '../complaint/complaint_page.dart';
import '../survey/survey.dart';
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
    SearchPage(),
    SOSPage(),
    SurveyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      key: _scaffoldKey,
      appBar: InLimaAppBar(
        scaffoldKey: _scaffoldKey,
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
        selectedItemColor: isDarkMode
            ? Colors.white // Color para ítem seleccionado en modo oscuro
            : const Color.fromARGB(255, 16, 33, 56), // Color para ítem seleccionado en modo claro
        unselectedItemColor: isDarkMode
            ? Colors.grey.shade400 // Color para ítem no seleccionado en modo oscuro
            : AppColors.secondaryColorInlima, // Color para ítem no seleccionado en modo claro
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 24, 24, 24) // Fondo para modo oscuro
            : const Color.fromARGB(120, 159, 214, 250), // Fondo para modo claro
        onTap: _onItemTapped,
      ),
    );
  }
}