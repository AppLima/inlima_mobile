import 'package:flutter/material.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import 'package:inlima_mobile/models/usuario.dart';
import '../sos/sos_page.dart';
import '../complaint/complaint_page.dart';
import '../survey/survey.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> _pages = [
    ComplaintPage(),
    SOSPage(),
    SurveyPage(),
    HistoricPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Detectar si el tema es claro u oscuro
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      key: _scaffoldKey,
      appBar: InLimaAppBar(
        scaffoldKey: _scaffoldKey,
      ),
      drawer: LateralBar(),
      body: Stack(
        children: [
          _pages[_selectedIndex],
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
        selectedItemColor: isDarkMode
            ? Colors.white // Color para ítem seleccionado en modo oscuro
            : AppColors.primaryColorInlima , // Color para ítem seleccionado en modo claro
        unselectedItemColor: isDarkMode
            ? Colors.grey.shade400 // Color para ítem no seleccionado en modo oscuro
            : AppColors.blackInlima, // Color para ítem no seleccionado en modo claro
        backgroundColor: isDarkMode
            ? const Color.fromARGB(255, 24, 24, 24) // Fondo para modo oscuro
            : AppColors.beigeColor, // Fondo para modo claro
        onTap: _onItemTapped,
      ),
    );
  }
}
