import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: const SingleChildScrollView(
          child: Column(
            children: [
              //

              // MyButtonTemplate(
              //     height: mainh * 0.05,
              //     onPressed: () {},
              //     text: 'show',
              //     width: mainw * .45)

              //
            ],
          ),
        ),
      ),
    );
  }
}
