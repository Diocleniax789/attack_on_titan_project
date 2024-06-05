// Created by Julio
// Date: 04/06/2024
// Description: this is a project test

PROGRAM attack_on_titan_software;
USES crt;

CONST
     posX_us = 15;
     posX_pass = 10;

TYPE
    arreglo_usuario = array[1..15]of string;

    arreglo_password = array[1..10]of string;

    personaje = RECORD
               nombre: string;
               division: string;
               estado: string;
               edad: integer;
               info: string;
               END;

    temporada = RECORD
               numero_temporada: integer;
               fecha_emision: string;
               sinopsis: string;
               plataforma_streaming: string;
               END;

    preguntas_respuestas = RECORD
               pregunta: string;
               respuesta_1: string;
               respuesta_2: string;
               respuesta_3: string;
               respuesta_4: string;
               END;

    cuentas = RECORD
              usuario: string;
              password: string;
              END;

    respuesta_correcta = RECORD
               numero: integer;
               respuesta: string;
               info_adicional: string;
               END;

    jugador_score = RECORD
               nombre_usuario: string;
               score_usuario: integer;
               END;

VAR
   archivo_personaje: FILE OF personaje;
   registro_personaje: personaje;
   archivo_temporada: FILE OF temporada;
   registro_temporada: temporada;
   archivo_preguntas_respuestas: FILE OF preguntas_respuestas;
   registro_preguntas_respuestas: preguntas_respuestas;
   archivo_cuentas: FILE OF cuentas;
   registro_cuentas: cuentas;
   archivo_respuesta_correcta: FILE OF respuesta_correcta;
   registro_respuesta_correcta: respuesta_correcta;
   archivo_jugador_score: FILE OF jugador_score;
   registro_jugador_score: jugador_score;
   ar_usuario: arreglo_usuario;
   ar_password: arreglo_password;
   mostrar_usuario,sinopsis_aot:string;

PROCEDURE crear_archivo_personaje;
 BEGIN
  rewrite(archivo_personaje);
  close(archivo_personaje);
 END;

PROCEDURE crear_archivo_temporada;
 BEGIN
  rewrite(archivo_temporada);
  close(archivo_temporada);
 END;

PROCEDURE crear_archivo_preguntas_respuestas;
 BEGIN
  rewrite(archivo_preguntas_respuestas);
  close(archivo_preguntas_respuestas);
 END;

PROCEDURE crear_archivo_cuentas;
 BEGIN
  rewrite(archivo_cuentas);
  close(archivo_cuentas);
 END;

PROCEDURE crear_archivo_respuesta_correcta;
 BEGIN
 rewrite(archivo_respuesta_correcta);
 close(archivo_respuesta_correcta);
 END;

PROCEDURE crear_archivo_jugador_score;
 BEGIN
 rewrite(archivo_jugador_score);
 close(archivo_jugador_score);
 END;

PROCEDURE incializar_arreglo_usuario;
VAR
 i: integer;
 BEGIN
  FOR i:= 1 TO 15 DO
   BEGIN
    ar_usuario[i]:= ' ';
   END;
 END;

PROCEDURE incializar_arreglo_password;
VAR
 i: integer;
 BEGIN
  FOR i:= 1 TO 10 DO
   BEGIN
    ar_password[i]:= ' ';
   END;
 END;

PROCEDURE cargar_sinopsis;
 BEGIN
  textcolor(brown);
  writeln();
  writeln('=================================================');
  writeln('Introduzca la sinopsis para que sea almacenada: ');
  readln(sinopsis_aot);
  writeln();
  writeln('-----------------------------------------------------------------------');
  writeln('Sinopsis cargada. Se lo regresara al menu principal. Por favor, espere.');
  delay(2000);
 END;

PROCEDURE cargar_temporadas;
VAR
 i: integer;
 BEGIN
 reset(archivo_temporada);
 i:= 0;
  REPEAT
   clrscr;
   i:= i + 1;
   textcolor(yellow);
   writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||||');
   writeln('=====================================================');
   write('Ingrese numero de temporada: ');
   readln(registro_temporada.numero_temporada);
   writeln();
   write('Ingrese fecha de emision: ');
   readln(registro_temporada.fecha_emision);
   writeln();
   write('Ingrese sinopsis de la temporada: ');
   readln(registro_temporada.sinopsis);
   writeln();
   write('Ingrese la plataforma de streaming donde se estreno: ');
   readln(registro_temporada.plataforma_streaming);
   writeln();
   seek(archivo_temporada,filesize(archivo_temporada));
   write(archivo_temporada,registro_temporada);
   textcolor(green);
   writeln('====================================');
   writeln('*** Registro guardado con exito! ***');
   writeln('====================================');
   writeln();
   UNTIL (i = 5);
   textcolor(lightgreen);
   writeln('---------------------------------------------------------');
   writeln('*** TODAS LAS TEMPORADAS HAN SIDO CARGADAS CON EXITO! ***');
   writeln('---------------------------------------------------------');
   close(archivo_temporada);
 END;

PROCEDURE carga_personajes;
VAR
 opcion: string;
 BEGIN
  reset(archivo_personaje);
  REPEAT
   clrscr;
   textcolor(brown);
   writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
   writeln('==============================================================================');
   write('Ingrese nombre de personaje: ');
   readln(registro_personaje.nombre);
   writeln();
   write('Ingrese division a la que pertenece: ');
   readln(registro_personaje.division);
   writeln();
   write('Ingrese estado: ');
   readln(registro_personaje.estado);
   writeln();
   write('Ingrese edad: ');
   readln(registro_personaje.edad);
   writeln();
   writeln('Ingrese informacion del personaje: ');
   readln(registro_personaje.info);
   writeln();
   seek(archivo_personaje,filesize(archivo_personaje));
   write(archivo_personaje,registro_personaje);
   textcolor(green);
   writeln('====================================');
   writeln('*** Registro guardado con exito! ***');
   writeln('====================================');
   writeln();
   writeln('-------------------------------------');
   write('Desea agregar otro registro[s/n]?: ');
   readln(opcion);
  UNTIL (opcion = 'n');
  close(archivo_personaje);
 END;

PROCEDURE almacenar_respuesta(informacion_adicional,respuesta: string; numero: integer);
 BEGIN
 reset(archivo_respuesta_correcta);
 registro_respuesta_correcta.respuesta:= respuesta;
 registro_respuesta_correcta.numero:= numero;
 registro_respuesta_correcta.info_adicional:= informacion_adicional;
 seek(archivo_respuesta_correcta,filesize(archivo_respuesta_correcta));
 write(archivo_respuesta_correcta,registro_respuesta_correcta);
 close(archivo_respuesta_correcta);
 END;

FUNCTION verificar_estado_archivo_personaje(): boolean;
 BEGIN
  reset(archivo_personaje);
  IF filesize(archivo_personaje) = 0 THEN
   verificar_estado_archivo_personaje:= true
  ELSE
   verificar_estado_archivo_personaje:= false;
  close(archivo_personaje);
 END;

FUNCTION busca_aniade_info(respuesta: string): string;
VAR
 f: boolean;
 BEGIN
 reset(archivo_personaje);
 f:= false;
 REPEAT
  read(archivo_personaje,registro_personaje);
  IF respuesta = registro_personaje.nombre THEN
   f:= true;
 UNTIL eof(archivo_personaje) OR (f = true);
 IF f = true THEN
  busca_aniade_info:= registro_personaje.info
 ELSE
  busca_aniade_info:= 'Info no cargada aun';
 close(archivo_personaje);
 END;

