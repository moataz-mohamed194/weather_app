import 'package:flutter/material.dart';
import 'package:weather_app/core/vars.dart';

class BuildErrorState extends StatelessWidget {
  final String? errorMessage;

  const BuildErrorState({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Icon(
            Icons.error_outline,
            size: 50,
            color: Colors.red[400],
          ),
          10.ph,
          Text(
            errorMessage ?? 'An error occurred',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
