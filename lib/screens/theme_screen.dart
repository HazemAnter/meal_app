import 'package:flutter/material.dart';


import 'package:mealapp/providers/theme_provider.dart';
import 'package:mealapp/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatelessWidget {
  static const routeName = '/Theme/Screen';

  Widget buildRadioListTile(
    ThemeMode themeVal,
    String txt,
    IconData icon,
    BuildContext ctx,
  ) {
    return RadioListTile(
      title: Text(txt),
      secondary: Icon(
        icon,
        color: Theme.of(ctx).buttonColor,
      ),
      value: themeVal,
      groupValue: Provider.of<ThemeProvider>(ctx).tm,
      onChanged: (newThemeVal) => Provider.of<ThemeProvider>(ctx, listen: false)
          .themeModeChanged(newThemeVal),
    );
  }

  /*Widget buildListTile(BuildContext context, String txt) {
    var primaryColor = Provider.of<ThemeProvider>(context).primaryColor;
    var accentColor = Provider.of<ThemeProvider>(context).accentColor;
    return ListTile(
      trailing: CircleAvatar(
        backgroundColor: txt == "primary" ? primaryColor : accentColor,
      ),
      title: Text(
        txt,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext ctx) {
              return AlertDialog(
                elevation: 4,
                titlePadding: const EdgeInsets.all(0),
                contentPadding: const EdgeInsets.all(0),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: txt == "primary" ? primaryColor : accentColor,
                    onColorChanged: (newColor) =>
                        Provider.of<ThemeProvider>(ctx, listen: false)
                            .onChanged(newColor, txt == "primary" ? 1 : 2),
                    colorPickerWidth: 300,
                    pickerAreaHeightPercent: 0.7,
                    enableAlpha: false,
                    displayThumbColor: true,
                    showLabel: false,
                  ),
                ),
              );
            });
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Themes'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[

          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(26),
                  child: Text("Choose your Theme Mode",
                      style: Theme.of(context).textTheme.headline6),
                ),
                buildRadioListTile(ThemeMode.system, "System Default Theme",
                    Icons.settings, context),
                buildRadioListTile(ThemeMode.light, "Light Theme",
                    Icons.wb_sunny_outlined, context),
                buildRadioListTile(ThemeMode.dark, "Dark Theme",
                    Icons.nights_stay_outlined, context),
                /*buildListTile(context, "primary"),
                buildListTile(context, "accent"),*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}
