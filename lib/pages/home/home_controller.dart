import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:inlima_mobile/pages/complaint/complaint_page.dart';
import 'package:inlima_mobile/pages/survey/survey.dart';

class HomeController extends GetxController {
  void navigateToSurvey(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SurveyPage()),
    );
  }

  void navigateToComplaint(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComplaintPage()),
    );
  }
}
