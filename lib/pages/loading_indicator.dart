import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {

  //final bool isLoading;
  //final Widget child;
  const LoadingIndicator({super.key,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 50,
            ),
          ),
        )
      ],
    );
  }
}