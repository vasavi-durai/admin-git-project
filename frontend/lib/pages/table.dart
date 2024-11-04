import 'package:adminapp/pages/edit_license_dialog.dart';
import 'package:flutter/material.dart';
import '../widgets/navbar.dart';
import '../widgets/sidebar.dart';
import 'package:adminapp/api_service.dart';

class TablesPageW extends StatefulWidget {
  const TablesPageW({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TablesPageWState createState() => _TablesPageWState();
}

class _TablesPageWState extends State<TablesPageW> {
  late Future<List<License>> _licenses;

  @override
  void initState() {
    super.initState();
    _licenses = ApiService.getLicenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Navbar(pageTitle: 'Authors Table'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
            child: const Text(
              'Authors Table',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: FutureBuilder<List<License>>(
                future: _licenses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No licenses available'));
                  } else {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('LICENSE')),
                          DataColumn(label: Text('EXPIRY DATE')),
                          DataColumn(label: Text('GUID')),
                          DataColumn(label: Text('EDIT')),
                          DataColumn(label: Text('DELETE')),
                        ],
                        rows: snapshot.data!.map((license) {
                          return DataRow(cells: [
                            DataCell(Text(license.licenseID)),
                            DataCell(Text(license.expireDate)),
                            DataCell(Text(license.associatedGUID)),
                            DataCell(
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return EditLicenseDialog(
                                        licenseID: license.licenseID,
                                        expireDate: license.expireDate,
                                        associatedGUID: license.associatedGUID, 
                                        onUpdate: (newExpireDate, newGUID) async {
                                         
                                          await ApiService.updateLicense(
                                            license.licenseID,
                                            newExpireDate,
                                            newGUID, 
                                          );
                                          setState(() {
                                            _licenses = ApiService.getLicenses();
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text('Edit'),
                              ),
                            ),
                            DataCell(
                              ElevatedButton(
                                onPressed: () async {
                                  await ApiService.deleteLicense(license.licenseID);
                                  setState(() {
                                    _licenses = ApiService.getLicenses();
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                child: const Text('Delete'),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

