import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class LanguageCubit extends Cubit<Locale?> {
  LanguageCubit(this.context) : super(null) {
    load(context);
  }

  final BuildContext context;

  void load(BuildContext context) async {
    Locale locale = Localizations.localeOf(context);
    emit(locale);
  }

  void change(Locale locale) {
    emit(locale);
  }
}
