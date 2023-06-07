import 'package:flutter/material.dart';
import 'package:pixabay/Constants.dart';
import 'package:provider/provider.dart';

import 'PButton.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function() onConfirmed;

  const CommonDialog(
      {super.key,
        required this.title,
        required this.subtitle,
        required this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: SpaceConstants.paddingMedium.copyWith(left:30,right: 30),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: SpaceConstants.paddingMedium,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SpaceConstants.space,
                Text(subtitle,
                    style: Theme.of(context).textTheme.bodyMedium),
                SpaceConstants.space,
                Row(
                  children: [
                    Expanded(
                      child: PButton(
                          color: Colors.grey,
                          text: "Cancel",
                          onTap: () => Navigator.pop(context)),
                    ),
                    SpaceConstants.space,
                    Expanded(
                      child: PButton(
                          text: "Confirm",
                          onTap: onConfirmed),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
