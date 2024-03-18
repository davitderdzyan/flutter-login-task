import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> images = ['image_1.png', 'image_2.png', 'image_3.png'];

  final List<String> messages = [
    'Find customers for your services',
    'Gain interested shoppers for your products',
    'Increase your awareness in style, fashion and beauty'
  ];

  late CarouselSliderController _sliderController;

  @override
  void initState() {
    super.initState();
    _sliderController = CarouselSliderController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).width * 1.64,
      child: CarouselSlider.builder(
        unlimitedMode: true,
        controller: _sliderController,
        slideBuilder: (index) {
          return Stack(children: [
            Image.asset('assets/images/${images[index]}',
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 0),
                      Color.fromRGBO(0, 0, 0, 0.0629),
                      Color.fromRGBO(0, 0, 0, 0.65),
                    ],
                  ),
                ),
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.only(
                    left: 40, right: 40, bottom: 38, top: 48),
                child: Text(
                  messages[index],
                  style: const TextStyle(
                    fontFamily: 'roboto',
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                ),
              ),
            ),
          ]);
        },
        slideTransform: StackTransform(),
        slideIndicator: CircularSlideIndicator(
            padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
            currentIndicatorColor: const Color.fromRGBO(255, 255, 255, 1),
            indicatorBackgroundColor: const Color.fromRGBO(255, 255, 255, 0.53),
            indicatorRadius: 4),
        itemCount: images.length,
        initialPage: 0,
        enableAutoSlider: true,
      ),
    );
  }
}
