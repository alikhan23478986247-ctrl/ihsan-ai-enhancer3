import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../../data/services/firestore_service.dart';
import '../../data/models/history_model.dart';

class AIProvider with ChangeNotifier {
  File? _selectedImage;
  File? _processedImage;
  bool _isProcessing = false;
  
  File? get selectedImage => _selectedImage;
  File? get processedImage => _processedImage;
  bool get isProcessing => _isProcessing;

  final ImagePicker _picker = ImagePicker();
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      _selectedImage = File(image.path);
      _processedImage = null;
      notifyListeners();
    }
  }

  void clearImages() {
    _selectedImage = null;
    _processedImage = null;
    notifyListeners();
  }

  Future<void> processImage(String featureType, String userId) async {
    if (_selectedImage == null) return;
    
    _isProcessing = true;
    notifyListeners();
    
    try {
      // Real API integration logic would go here
      // Example: calling Replicate API for enhancement
      // For now, we simulate with a delay
      await Future.delayed(const Duration(seconds: 3));
      
      // Mock processing: just use the same image
      _processedImage = _selectedImage;

      // Save to Firestore History (in real app, use uploaded URLs)
      final history = HistoryModel(
        id: const Uuid().v4(),
        userId: userId,
        originalImageUrl: 'https://placeholder.com/original.jpg',
        processedImageUrl: 'https://placeholder.com/processed.jpg',
        featureType: featureType,
        timestamp: DateTime.now(),
      );
      
      await _firestoreService.saveHistory(history);
      
    } catch (e) {
      debugPrint('Processing error: $e');
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  Future<bool> saveToGallery() async {
    if (_processedImage == null) return false;
    
    try {
      final result = await ImageGallerySaver.saveFile(_processedImage!.path);
      return result['isSuccess'] ?? false;
    } catch (e) {
      debugPrint('Save error: $e');
      return false;
    }
  }
}
