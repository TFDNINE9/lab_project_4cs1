import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double height;
  final double width;
  final String textBoldtitle;
  final Color textDetailColor;
  final Widget? priceCurrency;
  final Widget? onlyPrice;
  final Widget? textAccountNameWidget;
  final String textDetailtitle;
  final String textAccountName;
  final String? priceTitle;
  final String currency;

  final GestureTapCallback? onPressed;
  const CustomCard(
      {super.key,
      this.height = 100,
      this.width = 353,
      this.textBoldtitle = '--/--/--',
      this.textDetailColor = Colors.black,
      this.textDetailtitle = 'no detail',
      this.priceTitle = '0',
      this.currency = '',
      this.onPressed,
      this.priceCurrency,
      this.textAccountName = '',
      this.textAccountNameWidget,
      this.onlyPrice});

  @override
  Widget build(BuildContext context) {
    String amount = priceTitle.toString();
    var arr = amount.split('.');

    return InkWell(
      onTap: onPressed,
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: height,
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        textBoldtitle,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    if (priceCurrency != null || currency.isNotEmpty) ...[
                      priceCurrency ??
                          Row(
                            children: [
                              if (priceTitle != '0' || onlyPrice != null) ...[
                                onlyPrice ??
                                    Text(
                                      arr[0],
                                      style: const TextStyle(
                                          color: Colors.red, fontSize: 16),
                                    )
                              ],
                              const SizedBox(width: 5),
                              Text(
                                currency,
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  textDetailtitle,
                  style: TextStyle(
                    color: textDetailColor,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const Spacer(),
                if (textAccountNameWidget != null ||
                    textAccountName.isNotEmpty) ...[
                  textAccountNameWidget ?? const Spacer(),
                ],
                if (textAccountNameWidget != null ||
                    textAccountName.isNotEmpty) ...[
                  textAccountNameWidget ??
                      Text(
                        textAccountName,
                        style: TextStyle(
                          color: textDetailColor,
                          fontSize: 16,
                        ),
                      ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
