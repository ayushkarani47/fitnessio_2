import 'package:Fitnessio/presentation/auth/pages/register_page.dart';
import 'package:Fitnessio/trainer/auth/provider/auth_provider_trainer.dart';
import 'package:Fitnessio/trainer/home/provider/trainer_home_provider.dart';
import 'package:Fitnessio/trainer/home/widgets/home_page_appbar.dart';
import 'package:Fitnessio/trainer/presentation/exercise_or_meal.dart';
import 'package:Fitnessio/utils/managers/style_manager.dart';
import 'package:Fitnessio/utils/managers/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TrainerMainPage extends StatefulWidget {
  const TrainerMainPage({super.key});

  @override
  State<TrainerMainPage> createState() => _TrainerMainPageState();
}

class _TrainerMainPageState extends State<TrainerMainPage> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    searchController.addListener(_filterUsers);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchUsers() async {
    final trainerAuthProvider = Provider.of<AuthProviderTrainer>(context, listen: false);
    try {
      List<Map<String, dynamic>> fetchedUsers = await trainerAuthProvider.fetchUsersForTrainer();
      setState(() {
        users = fetchedUsers;
        filteredUsers = fetchedUsers; // Initialize with all users
      });
    } catch (e) {
      print('Error fetching users: $e');
    }
  }

  void _filterUsers() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredUsers = users.where((user) {
        final name = user['name']?.toLowerCase() ?? '';
        return name.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final trainerHomeProvider = Provider.of<TrainerHomeProvider>(context);
    final user = Provider.of<AuthProviderTrainer>(context).user;

    if (user == null) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: const Center(
          child: Text(
            'No user is logged in.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }

    trainerHomeProvider.fetchTrainerData();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, SizeManager.s60.h),
        child: const HomePageAppbar(),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeManager.s16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Message
            Text(
              'Welcome ${trainerHomeProvider.userData['name']} ${trainerHomeProvider.userData['surname']}!',
              style: StyleManager.homeTitleDataTextStyle,
            ),
            const SizedBox(height: 10),

            // Search Bar
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search users...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // User List
            Expanded(
              child: filteredUsers.isEmpty
                  ? const Center(
                      child: Text(
                        'No users found.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredUsers.length,
                      itemBuilder: (context, index) {
                        final user = filteredUsers[index];
                        return Card(
                          color: Colors.grey[800],
                          child: ListTile(
                            title: Text(
                              user['name'] ?? 'Unknown User',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "Email: ${user['email'] ?? 'N/A'}",
                              style: const TextStyle(color: Colors.grey),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            onTap: () {
                              // Navigate to user details
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseOrMeal(user: user)));
                              print('Selected user: ${user['name']}');
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),

      // Add Trainee Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegisterPage()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
