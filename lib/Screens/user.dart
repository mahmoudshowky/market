import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter3/widgets/text_widget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../provider/dark_theme_provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _adderssTextController =
      TextEditingController(text: "");
  @override
  void dispose() {
    _adderssTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Hi,    ',
                    style: const TextStyle(
                      color: Colors.cyan,
                      fontSize: 27,
                      fontWeight: FontWeight.bold,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'My Name',
                          style: TextStyle(
                            color: color,
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('my name is mahmoud');
                            }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                TextWidget(text: 'Email@email.com', color: color, textSize: 18),
                const SizedBox(
                  height: 15,
                ),
                const Divider(
                  thickness: 2,
                ),
                _listTitles(
                  title: 'Adderss',
                  subtitle: 'my Adderss 2',
                  icon: IconlyBold.profile,
                  onPressed: () async {
                    await _showAdderssDialog();
                  },
                  color: color,
                ),
                _listTitles(
                  title: 'Orders',
                  icon: IconlyBold.bag,
                  onPressed: () {},
                  color: color,
                ),
                _listTitles(
                  title: 'Wishlis',
                  icon: IconlyBold.heart,
                  onPressed: () {},
                  color: color,
                ),
                _listTitles(
                  title: 'Viewed',
                  icon: IconlyBold.show,
                  onPressed: () {},
                  color: color,
                ),
                _listTitles(
                  title: 'Forget password',
                  icon: IconlyBold.unlock,
                  onPressed: () {},
                  color: color,
                ),
                SwitchListTile(
                  title: TextWidget(
                      text:
                          themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                      color: color,
                      textSize: 22),
                  secondary: Icon(themeState.getDarkTheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined),
                  onChanged: (bool value) {
                    setState(() {
                      themeState.setDarkTheme = value;
                    });
                  },
                  value: themeState.getDarkTheme,
                ),
                _listTitles(
                  title: 'Logout',
                  icon: IconlyBold.logout,
                  onPressed: () {
                    _showLogoutDialog();
                  },
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('Sign out'),
            ]),
            content: const Text('do you wanna sign out?'),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'cancel',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: TextWidget(
                  color: Colors.red,
                  text: 'ok',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

  Future<void> _showAdderssDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text('Update'),
              content: TextField(
                // onChanged: (value) {
                //   print(
                //       '_adderssTextController.text ${_adderssTextController.text}');
                // },
                controller: _adderssTextController,
                maxLines: 5,
                decoration: const InputDecoration(hintText: "your Adderss"),
              ),
              actions: [
                TextButton(child: const Text('update'), onPressed: () {})
              ]);
        });
  }

  Widget _listTitles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        textSize: 22,
        color: color,
        //isTitle: true,
      ),
      subtitle: TextWidget(
        text: subtitle == null ? "" : subtitle,
        textSize: 18,
        color: color,
      ),
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }
}
