import 'dart:html';

import 'package:flutter/material.dart';

class InsulTab extends StatelessWidget {
  List<String> insultArray;
  InsulTab({Key? key, required this.insultArray}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: insultArray.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                  itemCount: insultArray.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 5,
                      ),
                      title: Text(
                        insultArray[index].toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w300),
                      ),
                    );
                  })
              : const Center(
                  child: Text(
                    'No comments come under this category',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  ),
                ),
        ));
  }
}
