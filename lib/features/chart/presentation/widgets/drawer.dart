import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:haash_moving_chart/cores/services/firebase_methods.dart';
import 'package:haash_moving_chart/cores/theme/color_pellets.dart';
import 'package:haash_moving_chart/cores/theme/provider/theme_provider.dart';
import 'package:haash_moving_chart/cores/widgets/spacer.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SpacerWidget(
                    height: 20,
                  ),
                  const SizedBox(
                    child: ListTile(
                      tileColor: Colors.transparent,
                      contentPadding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      title: Text(
                        'MOVING CHART',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 5),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    height: 2,
                    width: 200,
                    color: AppPallete.greyColor,
                  ),
                  const SpacerWidget(
                    height: 20,
                  ),
                  user == null
                      ? const SizedBox()
                      : ListTile(
                          tileColor: Colors.transparent,
                          leading: const Icon(Icons.person_outlined),
                          visualDensity:
                              const VisualDensity(vertical: -3, horizontal: 1),
                          title: Text(user!.email!),
                          onTap: () {
                            context
                                .read<FirebaseAuthMethods>()
                                .signOut(context);
                          },
                        ),
                  ListTile(
                    tileColor: Colors.transparent,
                    leading: const Icon(Icons.color_lens),
                    visualDensity:
                        const VisualDensity(vertical: -3, horizontal: 1),
                    trailing: Consumer<ThemeProvider>(
                        builder: (context, provider, child) {
                      return Switch(
                        value: provider.isDarkMode,
                        onChanged: (value) {
                          provider.toggleTheme(user!);
                        },
                      );
                    }),
                    title: const Text('Dark Mode '),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  user == null
                      ? const SizedBox()
                      : ListTile(
                          tileColor: Colors.transparent,
                          leading: const Icon(Icons.logout),
                          visualDensity:
                              const VisualDensity(vertical: -3, horizontal: 1),
                          title: const Text('Logout'),
                          onTap: () {
                            context
                                .read<FirebaseAuthMethods>()
                                .signOut(context);
                          },
                        ),
                ],
              ),
            ),
            const Text('@ HAASH.tech')
          ],
        ),
      ),
    );
  }
}
