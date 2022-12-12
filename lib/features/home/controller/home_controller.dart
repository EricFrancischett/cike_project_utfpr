import 'dart:math';

import 'package:cike_project_utfpr/features/home/model/input_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';
part 'home_controller.g.dart';

// ignore: library_private_types_in_public_api
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  // @action
  // Future<void> mapUpload() async {
  //   for (int i = 0; i < listToBeUpaloded.length; i++) {
  //     var rng = Random();
  //     var randomNumberToId = rng.nextInt(1000000000).toString();
  //     final collectionReference =
  //         FirebaseFirestore.instance.collection('inputs');
  //     await collectionReference.doc(randomNumberToId).set(listToBeUpaloded[i]);
  //     await collectionReference.doc(randomNumberToId).update(
  //       {
  //         "id": randomNumberToId,
  //         "timeAdded": Timestamp.now(),
  //       },
  //     );
  //   }
  // }

  // @observable
  // List<Map<String, dynamic>> listToBeUpaloded = [
  //   {
  //     "category": "alert",
  //     "address": "AV, ANITA GARIBALDI",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: NÃO EXISTE / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3565293,
  //     "lgn": -49.2635277
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, CÂNDIDO HARTMANN",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4232032,
  //     "lgn": -49.3081223
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, DAS INDÚSTRIAS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5121087,
  //     "lgn": -49.3099967
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, DOUTOR DARIO LOPES DOS SANTOS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.436918,
  //     "lgn": -49.2543835
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, FREDOLIN WOLF",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3873039,
  //     "lgn": -49.3047014
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, JOÃO GUALBERTO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4245828,
  //     "lgn": -49.269245
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, MAL, FLORIANO PEIXOTO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5001327,
  //     "lgn": -49.2383609
  //   },
  //   {
  //     "category": "alert",
  //     "address": "AV, PREFEITO MAURÍCIO FRUET",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4439504,
  //     "lgn": -49.2083989
  //   },
  //   {
  //     "category": "alert",
  //     "address": "AV, PRESIDENTE AFFONSO CAMARGO",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4358339,
  //     "lgn": -49.2606504
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, PRESIDENTE ARTHUR DA SILVA BERNARDES",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4679335,
  //     "lgn": -49.2979228
  //   },
  //   {
  //     "category": "alert",
  //     "address": "AV, PRESIDENTE GETÚLIO VARGAS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4432407,
  //     "lgn": -49.267434
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, SETE DE SETEMBRO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4520047,
  //     "lgn": -49.3042879
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, SILVA JARDIM",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4403733,
  //     "lgn": -49.2692972
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "AV, VICTOR FERREIRA DO AMARAL",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4273175,
  //     "lgn": -49.2393384
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "PARQUE BARIGUI",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4276256,
  //     "lgn": -49.3098438
  //   },
  //   {
  //     "category": "alert",
  //     "address": "PARQUE SÃO LOURENÃO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.384704,
  //     "lgn": -49.2664781
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "PARQUE TINGUI",
  //     "description":
  //         "Pavimento: REGULAR / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.400601,
  //     "lgn": -49.3044833
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "PC, DAS NAÇÕES",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4279584,
  //     "lgn": -49.2424267
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "PRAÇA DO JAPÃO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4456377,
  //     "lgn": -49.2871004
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, ALFERES POLI",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4412379,
  //     "lgn": -49.271266
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, ALUIZIO FINZETTO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4674124,
  //     "lgn": -49.2536865
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, ANTONIO ESCORSIN",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.414766,
  //     "lgn": -49.3401428
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, BARAO DE ANTONINA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4221298,
  //     "lgn": -49.2723962
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, CECÍLIA MEIRELES",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3997283,
  //     "lgn": -49.2699025
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, CONSELHEIRO LAURINDO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.427822,
  //     "lgn": -49.2659451
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, CYRO VELLOZO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4525629,
  //     "lgn": -49.2576962
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, DESEMBARGADOR CID CAMPELO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5171198,
  //     "lgn": -49.3255385
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, DOMINGOS ANTONIO MORO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3832141,
  //     "lgn": -49.2872135
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, DOS PIONEIROS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5323033,
  //     "lgn": -49.2605145
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, DOUTOR ALEXANDRE GUTIERREZ",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.445608,
  //     "lgn": -49.2865238
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, EDUARDO SPRADA",
  //     "description":
  //         "Pavimento: REGULAR / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4516063,
  //     "lgn": -49.3628294
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, ENGENHEIRO OSTOJA ROGUSKI",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.438954,
  //     "lgn": -49.2380752
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, ENGENHEIROS REBOUÇAS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4463858,
  //     "lgn": -49.2712672
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, EUCLIDES BANDEIRA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4150228,
  //     "lgn": -49.2705364
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, FLÁVIO DALLEGRAVE",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3842776,
  //     "lgn": -49.2615423
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, FRANCISCO FRISCHMANN",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4717871,
  //     "lgn": -49.2952131
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, GENERAL MARIO TOURINHO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4517452,
  //     "lgn": -49.304772
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, HEITOR STOCKLER DE FRANÇA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4209088,
  //     "lgn": -49.2682918
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, JOÃO BETTEGA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.475351,
  //     "lgn": -49.3023966
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, JOÃO GAVA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3856202,
  //     "lgn": -49.2760141
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, JOÃO GUARIZA",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3913246,
  //     "lgn": -49.2640115
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, JOÃO NEGRÃO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4393944,
  //     "lgn": -49.2621247
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, JOÃO RODRIGUES PINHEIRO",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5117575,
  //     "lgn": -49.2944757
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, LUIZ LEÃO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4257049,
  //     "lgn": -49.2658175
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, MANOEL VALDOMIRO DE MACEDO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5171587,
  //     "lgn": -49.3257629
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, MARIANO TORRES",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4308199,
  //     "lgn": -49.2623458
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, MATEUS LEME",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3846554,
  //     "lgn": -49.2678426
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, NAPOLEÃO LAUREANO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4998628,
  //     "lgn": -49.2343149
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, NILO PEÇANHA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.3855786,
  //     "lgn": -49.2795063
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, OMAR RAYMUNDO PICHETH",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5136079,
  //     "lgn": -49.2719825
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, PEDRO DE TOLEDO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4584312,
  //     "lgn": -49.2526111
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, PEDRO GUSSO",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4984641,
  //     "lgn": -49.3090946
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, PRESIDENTE CARLOS CAVALCANTI",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4267769,
  //     "lgn": -49.2671092
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, PRESIDENTE FARIA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4252903,
  //     "lgn": -49.2688098
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, PROFESSORA EMMA CARVALHO DOS SANTOS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5156275,
  //     "lgn": -49.2701639
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, PROFESSORA REGINA CASAGRANDE MARINONI",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4555502,
  //     "lgn": -49.2552726
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, RAPHAEL PAPA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4277235,
  //     "lgn": -49.2410766
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, REINALDINO SCHAFFENBERG DE QUADROS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4298474,
  //     "lgn": -49.2518139
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, RODOLFO REKSIDLER",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.382802,
  //     "lgn": -49.2635369
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, SÃO SALVADOR",
  //     "description":
  //         "Pavimento: BOM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.385411,
  //     "lgn": -49.2807496
  //   },
  //   {
  //     "category": "recomendation",
  //     "address": "R, WALDEMAR LOUREIRO CAMPOS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: EM BOM ESTADO / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5030639,
  //     "lgn": -49.2367563
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, WILSON DACHEUX PEREIRA",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.5290891,
  //     "lgn": -49.246163
  //   },
  //   {
  //     "category": "alert",
  //     "address": "R, ZEILA MOURA DOS SANTOS",
  //     "description":
  //         "Pavimento: BOM / Sinalização: NÃO EXISTE / Iluminação: SUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.4332588,
  //     "lgn": -49.2513226
  //   },
  //   {
  //     "category": "alert",
  //     "address": "RIO NORTE BELEM",
  //     "description":
  //         "Pavimento: RUIM / Sinalização: PARCIALMENTE DEPREDADA / Iluminação: INSUFICIENTE",
  //     "type": "Ciclovia",
  //     "lat": -25.391374,
  //     "lgn": -49.266932
  //   }
  // ];

  @action
  void filterInputShowed() {
    if (pageViewIndex == 0) {
      if (filterApplied.contains('Todas')) {
        inputShowedList = inputRecomendationList;
      } else {
        inputShowedList = <InputModel>[].asObservable();
        for (var filter in filterApplied) {
          for (var input in inputRecomendationList) {
            if (!inputShowedList.contains(input) && input.type == filter) {
              inputShowedList.add(input);
            }
          }
        }
      }
      inputShowedList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
          .compareTo(b.timeAdded.millisecondsSinceEpoch));
      inputShowedList = inputShowedList.reversed.toList().asObservable();
    } else if (pageViewIndex == 1) {
      if (filterApplied.contains('Todas')) {
        inputShowedList = inputAlertList;
      } else {
        inputShowedList = <InputModel>[].asObservable();
        for (var filter in filterApplied) {
          for (var input in inputAlertList) {
            if (!inputShowedList.contains(input) && input.type == filter) {
              inputShowedList.add(input);
            }
          }
        }
      }
      inputShowedList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
          .compareTo(b.timeAdded.millisecondsSinceEpoch));
      inputShowedList = inputShowedList.reversed.toList().asObservable();
    }
  }

  @observable
  String addressFromStreetGiven = '';

  @observable
  String newInputDescription = '';

  @observable
  bool isLoading = false;

  @observable
  ObservableList<InputModel> inputRecomendationList =
      <InputModel>[].asObservable();

  @observable
  ObservableList<InputModel> inputAlertList = <InputModel>[].asObservable();

  @observable
  ObservableList<InputModel> inputShowedList = <InputModel>[].asObservable();

  @observable
  String modalDropdownSelectedValue = 'Ciclovia';

  @observable
  ObservableList<String> dropdownItensList = <String>[
    'Ciclovia',
    'Local',
    'Estacionamento',
  ].asObservable();

  @observable
  ObservableList<String> filterApplied = <String>[
    'Todas',
  ].asObservable();

  @observable
  ObservableList<String> filterList = <String>[
    'Todas',
    'Ciclovia',
    'Local',
    'Estacionamento',
  ].asObservable();

  @observable
  int mapPageViewIndex = 0;

  @observable
  int pageViewIndex = 0;

  @observable
  int bottomNavigationBarIndex = 0;

  @action
  void changeBottomNavigationBarIndex(int newIndex) {
    bottomNavigationBarIndex = newIndex;
  }

  @action
  void changePageViewIndex() {
    if (pageViewIndex == 0) {
      pageViewIndex = 1;
    } else if (pageViewIndex == 1) {
      pageViewIndex = 0;
    }
  }

  @observable
  ObservableList<Placemark> placemarks = <Placemark>[].asObservable();

  @observable
  String? currentStreet = '';

  @observable
  String? currentSubLocality = '';

  @observable
  String? currentSubAdministrativeArea = '';

  @observable
  String? currentPostalCode = '';

  @observable
  Position? currentPosition = Position(
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  );

  @observable
  bool serviceEnabled = false;

  @observable
  LocationPermission permission = LocationPermission.unableToDetermine;

  @action
  Future<bool> handleLocationPermission(BuildContext context) async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location permissions are denied'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @action
  Future<void> getCurrentPosition(BuildContext context) async {
    isLoading = true;
    final hasPermission = await handleLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      // currentPosition = Position(
      //   longitude: -49.329030,
      //   latitude: -25.488350,
      //   timestamp: DateTime.now(),
      //   accuracy: 0,
      //   altitude: 0,
      //   heading: 0,
      //   speed: 0,
      //   speedAccuracy: 0,
      // );
      getAddressFromLatLng(currentPosition!);
      isLoading = false;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @action
  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentStreet = place.street;
      currentSubLocality = place.subLocality;
      currentSubAdministrativeArea = place.subAdministrativeArea;
      currentPostalCode = place.postalCode;
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @action
  Future getInputs() async {
    final inputs = FirebaseFirestore.instance.collection('inputs');
    final inputListQuerySnapshot = await inputs.get();
    final inputListFromFB = inputListQuerySnapshot.docs
        .map((e) => InputModel.fromMap(e.data()))
        .toList();
    inputAlertList = inputListFromFB
        .where((element) => element.category == 'alert')
        .toList()
        .asObservable();
    inputAlertList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
        .compareTo(b.timeAdded.millisecondsSinceEpoch));
    inputAlertList = inputAlertList.reversed.toList().asObservable();
    inputRecomendationList = inputListFromFB
        .where((element) => element.category == 'recomendation')
        .toList()
        .asObservable();
    inputRecomendationList.sort((a, b) => a.timeAdded.millisecondsSinceEpoch
        .compareTo(b.timeAdded.millisecondsSinceEpoch));
    inputRecomendationList =
        inputRecomendationList.reversed.toList().asObservable();
  }

  @action
  Future addInput(int currentPageViewIndex) async {
    var rng = Random();
    var randomNumberToId = rng.nextInt(1000000000).toString();
    final collectionReference = FirebaseFirestore.instance.collection('inputs');
    await collectionReference.doc(randomNumberToId).set(
      {
        "type": modalDropdownSelectedValue,
        "timeAdded": Timestamp.now(),
        "address":
            '${currentStreet!}, ${currentSubLocality!}, ${currentSubAdministrativeArea!}',
        "description": newInputDescription,
        "id": randomNumberToId,
        "category": currentPageViewIndex == 0 ? 'recomendation' : 'alert',
        "lat": currentPosition!.latitude,
        "lgn": currentPosition!.longitude,
      },
    );
    Modular.to.pop();
    getInputs();
  }

  Future<void> addressListFromStreetGiven(String street) async {
    try {
      final locationList =
          await locationFromAddress('$street, Curitiba, Paraná, Brazil');
      for (var element in locationList) {
        final placemarkList =
            await placemarkFromCoordinates(element.latitude, element.longitude);
        final List<String> streetList = placemarkList.map((e) {
          return e.street!;
        }).toList();
        addressFromStreetGiven = streetList.first;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
