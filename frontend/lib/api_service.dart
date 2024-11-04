import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:4000/api';
  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      log('Response status: ${response.statusCode}');
      log('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'message': responseData['message'],
          'token': responseData['token'],
        };
      } else if (response.statusCode == 401) {
        return {'error': 'Unauthorized: Invalid email or password'};
      } else {
        throw Exception('Failed to login: ${response.body}');
      }
    } catch (error) {
      log('Login error: $error');
      return {'error': 'An error occurred during login'};
    }
  }

  static Future<dynamic> signOut() async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/logout'),
        headers: {'Content-Type': 'application/json'},
      );
      log('Logout Response Status: ${response.statusCode}');
      log('Logout Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to Logout: ${response.body}');
      }
    } catch (error) {
      log('Logout error: $error');
      return {'error': 'An error occurred during logout'};
    }
  }

  static Future<Map<String, dynamic>> createLicense(
    String licenseID, String expireDate, String? associatedGUID) async
     {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/createlicense'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'licenseID': licenseID,
          'expireDate': expireDate,
          'associatedGUID': associatedGUID,
        }
        ),
      );
      log('Create License Response status: ${response.statusCode}');
      log('Create License Response body: ${response.body}');
      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        return {'error': jsonDecode(response.body)['error']};
      } else 
      {
        throw Exception('Failed to create license: ${response.body}');
      }
    } catch (error) {
      log('Create License error: $error');
      return {'error': 'An error occurred while creating the license'};
    }
  }

  static Future<List<License>> getLicenses() async {
    final response = await http.get(Uri.parse('$baseUrl/getlicense'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((license) => License.fromJson(license)).toList();
    } else {
      throw Exception('Failed to load licenses');
    }
  }

static Future<Map<String, dynamic>> updateLicense(
  String licenseID, String? expireDate, String? associatedGUID) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/updatelicense/$licenseID'),  
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        if (expireDate != null) 'expireDate': expireDate,
        if (associatedGUID != null) 'associatedGUID': associatedGUID,
      }),
    );

    log('Update License Response status: ${response.statusCode}');
    log('Update License Response body: ${response.body}');
  
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return {'error': 'License not found'};
    } else {
      throw Exception('Failed to update license: ${response.body}');
    }
  } catch (error) {
    log('Update License error: $error');
    return {'error': 'An error occurred while updating the license'};
  }
}

static Future<Map<String, dynamic>> removeGUID(String licenseID) async {
  try {
    final response = await http.put(
      Uri.parse('$baseUrl/delguid/$licenseID'),
      headers: {'Content-Type': 'application/json'},
    );

    log('Remove GUID Response Status: ${response.statusCode}');
    log('Remove GUID Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return {'error': 'License not found'};
    } else {
      throw Exception('Failed to remove GUID: ${response.body}');
    }
  } catch (error) {
    log('Remove GUID error: $error');
    return {'error': 'An error occurred while removing the GUID'};
  }
}

  static Future<void> deleteLicense(String licenseID) async {
    final response = await http.delete(Uri.parse('$baseUrl/dellicense/$licenseID'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete license');
    }
  }
}

class License {
  final String licenseID;
  final String expireDate;
  final String associatedGUID;

  License({required this.licenseID, required this.expireDate, required this.associatedGUID});

  factory License.fromJson(Map<String, dynamic> json) {
    return License(
      licenseID: json['licenseID'],
      expireDate: json['expireDate'],
      associatedGUID: json['associatedGUID'] ?? '',
    );
  }
  }


