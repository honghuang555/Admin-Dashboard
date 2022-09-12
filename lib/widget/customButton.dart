import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final bool isLoading;
  final bool active;
  final String text;
  final VoidCallback onPressed;
  Color buttonColor;
  Icon icon;

  CustomButton({this.isLoading = false, this.active = true, this.text = "Button", required this.onPressed, this.buttonColor = Colors.black, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 280,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(active ? buttonColor : Colors.grey[200]),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              )
          ),
          onPressed: active ? onPressed : () {},
          child: isLoading ?
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon != null ? Row(children: [icon, SizedBox(width: 10) ],) : Container(),
              Text(
                text,
                style: TextStyle(
                  color: active ? Colors.white : Color(0xFF285474),
                  fontSize: 20.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          )
      ),
    );
  }
}