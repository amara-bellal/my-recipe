



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/styles/themes.dart';

class SettingsDrawer extends StatefulWidget{

  const SettingsDrawer({super.key});


  @override
  State<SettingsDrawer> createState() => _SettingsDrawer() ;

}


class _SettingsDrawer extends State<SettingsDrawer>{


  @override
  Widget build(BuildContext context) {

    final isDarhmode = context.watch<ThemeProvider>().isDarkmode;
    
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .center,
          children: [
            Container(
              padding: .only(top: 60 , bottom: 120),
              decoration: BoxDecoration(),
              child: Text("الإعدادات" ,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary ,
                  fontWeight: .bold,
                  fontSize: 30 ,
                ),
              ),
              ),
        
              Row(
                textDirection: .rtl,
                mainAxisAlignment: .spaceBetween,
                children: [
                  
                    Text("الوضع الداكن" , style: TextStyle(
                        color: Theme.of(context).colorScheme.primary ,
                        fontSize: 18 ,
                        
                      ),
                    ),
                    
                  
                

                  Switch(
                    inactiveThumbColor: Theme.of(context).primaryColor,
                    thumbColor: .all(Theme.of(context).primaryColor),
                    activeTrackColor: Theme.of(context).colorScheme.surface,
                    inactiveTrackColor: Theme.of(context).colorScheme.onSecondary,
                    trackOutlineColor: .all(Colors.black.withAlpha(0)),
                    value: isDarhmode, 
                    onChanged: (value){
                      context.read<ThemeProvider>().toggleTheme();
                    })

                ],
              ),
          ],
        ),
      ),
    );
    
  }
  

}