import 'package:flutter/material.dart';
import 'package:weather_app/core/vars.dart';

class BuildInitialState extends StatelessWidget {
  const BuildInitialState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Icon(
            Icons.search,
            size: 50,
            color: Colors.grey[400],
          ),
          10.ph,
          Text(
            'Search for a city to get weather information',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
