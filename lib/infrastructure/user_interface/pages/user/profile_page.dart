import 'package:flutter/material.dart';
import 'package:overload/infrastructure/exception/exception_handler.dart';
import 'package:overload/infrastructure/providers/user_provider.dart';
import 'package:overload/infrastructure/user_interface/widgets/layout/app_bar_widget.dart';
import 'package:overload/infrastructure/user_interface/widgets/user/user_profile_form_widget.dart';
import 'package:provider/provider.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(
        context,
        listen: false,
      ).loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(
      context,
    );
    return Scaffold(
      appBar: const AppBarWidget(title: ProfilePage.title),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              UserProfileFormWidget(
                user: userProvider.user,
                onSubmit: (Map<String, dynamic> formData) async {
                  final userProvider = Provider.of<UserProvider>(
                    context,
                    listen: false,
                  );
                  try {
                    await userProvider.updateProfile(formData);
                    if (!context.mounted) return;
                  } catch (e) {
                    ExceptionHandler().handleException(context, e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
