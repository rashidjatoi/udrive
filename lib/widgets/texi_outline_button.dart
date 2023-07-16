import 'package:flutter/material.dart';

class TaxiOutlineButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final bool loading;

  const TaxiOutlineButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.color,
    required this.textColor,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      onPressed: onPressed,
      color: color,
      textColor: textColor,
      child: SizedBox(
        height: 50.0,
        child: Center(
          child: loading
              ? const CircularProgressIndicator()
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Brand-Bold',
                    color: textColor,
                  ),
                ),
        ),
      ),
    );
  }
}