PROCEDURE cargar_preguntas_y_respuestas;
VAR
 i,numero: integer;
 respuesta,informacion_adicional: string;
 BEGIN
  i:= 0;
  reset(archivo_preguntas_respuestas);
  REPEAT
   i:= i + 1;
   clrscr;
   textcolor(lightgreen);
   writeln('==============================================================');
   writeln(' Este juego solo contara con 10 preguntas                     ');
   writeln('==============================================================');
   writeln();
   textcolor(lightmagenta);
   writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
   writeln('==============================================================');
   write('Ingrese pregunta ',i,': ');
   readln(registro_preguntas_respuestas.pregunta);
   writeln();
   write('Ingrese respuesta 1: ');
   readln(registro_preguntas_respuestas.respuesta_1);
   writeln();
   write('Ingrese respuesta 2: ');
   readln(registro_preguntas_respuestas.respuesta_2);
   writeln();
   write('Ingrese respuesta 3: ');
   readln(registro_preguntas_respuestas.respuesta_3);
   writeln();
   write('Ingrese respuesta 4: ');
   readln(registro_preguntas_respuestas.respuesta_4);
   writeln();
   seek(archivo_preguntas_respuestas,filesize(archivo_preguntas_respuestas));
   write(archivo_preguntas_respuestas,registro_preguntas_respuestas);
   textcolor(lightcyan);
   writeln('Respuesta correcta para guardar en el registro: ');
   writeln();
   readln(respuesta);
   IF verificar_estado_archivo_personaje() = true THEN
    BEGIN
    textcolor(lightred);
    writeln();
    writeln('|////////////////////////////////////////////////////////////////////////////////////////////////|');
    writeln('|La info de personajes esta vacia. Rellene el archivo de personajes antes de cargar las preguntas|');
    writeln('|////////////////////////////////////////////////////////////////////////////////////////////////|');
    END
   ELSE
    informacion_adicional:= busca_aniade_info(respuesta);
   textcolor(lightcyan);
   writeln();
   writeln('Numero de respuesta');
   writeln();
   readln(numero);
   almacenar_respuesta(informacion_adicional,respuesta,numero);
  UNTIL (i = 10);
  textcolor(green);
  clrscr;
  writeln('========================================================================');
  writeln(' *** Las preguntas fueron guardadas con sus respectivas respuestas! *** ');
  writeln('========================================================================');
  close(archivo_preguntas_respuestas);
  delay(2000);
 END;

PROCEDURE mostrar_sinopsis;
 BEGIN
 IF sinopsis_aot = ' ' THEN
  BEGIN
   textcolor(lightred);
   writeln();
   writeln('|//////////////////////////////////////////////////|');
   writeln('|No hay sinopsis cargada. Volvera al menu principal|');
   writeln('|//////////////////////////////////////////////////|');
  END
 ELSE
  BEGIN
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=');
  textcolor(green);
  writeln('||||||||||||||||||||||||||||||||||||||Shingeki No Kyojin|||||||||||||||||||||||||||||||||||||||||||');
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=');
  writeln();
  writeln(sinopsis_aot);
  writeln();
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
  textcolor(green);
  writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
  writeln();
  textcolor(lightmagenta);
  writeln('--------------------------------------------');
  writeln('Pulse enter para volver al menu principal...');
  readln();
  END;
 END;

FUNCTION valida_temporada(): integer;
VAR
   temp: integer;
   BEGIN
    REPEAT
     textcolor(cyan);
     write('Ingrese numero de temporada que desea buscar: ');
     readln(temp);
     IF (temp < 1) OR (temp > 4) THEN
      BEGIN
      textcolor(lightred);
      writeln();
      writeln('////////////////////////////////////////////////////////////////////');
      writeln('No existe ese numero de temporada. Ingrese una temporada entre 1 y 4');
      writeln('////////////////////////////////////////////////////////////////////');
      writeln();
      END;
    UNTIL (temp >= 1) AND (temp <= 4);
    valida_temporada:= temp;
   END;

FUNCTION busca_temporada(almacena_temporada: integer): boolean;
VAR
f: boolean;
 BEGIN
  f:= false;
  REPEAT
   read(archivo_temporada,registro_temporada);
   IF almacena_temporada = registro_temporada.numero_temporada THEN
    f:= true;
  UNTIL eof(archivo_temporada) OR (f = true);
  IF  f = true THEN
   busca_temporada:= true
  ELSE
   busca_temporada:= false;
 END;

FUNCTION verificar_estado_archivo_temporada(): boolean;
 BEGIN
  IF filesize(archivo_temporada) = 0 THEN
   verificar_estado_archivo_temporada:= true
  ELSE
   verificar_estado_archivo_temporada:= false;
 END;

PROCEDURE filtrar_temporadas;
VAR
 opcion: string;
 almacena_temporada:integer;
 BEGIN
  clrscr;
  reset(archivo_temporada);
  IF verificar_estado_archivo_temporada = true THEN
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('|//////////////////////////////////////////////////////////////|');
   writeln('|El archivo de temporadas esta vacio. Volvera al menu principal|');
   writeln('|//////////////////////////////////////////////////////////////|');
   delay(2000);
   END
  ELSE
   BEGIN
    REPEAT
    clrscr;
    writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    writeln('---------------------------------------------------------------------------------------------------');
    almacena_temporada:= valida_temporada;
    writeln();
     IF busca_temporada(almacena_temporada) = true THEN
      BEGIN
      textcolor(brown);
      writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
      writeln('||||||||||||||||||||||||||||||||||||SHINGEKI NO KYOJIN |||||||||||||||||||||||||||||||||||||||||||||');
      writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
      writeln();
      textcolor(green);
      writeln('Numero de temporada: ',registro_temporada.numero_temporada);
      writeln();
      writeln('Fecha de emision: ',registro_temporada.fecha_emision);
      writeln();
      writeln('Sinopsis: ',registro_temporada.sinopsis);
      writeln();
      writeln('Plataforma de streaming: ',registro_temporada.plataforma_streaming);
      writeln();
      textcolor(brown);
      writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
      writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
      writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
      END
     ELSE
      BEGIN
      textcolor(lightred);
      writeln();
      writeln('//////////////////////////////////////////////');
      writeln('Esa temporada no existe en nuestros registros.');
      writeln('//////////////////////////////////////////////');
      END;
    textcolor(cyan);
    writeln();
    writeln('====================================');
    writeln('Desea filtrar otra temporada[s/n]?: ');
    readln(opcion);
    UNTIL (opcion = 'n');
   END;
 close(archivo_temporada);
 END;

FUNCTION busca_personaje(nombre_personaje: string): boolean;
VAR
f: boolean;
 BEGIN
  f:= false;
  REPEAT
   read(archivo_personaje,registro_personaje);
   IF nombre_personaje = registro_personaje.nombre THEN
    f:= true;
  UNTIL eof(archivo_personaje) OR (f = true);
  IF  f = true THEN
   busca_personaje:= true
  ELSE
   busca_personaje:= false;
 END;

PROCEDURE filtrar_personaje;
VAR
 nombre_personaje,opcion: string;
 BEGIN
  clrscr;
  IF verificar_estado_archivo_personaje = true THEN
   BEGIN
   textcolor(lightred);
   writeln();
   writeln('|//////////////////////////////////////////////////////////////|');
   writeln('|El archivo de personajes esta vacio. Volvera al menu principal|');
   writeln('|//////////////////////////////////////////////////////////////|');
   delay(2000);
   END
  ELSE
   BEGIN
    reset(archivo_personaje);
    REPEAT
    clrscr;
    textcolor(brown);
    writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
    writeln('---------------------------------------------------------------------------------------------------');
    writeln('Ingrese nombre de personaje que desea buscar: ');
    readln(nombre_personaje);
    writeln();
    IF busca_personaje(nombre_personaje) = true THEN
     BEGIN
     textcolor(brown);
     writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
     writeln('||||||||||||||||||||||||||||||||||||SHINGEKI NO KYOJIN||||||||||||||||||||||||||||||||||||||||||||||');
     writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
     writeln();
     textcolor(green);
     writeln('Personaje: ',registro_personaje.nombre);
     writeln();
     writeln();
     writeln('Estado: ',registro_personaje.estado);
     writeln();
     writeln('Edad: ',registro_personaje.edad);
     writeln();
     writeln('Informacion: ',registro_personaje.info);
     writeln();
     textcolor(brown);
     writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
     writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
     writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
     END
    ELSE
     BEGIN
     textcolor(lightred);
     writeln();
     writeln('//////////////////////////////////////////////');
     writeln('Ese personaje no existe en nuestros registros.');
     writeln('//////////////////////////////////////////////');
     END;
     textcolor(cyan);
     writeln();
     writeln('====================================');
     writeln('Desea filtrar otro personaje[s/n]?: ');
     readln(opcion);
     UNTIL (opcion = 'n');
     close(archivo_personaje);
   END;
 END;

