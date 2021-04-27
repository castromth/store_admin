import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {


  final Function(File) onImageSelected;

  ImageSourceSheet({this.onImageSelected});
  void imageSelected(PickedFile image) async{
    if(image != null){
      File cropedImage =  await ImageCropper.cropImage(sourcePath: image.path);
      onImageSelected(cropedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(onClosing: (){}, builder: (context) => Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
            onPressed: () async {
              PickedFile image = await ImagePicker.platform.pickImage(source: ImageSource.camera);
              imageSelected(image);
            },
            child: Text("Câmera")),
        TextButton(
            onPressed: () async {
              PickedFile image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
              imageSelected(image);
            },
            child: Text("Galeria")),
      ],
    ));
  }
}
