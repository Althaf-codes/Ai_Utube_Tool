import 'package:flutter/material.dart';

class ThreatTab extends StatelessWidget {
  List<String> threatArray;
  ThreatTab({Key? key, required this.threatArray}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('threat array is');
    print(threatArray);
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: threatArray.length > 0 || threatArray.isNotEmpty
              ? ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.grey,
                        height: 0.5,
                      ),
                  itemCount: threatArray.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 5,
                      ),
                      title: Text(
                        '${threatArray[index]}',
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
