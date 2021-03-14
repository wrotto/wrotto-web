import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wrotto_web/constants/strings.dart';
import 'package:wrotto_web/utils/utilities.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Card(
            child: GestureDetector(
              onTap: () {
                openFeaturesForm();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.app_registration),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Request Features")
                ]),
              ),
            ),
          ),
          Card(
            child: GestureDetector(
              onTap: () {
                openRateApp();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Icon(Icons.rate_review),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Rate App")
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  openFeaturesForm() {
    Utilities.launchInWebViewOrVC(FEATUREFORMURL);
  }

  openRateApp() {
    Utilities.launchInWebViewOrVC(RATEAPPURL);
  }
}
