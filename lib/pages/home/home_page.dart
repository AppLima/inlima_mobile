import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inlima_mobile/components/inlima_appbar.dart';
import '../sos/sos_page.dart';
import '../survey_creation/survey_creation.dart';
import '../complaint/complaint_page.dart';
import '../survey/survey.dart';
import '../historic/historic_page.dart';
import '../search/search_page.dart';
import '../../configs/colors.dart';
import '../../components/lateral_bar.dart';
import '../../_global_controllers/sesion_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final List<Widget> _userPages;
  late final List<Widget> _adminPages;

  @override
  void initState() {
    super.initState();
    _userPages = [
      ComplaintPage(),
      SOSPage(),
      SurveyPage(),
      HistoricPage(),
    ];
    _adminPages = [
      SearchPage(),
      SurveyCreationPage(),
      SurveyPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final SesionController sesionController = Get.find<SesionController>();
    int? rol = sesionController.usuario?.rolId;
    
    final isAdmin = rol == 1;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<Widget> pages = isAdmin ? _adminPages : _userPages;

    return Scaffold(
      key: _scaffoldKey,
      appBar: InLimaAppBar(
        scaffoldKey: _scaffoldKey,
      ),
      drawer: LateralBar(),
      body: Stack(
        children: [
          pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: isAdmin
            ? const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
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
              ]
            : const <BottomNavigationBarItem>[
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
