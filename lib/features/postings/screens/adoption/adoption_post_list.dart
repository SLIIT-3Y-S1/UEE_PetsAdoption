import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pawpal/core/constants/colors.dart';
import 'package:pawpal/features/postings/models/adoption_post_model.dart';
import 'package:pawpal/features/postings/services/adoption_firestore_service.dart';
import 'package:pawpal/theme/theme.dart';
import 'package:pawpal/features/postings/screens/adoption/adoption_post_view.dart'; // Import the AdoptionPostView

class AllAdoptionPosts extends StatefulWidget {
  @override
  _AllAdoptionPostsState createState() => _AllAdoptionPostsState();
}

class _AllAdoptionPostsState extends State<AllAdoptionPosts> {
  final AdoptionFirestoreService _firestoreService = AdoptionFirestoreService();
  late List<AdoptionPostModel> _postlist = [];

  Color switchColor(String availability) {
    if (availability == 'Available') {
      return Colors.green[500]!;
    } else {
      return Colors.orange[500]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance.collection('adoptionPosts').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No adoption posts found.'));
        }
        final adoptionPosts = snapshot.data!.docs;
        return ListView.builder(
          itemCount: adoptionPosts.length,
          itemBuilder: (context, index) {
            final adoption = adoptionPosts[index];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AdoptionPostView(postSnapshot: adoption),
                    ),
                  );
                },
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
                          child: Image.network(adoption[
                              'imageUrl']), // Image.network(adoption['imageUrl']),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(adoption['palname'],
                                    textAlign: TextAlign.left,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodyMedium),
                                Text(adoption['breed'],
                                    textAlign: TextAlign.end,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('${adoption['age']} years',
                                    textAlign: TextAlign.left,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall),
                                Text(
                                  adoption['availability'],
                                  textAlign: TextAlign.end,
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color:
                                        switchColor(adoption['availability']),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(adoption['gender'],
                                    textAlign: TextAlign.left,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall),
                                Text(adoption['city'],
                                    textAlign: TextAlign.end,
                                    style: AppTheme
                                        .lightTheme.textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class AdoptionPostView extends StatelessWidget {
  final DocumentSnapshot postSnapshot;

  AdoptionPostView({required this.postSnapshot});

  @override
  Widget build(BuildContext context) {
    final data = postSnapshot.data() as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posted by ' + data['email'],
          style: AppTheme.lightTheme.textTheme.labelMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['palname'],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.0),
            Container(
                height: 300,
                width: double.infinity,
                child: Image.network(data['imageUrl'])),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Text(
                (data['timestamp'] as Timestamp).toDate().toLocal().toString().split(' ')[0],
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(width: 100.0),
              Text(
                '${data['availability']}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: data['availability'] == 'Available'
                    ? Colors.green
                    : Colors.orange,
                  ),
              ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Container(
                width: 120, // Set a fixed width for each column
                height: 80, // Set a fixed height for each column
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 226, 226),
                borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  'Breed',
                  style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                  data['breed'],
                  style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                ),
              ),
              Container(
                width: 120, // Set a fixed width for each column
                height: 80, // Set a fixed height for each column
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                color: Color.fromARGB(255, 226, 226, 226),
                borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  'Age',
                  style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                  data['age'].toString() + ' Years',
                  style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                ),
              ),
              Container(
                width: 120, // Set a fixed width for each column
                 height: 80,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                color: const Color.fromARGB(255, 226, 226, 226),
                borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                children: [
                  Text(
                  'Weight',
                  style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                  data['weight'].toString() + 'kg',
                  style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
                ),
              ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Container(
                width: 120,
                height: 60,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                color: AppColors.accentYellow,
                borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  '${data['gender']}',
                  style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
                ),
              ),
              Container(
                width: 120,
                height: 60,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                color: Colors.green[500],
                borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(textAlign: TextAlign.center,
                  data['vaccinated'] == 'yes' ? 'Vaccinated' : 'Not Vaccinated',
                  style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
                ),
              ),
              Container(
                width: 120,
                height: 60,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                color: AppColors.accentYellow,
                borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  data['trained'] == 'yes' ? 'Trained' : 'Not Trained',
                  style: Theme.of(context).textTheme.bodySmall
                  ),
                ],
                ),
              ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
              Expanded(
                child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColors.accentBlue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Icon(Icons.location_on, color: Colors.black12),
                  SizedBox(width: 4.0),
                  Text(
                    data['address'],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ],
                ),
                ),
              ),
              ],
            ),
            SizedBox(height: 16.0),
             Text(
              'About',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              data['description'],
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
