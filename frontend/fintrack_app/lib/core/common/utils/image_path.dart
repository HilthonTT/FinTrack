import 'package:fintrack_app/core/enums/company.dart';

String? getImagePath(Company company) {
  switch (company) {
    case Company.google: // Google logo
      return 'assets/images/google_logo.png';
    case Company.netflix: // Netflix
      return 'assets/images/netflix_logo.png';
    case Company.amazonPrime: // Amazon Prime
      return 'assets/images/amazon_logo.png';
    case Company.spotify: // Spotify
      return 'assets/images/spotify_logo.png';
    case Company.disneyPlus: // Disney Plus
      return 'assets/images/disney_logo.png';
    case Company.apple: // Apple
      return 'assets/images/apple_logo.png';
    case Company.hulu: // Hulu
      return 'assets/images/hulu_logo.png';
    case Company.youTubePremium: // YouTube Premium
      return 'assets/images/youtube_logo.png';
    case Company.microsoft: // Microsoft
      return 'assets/images/microsoft_logo.png';
    case Company.dropbox: // Dropbox
      return 'assets/images/dropbox_logo.png';
    case Company.none:
      return null;
  }
}
