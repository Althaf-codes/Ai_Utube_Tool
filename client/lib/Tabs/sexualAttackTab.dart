import 'package:flutter/material.dart';

class SexualAttackTab extends StatelessWidget {
  List<String> sexualAttackArray;
  SexualAttackTab({Key? key, required this.sexualAttackArray})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: sexualAttackArray.length > 0 || sexualAttackArray == null
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                  itemCount: sexualAttackArray.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 5,
                      ),
                      title: Text(
                        sexualAttackArray[index].toString(),
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
