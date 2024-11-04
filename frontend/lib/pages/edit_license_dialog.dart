import 'dart:developer';
import 'package:adminapp/api_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditLicenseDialog extends StatefulWidget {
  final String licenseID;
  final String expireDate;
  final String associatedGUID; 
  final Function(String newExpireDate, String? newGUID) onUpdate; 

  const EditLicenseDialog({
    super.key,
    required this.licenseID,
    required this.expireDate,
    required this.associatedGUID, 
    required this.onUpdate,
  });

  @override
  _EditLicenseDialogState createState() => _EditLicenseDialogState();
}

class _EditLicenseDialogState extends State<EditLicenseDialog> {
  late TextEditingController expireDateController;
  late TextEditingController guidController;

  @override
  void initState() {
    super.initState();
    expireDateController = TextEditingController(text: widget.expireDate);
    guidController = TextEditingController(text: widget.associatedGUID);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit License'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: TextEditingController(text: widget.licenseID),
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'License ID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: expireDateController,
            decoration: const InputDecoration(
              labelText: 'Expiry Date',
              suffixIcon: Icon(Icons.calendar_today),
              border: OutlineInputBorder(),
            ),
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.parse(widget.expireDate),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null) {
                setState(() {
                  expireDateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                });
              }
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: guidController,
            decoration: const InputDecoration(
              labelText: 'Associated GUID',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final response = await ApiService.removeGUID(widget.licenseID);
              if (response.containsKey('error')) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(response['error'])),
                );
              } else {
                setState(() {
                  guidController.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('GUID removed successfully')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('REMOVE GUID'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            log('Updated Expiry Date: ${expireDateController.text}');
            log('Updated GUID: ${guidController.text.isEmpty ? 'null' : guidController.text}');
            widget.onUpdate(
              expireDateController.text,
              guidController.text.isEmpty ? "null" : guidController.text,
            );
            Navigator.of(context).pop();
          },
          child: const Text('UPDATE'),
        ),
      ],
    );
  }
}

