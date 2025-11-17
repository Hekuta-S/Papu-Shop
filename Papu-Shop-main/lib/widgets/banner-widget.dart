// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shop/controllers/banners-controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    final CarouselController carouselController = CarouselController();
    final bannerController _bannerController = Get.put(bannerController());
    return Container(
      child: Obx(() {
        return CarouselSlider(
          items: _bannerController.bannerUrls
              .map(
                (urlImagenes) => ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: CachedNetworkImage(
                    imageUrl: urlImagenes,
                    fit: BoxFit.cover,
                    width: Get.width - 10,
                    placeholder: (context, url) => ColoredBox(
                      color: Colors.white,
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, Error) => Icon(Icons.error),
                  ),
                ),
              )
              .toList(),
          options: CarouselOptions(
            scrollDirection: Axis.horizontal,
            autoPlay: true,
            aspectRatio: 2.5,
            viewportFraction: 1,
          ),
        );
      }),
    );
  }
}
