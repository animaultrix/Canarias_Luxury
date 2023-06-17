// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get entrar {
    return Intl.message(
      'Login',
      name: 'entrar',
      desc: '',
      args: [],
    );
  }

  /// `User code`
  String get codigoUsuario {
    return Intl.message(
      'User code',
      name: 'codigoUsuario',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nombreUsuario {
    return Intl.message(
      'Name',
      name: 'nombreUsuario',
      desc: '',
      args: [],
    );
  }

  /// `Passport number or DNI`
  String get numeropasaporte {
    return Intl.message(
      'Passport number or DNI',
      name: 'numeropasaporte',
      desc: '',
      args: [],
    );
  }

  /// `If you want to receive promotions, insert your email`
  String get textCorreoElec {
    return Intl.message(
      'If you want to receive promotions, insert your email',
      name: 'textCorreoElec',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get correoElec {
    return Intl.message(
      'Email',
      name: 'correoElec',
      desc: '',
      args: [],
    );
  }

  /// `Form`
  String get cuestionario {
    return Intl.message(
      'Form',
      name: 'cuestionario',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get guardar {
    return Intl.message(
      'Save',
      name: 'guardar',
      desc: '',
      args: [],
    );
  }

  /// `My stance`
  String get miStancia {
    return Intl.message(
      'My stance',
      name: 'miStancia',
      desc: '',
      args: [],
    );
  }

  /// `Store`
  String get tienda {
    return Intl.message(
      'Store',
      name: 'tienda',
      desc: '',
      args: [],
    );
  }

  /// `Leisure`
  String get ocio {
    return Intl.message(
      'Leisure',
      name: 'ocio',
      desc: '',
      args: [],
    );
  }

  /// `POI`
  String get puntoInteres {
    return Intl.message(
      'POI',
      name: 'puntoInteres',
      desc: '',
      args: [],
    );
  }

  /// `Points of interest`
  String get poi {
    return Intl.message(
      'Points of interest',
      name: 'poi',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get campoRequerido {
    return Intl.message(
      'This field is required',
      name: 'campoRequerido',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get numerotelefono {
    return Intl.message(
      'Phone number',
      name: 'numerotelefono',
      desc: '',
      args: [],
    );
  }

  /// `Shopping cart`
  String get carro {
    return Intl.message(
      'Shopping cart',
      name: 'carro',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get aniadir {
    return Intl.message(
      'Add',
      name: 'aniadir',
      desc: '',
      args: [],
    );
  }

  /// `Date and time`
  String get selecionfechahora {
    return Intl.message(
      'Date and time',
      name: 'selecionfechahora',
      desc: '',
      args: [],
    );
  }

  /// `Delivery hours are from 12:00 to 20:00`
  String get horarioreparto {
    return Intl.message(
      'Delivery hours are from 12:00 to 20:00',
      name: 'horarioreparto',
      desc: '',
      args: [],
    );
  }

  /// `Selected date and time: `
  String get fechahoraseleccionada {
    return Intl.message(
      'Selected date and time: ',
      name: 'fechahoraseleccionada',
      desc: '',
      args: [],
    );
  }

  /// `You must choose date and time`
  String get nofechahoraseleccionada {
    return Intl.message(
      'You must choose date and time',
      name: 'nofechahoraseleccionada',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get pagar {
    return Intl.message(
      'Pay',
      name: 'pagar',
      desc: '',
      args: [],
    );
  }

  /// `There are no products`
  String get nohayproductos {
    return Intl.message(
      'There are no products',
      name: 'nohayproductos',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been placed successfully`
  String get exitopedido {
    return Intl.message(
      'Your order has been placed successfully',
      name: 'exitopedido',
      desc: '',
      args: [],
    );
  }

  /// `try later`
  String get errorhttp {
    return Intl.message(
      'try later',
      name: 'errorhttp',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get pedido {
    return Intl.message(
      'Order',
      name: 'pedido',
      desc: '',
      args: [],
    );
  }

  /// `User menu`
  String get menuUsuario {
    return Intl.message(
      'User menu',
      name: 'menuUsuario',
      desc: '',
      args: [],
    );
  }

  /// `Edit data`
  String get editarDatos {
    return Intl.message(
      'Edit data',
      name: 'editarDatos',
      desc: '',
      args: [],
    );
  }

  /// `Data updated successfully`
  String get datosActualizados {
    return Intl.message(
      'Data updated successfully',
      name: 'datosActualizados',
      desc: '',
      args: [],
    );
  }

  /// `There are no orders`
  String get nohaypedidos {
    return Intl.message(
      'There are no orders',
      name: 'nohaypedidos',
      desc: '',
      args: [],
    );
  }

  /// `Pre entrance`
  String get preEntrada {
    return Intl.message(
      'Pre entrance',
      name: 'preEntrada',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message(
      'Total',
      name: 'total',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get estasSeguro {
    return Intl.message(
      'Are you sure?',
      name: 'estasSeguro',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelar {
    return Intl.message(
      'Cancel',
      name: 'cancelar',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get aceptar {
    return Intl.message(
      'Accept',
      name: 'aceptar',
      desc: '',
      args: [],
    );
  }

  /// `Number of people`
  String get numeroPersonas {
    return Intl.message(
      'Number of people',
      name: 'numeroPersonas',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get pedir {
    return Intl.message(
      'Order',
      name: 'pedir',
      desc: '',
      args: [],
    );
  }

  /// `Look at the description`
  String get mirarDescripccion {
    return Intl.message(
      'Look at the description',
      name: 'mirarDescripccion',
      desc: '',
      args: [],
    );
  }

  /// `Select date`
  String get selecionfecha {
    return Intl.message(
      'Select date',
      name: 'selecionfecha',
      desc: '',
      args: [],
    );
  }

  /// `Selected date: `
  String get fechaSeleccionada {
    return Intl.message(
      'Selected date: ',
      name: 'fechaSeleccionada',
      desc: '',
      args: [],
    );
  }

  /// `Transport included`
  String get tansporteIncluido {
    return Intl.message(
      'Transport included',
      name: 'tansporteIncluido',
      desc: '',
      args: [],
    );
  }

  /// `Confirm order`
  String get confirmarPedido {
    return Intl.message(
      'Confirm order',
      name: 'confirmarPedido',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to make the payment?`
  String get estaSeguroRealizarPago {
    return Intl.message(
      'Are you sure you want to make the payment?',
      name: 'estaSeguroRealizarPago',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
