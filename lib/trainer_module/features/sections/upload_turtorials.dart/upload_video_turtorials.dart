import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/buttons/circular_button.dart';
import 'package:t_store/constants/colors.dart';
import 'package:t_store/trainer_module/features/controllers/upload_video_controller.dart';
import 'package:t_store/user_module/features/personalization/controllers/user_controller.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  _UploadVideoScreenState createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  final UploadVideoController controller = Get.put(UploadVideoController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title input
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    labelText: "Video Title",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "Title is required"
                      : null,
                ),
                const SizedBox(height: 16),

                // Description input
                TextFormField(
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Video Description",
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) => value == null || value.isEmpty
                      ? "Description is required"
                      : null,
                ),
                const SizedBox(height: 16),

                // Tags input
                TextFormField(
                  controller: controller.tagsController,
                  decoration: const InputDecoration(
                    labelText: "Tags (comma-separated)",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value == null || value.isEmpty
                      ? "At least one tag is required"
                      : null,
                ),
                const SizedBox(height: 16),

                // Select Video Button
                // Select Video Button
                SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Allow horizontal scrolling
                  child: Row(
                    children: [
                      TCircularButton(
                        onTap: controller.pickVideoFile,
                        text: "Select Video",
                        textColor: Colors.orange,
                      ),
                      const SizedBox(width: 16),
                      Obx(() {
                        return controller.selectedFilePath.value != null
                            ? Text(
                                "Selected: ${controller.selectedFilePath.value!.split('/').last}",
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container();
                      }),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

// Select Thumbnail Button
                SingleChildScrollView(
                  scrollDirection:
                      Axis.horizontal, // Allow horizontal scrolling
                  child: Row(
                    children: [
                      TCircularButton(
                        onTap: controller.pickThumbnailFile,
                        text: "Select Thumbnail",
                        textColor: TColors.primary,
                      ),
                      const SizedBox(width: 16),
                      Obx(() {
                        return controller.thumbnailPath.value != null
                            ? Text(
                                "Selected: ${controller.thumbnailPath.value!.split('/').last}",
                                overflow: TextOverflow.ellipsis,
                              )
                            : Container();
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: TCircularButton(
                    onTap: () => controller.submitForm(
                        context, userController.user.value.id),
                    text: "Upload Video",
                    textColor: TColors.white,
                    backgroundColor: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
