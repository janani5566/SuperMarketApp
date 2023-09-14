import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:SuperMarket/controllers/MenuAppController.dart';
import 'package:SuperMarket/screens/main/main_screen.dart';
import 'package:SuperMarket/IpAddress/database_helper.dart';
import 'package:SuperMarket/screens/main/main_screen.dart';

class IpScreen extends StatefulWidget {
  @override
  _IpScreenState createState() => _IpScreenState();
}

class _IpScreenState extends State<IpScreen> {
  final TextEditingController _ipController = TextEditingController();
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Enter IP Address',
          style: GoogleFonts.crimsonText(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _ipController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter IP',
                errorText: _errorMessage.isNotEmpty ? _errorMessage : null,
                labelStyle: TextStyle(
                  color: Colors.black, // Change the label text color
                ),
                // Change the text color
                // Use inputDecoration's `hintStyle` for the text color
                // Use `focusedBorder` and `enabledBorder` to change border color
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                hintStyle: TextStyle(
                  color: Colors.black, // Change the hint text color
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String ipAddress = _ipController.text;
                // Check if the IP address is non-empty.
                if (ipAddress.isNotEmpty) {
                  bool hasJsonData = await checkIpAddressHasJsonData(ipAddress);
                  if (hasJsonData) {
                    // Save the IP address and navigate to the Dashboard.
                    saveIpAddress(ipAddress);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (context) => MenuAppController(),
                            ),
                          ],
                          child: MainScreen(),
                        ),
                      ),
                    );
                  } else {
                    setState(() {
                      _errorMessage = 'Invalid IP Address!!';
                    });
                  }
                } else {
                  setState(() {
                    _errorMessage = 'IP address cannot be empty';
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.blue,
                ), // Change the color here
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 25,
                  ), // Increase the padding here
                ),
              ),
              child: Text(
                'Save',
                style: GoogleFonts.crimsonText(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> checkIpAddressHasJsonData(String ipAddress) async {
    final url =
        Uri.parse('http://$ipAddress'); // Use http:// with the IP address.

    try {
      final response = await http.get(url);
      // Check if the response contains JSON data and it's not empty.
      if (response.statusCode == 200) {
        try {
          Map<String, dynamic> jsonData = json.decode(response.body);
          return jsonData.isNotEmpty;
        } catch (e) {
          // If parsing as JSON fails, the response doesn't have JSON data.
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      print('Error checking IP address data: $e');
      return false;
    }
  }

  Future<void> saveIpAddress(String ipAddress) async {
    await SharedPrefs.saveIpAddress(ipAddress);
  }
}
