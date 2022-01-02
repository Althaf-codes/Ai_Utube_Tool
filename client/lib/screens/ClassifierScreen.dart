import 'package:client/Tabs/identity_attackTab.dart';
import 'package:client/Tabs/insultTab.dart';
import 'package:client/Tabs/obsceneTab.dart';
import 'package:client/Tabs/severeToxicityTab.dart';
import 'package:client/Tabs/sexualAttackTab.dart';
import 'package:client/Tabs/threatTab.dart';
import 'package:flutter/material.dart';

class Classifier extends StatelessWidget {
  List<String> insultArray;
  List<String> toxicityArray;
  List<String> threatArray;
  List<String> sexualExplicitArray;
  List<String> obsceneArray;
  List<String> severeToxicityArray;
  List<String> identityAttackArray;
  Classifier(
      {Key? key,
      required this.insultArray,
      required this.toxicityArray,
      required this.threatArray,
      required this.sexualExplicitArray,
      required this.obsceneArray,
      required this.severeToxicityArray,
      required this.identityAttackArray})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('insultarray');
    print(insultArray);
    print(toxicityArray);
    print(threatArray);
    print(sexualExplicitArray);
    print(obsceneArray);
    print(severeToxicityArray);
    print(identityAttackArray);
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
            bottom: const TabBar(tabs: [
          Tab(
            text: 'identity attack',
          ),
          Tab(
            text: 'insult',
          ),
          Tab(
            text: 'obscene',
          ),
          Tab(
            text: 'severe_toxicity',
          ),
          Tab(
            text: 'sexual_explicit',
          ),
          Tab(
            text: 'threat',
          ),
        ])),
        body: TabBarView(
          children: [
            IdentityAttackTab(
              identityAttackArray: identityAttackArray,
            ),
            InsulTab(
              insultArray: insultArray,
            ),
            Obscene(
              obsceneArray: obsceneArray,
            ),
            SevereToxicity(
              severeToxicityArray: severeToxicityArray,
            ),
            SexualAttackTab(
              sexualAttackArray: sexualExplicitArray,
            ),
            ThreatTab(
              threatArray: threatArray,
            )
          ],
        ),
      ),
    );
  }
}
