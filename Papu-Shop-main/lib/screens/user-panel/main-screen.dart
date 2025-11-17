// ignore_for_file: file_names, prefer_const_constructors

import 'package:e_shop/screens/user-panel/carrito-screen.dart';
import 'package:e_shop/screens/user-panel/todas-categorias-screen.dart';
import 'package:e_shop/screens/user-panel/todas-ventas-flash-productos.dart';
import 'package:e_shop/screens/user-panel/todos-productos-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:e_shop/widgets/custom-drawer-widget.dart';
import 'package:e_shop/widgets/heading-widget.dart';
import 'package:e_shop/widgets/ventas-flash-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../widgets/banner-widget.dart';
import '../../widgets/categoria-widget.dart';
import '../../widgets/todos-productos-widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppConstant.appTextColor),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppConstant.appSecondColor,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: TextStyle(color: AppConstant.appTextColor),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CarritoScreen()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.shopping_cart),
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            child: Column(
          children: [
            SizedBox(
              height: Get.height / 90.0,
            ),
            Text("Camisetas"),
            //banners
            BannerWidget(),

            //heading
            HeadingWidget(
              headingTitle: "Categorias",
              headingSubTitle: "Precios bajos",
              onTap: () => Get.to(() => AllCategoriesScreen()),
              buttonText: "Ver más >",
            ),

            CategoriaWidget(),

            HeadingWidget(
              headingTitle: "Ventas Relampago",
              headingSubTitle: "Precios bajos",
              onTap: () => Get.to(() => AllVentasFlashProductoScreen()),
              buttonText: "Ver más >",
            ),

            VentasFlashWidget(),

            HeadingWidget(
              headingTitle: "Todos los Productos",
              headingSubTitle: "Precios bajos",
              onTap: () => Get.to(() => AllProductosScreen()),
              buttonText: "Ver más >",
            ),

            AllProductosWidget(),
          ],
        )),
      ),
    );
  }
}
