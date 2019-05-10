import 'package:flutter/material.dart';
import 'package:shopping_app/src/constants/appColors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onTap;
  final IconData icon;
  final double borderRadius;

  RoundedButton({
    @required this.title,
    @required this.onTap,
    this.color = AppColors.primary,
    this.icon,
    this.borderRadius = 8.0
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 13),
      color: AppColors.primary,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      onPressed: onTap,
      child: Row(
        children: <Widget>[
          icon != null
              ? Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Icon(
                    icon,
                    color: AppColors.white,
                    size: 24,
                  ),
                )
              : Container(width: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
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
