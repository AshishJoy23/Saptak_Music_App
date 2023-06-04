import 'package:flutter/material.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({super.key});
  final String message = "1. User age limit: Users must be at least 10 years old to use the app.\n2. Subscription fees: Saptak doesn't charges any subscription fees and offers a free usage of this app.\n3. Copyright laws: Users must not use the app to infringe upon the rights of copyright holders.\n4. Data collection and privacy: Saptak collects user data such as usage statistics and location information, and this data is handled in compliance with privacy laws.\n5. Disclaimers: Saptak includes disclaimers limiting the liability of the company for any damages or losses incurred while using the app.";
  final String message1 = "We may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Terms and Conditions on this page.These terms and conditions are effective as of Jan 2023";
  final String message2 = "If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at ashishjoy23@gmail.com.";

  
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
                      'Terms and Conditions',
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
                  Padding(
                    padding: EdgeInsets.all(width1*0.03),
                    child: Text(message1,style: const TextStyle(fontSize: 16),),
                  ),
                  SizedBox(
                        height: height1*0.02,
                      ),
                  Padding(
                    padding: EdgeInsets.all(width1*0.03),
                    child: Text(message2,style: const TextStyle(fontSize: 16),),
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