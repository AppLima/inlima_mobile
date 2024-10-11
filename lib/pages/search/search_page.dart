import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/search_button_card.dart';
import './search_controller.dart';

class SearchPage extends StatelessWidget {
  final SearchCController searchController = Get.put(SearchCController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Obx(() {
        if (searchController.complaints.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
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
              ElevatedButton(
                onPressed: () {
                  if (searchController.areAllSelected()) {
                    searchController.deselectAllComplaints();
                  } else {
                    searchController.selectAllComplaints();
                  }
                },
                child: Obx(() => Text(
                  searchController.areAllSelected()
                      ? 'Deseleccionar Todo'
                      : 'Seleccionar Todo',
                )),
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
                  itemCount: searchController.complaints.length,
                  itemBuilder: (context, index) {
                    final queja = searchController.complaints[index];
                    return Obx(() {
                      final isSelected = searchController.selectedComplaints.contains(queja);
                      return SearchButtonCard(
                        svgPath: queja.urlSvg,
                        topic: queja.name,
                        isSelected: isSelected,
                        onTap: () {
                          searchController.toggleComplaintSelection(queja);
                        },
                      );
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final selectedTopics = searchController.selectedComplaints.map((queja) => queja.name).toList();
                    Navigator.pushNamed(
                        context,
                        '/result',
                        arguments: selectedTopics,
                    );
                  },
                  child: const Text('Buscar'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
