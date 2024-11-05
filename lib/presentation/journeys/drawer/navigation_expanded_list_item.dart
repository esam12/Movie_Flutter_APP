import 'package:flutter/material.dart';
import 'package:movieapp/presentation/journeys/drawer/navigation_list_item.dart';

class NavigationExpandedListItem extends StatelessWidget {
  const NavigationExpandedListItem({
    super.key,
    required this.title,
   required this.onTap,
    required this.children,
  });

  final String title;
  final Function onTap;
  final List<String> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
              blurRadius: 2),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        children: [
          for (int i = 0; i < children.length; i++)
            NavigationSubListItem(
              title: children[i],
              onTap: () => onTap(i),
            ),
        ],
      ),
    );
  }
}
