import 'package:flutter/material.dart';

class ProgramCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String additionalInfo;
  final VoidCallback onTap; // Callback for tap action

  const ProgramCard({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.additionalInfo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      elevation: 4,
      child: InkWell(
        onTap: onTap, // Make card clickable
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Column(
            children: [
              Stack(
                children: [
                  Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                    height: 400, // Adjust as per your requirement
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 16,
                    left: 16,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black45,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      description,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      additionalInfo,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
