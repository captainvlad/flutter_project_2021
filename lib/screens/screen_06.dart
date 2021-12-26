import 'package:flutter/material.dart';
import 'package:sequel/general_models/achievement.dart';
import 'package:sequel/managers/achievements_manager.dart';
import 'package:sequel/res/values/colors.dart';
import 'package:sequel/res/values/strings.dart';
import 'package:sequel/managers/ui_manager.dart';

class Screen06 extends StatelessWidget {
  const Screen06({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UiManager uiManager = UiManager(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: uiManager.blockSizeVertical * 2,
                width: double.infinity,
              ),
              UiManager.getText(
                text: title,
                size: uiManager.blockSizeVertical * 6,
                strokeWidth: uiManager.blockSizeVertical * 1,
                fillColor: yellowColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              UiManager.getText(
                text: gordon_gekko,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                fillColor: whiteColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/image_12.png'),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 6,
                  ),
                  Column(
                    children: <Widget>[
                      UiManager.getText(
                        text: gekko_brief,
                        size: uiManager.blockSizeVertical * 2,
                        strokeWidth: uiManager.blockSizeVertical * 0,
                        strokeColor: whiteColor,
                        fillColor: whiteColor,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 6,
                      ),
                      UiManager.getButton(
                        label: UiManager.getText(
                          text: more_label,
                          size: uiManager.blockSizeVertical * 2,
                          strokeWidth: uiManager.blockSizeVertical * 1,
                          strokeColor: blueColor,
                          fillColor: whiteColor,
                        ),
                        width: uiManager.blockSizeHorizontal * 40,
                        height: uiManager.blockSizeVertical * 4,
                        color: yellowColor,
                        cornerRaidus: 10,
                        onTap: () async {
                          Achievement achievement = await AchievementsManager()
                              .getAchievementByName(gordon_gekko);

                          Navigator.pushNamed(
                            context,
                            '/screen_07',
                            arguments: achievement,
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
              // Second achievement
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              UiManager.getText(
                text: rocky_balboa,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                fillColor: whiteColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      UiManager.getText(
                        text: balboa_brief,
                        size: uiManager.blockSizeVertical * 2,
                        strokeWidth: uiManager.blockSizeVertical * 0,
                        strokeColor: whiteColor,
                        fillColor: whiteColor,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 6,
                      ),
                      UiManager.getButton(
                        label: UiManager.getText(
                          text: more_label,
                          size: uiManager.blockSizeVertical * 2,
                          strokeWidth: uiManager.blockSizeVertical * 1,
                          strokeColor: blueColor,
                          fillColor: whiteColor,
                        ),
                        width: uiManager.blockSizeHorizontal * 40,
                        height: uiManager.blockSizeVertical * 4,
                        color: yellowColor,
                        cornerRaidus: 10,
                        onTap: () async {
                          Achievement achievement = await AchievementsManager()
                              .getAchievementByName(rocky_balboa);

                          Navigator.pushNamed(
                            context,
                            '/screen_07',
                            arguments: achievement,
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 6,
                  ),
                  Image.asset('assets/images/image_28.png'),
                ],
              ),
              // Third achievement
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              UiManager.getText(
                text: flash,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                fillColor: whiteColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/image_15.png'),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 6,
                  ),
                  Column(
                    children: <Widget>[
                      UiManager.getText(
                        text: flash_brief,
                        size: uiManager.blockSizeVertical * 2,
                        strokeWidth: uiManager.blockSizeVertical * 0,
                        strokeColor: whiteColor,
                        fillColor: whiteColor,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 6,
                      ),
                      UiManager.getButton(
                        label: UiManager.getText(
                          text: more_label,
                          size: uiManager.blockSizeVertical * 2,
                          strokeWidth: uiManager.blockSizeVertical * 1,
                          strokeColor: blueColor,
                          fillColor: whiteColor,
                        ),
                        width: uiManager.blockSizeHorizontal * 40,
                        height: uiManager.blockSizeVertical * 4,
                        color: yellowColor,
                        cornerRaidus: 10,
                        onTap: () async {
                          Achievement achievement = await AchievementsManager()
                              .getAchievementByName(flash);

                          Navigator.pushNamed(
                            context,
                            '/screen_07',
                            arguments: achievement,
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
              // Fourth achievement
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              UiManager.getText(
                text: alan_turing,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                fillColor: whiteColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      UiManager.getText(
                        text: turing_brief,
                        size: uiManager.blockSizeVertical * 2,
                        strokeWidth: uiManager.blockSizeVertical * 0,
                        strokeColor: whiteColor,
                        fillColor: whiteColor,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 6,
                      ),
                      UiManager.getButton(
                        label: UiManager.getText(
                          text: more_label,
                          size: uiManager.blockSizeVertical * 2,
                          strokeWidth: uiManager.blockSizeVertical * 1,
                          strokeColor: blueColor,
                          fillColor: whiteColor,
                        ),
                        width: uiManager.blockSizeHorizontal * 40,
                        height: uiManager.blockSizeVertical * 4,
                        color: yellowColor,
                        cornerRaidus: 10,
                        onTap: () async {
                          Achievement achievement = await AchievementsManager()
                              .getAchievementByName(alan_turing);

                          Navigator.pushNamed(
                            context,
                            '/screen_07',
                            arguments: achievement,
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 6,
                  ),
                  Image.asset('assets/images/image_16.png'),
                ],
              ),
              // Fifth achievement
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              UiManager.getText(
                text: the_dude,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                fillColor: whiteColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/images/image_17.png'),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 6,
                  ),
                  Column(
                    children: <Widget>[
                      UiManager.getText(
                        text: dude_brief,
                        size: uiManager.blockSizeVertical * 2,
                        strokeWidth: uiManager.blockSizeVertical * 0,
                        strokeColor: whiteColor,
                        fillColor: whiteColor,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 6,
                      ),
                      UiManager.getButton(
                        label: UiManager.getText(
                          text: more_label,
                          size: uiManager.blockSizeVertical * 2,
                          strokeWidth: uiManager.blockSizeVertical * 1,
                          strokeColor: blueColor,
                          fillColor: whiteColor,
                        ),
                        width: uiManager.blockSizeHorizontal * 40,
                        height: uiManager.blockSizeVertical * 4,
                        color: yellowColor,
                        cornerRaidus: 10,
                        onTap: () async {
                          Achievement achievement = await AchievementsManager()
                              .getAchievementByName(the_dude);

                          Navigator.pushNamed(
                            context,
                            '/screen_07',
                            arguments: achievement,
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
              // Sixth achievement
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              UiManager.getText(
                text: ace_nicky,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                fillColor: whiteColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      UiManager.getText(
                        text: ace_brief,
                        size: uiManager.blockSizeVertical * 2,
                        strokeWidth: uiManager.blockSizeVertical * 0,
                        strokeColor: whiteColor,
                        fillColor: whiteColor,
                      ),
                      SizedBox(
                        height: uiManager.blockSizeVertical * 9,
                      ),
                      UiManager.getButton(
                        label: UiManager.getText(
                          text: more_label,
                          size: uiManager.blockSizeVertical * 2,
                          strokeWidth: uiManager.blockSizeVertical * 1,
                          strokeColor: blueColor,
                          fillColor: whiteColor,
                        ),
                        width: uiManager.blockSizeHorizontal * 40,
                        height: uiManager.blockSizeVertical * 4,
                        color: yellowColor,
                        cornerRaidus: 10,
                        onTap: () async {
                          Achievement achievement = await AchievementsManager()
                              .getAchievementByName(ace_nicky);

                          Navigator.pushNamed(
                            context,
                            '/screen_07',
                            arguments: achievement,
                          );
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 6,
                  ),
                  Image.asset('assets/images/image_19.png'),
                ],
              ),
              // Seventh achievement
              SizedBox(
                height: uiManager.blockSizeVertical * 4,
              ),
              UiManager.getText(
                text: badcomedian,
                size: uiManager.blockSizeVertical * 3,
                strokeWidth: uiManager.blockSizeVertical * 0,
                fillColor: whiteColor,
                strokeColor: whiteColor,
              ),
              SizedBox(
                height: uiManager.blockSizeVertical * 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiManager.getText(
                    text: badcomedian_brief,
                    size: uiManager.blockSizeVertical * 2,
                    strokeWidth: uiManager.blockSizeVertical * 0,
                    strokeColor: whiteColor,
                    fillColor: whiteColor,
                  ),
                  SizedBox(
                    width: uiManager.blockSizeHorizontal * 4,
                  ),
                  UiManager.getButton(
                    label: UiManager.getText(
                      text: more_label,
                      size: uiManager.blockSizeVertical * 2,
                      strokeWidth: uiManager.blockSizeVertical * 1,
                      strokeColor: blueColor,
                      fillColor: whiteColor,
                    ),
                    width: uiManager.blockSizeHorizontal * 25,
                    height: uiManager.blockSizeVertical * 4,
                    color: yellowColor,
                    cornerRaidus: 10,
                    onTap: () async {
                      Achievement achievement = await AchievementsManager()
                          .getAchievementByName(badcomedian);

                      Navigator.pushNamed(
                        context,
                        '/screen_07',
                        arguments: achievement,
                      );
                    },
                  )
                ],
              ),
              Image.asset('assets/images/image_18.png'),
            ],
          ),
        ),
      ),
    );
  }
}
