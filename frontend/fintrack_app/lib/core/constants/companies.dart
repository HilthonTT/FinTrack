import 'package:fintrack_app/core/common/utils/image_path.dart';
import 'package:fintrack_app/core/enums/company.dart';

final List<Map<String, dynamic>> companies = [
  {
    "id": 1,
    "name": "Google",
    "icon": getImagePath(Company.google),
  },
  {
    "id": 2,
    "name": "Netflix",
    "icon": getImagePath(Company.netflix),
  },
  {
    "id": 3,
    "name": "Amazon Prime",
    "icon": getImagePath(Company.amazonPrime),
  },
  {
    "id": 4,
    "name": "Spotify",
    "icon": getImagePath(Company.spotify),
  },
  {
    "id": 5,
    "name": "Disney+",
    "icon": getImagePath(Company.disneyPlus),
  },
  {
    "id": 6,
    "name": "Apple",
    "icon": getImagePath(Company.apple),
  },
  {
    "id": 7,
    "name": "Hulu",
    "icon": getImagePath(Company.hulu),
  },
  {
    "id": 8,
    "name": "YouTube Premium",
    "icon": getImagePath(Company.youTubePremium),
  },
  {
    "id": 9,
    "name": "Microsoft",
    "icon": getImagePath(Company.microsoft),
  },
  {
    "id": 10,
    "name": "Dropbox",
    "icon": getImagePath(Company.dropbox),
  },
  {
    "id": 11,
    "name": "None",
    "icon": getImagePath(Company.none),
  }
];
