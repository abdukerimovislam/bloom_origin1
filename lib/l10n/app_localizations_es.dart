// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get trackYourCycle => 'Sigue tu ciclo';

  @override
  String lastPeriod(Object date) {
    return 'Último período: $date';
  }

  @override
  String get noData => 'Aún no hay datos. ¡Registra tu primer ciclo!';

  @override
  String get avatarStateResting => 'Descansando...';

  @override
  String get avatarStateActive => '¡Activa!';

  @override
  String get calendarTitle => 'Calendario de ciclo';

  @override
  String get save => 'Guardar';

  @override
  String get tapToLogPeriod => 'Toca un día para registrarlo o anularlo';

  @override
  String get logSymptomsButton => '¿Cómo te sientes hoy?';

  @override
  String get symptomsTitle => 'Síntomas de hoy';

  @override
  String get symptomCramps => 'Calambres';

  @override
  String get symptomHeadache => 'Dolor de cabeza';

  @override
  String get symptomNausea => 'Náuseas';

  @override
  String get moodHappy => 'Feliz';

  @override
  String get moodSad => 'Triste';

  @override
  String get moodIrritable => 'Irritable';

  @override
  String get noSymptomsLogged => 'No hay síntomas registrados para hoy.';

  @override
  String get predictionsTitle => 'Predicciones';

  @override
  String nextPeriodPrediction(Object days) {
    return 'Próximo período en ~$days días';
  }

  @override
  String nextPeriodDate(Object date) {
    return 'Cerca de $date';
  }

  @override
  String get fertileWindow => 'Ventana Fértil';

  @override
  String get ovulation => 'Ovulación';

  @override
  String cycleLength(Object days) {
    return 'Ciclo prom.: $days días';
  }

  @override
  String periodLength(Object days) {
    return 'Período prom.: $days días';
  }

  @override
  String get notEnoughData => 'Registra 2+ ciclos para ver predicciones.';

  @override
  String get calendarLegendPeriod => 'Tu Período';

  @override
  String get calendarLegendPredicted => 'Período Previsto';

  @override
  String get calendarLegendFertile => 'Ventana Fértil';

  @override
  String get welcomeTitle => '¡Bienvenida a Bloom!';

  @override
  String get welcomeDesc =>
      'Tu compañero de ciclo personal. Vamos a configurarlo.';

  @override
  String get questionPeriodTitle => '¿Cuándo empezó tu último período?';

  @override
  String get questionPeriodDesc =>
      'Puedes registrarlo en el calendario. ¡Si no te acuerdas, no pasa nada!';

  @override
  String get questionLengthTitle => '¿Cuál es la duración media de tu ciclo?';

  @override
  String get questionLengthDesc =>
      'Es el tiempo desde el inicio de un período hasta el siguiente. (Por defecto 28 días)';

  @override
  String get skip => 'Omitir';

  @override
  String get done => 'Hecho';

  @override
  String get pickADate => 'Elige una fecha';

  @override
  String get days => 'días';

  @override
  String get settingsTitle => 'Ajustes';

  @override
  String get settingsNotifications => 'Notificaciones';

  @override
  String get settingsNotificationsDesc => 'Mostrar alertas de predicciones';

  @override
  String get settingsLanguage => 'Idioma';

  @override
  String get settingsSupport => 'Soporte';

  @override
  String get settingsSupportDesc => 'Informar de un error o hacer una pregunta';

  @override
  String get notificationPeriodTitle => '¡Aviso de Bloom!';

  @override
  String notificationPeriodBody(Object days) {
    return 'Se predice que tu período comenzará en $days días.';
  }

  @override
  String get notificationFertileTitle => '¡Aviso de Bloom!';

  @override
  String get notificationFertileBody =>
      'Se predice que tu ventana fértil comenzará mañana.';

  @override
  String get logPeriodStartButton => 'El período comenzó hoy';

  @override
  String get logPeriodEndButton => 'El período terminó hoy';

  @override
  String periodIsActive(Object day) {
    return 'Estás en el día $day de tu período';
  }

  @override
  String periodDelayed(Object days) {
    return 'Período retrasado $days días';
  }

  @override
  String get avatarStateDelayed => 'Esperando...';

  @override
  String get avatarStateFollicular => '¡La energía regresa!';

  @override
  String get avatarStateOvulation => '¡Pico de energía!';

  @override
  String get avatarStateLuteal => 'Tiempo para descansar';

  @override
  String get insightNone =>
      '¡Registra tu primer ciclo en el calendario para empezar a ver consejos!';

  @override
  String get insightMenstruation_1 =>
      '¡Tiempo de comodidad! Tu energía está al mínimo, está bien. Recuerda descansar, ver tu serie favorita y tal vez comer esa barra de chocolate. 🍫';

  @override
  String get insightMenstruation_2 =>
      'Tu cuerpo está trabajando duro. ¡Escúchalo! Un estiramiento suave o un baño tibio pueden hacer maravillas.';

  @override
  String get insightMenstruation_3 =>
      'Es normal sentirse cansada. Tus hormonas están en su punto más bajo. Prioriza el sueño y la hidratación hoy.';

  @override
  String get insightFollicular_1 =>
      '¡La energía regresa! El estrógeno está subiendo. Gran día para hacer planes o hacer ese ejercicio que has estado posponiendo.';

  @override
  String get insightFollicular_2 =>
      'Tu mente se está aclarando. Es un buen momento para aprender algo nuevo o abordar un problema difícil.';

  @override
  String get insightFollicular_3 =>
      '¡Ánimo arriba! A medida que termina tu período, puedes sentirte más positiva y sociable. ¡Disfrútalo!';

  @override
  String get insightOvulation_1 =>
      '¡Estás en tu apogeo! 🌟 Hoy es tu día para brillar. La confianza y la energía están al máximo. Momento perfecto para tareas desafiantes o socializar.';

  @override
  String get insightOvulation_2 =>
      'Puedes sentirte extra segura hoy. ¡Es el pico de estrógeno! Un gran día para dar tu opinión o liderar un proyecto.';

  @override
  String get insightOvulation_3 =>
      '¡Pico de energía! Tu cuerpo está listo para ejercicio más intenso si te apetece. También puedes sentirte más conectada con los demás.';

  @override
  String get insightLuteal_1 =>
      'Puedes sentirte un poco irritable o cansada, culpa a la progesterona. Esto se llama SPM. Sé más amable contigo misma, ahora es el momento del autocuidado.';

  @override
  String get insightLuteal_2 =>
      '¿Antojos de comida? Es normal. Tu cuerpo está quemando más calorías. Opta por carbohidratos complejos o chocolate negro para mantener el equilibrio.';

  @override
  String get insightLuteal_3 =>
      '¿Te sientes un poco hinchada o sensible? Es la fase lútea. Intenta reducir la sal y bebe más agua. ¡Ayuda!';

  @override
  String get insightDelayed_1 =>
      '¿Retraso del período? Las pequeñas fluctuaciones son normales, el estrés o los cambios en la rutina pueden ser la causa. Solo mantén un registro.';

  @override
  String get insightDelayed_2 =>
      'Esperando... Es común tener un retraso de uno o dos días. Intenta relajarte, dormir bien y ver qué pasa mañana.';

  @override
  String get insightDelayed_3 =>
      'Tu cuerpo tiene su propio ritmo. Un período tardío puede ocurrir por muchas razones. Si estás preocupada, siempre puedes hablar con un adulto de confianza.';

  @override
  String get settingsTheme => 'Tema de la aplicación';

  @override
  String get themeRose => 'Rosa Suave';

  @override
  String get themeNight => 'Noche de Luna';

  @override
  String get themeForest => 'Calma del Bosque';
}
