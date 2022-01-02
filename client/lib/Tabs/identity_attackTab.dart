import 'dart:ui';

import 'package:flutter/material.dart';

class IdentityAttackTab extends StatelessWidget {
  List<String> identityAttackArray;

  IdentityAttackTab({Key? key, required this.identityAttackArray})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: identityAttackArray.length > 0 || identityAttackArray == null
            ? ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                      height: 0.5,
                    ),
                itemCount: identityAttackArray.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 5,
                    ),
                    title: Text(
                      identityAttackArray[index],
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
      ),
    );
  }
}
