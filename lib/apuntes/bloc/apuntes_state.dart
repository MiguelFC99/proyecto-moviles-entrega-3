part of 'apuntes_bloc.dart';

abstract class ApuntesState extends Equatable {
  const ApuntesState();
}

class ApuntesInitial extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreError extends ApuntesState {
  final String errorMessage;

  CloudStoreError({@required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

class CloudStoreRemoved extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreSaved extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CloudStoreGetData extends ApuntesState {
  @override
  List<Object> get props => [];
}

class CargaApunte extends ApuntesState{
  final bool carga;

  CargaApunte({@required this.carga});

  List<Object> get props => [carga];
}
class ImageGallery extends ApuntesState{
  final File image;

  ImageGallery({@required this.image});

  List<Object> get props => [image];
}

class ImageGalleryM extends ApuntesState {
  final String errorMessageGallery;

  ImageGalleryM({@required this.errorMessageGallery});
  @override
  List<Object> get props => [errorMessageGallery];
}

class DatoCargado extends ApuntesState {
  final bool otro;
  final String url;

  DatoCargado( {@required this.url,this.otro,});
   @override
  List<Object> get props => [url, otro];
}

class CargandoDatos extends ApuntesState {
  final bool isLoading;

  CargandoDatos({@required this.isLoading});
   @override
  List<Object> get props => [isLoading];
}