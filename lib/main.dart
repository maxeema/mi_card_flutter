import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mi_card/utils.dart';

import 'extensions.dart';
import 'resources.dart' as r;

void main() => runApp(
  MaterialApp(
    home: MyApp(),
    themeMode: ThemeMode.dark,
    darkTheme: ThemeData.dark(),
    debugShowCheckedModeBanner: false,
  ),
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) =>
    Scaffold(
      body: SafeArea(
        child: context.isLandscape ? buildLandscape(context) : buildPortrait(context))
    );

  Widget buildLandscape(BuildContext context) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildAvatar(50),
            SizedBox(height: 10,),
            Text(
              r.string.author,
              textScaleFactor: 1.3,
              style: GoogleFonts.juliusSansOne(),
            )
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 1,
              child: Text(
                r.char.love.repeat(5, separator: r.char.space),
                textScaleFactor: .75,
              )
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RichText(
              text: TextSpan(
                  style: TextStyle(
                    letterSpacing: 2
                  ),
                  children: spanzize(
                    r.conf.phone, r.conf.phone_code,
                    (nonMatched) => TextSpan(text: nonMatched),
                    (matched) => TextSpan(
                      text: matched,
                      style: TextStyle(color: Colors.lightBlueAccent),
//                        recognizer: TapGestureRecognizer()..onTap = () => call(r.conf.phone)
                    )
                  )
              ),
            ),
            SizedBox(height: 10,),
            RichText(
              textScaleFactor: 1.1,
              text: TextSpan(
                style: TextStyle(
                  letterSpacing: 1.5
                ),
                children: <TextSpan>[
                  ... spanzize(
                    r.conf.email, r.conf.email_nick,
                    (nonMatched) => TextSpan(text: nonMatched),
                    (matched) => TextSpan(
                      text: matched,
                      style: TextStyle(color: Theme.of(context).accentColor),
//                        recognizer: TapGestureRecognizer()..onTap = () => email(r.string.email)
                    )
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            RichText(
              textScaleFactor: 1.5,
              text: TextSpan(
                style: GoogleFonts.caveat(),
                children: [
                  TextSpan(text: r.string.flutter,
                    style: TextStyle(color: Colors.lightBlueAccent)
                  ),
                  TextSpan(text: r.char.space),
                  TextSpan(text: r.string.developer),
                ],
              ),
            ),
          ],
        ),
      ],
    );

  Widget buildPortrait(BuildContext context) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildAvatar(60),
            SizedBox.fromSize(size: Size.fromHeight(20)),
            Text(
              r.string.author,
              textScaleFactor: 1.5,
              style: GoogleFonts.juliusSansOne(),
            ),
            SizedBox.fromSize(size: Size.fromHeight(15)),
            Text(
              r.char.love.repeat(5),
              textScaleFactor: .85,
              style: TextStyle(
                letterSpacing: 7,
              ),
            ),
          ]
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              textScaleFactor: 1.2,
              text: TextSpan(
                style: TextStyle(
                  letterSpacing: 2
                ),
                children: spanzize(
                  r.conf.phone, "925",
                  (nonMatched) => TextSpan(text: nonMatched),
                  (matched) => TextSpan(
                    text: matched,
                    style: TextStyle(color: Colors.lightBlueAccent),
//                          recognizer: TapGestureRecognizer()..onTap = () => call(r.conf.phone)
                  )
                )
              ),
            ),
            Divider(height: 20,),
            RichText(
              textScaleFactor: 1.1,
              text: TextSpan(
                style: TextStyle(
                  letterSpacing: 1.5
                ),
                children: <TextSpan>[
                  ... spanzize(
                    r.conf.email, "america",
                    (nonMatched) => TextSpan(text: nonMatched),
                    (matched) => TextSpan(
                      text: matched,
                      style: TextStyle(color: Theme.of(context).accentColor),
//                        recognizer: TapGestureRecognizer()..onTap = () => email(r.conf.email)
                    )
                  )
                ],
              ),
            ),
            Divider(height: 20,),
            RichText(
              textScaleFactor: 1.7,
              text: TextSpan(
                style: GoogleFonts.caveat(),
                children: <TextSpan>[
                  TextSpan(text: r.string.flutter,
                    style: TextStyle(color: Colors.lightBlueAccent)
                  ),
                  TextSpan(text: r.char.space),
                  TextSpan(text: r.string.developer),
                ],
              ),
            ),
          ],
        )
      ]
    );

  Widget buildAvatar(double size) => MyFlutterAvatar(size: size);

}

class MyFlutterAvatar extends HookWidget {

  final double size, min, max;
  MyFlutterAvatar({Key key, @required this.size, this.min = .85, this.max = 1.3})
      : assert(size != null),
        super(key: key);

  @override
  Widget build(BuildContext context) =>
    CircleAvatar(
      radius: size,
      backgroundColor: Colors.white,
      child: ScaleTransition(
        scale: useAnimationController(
          initialValue: min, lowerBound: min, upperBound: max
        )..repeat(min: min, max: max, reverse: true, period: Duration(seconds: 5)),
        child: Image.asset(r.icon.bird.fromAssets()),
      ),
    );

}