FUNCTION verificar_estado_archivo_preguntas_respuestas(): boolean;
 BEGIN
  reset(archivo_respuesta_correcta);
  IF filesize(archivo_respuesta_correcta) = 0 THEN
   verificar_estado_archivo_preguntas_respuestas:= true
  ELSE
   verificar_estado_archivo_preguntas_respuestas:= false;
 close(archivo_respuesta_correcta);
 END;

FUNCTION correcta_incorrecta(opcion: integer; almacena_respuesta: string):boolean;
VAR
  f: boolean;
  BEGIN
   reset(archivo_respuesta_correcta);
   f:= false;
   REPEAT
   read(archivo_respuesta_correcta,registro_respuesta_correcta);
   IF opcion = registro_respuesta_correcta.numero THEN
    IF almacena_respuesta = registro_respuesta_correcta.respuesta THEN
     f:= true;
   UNTIL eof(archivo_respuesta_correcta) OR (f = true);
   IF f = true THEN
    correcta_incorrecta:= true
   ELSE
    correcta_incorrecta:= false;
   close(archivo_respuesta_correcta);
  END;

PROCEDURE carga_pantalla_trivia;
 BEGIN
   textcolor(lightcyan);
   writeln();
   gotoxy(whereX, whereY + 10);
   gotoxy(whereX + 25, whereY);
   writeln('||==================================||');
   gotoxy(whereX + 25, whereY);
   writeln('|| ___                              ||');
   gotoxy(whereX + 25, whereY);
   writeln('||-   ---___-                       ||');
   gotoxy(whereX + 25, whereY);
   writeln('||   (| ||           * ;     *   _  ||');
   gotoxy(whereX + 25, whereY);
   writeln('||  ((  ||    ,._-_ \\ \\/\ \\  < \,||');
   gotoxy(whereX + 25, whereY);
   writeln('|| ((   ||     ||   || || | ||  /-||||');
   gotoxy(whereX + 25, whereY);
   writeln('||  (( //      ||   || || | || (( ||||');
   gotoxy(whereX + 25, whereY);
   writeln('||    -____-   \\,  \\ \\/  \\  \/\\||');
   gotoxy(whereX + 25, whereY);
   writeln('||==================================||');
   writeln();
   delay(3000);
 END;

PROCEDURE introduccion_trivia;
 BEGIN
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=');
  textcolor(green);
  writeln('||||||||||||||||||||||||||||||||||||||||||||TRIVIA|||||||||||||||||||||||||||||||||||||||||||||||||');
  writeln('||||||||||||||||||||||||||||||||||||||Shingeki No Kyojin|||||||||||||||||||||||||||||||||||||||||||');
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=');
  writeln('||                                                                                               ||');
  writeln('||-----------------------------------------------------------------------------------------------||');
  writeln('||        Bienvenidos a nuestro juego de preguntas y respuestas sobre "Attack on Titan           ||');
  writeln('||-----------------------------------------------------------------------------------------------||');
  writeln('||                                                                                               ||');
  writeln('||       Crees que conoces todos los secretos de este epico anime, es hora de demostrarlo.       ||');
  writeln('||      Pon a prueba tu conocimiento sobre los personajes, tramas y misterios que hacen de       ||');
  writeln('||                          "Attack on Titan" una serie inolvidable.                             ||');
  writeln('|| Desde los detalles mas oscuros de los titanes hasta las estrategias del Cuerpo de Exploracion,||');
  writeln('||nuestras preguntas desafiaran a los fanaticos más apasionados. ¿Estás listo para enfrentar este||');
  writeln('||  desafio y demostrar que eres el verdadero experto en "Attack on Titan"? ¡Comienza a jugar y  ||');
  writeln('||                      muestra tu dominio del mundo de los titanes!                             ||');
  writeln('||                                                                                               ||');
  writeln('||-----------------------------------------------------------------------------------------------||');
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
  textcolor(green);
  writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
  writeln();
  writeln('Pulse enter para ver las instrucciones...');
  readln();
 END;

PROCEDURE instrucciones_trivia;
 BEGIN
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=');
  textcolor(green);
  writeln('||||||||||||||||||||||||||||||||||||||||||||TRIVIA|||||||||||||||||||||||||||||||||||||||||||||||||');
  writeln('||||||||||||||||||||||||||||||||||||||Shingeki No Kyojin|||||||||||||||||||||||||||||||||||||||||||');
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=');
  writeln('||                                                                                               ||');
  writeln('||-----------------------------------------------------------------------------------------------||');
  writeln('||                                       Instrucciones                                           ||');
  writeln('||-----------------------------------------------------------------------------------------------||');
  writeln('||                                                                                               ||');
  writeln('||       1 - Puntuacion por Pregunta: Cada pregunta correcta vale 1000 puntos.                   ||');
  writeln('||-----------------------------------------------------------------------------------------------||');
  writeln('||                                                                                               ||');
  writeln('||       2 - Categorias de Puntuacion:                                                           ||');
  writeln('||                                                                                               ||');
  textcolor(lightred);
  writeln('||               * 0 a 3000 puntos: Necesitas ver "Attack on Titan" nuevamente.                  ||');
  writeln('||                                ¡Hay mucho más por descubrir!                                  ||');
  writeln('||                                                                                               ||');
  textcolor(yellow);
  writeln('||           * 4000 a 6000 puntos: Necesitas echarle un poco mas al manga y al anime.            ||');
  writeln('||                          ¡Todavía hay cosas que se te escapan!                                ||');
  writeln('||                                                                                               ||');
  writeln('||                                                                                               ||');
  writeln('||                                                                                               ||');
  textcolor(lightgreen);
  writeln('||           * 7000 a 10000 puntos: Eres un verdadero fanatico y experto.                        ||');
  writeln('||                                  ¡Conoces "Attack on Titan" al detalle!                       ||');
  writeln('||                                                                                               ||');
  writeln('||                                                                                               ||');
  textcolor(lightmagenta);
  writeln('||                        VE Y COMIENZA A PONER APRUEBA TU CONOCIMIENTO!                         ||');
  textcolor(brown);
  writeln('||-----------------------------------------------------------------------------------------------||');
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
  textcolor(green);
  writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
  textcolor(brown);
  writeln('=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.=.');
  writeln();
  writeln('Pulse enter para empezar el juego...');
  readln();
 END;

FUNCTION verificar_estado_tabla_puntajes(): boolean;
 BEGIN
  IF filesize(archivo_jugador_score) = 0 THEN
   verificar_estado_tabla_puntajes:= true
  ELSE
   verificar_estado_tabla_puntajes:= false;
 END;

FUNCTION busca_jugador(mostrar_usuario: string): boolean;
VAR
 f: boolean;
 BEGIN
 f:= false;
 REPEAT
  seek(archivo_jugador_score,filesize(archivo_jugador_score) - 1 );
  read(archivo_jugador_score,registro_jugador_score);
  IF mostrar_usuario = registro_jugador_score.nombre_usuario THEN
   f:= true;
 UNTIL eof(archivo_jugador_score) OR (f = true);
 IF f = true THEN
  busca_jugador:= true
 ELSE
  busca_jugador:= false;
 END;

