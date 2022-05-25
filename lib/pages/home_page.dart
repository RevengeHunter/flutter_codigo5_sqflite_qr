import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite_qr/db/db_admin.dart';
import 'package:flutter_codigo5_sqflite_qr/models/vaccine_card_model.dart';
import 'package:flutter_codigo5_sqflite_qr/pages/scaner_qr_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ui/general/colors.dart';
import '../ui/widgets/item_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<VaccineCardModel> vaccineCards = [];
  // final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  //     GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    getInitialData();
  }

  getInitialData() {
    DBAdmin.db.getVaccineCards().then((value) {
      vaccineCards = value;
      setState(() {});
    });
  }

  _showInformation(VaccineCardModel vaccineModel) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.65),
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Detail Vaccine Card",
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Text(
                    "Full Name",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    vaccineModel.fullName,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                children: [
                  Text(
                    "DNI",
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    vaccineModel.dni.toString(),
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Text(
                "QR Image",
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.0,),
              GestureDetector(
                onTap: (){
                  print(vaccineModel.urlVaccineCard);
                  final Uri _url = Uri.parse(vaccineModel.urlVaccineCard);
                  launchUrl(_url);
                },
                child: SizedBox(
                  width: 160.0,
                  height: 160.0,
                  child: QrImage(
                    data: vaccineModel.urlVaccineCard, //En la primera se pone los parametros y constructor, y en la segunda usamos la palabra widget
                    version: QrVersions.auto,
                    size: 100,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
          Padding(
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
                vaccineCards.isNotEmpty
                    ? Expanded(
                  child: RefreshIndicator(
                    strokeWidth: 2.0,
                    color: kBrandPrimaryColor,
                    onRefresh: () async {
                      await Future.delayed(Duration(seconds: 3), () {
                        getInitialData();
                      });
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: vaccineCards.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ItemListWidget(
                          vaccineModel: vaccineCards[index],onPressed: (){_showInformation(vaccineCards[index]);},
                        );
                      },
                    ),
                  ),
                )
                    : Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      Image.asset(
                        'assets/images/box.png',
                        height: 100,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        "Aún no tienes carnets registrados.",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: kFontPrimaryColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 70.0,
                ),
              ],
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScanerQRPage()));
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
      ),
    );
  }
}
