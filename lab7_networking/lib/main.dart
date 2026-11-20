import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const RandomUserApp());
}

class RandomUserApp extends StatelessWidget {
  const RandomUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 7 - Networking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5E3A)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const UserHomeScreen(),
    );
  }
}

// ==========================================
// 1. Home Screen (Preview + Fetch Controls)
// ==========================================
class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  Map<String, dynamic>? _user;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Instruction 2: Fetch on initialization, not in build()
    _fetchRandomUser();
  }

  Future<void> _fetchRandomUser() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await http.get(
        Uri.parse('https://randomuser.me/api/'),
      );

      // Instruction 3: Check response status before decoding
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>?;

        if (results != null && results.isNotEmpty) {
          setState(() {
            _user = results.first as Map<String, dynamic>;
            _isLoading = false;
          });
        } else {
          throw const FormatException('No user data returned from API.');
        }
      } else {
        throw Exception('Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load user. Please check your internet connection.\n($e)';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Random User',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E5E3A),
        elevation: 2,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: _buildHomeBody(),
          ),
        ),
      ),
    );
  }

  Widget _buildHomeBody() {
    // State 1: Loading
    if (_isLoading) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF1E5E3A)),
          SizedBox(height: 16.0),
          Text(
            'Fetching random user...',
            style: TextStyle(color: Color(0xFF1E5E3A), fontWeight: FontWeight.w500),
          ),
        ],
      );
    }

    // State 2: Error & Recoverable Retry
    if (_errorMessage != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64.0, color: Colors.redAccent),
          const SizedBox(height: 14.0),
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0, color: Colors.black87,),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E5E3A),
              foregroundColor: Colors.white,
            ),
            onPressed: _fetchRandomUser,
            icon: const Icon(Icons.refresh),
            label: const Text('RETRY'),
          ),
        ],
      );
    }

    // State 3: Success Content
    if (_user != null) {
      final name = _user!['name'] as Map<String, dynamic>?;
      final fullName = '${name?['title'] ?? ''} ${name?['first'] ?? ''} ${name?['last'] ?? ''}'.trim();
      final email = _user!['email'] ?? 'No email provided';
      final picture = _user!['picture'] as Map<String, dynamic>?;
      final imageUrl = picture?['large'] ?? picture?['medium'] ?? '';

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Instruction 5: Tap avatar to navigate to Profile Screen
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetailScreen(user: _user!),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1E5E3A), width: 3.0),
              ),
              child: ClipOval(
                child: SizedBox(
                  width: 130.0,
                  height: 130.0,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    // Instruction 7: Loading and error fallback for network image
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(color: Color(0xFF1E5E3A)),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFE8F2EC),
                        child: const Icon(Icons.person, size: 60.0, color: Color(0xFF1E5E3A)),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Tap picture to view full profile',
            style: TextStyle(fontSize: 12.0, color: Colors.black45, fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 16.0),
          Text(
            fullName.isNotEmpty ? fullName : 'Unknown User',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E5E3A),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14.0, color: Colors.black54),
          ),
          const SizedBox(height: 36.0),

          // Instruction 4: Button to request new user and update preview
          SizedBox(
            width: double.infinity,
            height: 48.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E5E3A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: _fetchRandomUser,
              child: const Text(
                'NEW USER',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, letterSpacing: 1.0),
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

// ==============================================================
// 2. Profile Detail Screen (Receives Currently Fetched Object)
// ==============================================================
class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key, required this.user});

  // Passed model dictionary from home screen
  final Map<String, dynamic> user;

  @override
  Widget build(BuildContext context) {
    // Graceful data extraction (Instruction 6)
    final name = user['name'] as Map<String, dynamic>?;
    final fullName = '${name?['first'] ?? ''} ${name?['last'] ?? ''}'.trim();

    final picture = user['picture'] as Map<String, dynamic>?;
    final imageUrl = picture?['large'] ?? picture?['medium'] ?? '';

    final gender = (user['gender'] ?? 'N/A').toString().toUpperCase();
    final email = user['email'] ?? 'N/A';
    final phone = user['phone'] ?? 'N/A';
    final cell = user['cell'] ?? 'N/A';
    final nat = user['nat'] ?? 'N/A';

    final dob = user['dob'] as Map<String, dynamic>?;
    final age = dob?['age']?.toString() ?? 'N/A';
    final dobDate = dob?['date'] != null ? dob!['date'].toString().split('T').first : 'N/A';

    final registered = user['registered'] as Map<String, dynamic>?;
    final regDate = registered?['date'] != null ? registered!['date'].toString().split('T').first : 'N/A';

    final login = user['login'] as Map<String, dynamic>?;
    final username = login?['username'] ?? 'N/A';
    final uuid = login?['uuid'] ?? 'N/A';

    final id = user['id'] as Map<String, dynamic>?;
    final idDisplay = '${id?['name'] ?? 'ID'}: ${id?['value'] ?? 'None'}';

    final location = user['location'] as Map<String, dynamic>?;
    final street = location?['street'] as Map<String, dynamic>?;
    final streetStr = '${street?['number'] ?? ''} ${street?['name'] ?? ''}'.trim();
    final city = location?['city'] ?? '';
    final state = location?['state'] ?? '';
    final country = location?['country'] ?? '';
    final postcode = location?['postcode']?.toString() ?? '';
    final timezone = location?['timezone'] as Map<String, dynamic>?;
    final tzDesc = timezone?['description'] ?? timezone?['offset'] ?? 'N/A';

    final fullAddress = [streetStr, city, state, country, postcode].where((e) => e.isNotEmpty).join(', ');

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E5E3A),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 2,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Profile Image
              Center(
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF1E5E3A), width: 3.0),
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      width: 110.0,
                      height: 110.0,
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: const Color(0xFFE8F2EC),
                          child: const Icon(Icons.person, size: 50.0, color: Color(0xFF1E5E3A)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                fullName.isNotEmpty ? fullName : 'User Profile',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E5E3A),
                ),
              ),
              const SizedBox(height: 4.0),
              const Text(
                'Generated Synthetic Test Data',
                style: TextStyle(fontSize: 12.0, color: Colors.black45, fontStyle: FontStyle.italic),
              ),
              const SizedBox(height: 20.0),

              // Structured Information Sections
              _buildDetailTile(Icons.wc, 'Gender', gender),
              _buildDetailTile(Icons.account_circle, 'Username', username),
              _buildDetailTile(Icons.fingerprint, 'UUID', uuid),
              _buildDetailTile(Icons.email, 'Email', email),
              _buildDetailTile(Icons.phone, 'Phone / Cell', '$phone / $cell'),
              _buildDetailTile(Icons.cake, 'DOB / Age', '$dobDate ($age yrs)'),
              _buildDetailTile(Icons.calendar_today, 'Registration Date', regDate),
              _buildDetailTile(Icons.badge, 'ID', idDisplay),
              _buildDetailTile(Icons.flag, 'Nationality', nat),
              _buildDetailTile(Icons.location_on, 'Location', fullAddress.isNotEmpty ? fullAddress : 'N/A'),
              _buildDetailTile(Icons.access_time, 'Timezone', tzDesc),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F2EC),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.0, color: const Color(0xFF1E5E3A)),
          const SizedBox(width: 12.0),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 13.5, color: Color(0xFF2C3E50), height: 1.4),
                children: [
                  TextSpan(
                    text: '$title: ',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E5E3A)),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}