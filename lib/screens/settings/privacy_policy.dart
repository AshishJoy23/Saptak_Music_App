import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});
  final String message = "For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to tall man,. The information that I request will be retained on your device and is not collected by me in any way.\nThe app does use third-party services that may collect information used to identify you.";
  final String message1 = "We collect the following types of information from our users:\n1. Music library information, such as song titles, artist names, and album covers, to organize and display users' music collections.\n2. Usage data, such as songs played, playlists created, and repeat playback, to improve the user experience and make product decisions.\n3. Technical data, such as device information, operating system, and app version, to diagnose technical issues and improve app performance.";
  final String message2 = "We use the collected information to provide, maintain, and improve our music streaming application. Specifically, we use the information to:\n1. Organize and display users' music collections.\n2. Personalize the user experience by creating playlists and displaying recently played songs.\n3. Analyze usage data to improve our app features and user experience.\n4. Respond to user support inquiries and resolve technical issues.";
  final String message3 = "We do not share users' personal information with third parties, except for our service providers who assist us in providing our services. We ensure that such third-party service providers agree to use the information solely for the purpose of providing the requested services and comply with the relevant privacy regulations.";
  final String message4 = 'We may update this privacy policy from time to time to reflect changes in our business practices or legal obligations. We encourage users to review the policy periodically to stay informed about how we collect, use, and protect their personal information.';
  final String message5 = "Ashish Joy built the Saptak Music app as a Free app. This SERVICE is provided by Ashish Joy at no cost and is intended for use as is.";

  final String message6 = "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at ashishjoy23@gmail.com.";

  
  @override
  Widget build(BuildContext context) {
    final height1 = MediaQuery.of(context).size.height;
    final width1 = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 63, 97),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        color: Color.fromARGB(255, 152, 248, 72),
                      ),
                    ),
                    ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(width1*0.03),
                    child: Text(message,style: const TextStyle(fontSize: 16),),
                  ),
                  SizedBox(
                        height: height1*0.02,
                      ),
                  Row(
                    children: [
                      SizedBox(
                        width: width1 * 0.04,
                      ),
                      const Text(
                        'Information We Collect:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(width1*0.03),
                    child: ReadMoreText(
                      message1,
                      trimLines: 5,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                          fontSize: 16, height: 1.5, color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width1 * 0.04,
                      ),
                      const Text(
                        'Use of Information:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(width1*0.03),
                    child: ReadMoreText(
                      message2,
                      trimLines: 5,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                          fontSize: 16, height: 1.5, color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width1 * 0.04,
                      ),
                      const Text(
                        'Sharing of Information:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(width1*0.03),
                    child: ReadMoreText(
                      message3,
                      trimLines: 5,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                          fontSize: 16, height: 1.5, color: Colors.white),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: width1 * 0.04,
                      ),
                      const Text(
                        'Updates to Privacy Policy:',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(width1*0.03),
                    child: ReadMoreText(
                      message4,
                      trimLines: 5,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      lessStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      moreStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      style: const TextStyle(
                          fontSize: 16, height: 1.5, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(width1*0.03),
                    child: Text(message5,style: const TextStyle(fontSize: 16),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(width1*0.03),
                    child: Text(message6,style: const TextStyle(fontSize: 16),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}