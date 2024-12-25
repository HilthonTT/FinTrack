String? getImagePath(int company) {
  switch (company) {
    case 0: // Google logo
      return 'assets/images/google_logo.png';
    case 1: // Netflix
      return 'assets/images/netflix_logo.png';
    case 2: // Amazon Prime
      return 'assets/images/amazon_logo.png';
    case 3: // Spotify
      return 'assets/images/spotify_logo.png';
    case 4: // Disney Plus
      return 'assets/images/disney_logo.png';
    case 5: // Apple
      return 'assets/images/apple_logo.png';
    case 6: // Hulu
      return 'assets/images/hulu_logo.png';
    case 7: // YouTube Premium
      return 'assets/images/youtube_logo.png';
    case 8: // Microsoft
      return 'assets/images/microsoft_logo.png';
    case 9: // Dropbox
      return 'assets/images/dropbox_logo.png';
    case 10:
    default:
      return null;
  }
}
