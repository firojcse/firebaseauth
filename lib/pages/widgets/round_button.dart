import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String titele;
  final VoidCallback onTap;
  final bool loading;
  const RoundButton({Key? key,
    required this.titele,
    required this.onTap,
     this.loading=false,



})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.purple, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child:loading?CircularProgressIndicator(strokeWidth: 3,color: Colors.white,): Text(
            titele,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
