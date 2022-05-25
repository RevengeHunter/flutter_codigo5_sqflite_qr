import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite_qr/models/vaccine_card_model.dart';
import 'package:flutter_svg/svg.dart';

import '../general/colors.dart';

class ItemListWidget extends StatelessWidget {

  VaccineCardModel vaccineModel;
  Function onPressed;

  ItemListWidget({
    required this.vaccineModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 10.0,
      ),
      margin: const EdgeInsets.symmetric(vertical: 7.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bxl-user.svg',
                      color: kFontPrimaryColor,
                      height: 13.0,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(
                        color: kFontPrimaryColor.withOpacity(0.6),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  vaccineModel.fullName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/bxs-id-card.svg',
                      color: kFontPrimaryColor,
                      height: 13.0,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      "DNI",
                      style: TextStyle(
                        color: kFontPrimaryColor.withOpacity(0.6),
                        fontSize: 13.0,
                      ),
                    ),
                  ],
                ),
                Text(
                  vaccineModel.dni.toString(),
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: (){onPressed();},
            icon: SvgPicture.asset(
              'assets/icons/bxs-show.svg',
              color: kFontPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