PROCEDURE orderna_tabla_puntaje_mayor_a_menor;
VAR
 i,j:integer;
 raux: jugador_score;
 BEGIN
 FOR i:= 0 TO filesize(archivo_jugador_score) - 2 DO
  BEGIN
  FOR j:= i + 1 TO filesize(archivo_jugador_score) - 1 DO
   BEGIN
   seek(archivo_jugador_score, i);
   read(archivo_jugador_score,registro_jugador_score);
   seek(archivo_jugador_score,j);
   read(archivo_jugador_score,raux);
   IF registro_jugador_score.score_usuario < raux.score_usuario THEN
    BEGIN
    seek(archivo_jugador_score,i);
    write(archivo_jugador_score,raux);
    seek(archivo_jugador_score,j);
    write(archivo_jugador_score,registro_jugador_score);
    END;
   END;
  END;
 END;

PROCEDURE cargar_usuario_tabla_score(mostrar_usuario: string; score: integer);
 BEGIN
 reset(archivo_jugador_score);
 IF verificar_estado_tabla_puntajes = true THEN
  BEGIN
  registro_jugador_score.nombre_usuario:= mostrar_usuario;
  registro_jugador_score.score_usuario:= score;
  seek(archivo_jugador_score,filesize(archivo_jugador_score));
  write(archivo_jugador_score,registro_jugador_score);
  END
 ELSE
  BEGIN
  IF busca_jugador(mostrar_usuario) = true THEN
   BEGIN
   registro_jugador_score.score_usuario:= registro_jugador_score.score_usuario + score;
   seek(archivo_jugador_score,filesize(archivo_jugador_score) - 1);
   write(archivo_jugador_score,registro_jugador_score);
   END
  ELSE
   BEGIN
   registro_jugador_score.nombre_usuario:= mostrar_usuario;
   registro_jugador_score.score_usuario:= score;
   seek(archivo_jugador_score,filesize(archivo_jugador_score));
   write(archivo_jugador_score,registro_jugador_score);
   END;
  END;
 orderna_tabla_puntaje_mayor_a_menor;
 close(archivo_jugador_score);
 END;

PROCEDURE mostrar_tipo_puntaje(score: integer);
  BEGIN
  IF (score >= 0) AND (score <= 3000) THEN
   BEGIN
   clrscr;
   textcolor(lightred);
   writeln('***************************');
   writeln('Puntaje obtenido: ',score);
   writeln('**************************');
   writeln();
   writeln('-------------------------------------------------');
   writeln('|||||||||||||||||||||||||||||||||||||||||||||||||');
   writeln('-------------------------------------------------');
   writeln('|| Necesitas ver "Attack on Titan" nuevamente. ||');
   writeln('-------------------------------------------------');
   writeln('|||||||||||||||||||||||||||||||||||||||||||||||||');
   writeln('-------------------------------------------------');
   END
  ELSE
    IF (score >= 4000) AND (score <= 6000) THEN
     BEGIN
      clrscr;
      textcolor(yellow);
      writeln('***************************');
      writeln('Puntaje obtenido: ',score);
      writeln('**************************');
      writeln();
      writeln('----------------------------------------------------------------------------------------------------------------');
      writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
      writeln('----------------------------------------------------------------------------------------------------------------');
      writeln('|| Casi lo logras!. Tienes que repasar algunos datos para ser tener conocimiento regular de "Attack on Titan" ||');
      writeln('----------------------------------------------------------------------------------------------------------------');
      writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
      writeln('----------------------------------------------------------------------------------------------------------------');
     END
    ELSE
      IF (score >= 7000) AND (score <= 10000) THEN
       BEGIN
       clrscr;
       textcolor(lightgreen);
       writeln('***************************');
       writeln('Puntaje obtenido: ',score);
       writeln('**************************');
       writeln();
       writeln('----------------------------------------------------------------------------------');
       writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
       writeln('----------------------------------------------------------------------------------');
       writeln('|| Eres un verdadero fanático y experto.¡Conoces "Attack on Titan" al detalle!  ||');
       writeln('----------------------------------------------------------------------------------');
       writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||');
       writeln('----------------------------------------------------------------------------------');
       END;
  END;

PROCEDURE mostrar_tabla_score_jugadores;
VAR
 i: integer;
 BEGIN
 reset(archivo_jugador_score);
 clrscr;
 textcolor(lightgreen);
 writeln('=======================================================================');
 writeln('||////////////////////////////////SCORE//////////////////////////////||');
 writeln('=======================================================================');
 writeln('||  USUARIO |  SCORE                                                 ||');
 writeln('=======================================================================');
 FOR i:= 0 TO filesize(archivo_jugador_score) - 1 DO
  BEGIN
   seek(archivo_jugador_score,i);
   read(archivo_jugador_score,registro_jugador_score);
   writeln();
   writeln(registro_jugador_score.nombre_usuario,' ',registro_jugador_score.score_usuario);
   writeln('---------------------------------------------------------------------');
   writeln();
  END;
 delay(10000);
 close(archivo_jugador_score);
 END;

