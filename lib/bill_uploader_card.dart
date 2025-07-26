import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BillUploaderCard extends StatefulWidget {
  const BillUploaderCard({super.key});

  @override
  State<BillUploaderCard> createState() => _BillUploaderCardState();
}

class _BillUploaderCardState extends State<BillUploaderCard> {
  XFile? _selectedFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedFile = image;
    });
  }

  void _processBill() {
    if (_selectedFile == null) return;
    // TODO: Implement backend upload logic here.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Uploading ${_selectedFile!.name}... (Demo)')),
    );
    setState(() {
      _selectedFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: Text('Process a Bill', style: Theme.of(context).textTheme.titleLarge),
            subtitle: const Text('Upload an image or PDF'),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  icon: const Icon(Icons.cloud_upload_outlined),
                  label: const Text('Select File'),
                  onPressed: _pickImage,
                ),
                if (_selectedFile != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text('Selected: ${_selectedFile!.name}'),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: _selectedFile != null ? _processBill : null,
                child: const Text('Process Bill'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}