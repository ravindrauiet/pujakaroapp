class ImageUtils {
  /// Normalizes image paths to ensure they have the correct format
  /// Handles cases where the path might already include 'assets/images/' or just be a filename
  static String normalizeImagePath(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) {
      return 'assets/images/satyanarayan.jpg'; // Default fallback
    }
    
    // Remove leading slashes and clean up the path
    String cleanPath = imagePath.trim();
    while (cleanPath.startsWith('/')) {
      cleanPath = cleanPath.substring(1);
    }
    
    // If the path already starts with 'assets/images/', return as is
    if (cleanPath.startsWith('')) {
      return cleanPath;
    }
    
    // If it's just a filename, prepend the assets path
    return '$imagePath';
  }
} 