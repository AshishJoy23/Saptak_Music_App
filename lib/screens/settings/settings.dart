import 'package:flutter/material.dart';
import 'package:saptak_music_app/screens/settings/privacy_policy.dart';
import 'package:saptak_music_app/screens/settings/terms_and_condtn.dart';

class ScreenSettings extends StatefulWidget {
  const ScreenSettings({required this.title, super.key});

  final String title;
  @override
  State<ScreenSettings> createState() => _ScreenSettingsState();
}

class _ScreenSettingsState extends State<ScreenSettings> {
  // int _selectedIndex=3;
  // final _screens = [
  //   ScreenHome(),
  //   ScreenFavorites(),
  //   ScreenPlaylists(),
  //   ScreenSettings(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 40.0, bottom: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'Poppins',
              color: Color.fromARGB(255, 152, 248, 72),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(children: [
          ListTile(
            title: const Text(
              'Theme',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            onTap: () {
            },
          ),
          ListTile(
            title: const Text(
              'Privacy Policy',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'Terms and Conditions',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TermsAndCondition()),
              );
            },
          ),
          ListTile(
            title: const Text(
              'About Us',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            onTap: () {
              aboutUsPopUp();
            },
          ),
        ]),
      ),
    );
  }

  aboutUsPopUp() {
    final widthDsp = MediaQuery.of(context).size.width;
    final heightDsp = MediaQuery.of(context).size.height;
    showAboutDialog(
        context: context,
        applicationIcon: Container(
          height: heightDsp*0.09,
          width: widthDsp * 0.18,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/saptak_icon.png')),
          ),
        ),
        applicationName: "Saptak",
        applicationVersion: '1.0.0',
        applicationLegalese: 'Copyright © 2023 Saptak',
        children: [
          const Text(
              "Saptak is an offline music player app which allows user to hear music from their storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
          SizedBox(
            height: heightDsp*0.02,
          ),
          const Text("App developed by Ashish Joy.")
        ]);
  }
}
