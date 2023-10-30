import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.updateDate,
    required this.url,
  });

  final String title;
  final String description;
  final String updateDate;
  final String url;
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    DateTime updatedDateTime = DateTime.parse(updateDate);
    String updatedDateString =
        DateFormat('MMM dd, HH:mm').format(updatedDateTime);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageUrl != ""
              ? SizedBox(
                  height: 200,
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 20, color: Colors.blueGrey),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              description,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 16, color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Updated: $updatedDateString',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 14, color: Colors.grey),
            ),
          )
        ],
      ),
      floatingActionButton: url != ""
          ? FloatingActionButton.extended(
              onPressed: () {
                EasyLoading.show(status: 'Loading', dismissOnTap: false)
                    .whenComplete(() async {
                  await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication)
                      .whenComplete(() {
                    EasyLoading.dismiss();
                  });
                });
              },
              backgroundColor: Colors.blueGrey,
              icon: const Icon(Icons.read_more),
              label: const Text('Read More'),
            )
          : Container(),
    );
  }
}
