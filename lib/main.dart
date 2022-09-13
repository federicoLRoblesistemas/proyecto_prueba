import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_prueba/src/bloc/blocPrueba/bloc_prueba_bloc.dart';
import 'package:proyecto_prueba/src/bloc/notificaciones/notificaciones_bloc.dart';
import 'package:proyecto_prueba/src/page/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(      
      providers: [     
        BlocProvider(create: (BuildContext context) => BlocPruebaBloc(),),
        BlocProvider(create: (BuildContext context) => NotificacionesBloc(),),
      ],
      child:  const MaterialApp(
        // theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomePage(),
      ),
    );
  }
}