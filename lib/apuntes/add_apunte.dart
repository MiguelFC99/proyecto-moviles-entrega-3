import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/apuntes_bloc.dart';

class AddApunte extends StatefulWidget {
  AddApunte({Key key}) : super(key: key);

  @override
  _AddApunteState createState() => _AddApunteState();
}

class _AddApunteState extends State<AddApunte> {
  ApuntesBloc addApuntBloc;

  @override
  void dispose() {
    addApuntBloc.close();
    super.dispose();
  }

  File _choosenImage;
  bool _isLoading = false;
  TextEditingController _materiaController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    addApuntBloc = BlocProvider.of(context);
    /* TODO se esperaba entrar al segundo if para poder actualizar la UI 
    pero no logre hacer que entrara 
    BlocBuilder<ApuntesBloc, ApuntesState>(
        builder: (context, state) {
          if (state is ImageGallery) {
            _choosenImage = state.image;
          }
          if (state is CargaApunte) {
            _isLoading = state.carga;
          }*/

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xFFC6D8E1),
          title: Text("Seleccionar imagen")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Stack(
            alignment: FractionalOffset.center,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _choosenImage != null
                      ? Image.file(
                          _choosenImage,
                          width: 150,
                          height: 150,
                        )
                      : Container(
                          height: 150,
                          width: 150,
                          child: Placeholder(
                            fallbackHeight: 150,
                            fallbackWidth: 150,
                          ),
                        ),
                  SizedBox(height: 48),
                  IconButton(
                    icon: Icon(Icons.image),
                    onPressed: () {
                      BlocProvider.of<ApuntesBloc>(context).add(ChooseImage());
                    },
                  ),
                  SizedBox(height: 48),
                  /*TextField(
                    controller: _materiaController,
                    decoration: InputDecoration(
                      hintText: "Nombre de la materia",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: _descripcionController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: "Notas para el examen...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),*/
                  SizedBox(height: 24),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text("Guardar"),
                          onPressed: () {
                            // TODO aqui esta el llamado de guardado al bloc
                            //  BlocProvider.of<ApuntesBloc>(context).add(GuardarPress());

                            addApuntBloc.add(SaveDataEvent(
                              materia: _materiaController.text,
                              descripcion: _descripcionController.text,
                            ));
                            Future.delayed(Duration(milliseconds: 1500))
                                .then((_) {
                              Navigator.of(context).pop();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              _isLoading ? CircularProgressIndicator() : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
