import 'package:flutter/material.dart';

class Obscene extends StatelessWidget {
  List<String> obsceneArray;
  Obscene({Key? key, required this.obsceneArray}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: obsceneArray.length > 0 || obsceneArray == null
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                  itemCount: obsceneArray.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 5,
                      ),
                      title: Text(
                        obsceneArray[index].toString(),
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
