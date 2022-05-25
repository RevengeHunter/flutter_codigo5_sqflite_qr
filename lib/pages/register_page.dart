import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_codigo5_sqflite_qr/models/vaccine_card_model.dart';
import '../db/db_admin.dart';
import '../ui/general/colors.dart';
import '../ui/widgets/input_textfield_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  String url;
  RegisterPage({
    required this.url,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // @override
  // Widget build(BuildContext context) {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.white,
  //     statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarColor: Colors.white,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ));
  //   return MaterialApp(
  //     title: 'QR.Flutter',
  //     theme: ThemeData.light(),
  //     debugShowCheckedModeBanner: false,
  //     home: MainScreen(),
  //   );
  // }

  //Para que gestione los estados del formulario
  final formKey = GlobalKey<FormState>();

  //Controllers
  final TextEditingController _txtFullNameController = TextEditingController();
  final TextEditingController _txtDNIController = TextEditingController();

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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Register new vaccin card",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InputTextFieldWidget(
                      txtController: _txtFullNameController,
                      txtName: "FullName",
                      iconPath: 'assets/icons/bxl-user.svg',
                      isDNI: false,
                    ),
                    InputTextFieldWidget(
                      txtController: _txtDNIController,
                      txtName: "DNI",
                      iconPath: 'assets/icons/bxs-id-card.svg',
                      isDNI: true,
                    ),
                    Text(
                      "Vaccine Card QR",
                      style: TextStyle(
                        color: kFontPrimaryColor.withOpacity(0.6),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    QrImage(
                      data: widget
                          .url, //En la primera se pone los parametros y constructor, y en la segunda usamos la palabra widget
                      version: QrVersions.auto,
                      size: 220,
                      gapless: false,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 52.0,
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kBrandPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>ScanerQRPage()));
                  if(formKey.currentState!.validate()){
                    VaccineCardModel vaccineCardModel = VaccineCardModel(
                      fullName: _txtFullNameController.text,
                      dni: _txtDNIController.text,
                      urlVaccineCard: widget.url,
                    );
                    DBAdmin.db.insertVaccineCard(vaccineCardModel).then((value){
                      if(value>0){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: const Color(0xff00afb9),
                            duration: const Duration(seconds: 3),
                            content: Row(
                              children: [
                                const Icon(Icons.check),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Text(
                                    "The vaccine card register successful",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                        // Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                      }
                    });
                  }

                },
                child: const Text(
                  "Save Vaccine Card",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
