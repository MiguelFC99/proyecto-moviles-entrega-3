import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica_dos/acerca/bloc/acerca_bloc.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  AcercaBloc acerBloc;

  @override
  void dispose() {
    acerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          acerBloc = AcercaBloc();
          return acerBloc;
        },
        child:
            BlocListener<AcercaBloc, AcercaState>(listener: (context, state) {
        }, child: BlocBuilder<AcercaBloc, AcercaState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Contacto"),
              ),
              body: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text("Practica 2",
                          style: TextStyle(
                              fontSize: 75)),
                      SizedBox(height: 100),
                      Text("Acerca del desarrollador: ",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black)),
                      Text(
                          "  En este proyectyo se ve lo de bloc y firebase contacte al desarrollador para sugerencias",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black)),
                      SizedBox(height: 100),
                      Text("Contactar",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black)),
                      SizedBox(height: 10),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: MaterialButton(
                                    color: Colors.blueGrey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.envelope,
                                          color: Colors.white,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "Contacto",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      acerBloc.add(EviarEvent());
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        )));
  }
}
