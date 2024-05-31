import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  TextEditingController _bioController = TextEditingController();
  bool _isEditingBio = false;

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }

  Future _pickImage() async {
    final _picker = ImagePicker();
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _toggleEditBio() {
    setState(() {
      _isEditingBio = !_isEditingBio;
      if (_isEditingBio) {
        _bioController.text = _bioController.text;
      }
    });
  }

  void _saveBio() {
    setState(() {
      _isEditingBio = false;
    });
    // Save the bio to the database or perform any necessary actions
    print('Bio saved: ${_bioController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundImage: _image != null
                    ? FileImage(_image!)
                    : NetworkImage(
                            'https://images.unsplash.com/photo-1607746882042-944635dfe10e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80')
                        as ImageProvider,
                child: _image == null
                    ? Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 8,
                        ),
                        child: Icon(Icons.add_a_photo, size: 40),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Eden Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Heart Surgeon',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Bio:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (_isEditingBio)
              Padding(
                padding: EdgeInsets.all(16.0),
                child: TextField(
                  controller: _bioController,
                  decoration: InputDecoration(
                    hintText: 'Enter bio',
                  ),
                ),
              )
            else
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _bioController.text.isNotEmpty
                      ? _bioController.text
                      : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!_isEditingBio)
                  ElevatedButton(
                    onPressed: _toggleEditBio,
                    child: Text('Edit Bio'),
                  ),
                if (_isEditingBio)
                  ElevatedButton(
                    onPressed: _saveBio,
                    child: Text('Save'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