PROCEDURE trivia;
VAR
 i,opcion,score: integer;
 almacena_respuesta: string;
 BEGIN
  reset(archivo_preguntas_respuestas);
  IF verificar_estado_archivo_preguntas_respuestas = true THEN
   BEGIN
    textcolor(lightred);
    gotoxy(whereX, whereY + 10);
    gotoxy(whereX + 35, whereY);
    writeln('==================================');
    gotoxy(whereX + 35, whereY);
    writeln('||//////////////////////////////||');
    gotoxy(whereX + 35, whereY);
    writeln('==================================');
    gotoxy(whereX + 35, whereY);
    writeln('|| _-_,  /\\ ,._-_ ,._-_  \\/\\ ||');
    gotoxy(whereX + 35, whereY);
    writeln('||||_.  || ||  ||    ||    || ; ||');
    gotoxy(whereX + 35, whereY);
    writeln('|| ~ || || ||  ||    ||    ||/  ||');
    gotoxy(whereX + 35, whereY);
    writeln('||,-_-  \\,/   \\,   \\,   |/   ||');
    gotoxy(whereX + 35, whereY);
    writeln('||                        (     ||');
    gotoxy(whereX + 35, whereY);
    writeln('||                         -_-  ||');
    gotoxy(whereX + 35, whereY);
    writeln('==================================');
    gotoxy(whereX + 35, whereY);
    writeln('||//////////////////////////////||');
    gotoxy(whereX + 35, whereY);
    writeln('==================================');
    writeln();
    gotoxy(whereX + 15, whereY);
    writeln('|//////////////////////////////////////////////////////////////////////////|');
    gotoxy(whereX + 15, whereY);
    writeln('|El archivo de preguntas y respuestas esta vacio. Volvera al menu principal|');
    gotoxy(whereX + 15, whereY);
    writeln('|//////////////////////////////////////////////////////////////////////////|');
    delay(2000);
   END
  ELSE
   BEGIN
   clrscr;
   carga_pantalla_trivia;
   clrscr;
   introduccion_trivia;
   clrscr;
   instrucciones_trivia;
   score:= 0;
   FOR i:= 0 TO filesize(archivo_preguntas_respuestas) - 1 DO
    BEGIN
    clrscr;
    textcolor(lightcyan);
    writeln('//////////////////////////////////////////////////////////////////');
    writeln('==================================================================');
    seek(archivo_preguntas_respuestas, i);
    read(archivo_preguntas_respuestas,registro_preguntas_respuestas);
    writeln('Pregunta nro: ',i);
    writeln('-----------------');
    writeln(registro_preguntas_respuestas.pregunta);
    writeln();
    writeln('==================================================================');
    writeln('1 - ',registro_preguntas_respuestas.respuesta_1);
    writeln('2 - ',registro_preguntas_respuestas.respuesta_2);
    writeln('3 - ',registro_preguntas_respuestas.respuesta_3);
    writeln('4 - ',registro_preguntas_respuestas.respuesta_4);
    writeln('==================================================================');
    writeln();
    write('Seleccione su respuesta: ');
    readln(opcion);
    CASE opcion OF
         1:BEGIN
             almacena_respuesta:= registro_preguntas_respuestas.respuesta_1;
             IF correcta_incorrecta(opcion,almacena_respuesta) = true THEN
              BEGIN
              textcolor(lightgreen);
              writeln();
              score:= score + 1000;
              writeln('|==========================|');
              writeln('|*** respuesta correcta ***|');
              writeln('|==========================|');
              textcolor(green);
              writeln();
              writeln('Informacion Adicional:');
              writeln('----------------------');
              writeln(registro_respuesta_correcta.info_adicional);
              delay(2000);
              END
             ELSE
              BEGIN
              textcolor(lightred);
              writeln();
              writeln('======================');
              writeln('|////////////////////|');
              writeln('|respuesta incorrecta|');
              writeln('|////////////////////|');
              writeln('======================');
              delay(2000);
              END;
           END;
         2:BEGIN
             almacena_respuesta:= registro_preguntas_respuestas.respuesta_2;
             IF correcta_incorrecta(opcion,almacena_respuesta) = true THEN
              BEGIN
              textcolor(lightgreen);
              writeln();
              score:= score + 1000;
              writeln('|==========================|');
              writeln('|*** respuesta correcta ***|');
              writeln('|==========================|');
              textcolor(green);
              writeln();
              writeln('Informacion Adicional:');
              writeln('----------------------');
              writeln(registro_respuesta_correcta.info_adicional);
              delay(2000);
              END
             ELSE
              BEGIN
              textcolor(lightred);
              writeln();
              writeln('======================');
              writeln('|////////////////////|');
              writeln('|respuesta incorrecta|');
              writeln('|////////////////////|');
              writeln('======================');
              delay(2000);
              END;
           END;
         3:BEGIN
              almacena_respuesta:= registro_preguntas_respuestas.respuesta_3;
             IF correcta_incorrecta(opcion,almacena_respuesta) = true THEN
              BEGIN
              textcolor(lightgreen);
              writeln();
              score:= score + 1000;
              writeln('|==========================|');
              writeln('|*** respuesta correcta ***|');
              writeln('|==========================|');
              textcolor(green);
              writeln();
              writeln('Informacion Adicional:');
              writeln('----------------------');
              writeln(registro_respuesta_correcta.info_adicional);
              delay(2000);
              END
             ELSE
              BEGIN
              textcolor(lightred);
              writeln();
              writeln('======================');
              writeln('|////////////////////|');
              writeln('|respuesta incorrecta|');
              writeln('|////////////////////|');
              writeln('======================');
              delay(2000);
              END;
           END;
         4:BEGIN
             almacena_respuesta:= registro_preguntas_respuestas.respuesta_4;
             IF correcta_incorrecta(opcion,almacena_respuesta) = true THEN
              BEGIN
              textcolor(lightgreen);
              writeln();
              score:= score + 1000;
              writeln('|==========================|');
              writeln('|*** respuesta correcta ***|');
              writeln('|==========================|');
              textcolor(green);
              writeln();
              writeln('Informacion Adicional:');
              writeln('----------------------');
              writeln(registro_respuesta_correcta.info_adicional);
              delay(2000);
              END
             ELSE
              BEGIN
              textcolor(lightred);
              writeln();
              writeln('======================');
              writeln('|////////////////////|');
              writeln('|respuesta incorrecta|');
              writeln('|////////////////////|');
              writeln('======================');
              delay(2000);
              END;
           END;
    END;
  END;
  cargar_usuario_tabla_score(mostrar_usuario,score);
  clrscr;
  mostrar_tipo_puntaje(score);
  delay(8000);
  mostrar_tabla_score_jugadores;
  END;
 END;

PROCEDURE mostrar_tabla_puntajes;
 BEGIN
 reset(archivo_jugador_score);
 IF verificar_estado_tabla_puntajes = true THEN
  BEGIN
  textcolor(lightred);
  writeln();
  gotoxy(whereX, whereY + 10);
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  gotoxy(whereX + 35, whereY);
  writeln('||//////////////////////////////||');
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  gotoxy(whereX + 35, whereY);
  writeln('|| _-_,  /\\ ,._-_ ,._-_  \\/\\ ||');
  gotoxy(whereX + 35, whereY);
  writeln('||||_.  || ||  ||    ||    || ; ||');
  gotoxy(whereX + 35, whereY);
  writeln('|| ~ || || ||  ||    ||    ||/  ||');
  gotoxy(whereX + 35, whereY);
  writeln('||,-_-  \\,/   \\,   \\,   |/   ||');
  gotoxy(whereX + 35, whereY);
  writeln('||                        (     ||');
  gotoxy(whereX + 35, whereY);
  writeln('||                         -_-  ||');
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  gotoxy(whereX + 35, whereY);
  writeln('||//////////////////////////////||');
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  writeln();
  gotoxy(whereX + 25, whereY);
  writeln('|////////////////////////////////////////////////////////////|');
  gotoxy(whereX + 25, whereY);
  writeln('|El archivo de puntajes esta vacio. Volvera al menu principal|');
  gotoxy(whereX + 25, whereY);
  writeln('|////////////////////////////////////////////////////////////|');
  delay(2000);
  END
 ELSE
  mostrar_tabla_score_jugadores;
 close(archivo_jugador_score);
 END;

PROCEDURE menu_usuario;
VAR
 opcion: integer;
 BEGIN
  REPEAT
   clrscr;
   textcolor(green);
   writeln();
   gotoxy(whereX, whereY);
   gotoxy(whereX + 25, whereY);
   writeln('==========================================');
   gotoxy(whereX + 25, whereY);
   writeln('| USUARIO: ',mostrar_usuario               );
   gotoxy(whereX + 25, whereY);
   writeln('==========================================');
   writeln();
   textcolor(brown);
   gotoxy(whereX + 25, whereY);
   writeln('================================================');
   gotoxy(whereX + 25, whereY);
   writeln('|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|* |');
   gotoxy(whereX + 25, whereY);
   writeln('================================================');
   gotoxy(whereX + 25, whereY);
   writeln('|*|                                          |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|        ,    ,             ,,             |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|  _    ||   ||    _        ||             |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*| < \, =||= =||=  < \,  _-_ ||/\           |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*| /-||  ||   ||   /-|| ||   ||_<           |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|(( ||  ||   ||  (( || ||   || |           |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*| \/\\  \\,  \\,  \/\\ \\,/ \\,\           |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|                                          |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|                                          |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|                    ,       ,             |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|                   ||   *  ||    _        |*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|/\\\\  /\\         =||= \\ =||= < \, \\/\\|*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*||| || || ||        ||  ||  ||   /-|| || |||*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*||| || || ||        ||  ||  ||  (( || || |||*|');
   gotoxy(whereX + 25, whereY);
   writeln('|*|\\,/  \\ \\        \\, \\  \\,  \/\\ \\ \\|*|');
   gotoxy(whereX + 25, whereY);
   writeln('================================================');
   gotoxy(whereX + 25, whereY);
   writeln('|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|* |');
   gotoxy(whereX + 25, whereY);
   writeln('================================================');
   writeln();
   gotoxy(whereX + 25, whereY);
   writeln('==========================');
   gotoxy(whereX + 25, whereY);
   writeln('*** MENU PARA USUARIOS ***');
   gotoxy(whereX + 25, whereY);
   writeln('==========================');
   writeln();
   gotoxy(whereX + 25, whereY);
   writeln('-------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|1| - Sinopsis de Shingenki No Kyojin - |1|');
   gotoxy(whereX + 25, whereY);
   writeln('-------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|2| -       Filtrar temporadas        - |2|');
   gotoxy(whereX + 25, whereY);
   writeln('-------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|3| -  Ver informacion de personajes  - |3|');
   gotoxy(whereX + 25, whereY);
   writeln('-------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|4| -            Trivia               - |4|');
   gotoxy(whereX + 25, whereY);
   writeln('-------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|5| -    Ver tabla de puntaciones     - |5|');
   gotoxy(whereX + 25, whereY);
   writeln('-------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|6| -    Regresar al menu de cargas   - |6|');
   gotoxy(whereX + 25, whereY);
   writeln('-------------------------------------------');
   writeln();
   gotoxy(whereX + 25, whereY);
   writeln('===================================');
   gotoxy(whereX + 25, whereY);
   write('Seleccion opcion: ');
   readln(opcion);
   CASE opcion OF
        1:BEGIN
           clrscr;
           mostrar_sinopsis;
          END;
        2:BEGIN
           clrscr;
           filtrar_temporadas;
          END;
       3:BEGIN
           clrscr;
           filtrar_personaje;
          END;
       4:BEGIN
           clrscr;
           trivia;
         END;
       5:BEGIN
           clrscr;
           mostrar_tabla_puntajes;
         END;
  END;
  UNTIL (opcion = 6);
 END;

