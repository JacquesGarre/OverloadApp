import 'package:flutter/material.dart';
import 'package:overload/infrastructure/user_interface/pages/user/profile_page.dart';
import 'package:overload/infrastructure/user_interface/theme/app_color_scheme.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        if (title != ProfilePage.title)
          IconButton(
            icon: CircleAvatar(
              backgroundColor: AppColorScheme.lightBackground,
              radius: 16,
              child: Icon(Icons.person, color: AppColorScheme.primary),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfilePage(),
                ),
              );
            },
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
