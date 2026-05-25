import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:before_after/before_after.dart';
import '../../providers/ai_provider.dart';
import '../../core/theme/app_theme.dart';

class FeatureScreen extends StatelessWidget {
  final String title;
  final String featureType;

  const FeatureScreen({
    super.key,
    required this.title,
    required this.featureType,
  });

  @override
  Widget build(BuildContext context) {
    final aiProvider = Provider.of<AIProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (aiProvider.selectedImage != null)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => aiProvider.clearImages(),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: _buildImageArea(context, aiProvider),
            ),
            const SizedBox(height: 24),
            if (aiProvider.selectedImage == null)
              _buildImagePickers(context, aiProvider)
            else if (aiProvider.processedImage == null)
              _buildProcessButton(context, aiProvider)
            else
              _buildActionButtons(context, aiProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildImageArea(BuildContext context, AIProvider aiProvider) {
    if (aiProvider.selectedImage == null) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white10, width: 2),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_outlined, size: 80, color: Colors.white24),
            SizedBox(height: 16),
            Text('No image selected', style: TextStyle(color: Colors.white54)),
          ],
        ),
      );
    }

    if (aiProvider.isProcessing) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(color: AppTheme.primaryColor),
            const SizedBox(height: 24),
            Text(
              'AI is processing your image...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    if (aiProvider.processedImage != null) {
      if (featureType == 'compare') {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BeforeAfter(
            before: Image.file(aiProvider.selectedImage!, fit: BoxFit.cover),
            after: Image.file(aiProvider.processedImage!, fit: BoxFit.cover),
          ),
        );
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.file(aiProvider.processedImage!, fit: BoxFit.contain),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.file(aiProvider.selectedImage!, fit: BoxFit.contain),
    );
  }

  Widget _buildImagePickers(BuildContext context, AIProvider aiProvider) {
    return Row(
      children: [
        Expanded(
          child: _buildPickButton(
            context,
            'Gallery',
            Icons.photo_library,
            () => aiProvider.pickImage(ImageSource.gallery),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildPickButton(
            context,
            'Camera',
            Icons.camera_alt,
            () => aiProvider.pickImage(ImageSource.camera),
          ),
        ),
      ],
    );
  }

  Widget _buildPickButton(BuildContext context, String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.surfaceColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget _buildProcessButton(BuildContext context, AIProvider aiProvider) {
    return ElevatedButton(
      onPressed: () => aiProvider.processImage(featureType),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
      ),
      child: Text('Process with $title'),
    );
  }

  Widget _buildActionButtons(BuildContext context, AIProvider aiProvider) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Implementation for saving to gallery
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Saved to gallery')),
              );
            },
            icon: const Icon(Icons.download),
            label: const Text('Download'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              // Implementation for sharing
            },
            icon: const Icon(Icons.share),
            label: const Text('Share'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.surfaceColor,
            ),
          ),
        ),
      ],
    );
  }
}
