import 'package:e_shop/screens/admin-panel/crud-categorias-screen.dart';
import 'package:e_shop/screens/admin-panel/crud-productos-off-screen.dart';
import 'package:e_shop/screens/user-panel/carrito-screen.dart';
import 'package:e_shop/screens/user-panel/factura-screen.dart';
import 'package:e_shop/utils/app-constant.dart';
import 'package:e_shop/widgets/custom-drawer-widget.dart';
import 'package:e_shop/widgets/edit-producto-widget.dart';
import 'package:e_shop/widgets/edit-ventas-flash-widget.dart';
import 'package:e_shop/widgets/edith-categoria-widget.dart';
import 'package:e_shop/widgets/heading-widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../widgets/banner-widget.dart';

class AdminMainScreen extends StatelessWidget {
  const AdminMainScreen({super.key});

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
              onTap: () => Get.to(() => CrudCategoriesScreen()),
              buttonText: "Ver más >",
            ),

            EditCategoriaWidget(),

            HeadingWidget(
              headingTitle: "Ventas Relampago",
              headingSubTitle: "Precios bajos",
              onTap: () => Get.to(() => CrudProductosFlashScreen()),
              buttonText: "Ver más >",
            ),

            EditVentasFlashWidget(),

            HeadingWidget(
              headingTitle: "Todos los Productos",
              headingSubTitle: "Precios bajos",
              onTap: () => Get.to(() => FacturasScreeen()),
              buttonText: "Ver más >",
            ),

            EditAllProductosWidget(),
          ],
        )),
      ),
    );
  }
}
