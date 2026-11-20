import 'package:flutter/material.dart';

class SampleModal extends StatelessWidget {
  const SampleModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400.0,
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Modal Header matching lab illustration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              color: const Color(0xFF1E5E3A),
              child: const Text(
                'SampleModal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Scrollable Content Area (Image + Long Text)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Image Asset
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        'assets/images/sample_modal_image.png',
                        width: double.infinity,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Long Paragraph Text
                    const Text(
                      'Long text in a scrollable area. The body continues beyond the visible section so users can scroll. Keep the close action below it.\n\n'
                      'Flutter modal dialogs allow presenting focused content, notifications, or actions that require user interaction without navigating away from the current screen context.\n\n'
                      'By enclosing variable-length content within an Expanded widget coupled with a SingleChildScrollView, the dialog avoids layout overflow exceptions (RenderFlex overflow) even when rendered across compact mobile viewports.\n\n'
                      'The asset image displayed at the top illustrates how local raster and vector files are bundled and loaded via pubspec.yaml asset manifests.',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF2C3E50),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // CLOSE Button Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 44.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5E3A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'CLOSE',
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}