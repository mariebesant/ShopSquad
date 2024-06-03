import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:typed_data';

import 'package:shopsquad/theme/colors.dart';

class ImageBill extends StatefulWidget {
  final Function(String)? onImageConverted;
  const ImageBill({Key? key, this.onImageConverted}) : super(key: key);

  @override
  State<ImageBill> createState() => _ImageBillState();
}

class _ImageBillState extends State<ImageBill> {
  late ImagePicker _picker;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
  }

  void _getImageFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
      });
    }
  }

  void _onOkPressed() {
    if (_imageBytes != null) {
      final base64Image = base64Encode(_imageBytes!);
      widget.onImageConverted?.call(base64Image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bild aufnehmen',
          style: TextStyle(color: AppColors.white),
        ),
        backgroundColor: AppColors.accentGray,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageBytes != null
                ? Image.memory(
                    _imageBytes!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  )
                : Text('Kein Bild ausgewählt'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text('Kamera öffnen'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _onOkPressed,
              child: Text('OK'),
            ),
          ],
        ),
      ),
    );
  }
}
