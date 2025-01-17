import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    double mainw = MediaQuery.of(context).size.width;
    double mainh = MediaQuery.of(context).size.height;
    return UnconstrainedBox(
      child: Container(
        width: mainw * .20,
        height: mainh * .08,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: const Offset(5, 5),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.01),
              offset: const Offset(-5, -5),
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Material(
          color: Colors.transparent,
          child: LayoutBuilder(
              builder: (context, constraints) => UnconstrainedBox(
                    child: Container(
                        color: Colors.transparent,
                        width: constraints.maxWidth * .85,
                        height: constraints.maxHeight * .85,
                        child: Lottie.asset('lotties/loading.json')),
                  )),
        ),
      ),
    );
  }
}
