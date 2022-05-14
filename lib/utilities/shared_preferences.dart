import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';


class AvatarImage {
  static late XFile imageFile;
  static late String imagePath;
  static late XFile? image;
  static late SharedPreferences saveImage;

  //getter + setter for image
  static XFile get imgFile => imageFile;
  static set imgFile(XFile image) {
    imageFile = image;
  }

  //getter + setter for image path
  static String get imgPath => imagePath;
  static set imgPath(String path) {
    imagePath = path;
  }
}