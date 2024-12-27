import 'package:fintrack_app/features/settings/domain/enums/security_option.dart';
import 'package:fintrack_app/features/settings/domain/enums/sorting_option.dart';

class Settings {
  final SecurityOption securityOption;
  final SortingOption sortingOption;
  final String currency;

  const Settings({
    required this.securityOption,
    required this.sortingOption,
    required this.currency,
  });
}
