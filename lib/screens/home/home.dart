import 'package:flutter/material.dart';
import 'package:saptak_music_app/screens/home/mostly.dart';
import 'package:saptak_music_app/screens/home/recently.dart';
import 'package:saptak_music_app/screens/search_screen.dart';
import 'package:saptak_music_app/widgets/allsongs_list.dart';



class ScreenHome extends StatefulWidget {
  final String title;
  const ScreenHome({required this.title, super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  //List<MostlyPlayed> mostlySongs = [];
  var time = DateTime.now();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightDsp = MediaQuery.of(context).size.height;
    final widthDsp = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(left: widthDsp*0.03),
            child: const CircleAvatar(
              radius: 10,
              backgroundImage: AssetImage('assets/images/saptak_icon.png'),
            ),
          ),
          title: Text(
            (time.hour<12)?
            'Good Morning!'
            :((time.hour<17)?
            'Good Afternoon!'
            :'Good Evening!'),
            style: const TextStyle(
              fontSize: 24,
              fontFamily: 'HappyMonkey',
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 152, 248, 72),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenSearch()));
              },
              icon: const Icon(Icons.search_sharp,
                  size: 28, color: Color.fromARGB(255, 152, 248, 72)),
            ),
            SizedBox(
              width: widthDsp*0.02,
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: widthDsp * 0.025,
              right: widthDsp * 0.025,
              top: heightDsp * 0.01),
          child: SingleChildScrollView(
            child: Flex(
              direction: Axis.vertical,
              children: 
                [Column(
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Discover!',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: heightDsp * 0.008,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widthDsp * 0.465,
                          height: heightDsp * 0.075,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF00010A),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ScreenRecently()),
                              );
                            },
                            child: const Center(
                              child: Text(
                                'Recently Played',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: widthDsp * 0.465,
                          height: heightDsp * 0.075,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF00010A),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenMostly()),
                              );
                            },
                            child: const Center(
                              child: Text(
                                'Mostly Played',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: heightDsp * 0.007,
                    ),
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Find Your Music',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 0.3,
                      color: Colors.white,
                    ),
                    // const ScreenAllSongs(),
                  ],
                ),
                const ScreenAllSongs(),
              ],
            ),
            
          ),
        ),
      );
  }
}
