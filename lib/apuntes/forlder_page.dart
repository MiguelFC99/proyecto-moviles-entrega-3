import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica_dos/apuntes/add_apunte.dart';
import 'package:practica_dos/apuntes/bloc/apuntes_bloc.dart';
import 'package:practica_dos/apuntes/ind_image.dart';
import 'package:practica_dos/apuntes/item_apuntes.dart';
import 'package:practica_dos/utils/constants.dart';

class FolderPage extends StatefulWidget {
  FolderPage({Key key}) : super(key: key);

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  ApuntesBloc bloc;

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY_COLOR,
      appBar: AppBar(
        title: Text("My Folder"),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: UniqueKey(),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: AddApunte(),
              ),
            ),
          );
        },
        label: Text("Agregar"),
        icon: Icon(Icons.add_box),
      ),
      body: BlocProvider(
        create: (context) {
          bloc = ApuntesBloc()..add(GetDataEvent());
          return bloc;
        },
        child: BlocListener<ApuntesBloc, ApuntesState>(
          listener: (context, state) {
            if (state is CloudStoreRemoved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha eliminado el elemento."),
                  ),
                );
            } else if (state is CloudStoreError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("${state.errorMessage}"),
                  ),
                );
            } else if (state is CloudStoreSaved) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Se ha guardado el elemento."),
                  ),
                );
            } else if (state is CloudStoreGetData) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text("Descargando datos..."),
                  ),
                );
            }
          },
          child: BlocBuilder<ApuntesBloc, ApuntesState>(
            builder: (context, state) {
              if (state is ApuntesInitial) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: bloc.getApuntesList.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => IndImage(
                              materia: bloc.getApuntesList[index].materia ??
                                  "No name",
                              descripcion:
                                  bloc.getApuntesList[index].descripcion ??
                                      "No description",
                              imageUrl: bloc.getApuntesList[index].imageUrl),
                        ),
                      );
                    },
                    child: ItemApuntes(
                      key: UniqueKey(),
                      index: index,
                      imageUrl: bloc.getApuntesList[index].imageUrl,
                      materia: bloc.getApuntesList[index].materia ?? "No name",
                      descripcion: bloc.getApuntesList[index].descripcion ??
                          "No description",
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}