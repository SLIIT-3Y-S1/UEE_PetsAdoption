import 'package:flutter/material.dart';
import 'package:pawpal/theme/theme.dart';

class AllAdoptionPosts extends StatefulWidget {
  @override
  _AllAdoptionPostsState createState() => _AllAdoptionPostsState();
}

class _AllAdoptionPostsState extends State<AllAdoptionPosts> {
  Color switchColor(String availability) {
    if (availability == 'Available') {
      return Colors.green[500]!;
    } else {
      return Colors.orange[500]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                  child: Container(
                    height: 290,
                    width: double.infinity,
                    color: AppTheme.lightTheme.colorScheme.surface,
                    child: Image.network('https://placehold.co/620x480/FFDBBB/000000/png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name', textAlign: TextAlign.left, style: AppTheme.lightTheme.textTheme.bodyMedium),
                          Text('Breed $index', textAlign: TextAlign.end, style: AppTheme.lightTheme.textTheme.bodySmall),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$index Age', textAlign: TextAlign.left, style: AppTheme.lightTheme.textTheme.bodySmall),
                          Text(
                            'Available',
                            textAlign: TextAlign.end,
                            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                              color: switchColor('Available'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Gender', textAlign: TextAlign.left, style: AppTheme.lightTheme.textTheme.bodySmall),
                          Text('Location', textAlign: TextAlign.end, style: AppTheme.lightTheme.textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
