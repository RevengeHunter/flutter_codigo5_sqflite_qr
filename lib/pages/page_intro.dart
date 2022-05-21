import 'package:flutter/material.dart';

import '../ui/general/colors.dart';
import 'home_page.dart';

class PageIntro extends StatelessWidget {
  const PageIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Tu carnet de Vacunacion",
              style: TextStyle(
                fontSize: 46.0,
                height: 1.0,
                fontWeight: FontWeight.w800,
                color: kFontPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              "Con esta app podras gestionar los carnets de vacunación de las personas que más prefieras. No olvides ser responsable",
              style: TextStyle(
                fontSize: 16.0,
                height: 1.4,
                fontWeight: FontWeight.w500,
                color: kFontPrimaryColor,
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 52.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kBrandPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                },
                child: Text(
                  "Iniciar Ahora",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
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
