import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../configs/colors.dart';

class SearchButtonCard extends StatelessWidget {
  final String svgPath;
  final String topic;
  final bool isSelected;
  final VoidCallback onTap;

  const SearchButtonCard({
    Key? key,
    required this.svgPath,
    required this.topic,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Container(
              width: screenWidth - 32,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.greenAccent : AppColors.lightGreyInlima,
                borderRadius: BorderRadius.circular(15),
                border: isSelected 
                    ? Border.all(color: Colors.green, width: 3) 
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.network(
                      svgPath,
                      fit: BoxFit.contain,
                      height: 80,
                      placeholderBuilder: (BuildContext context) =>
                          const CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 12),
                    Flexible(
                      child: Text(
                        topic,
                        style: TextStyle(
                          color: AppColors.textColorBlack,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (isSelected)
              Center(
                child: Image.asset(
                  'assets/img_app/check.png',
                  width: 60,
                  height: 60,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
