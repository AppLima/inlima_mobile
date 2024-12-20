import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/complaint_button_card.dart';
import './complaint_controller.dart';

class ComplaintPage extends StatelessWidget {
  final ComplaintController complaintController = Get.put(ComplaintController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Obx(() {
        if (complaintController.complaints.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Elige el tipo de queja:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: complaintController.complaints.length,
                  itemBuilder: (context, index) {
                    final queja = complaintController.complaints[index];
                    return ComplaintButtonCard(
                      svgPath: queja.logo,
                      topic: queja.name,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
