import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/text/grey_text.dart';
import 'package:t_store/common/widgets/text/section_header.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/trainers/widgets/trainer_item.dart';
import 'package:t_store/user_module/features/personalization/screens/training/widgets/trainers/widgets/trainer_widget.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TrainerListScreen extends StatelessWidget {
  const TrainerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    // Define unique trainer data
    final List<TrainerItem> trainers = [
      TrainerItem(
        name: 'Ahmed',
        subtitle:
            'Certified Personal Trainer specializing in strength training.',
        imagePath: 'assets/images/content/ahmed.jpg',
      ),
      TrainerItem(
        name: 'Nandana Ajith',
        subtitle: 'Animal Flow Instructor focusing on handling snakes.',
        imagePath: 'assets/images/content/snake.jpg',
      ),
      TrainerItem(
        name: 'Michael Brown',
        subtitle: 'Cardio Specialist with expertise in endurance and HIIT.',
        imagePath: 'assets/images/trainer_2.jpg',
      ),
      TrainerItem(
        name: 'Emily Davis',
        subtitle: 'Nutrition Coach providing guidance on balanced diets.',
        imagePath: 'assets/images/trainer_3.jpg',
      ),
      TrainerItem(
        name: 'Chris Johnson',
        subtitle: 'Pilates Instructor emphasizing core strength.',
        imagePath: 'assets/images/trainer_4.jpg',
      ),
      TrainerItem(
        name: 'Katie Wilson',
        subtitle: 'Group Fitness Leader with energetic classes and workshops.',
        imagePath: 'assets/images/trainer_5.jpg',
      ),
      TrainerItem(
        name: 'Ryan Lee',
        subtitle:
            'Sports Coach with experience in various athletic disciplines.',
        imagePath: 'assets/images/trainer_6.jpg',
      ),
      TrainerItem(
        name: 'Laura Adams',
        subtitle: 'Rehabilitation Expert specializing in post-injury recovery.',
        imagePath: 'assets/images/trainer_7.jpg',
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              const TSectionHeading(title: 'Meet our Trainers'),
              const SizedBox(height: 20),
              const TGreyText(
                  text: 'Guiding you in all the ways you want to move'),
              const SizedBox(height: 50), // Adjusted padding after subtitle

              // GridView wrapped in SizedBox to limit its height
              SizedBox(
                height: MediaQuery.of(context).size.height -
                    100, // Adjust height as needed
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                      bottom: 16.0), // Optional padding at the bottom
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16, // Adjust spacing
                  ),
                  itemCount: trainers.length,
                  itemBuilder: (context, index) {
                    return TrainerCard(trainerItem: trainers[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
