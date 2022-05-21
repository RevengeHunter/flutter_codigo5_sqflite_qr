import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite_qr/pages/scaner_qr_page.dart';
import 'package:flutter_svg/svg.dart';

import '../ui/general/colors.dart';
import '../ui/widgets/item_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: kFontPrimaryColor,
          ),
          title: Text(
            "Vaccine Storage",
            style: TextStyle(
              color: kFontPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "My vaccin cards registered",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ItemListWidget(),
                    ItemListWidget(),
                    ItemListWidget(),
                    ItemListWidget(),
                    ItemListWidget(),
                    ItemListWidget(),
                    ItemListWidget(),
                    ItemListWidget(),
                    ItemListWidget(),
                    const SizedBox(
                      height: 70.0,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 52.0,
                width: double.infinity,
                margin: const EdgeInsets.all(12.0),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: kBrandPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanerQRPage()));
                  },
                  label: const Text(
                    "Scan QR",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/icons/bx-qr-scan.svg',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
