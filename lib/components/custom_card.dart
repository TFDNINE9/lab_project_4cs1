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

  const CustomCard({
    super.key,
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
    this.onlyPrice,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.blue.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: 20,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.blue.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.category_outlined,
                      color: Colors.blue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          textBoldtitle,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          textDetailtitle,
                          style: TextStyle(
                            color: textDetailColor,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
