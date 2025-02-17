import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/app_bar_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  
  static const String title = 'My profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(title: ProfilePage.title),
      body: Column(
        children: [
          Text("My profile page"),
        ],
      ),
    );
  }
}