PROCEDURE cerrar_sesion;
VAR
 i: integer;
 BEGIN
  i:= 0;
  REPEAT
  clrscr;
  textcolor(blue);
  i:= i + 1;
  gotoxy(whereX, whereY + 10);
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('======================================================');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('======================================================');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||                                    |\            ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||                         _           \\           ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('|| _-_  _-_  ,._-_ ,._-_  < \, \\/\\  / \\  /\\     ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||||   || \\  ||    ||    /-|| || || || || || ||    ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||||   ||/    ||    ||   (( || || || || || || ||    ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||\\,/ \\,/   \\,   \\,   \/\\ \\ \\  \\/  \\,/     ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||                                                  ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||                                                  ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||                   *                              ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('|| _-_,  _-_   _-_, \\  /\\ \\/\\                   ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||||_.  || \\ ||_.  || || || || ||                  ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('|| ~ || ||/    ~ || || || || || ||                  ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||,-_-  \\,/  ,-_-  \\ \\,/  \\ \\                  ||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('======================================================');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('||||||||||||||||||||||||||||||||||||||||||||||||||||||');
  gotoxy(whereX + 25,  whereY);
  delay(30);
  writeln('======================================================');
  UNTIL (i = 5);
 END;

PROCEDURE menu_cargas;
VAR
 opcion: integer;
 BEGIN
  REPEAT
   clrscr;
   textcolor(yellow);
   gotoxy(whereX, whereY + 10);
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('==========================================');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('||  ,- _~.                              ||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('|| (  /|     _           _     _        ||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('||((  ||    < \, ,._-_  / \\  < \,  _-_,||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('||((  ||    /-||  ||   || ||  /-|| ||_. ||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('|| ( / |   (( ||  ||   || || (( ||  ~ ||||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('||  -____-  \/\\  \\,  \\_-|  \/\\ ,-_- ||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('||                      /  \            ||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('||                     <---->           ||');
   gotoxy(whereX + 25, whereY);
   delay(90);
   writeln('||======================================||');
   writeln();
   gotoxy(whereX + 25, whereY);
   writeln('==========================================');
   gotoxy(whereX + 25, whereY);
   writeln('| USUARIO: ',mostrar_usuario);
   gotoxy(whereX + 25, whereY);
   writeln('==========================================');
   writeln();
   textcolor(lightgreen);
   gotoxy(whereX + 25, whereY);
   writeln('=================================================');
   gotoxy(whereX + 25, whereY);
   writeln(' ***             MENU PRINCIPAL              *** ');
   gotoxy(whereX + 25, whereY);
   writeln('=================================================');
   writeln();
   textcolor(lightmagenta);
   gotoxy(whereX + 25, whereY);
   writeln('--------------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|1| - Cargar sinopsis de Shingeki No Kyojin  - |1|');
   gotoxy(whereX + 25, whereY);
   writeln('--------------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|2| -          Cargar temporadas             - |2|');
   gotoxy(whereX + 25, whereY);
   writeln('--------------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|3| -          Cargar personajes             - |3|');
   gotoxy(whereX + 25, whereY);
   writeln('--------------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|4| -    Cargar preguntas y respuestas       - |4|');
   gotoxy(whereX + 25, whereY);
   writeln('--------------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|5| -         Menu para el usuario           - |5|');
   gotoxy(whereX + 25, whereY);
   writeln('--------------------------------------------------');
   gotoxy(whereX + 25, whereY);
   writeln('|6| -            Cerrar sesion               - |6|');
   gotoxy(whereX + 25, whereY);
   writeln('--------------------------------------------------');
   writeln();
   textcolor(lightcyan);
   gotoxy(whereX + 25, whereY);
   writeln('------------------------------------------------');
   gotoxy(whereX + 25, whereY);
   write('Seleccion opcion: ');
   readln(opcion);
   CASE opcion OF
        1:BEGIN
           clrscr;
           cargar_sinopsis;
          END;
        2:BEGIN
           clrscr;
           cargar_temporadas;
          END;
        3:BEGIN
           clrscr;
           carga_personajes;
          END;
        4:BEGIN
           clrscr;
           cargar_preguntas_y_respuestas
          END;
        5:BEGIN
           menu_usuario;
          END;
        6:BEGIN
           clrscr;
           cerrar_sesion;
          END;
   END;
  UNTIL (opcion =  6);
 END;

FUNCTION estado_archivo_cuentas(): boolean;
 BEGIN
  IF filesize(archivo_cuentas) = 0 THEN
   estado_archivo_cuentas:= true
  ELSE
   estado_archivo_cuentas:= false;
 END;

FUNCTION busca_usuario_contrasenia(almacena_usuario,almacena_password: string): boolean;
VAR
 f: boolean;
 BEGIN
 REPEAT
    seek(archivo_cuentas,filesize(archivo_cuentas) - 1);
    read(archivo_cuentas,registro_cuentas);
    IF almacena_usuario = registro_cuentas.usuario THEN
     IF almacena_password = registro_cuentas.password THEN
       f:= true;
 UNTIL eof(archivo_cuentas) OR (f = true);
  IF f = true THEN
   busca_usuario_contrasenia:= true
  ELSE
   busca_usuario_contrasenia:= false;
 END;

FUNCTION existe_usuario(almacena_usuario: string): boolean;
VAR
 f: boolean;
 BEGIN
  f:= false;
  REPEAT
    seek(archivo_cuentas,filesize(archivo_cuentas) - 1);
    read(archivo_cuentas,registro_cuentas);
    IF almacena_usuario = registro_cuentas.usuario THEN
     f:= true;
  UNTIL eof(archivo_cuentas) OR (f = true);
   IF f = true THEN
    existe_usuario:= true
   ELSE
    existe_usuario:= false;
 END;

FUNCTION existe_password(almacena_password: string): boolean;
VAR
  f: boolean;
  BEGIN
  f:= false;
   REPEAT
    seek(archivo_cuentas,filesize(archivo_cuentas) - 1);
    read(archivo_cuentas,registro_cuentas);
    IF almacena_password = registro_cuentas.password THEN
     f:= true;
   UNTIL eof(archivo_cuentas) OR (f = true);
   IF  f = true THEN
    existe_password:= true
   ELSE
    existe_password:= false;
  END;

FUNCTION crea_ingresa_usuario(): string;
VAR
 i: integer;
 caracter,aux,usuario_listo: string;
 BEGIN
 incializar_arreglo_usuario;
 i:= 0; caracter:= readkey;
 WHILE caracter <> #13 DO
 BEGIN
   IF caracter <> #8 THEN
   BEGIN
   gotoxy(whereX,whereY);
    IF (whereX <= posX_us) OR (whereX = posX_us) THEN
     BEGIN
     write(caracter);
     i:= i + 1;
     ar_usuario[i]:= caracter;
     END;
    END
    ELSE
     BEGIN
     gotoxy(whereX - 1, whereY);
     write(' ',#8);
     ar_usuario[i]:= ' ';
     IF (i >= 1) AND (i <= 15) THEN
      i:= i - 1
     ELSE
      i:= 0;
     END;
    caracter:= readkey;
   END;
  aux:= ' ';
  FOR i:= 1 TO 15 DO
   BEGIN
    usuario_listo:= concat(aux,ar_usuario[i]);
    aux:= usuario_listo;
   END;
  crea_ingresa_usuario:= usuario_listo;
 END;

FUNCTION crea_ingresa_password(): string;
VAR
 i: integer;
 caracter,aux,password_listo: string;
 BEGIN
 incializar_arreglo_password;
 i:= 0;
 caracter:= readkey;
 WHILE caracter <> #13 DO
  BEGIN
   IF caracter <> #8 THEN
   BEGIN
   gotoxy(whereX,whereY);
    IF (whereX <= posX_pass) OR (whereX = posX_pass) THEN
      BEGIN
      write('*');
      i:= i + 1;
      ar_password[i]:= caracter;
      END;
     END
    ELSE
     BEGIN
     gotoxy(whereX - 1, whereY);
     write(' ',#8);
     ar_password[i]:= ' ';
      IF (i >= 1) AND (i <= 10) THEN
       i:= i - 1
      ELSE
       i:= 0;
     END;
    caracter:= readkey;
   END;
  aux:= ' ';
  FOR i:= 1 TO 10 DO
   BEGIN
    password_listo:= concat(aux,ar_password[i]);
    aux:= password_listo;
   END;
  crea_ingresa_password:= password_listo;
 END;

PROCEDURE iniciar_sesion;
VAR
 almacena_usuario,almacena_password: string;
 BEGIN
 reset(archivo_cuentas);
 IF estado_archivo_cuentas = true THEN
  BEGIN
  textcolor(lightred);
  gotoxy(whereX, whereY + 10);
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  gotoxy(whereX + 35, whereY);
  writeln('||//////////////////////////////||');
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  gotoxy(whereX + 35, whereY);
  writeln('|| _-_,  /\\ ,._-_ ,._-_  \\/\\ ||');
  gotoxy(whereX + 35, whereY);
  writeln('||||_.  || ||  ||    ||    || ; ||');
  gotoxy(whereX + 35, whereY);
  writeln('|| ~ || || ||  ||    ||    ||/  ||');
  gotoxy(whereX + 35, whereY);
  writeln('||,-_-  \\,/   \\,   \\,   |/   ||');
  gotoxy(whereX + 35, whereY);
  writeln('||                        (     ||');
  gotoxy(whereX + 35, whereY);
  writeln('||                         -_-  ||');
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  gotoxy(whereX + 35, whereY);
  writeln('||//////////////////////////////||');
  gotoxy(whereX + 35, whereY);
  writeln('==================================');
  gotoxy(whereX + 25, whereY);
  writeln('-----------------------------------------------------');
  gotoxy(whereX + 25, whereY);
  writeln('/////////////////////////////////////////////////////');
  gotoxy(whereX + 25, whereY);
  writeln('No hay usuarios registrados. Intente en otro momento.');
  gotoxy(whereX + 25, whereY);
  writeln('/////////////////////////////////////////////////////');
  gotoxy(whereX + 25, whereY);
  writeln('-----------------------------------------------------');
  writeln();
  gotoxy(whereX + 20, whereY);
  writeln('Se lo regresara al menu de acceso principal automaticamente...');
  delay(2000);
  END
 ELSE
  BEGIN
  textcolor(cyan);
  writeln('---------------------------------------------------');
  writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||');
  writeln('---------------------------------------------------');
  writeln('Ingrese su nombre de usuario <maximo 15 caracteres> : ');
  writeln();
  almacena_usuario:= crea_ingresa_usuario;
  writeln();
  writeln();
  writeln('---------------------------------------------------');
  writeln('Ingrese su password <maximo 10 caracteres> : ');
  almacena_password:= crea_ingresa_password;
  IF busca_usuario_contrasenia(almacena_usuario,almacena_password) = true THEN
   BEGIN
   clrscr;
   mostrar_usuario:= almacena_usuario;
   textcolor(lightgreen);
   writeln();
   gotoxy(whereX, whereY + 10);
   writeln('*********************************************************************************************');
   writeln('=============================================================================================');
   writeln('| Ha ingrasado con exito!. Se lo llevara al menu de Attack On Titan automaticamente. Espere |');
   writeln('=============================================================================================');
   writeln('*********************************************************************************************');
   delay(2000);
   clrscr;
   menu_cargas;
   END
  ELSE
   BEGIN
   clrscr;
   textcolor(lightred);
   writeln();
   gotoxy(whereX, whereY + 10);
   writeln('=================================================================');
   writeln('|///////////////////////////////////////////////////////////////|');
   writeln('=================================================================');
   writeln('| El usuario o password no fue encontrado en el registro,       |');
   writeln('| por lo tanto se lo regresara al menu principal automaticamente| ');
   writeln('=================================================================');
   writeln('|///////////////////////////////////////////////////////////////|');
   writeln('=================================================================');
   delay(2000);
   END;
  END;
 END;

PROCEDURE registrarse;
VAR
 almacena_usuario,almacena_password: string;
 BEGIN
 reset(archivo_cuentas);
 IF estado_archivo_cuentas = true THEN
  BEGIN
   textcolor(cyan);
   writeln('---------------------------------------------------');
   writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||');
   writeln('Cree su nombre de usuario <maximo 15 caracteres> : ');
   writeln();
   registro_cuentas.usuario:= crea_ingresa_usuario;
   writeln();
   writeln();
   writeln('---------------------------------------------------');
   writeln('Cree su password <maximo 10 caracteres> : ');
   writeln();
   registro_cuentas.password:= crea_ingresa_password;
   seek(archivo_cuentas,filesize(archivo_cuentas));
   write(archivo_cuentas,registro_cuentas);
   writeln();
   clrscr;
   textcolor(lightgreen);
   gotoxy(whereX, whereY + 10);
   gotoxy(whereX + 30, whereY);
   writeln('-------------------------------------');
   gotoxy(whereX + 30, whereY);
   writeln('*************************************');
   gotoxy(whereX + 30, whereY);
   writeln('-------------------------------------');
   gotoxy(whereX + 30, whereY);
   writeln('-    Cuenta creada exitosamente     -');
   gotoxy(whereX + 30, whereY);
   writeln('-------------------------------------');
   gotoxy(whereX + 30, whereY);
   writeln('*************************************');
   gotoxy(whereX + 30, whereY);
   writeln('-------------------------------------');
   writeln();
   gotoxy(whereX + 20, whereY);
   writeln('Se lo regresara al menu de acceso principal automaticamente...');
   delay(2000);
  END
 ELSE
  BEGIN
   textcolor(cyan);
   writeln();
   writeln('---------------------------------------------------');
   writeln('|||||||||||||||||||||||||||||||||||||||||||||||||||');
   writeln('Cree su nombre de usuario <maximo 15 caracteres> : ');
   writeln();
   almacena_usuario:= crea_ingresa_usuario;
   writeln();
   IF existe_usuario(almacena_usuario) = true THEN
    BEGIN
    clrscr;
    textcolor(lightred);
    writeln();
    gotoxy(whereX, whereY + 10);
    gotoxy(whereX + 30, whereY);
    writeln('------------------------------------------');
    gotoxy(whereX + 30, whereY);
    writeln('//////////////////////////////////////////');
    gotoxy(whereX + 30, whereY);
    writeln('Este usuario ya existe en nuestro registro');
    gotoxy(whereX + 30, whereY);
    writeln('//////////////////////////////////////////');
    gotoxy(whereX + 30, whereY);
    writeln('------------------------------------------');
    writeln();
    gotoxy(whereX + 20, whereY);
    writeln('Se lo regresara al menu de acceso principal automaticamente...');
    delay(2000);
    END
   ELSE
    BEGIN
    writeln();
    writeln();
    writeln('---------------------------------------------------');
    writeln('Cree su password <maximo 10 caracteres> : ');
    writeln();
    almacena_password:= crea_ingresa_password;
    IF existe_password(almacena_password) = true THEN
     BEGIN
     textcolor(lightred);
     clrscr;
     writeln();
     gotoxy(whereX, whereY + 10);
     gotoxy(whereX + 30, whereY);
     writeln('-------------------------------------------');
     gotoxy(whereX + 30, whereY);
     writeln('///////////////////////////////////////////');
     gotoxy(whereX + 30, whereY);
     writeln('Este password ya existe en nuestro registro');
     gotoxy(whereX + 30, whereY);
     writeln('///////////////////////////////////////////');
     gotoxy(whereX + 30, whereY);
     writeln('-------------------------------------------');
     writeln();
     gotoxy(whereX + 20, whereY);
     writeln('Se lo regresara al menu de acceso principal automaticamente...');
     delay(2000);
     END
    ELSE
     BEGIN
     registro_cuentas.usuario:= almacena_usuario;
     registro_cuentas.password:= almacena_password;
     seek(archivo_cuentas,filesize(archivo_cuentas));
     write(archivo_cuentas,registro_cuentas);
     clrscr;
     textcolor(lightgreen);
     gotoxy(whereX, whereY + 10);
     gotoxy(whereX + 30, whereY);
     writeln('-------------------------------------');
     gotoxy(whereX + 30, whereY);
     writeln('*************************************');
     gotoxy(whereX + 30, whereY);
     writeln('-------------------------------------');
     gotoxy(whereX + 30, whereY);
     writeln('-    Cuenta creada exitosamente     -');
     gotoxy(whereX + 30, whereY);
     writeln('-------------------------------------');
     gotoxy(whereX + 30, whereY);
     writeln('*************************************');
     gotoxy(whereX + 30, whereY);
     writeln('-------------------------------------');
     writeln();
     gotoxy(whereX + 20, whereY);
     writeln('Se lo regresara al menu de acceso principal automaticamente...');
     delay(2000);
     END;
    END;
  END;
 close(archivo_cuentas);
 END;

PROCEDURE pantalla_carga;
VAR
 i: integer;
 BEGIN
 i:= 0;
 REPEAT
 clrscr;
 textcolor(brown);
 i:= i + 1;
 gotoxy(whereX, whereY + 10);
 delay(30);
 gotoxy(whereX + 25, whereY);
 writeln('=====================================================');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('||                                    |\          ||');
 delay(30);
  gotoxy(whereX + 25, whereY);
 writeln('||       _           _     _           \\         ||');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('|| _-_  < \, ,._-_  / \\  < \, \\/\\  / \\  /\\   ||');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('|| ||    /-||  ||   || ||  /-|| || || || || || || ||');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('|| ||   (( ||  ||   || || (( || || || || || || || ||');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('|| \\,/  \/\\  \\,  \\_-|  \/\\ \\ \\  \\/  \\,/  ||');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('||                  /  \                          ||');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('||                 <---->                         ||');
 delay(30);
 gotoxy(whereX + 25,  whereY);
 writeln('====================================================');
 Delay(30);
 UNTIL (i = 5);
 END;

PROCEDURE pantalla_despedir_usuario;
VAR
 i: integer;
 BEGIN
 i:= 0;
 REPEAT
  clrscr;
  i:= i + 1;
  textcolor(brown);
  gotoxy(whereX, whereY + 10);
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('===================================================');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('===================================================');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*| _-_,  _-_   _-_         \\/\\  /\\ \\ \\    |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|||_.  || \\ || \\        || ;  || || || ||   |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*| ~ || ||/   ||/          ||/   || || || ||   |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|,-_-  \\,/  \\,/         |/    \\,/  \\/\\   |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|                        (                    |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|                         -_-                 |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|                                             |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|                                             |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|                                             |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|        _-_,  /\\   /\\ \\/\\                |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|       ||_.  || || || || || ||               |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|        ~ || || || || || || ||               |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|       ,-_-  \\,/  \\,/  \\ \\               |*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('===================================================');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|*|');
  delay(30);
  gotoxy(whereX + 25,  whereY);
  writeln('===================================================');
 UNTIL ( i = 5);
 END;

PROCEDURE acceso_principal;
VAR
   opcion: integer;
   BEGIN
    REPEAT
     clrscr;
     textcolor(green);
     gotoxy(whereX, whereY + 10);
     gotoxy(whereX + 25, whereY);
     writeln('================================================');
     gotoxy(whereX + 25, whereY);
     writeln('||////////////////////////////////////////////||');
     gotoxy(whereX + 25, whereY);
     writeln('================================================');
     gotoxy(whereX + 25, whereY);
     writeln('||  _                                         ||');
     gotoxy(whereX + 25, whereY);
     writeln('|| - - /, /,       ,,                         ||');
     gotoxy(whereX + 25, whereY);
     writeln('||  )/ )/ )       ||                          ||');
     gotoxy(whereX + 25, whereY);
     writeln('||  )__)__)  _-_  ||  _-_  /\\ \\/\\/\\  _-_  ||');
     gotoxy(whereX + 25, whereY);
     writeln('|| ~)__)__) || \\ || ||   || || || || || || \\||');
     gotoxy(whereX + 25, whereY);
     writeln('||  )  )  ) ||/   || ||   || || || || || ||/  ||');
     gotoxy(whereX + 25, whereY);
     writeln('|| /-_/-_/  \\,/  \\ \\,/ \\,/  \\ \\ \\ \\,/ ||');
     gotoxy(whereX + 25, whereY);
     writeln('================================================');
     gotoxy(whereX + 25, whereY);
     writeln('||////////////////////////////////////////////||');
     gotoxy(whereX + 25, whereY);
     writeln('================================================');
     writeln();
     gotoxy(whereX + 40, whereY);
     writeln('----------------');
     gotoxy(whereX + 40, whereY);
     writeln('Acceso Principal');
     gotoxy(whereX + 40, whereY);
     writeln('----------------');
     writeln();
     gotoxy(whereX + 35, whereY);
     writeln('--------------------------');
     gotoxy(whereX + 35, whereY);
     writeln('|1| - Iniciar sesion - |1|');
     gotoxy(whereX + 35, whereY);
     writeln('--------------------------');
     gotoxy(whereX + 35, whereY);
     writeln('|2| -  Registrarse   - |2|');
     gotoxy(whereX + 35, whereY);
     writeln('--------------------------');
     gotoxy(whereX + 35, whereY);
     writeln('|3| -      Salir     - |3|');
     gotoxy(whereX + 35, whereY);
     writeln('--------------------------');
     writeln();
     gotoxy(whereX + 35, whereY);
     writeln('---------------------------');
     gotoxy(whereX + 35, whereY);
     write('Seleccion opcion (1, 2 o 3): ');
     readln(opcion);
     CASE opcion OF
      1:BEGIN
        clrscr;
        iniciar_sesion;
        END;
      2:BEGIN
        clrscr;
        registrarse;
        END;
      END;
    UNTIL (opcion = 3);
    clrscr;
    pantalla_despedir_usuario
   END;

BEGIN
assign(archivo_personaje,'C:\Users\JULIO\Desktop\SOFTWARE PROJECTS\Proyectos Personales\2. Attack On Titan Software\personaje.dat');
assign(archivo_temporada,'C:\Users\JULIO\Desktop\SOFTWARE PROJECTS\Proyectos Personales\2. Attack On Titan Software\temporada.dat');
assign(archivo_preguntas_respuestas,'C:\Users\JULIO\Desktop\SOFTWARE PROJECTS\Proyectos Personales\2. Attack On Titan Software\preguntas_respuestas.dat');
assign(archivo_cuentas,'C:\Users\JULIO\Desktop\SOFTWARE PROJECTS\Proyectos Personales\2. Attack On Titan Software\cuentas.dat');
assign(archivo_respuesta_correcta,'C:\Users\JULIO\Desktop\SOFTWARE PROJECTS\Proyectos Personales\2. Attack On Titan Software\respuesta_correcta.dat');
assign(archivo_jugador_score,'C:\Users\JULIO\Desktop\SOFTWARE PROJECTS\Proyectos Personales\2. Attack On Titan Software\jugador_score.dat');
crear_archivo_personaje;
crear_archivo_temporada;
crear_archivo_preguntas_respuestas;
crear_archivo_cuentas;
crear_archivo_respuesta_correcta;
crear_archivo_jugador_score;
pantalla_carga;
acceso_principal;
END.

