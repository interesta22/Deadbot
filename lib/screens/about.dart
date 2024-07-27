import 'package:flutter/material.dart';
import 'package:testt/util/colors.dart';
import 'package:testt/widgets/info_item.dart';


class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLight() {
      if (Theme.of(context).textTheme.bodyLarge!.color == Colors.black) {
        return true;
      } else
        return false;
    }

    bool Is = isLight();

    return Scaffold(
      backgroundColor: Is ? TColors.light : TColors.dark,
      appBar: AppBar(
        backgroundColor: TColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'About',
          style: TextStyle(
              fontSize: 22,
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Image(
              width: 200,
              height: 200,
              image: AssetImage('images/Ellipse 1.png'),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text('Some Features',
                  style: Is
                      ? const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Poppins')
                      : const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Poppins')),
            ),
            Center(
              child: Text('of deadbot',
                  style: Is
                      ? const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: 'Poppins')
                      : const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontFamily: 'Poppins')),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 13),
              child: Divider(),
            ),
            InfoItem(
              title: 'Multimodal understanding',
              value: 'I can process information from text, code, images, and even video, allowing me to grasp complex topics and respond with relevant insights.',
            ),
            InfoItem(
              title: 'Strong performance across benchmarks',
              value: 'Compared to other large language models, I achieve high scores in tasks like document understanding, question answering, and code generation.',
            ),
            InfoItem(
              title: 'Flexibility',
              value: 'I come in three versions (Nano, Pro, and Ultra) to suit different needs. You can use the lightweight Nano version on mobile devices or the powerful Ultra for large-scale data analysis.',
            ),
            InfoItem(
              title: 'Constantly learning',
              value: 'I am still under development, but I am continuously being updated with new information and improving my abilities.',
            ),
            InfoItem(
              title: 'Efficiency and Automation',
              value: 'I can automate tasks that involve information processing and analysis. This saves you time and allows you to focus on more complex work.',
            ),
            InfoItem(
              title: 'Improved Content Creation',
              value: 'I can help you generate different creative text formats, translate languages, and write different kinds of content more efficiently.',
            ),
            InfoItem(
              title: 'Research and Summarization',
              value: 'I can sift through vast amounts of information and summarize key points, helping you conduct research and stay informed on specific topics.',
            ),
            InfoItem(
              title: 'Enhanced User Experience',
              value: 'I can be used to create chatbots and virtual assistants that provide more natural and informative interactions.',
            ),
            InfoItem(
              title: 'Multilingual capabilities',
              value: 'I can understand and respond in multiple languages, fostering communication and information access across language barriers.',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text('Thanks',
                    style: Is
                        ? const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: 'Poppins')
                        : const TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'Poppins')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
