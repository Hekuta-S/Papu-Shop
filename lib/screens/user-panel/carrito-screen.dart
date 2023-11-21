import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text("Carrito"),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 10,
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return Card(
              elevation: 5,
              color: AppConstant.appTextColor,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppConstant.appMainColor,
                  child: Text("olap"),
                ),
                title: Text("coyonas gratis"),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("20"),
                    SizedBox(width: Get.width / 20 - 0),
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: AppConstant.appMainColor,
                      child: Text('-'),
                    ),
                    SizedBox(width: Get.width / 20 - 0),
                    CircleAvatar(
                      radius: 14.0,
                      backgroundColor: AppConstant.appMainColor,
                      child: Text('+'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 5.0),
        child: Row(
          children: [
            Text("Sub Total: "),
            SizedBox(
              width: Get.width / 40,
            ),
            Text("Rs holam"),
            SizedBox(
              width: Get.width / 3.1,
            ),
            Material(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width / 3.0,
                  height: Get.height / 20,
                  decoration: BoxDecoration(
                      color: AppConstant.appSecondColor,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: TextButton(
                    child: Text("Comprar",
                        style: TextStyle(color: AppConstant.appTextColor)),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
