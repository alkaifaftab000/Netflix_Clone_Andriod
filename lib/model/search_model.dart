class Show {
  final double? id;
  final String url;
  final String name;
  final String type;
  final String language;
  final List<String> genres;
  final String status;
  final double? runtime;
  final double? averageRuntime;
  final String premiered;
  final String? ended;
  final String? officialSite;
  final Schedule schedule;
  final Rating? rating;
  final double? weight;
  final Network? network;
  final dynamic webChannel;
  final dynamic dvdCountry;
  final Externals externals;
  final Image? image;
  final String summary;
  final double? updated;

  Show({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.language,
    required this.genres,
    required this.status,
    required this.runtime,
    required this.averageRuntime,
    required this.premiered,
    this.ended,
    this.officialSite,
    required this.schedule,
    this.rating,
    required this.weight,
    this.network,
    this.webChannel,
    this.dvdCountry,
    required this.externals,
    this.image,
    required this.summary,
    required this.updated,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
    id: (json['id'] as num?)?.toDouble() ?? 0.0,
    url: json['url'] ?? '',
    name: json['name'] ?? '',
    type: json['type'] ?? '',
    language: json['language'] ?? '',
    genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
    status: json['status'] ?? '',
    runtime: (json['runtime'] as num?)?.toDouble() ?? 0.0,
    averageRuntime: (json['averageRuntime'] as num?)?.toDouble() ?? 0.0,
    premiered: json['premiered'] ?? '',
    ended: json['ended'],
    officialSite: json['officialSite'],
    schedule: json['schedule'] is Map<String, dynamic>
        ? Schedule.fromJson(json['schedule'])
        : Schedule(time: '', days: []),
    rating: json['rating'] is Map<String, dynamic> && json['rating']['average'] != null
        ? Rating((json['rating']['average'] as num?)?.toDouble())
        : null,
    weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
    network: json['network'] is Map<String, dynamic>
        ? Network.fromJson(json['network'])
        : null,
    webChannel: json['webChannel'],
    dvdCountry: json['dvdCountry'],
    externals: json['externals'] is Map<String, dynamic>
        ? Externals.fromJson(json['externals'])
        : Externals(),
    image: json['image'] is Map<String, dynamic>
        ? Image.fromJson(json['image'])
        : null,
    summary: json['summary'] ?? '',
    updated: (json['updated'] as num?)?.toDouble() ?? 0.0,
  );
}

class Schedule {
  final String time;
  final List<String> days;

  Schedule({
    required this.time,
    required this.days,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    time: json['time'] ?? '',
    days: json['days'] != null ? List<String>.from(json['days']) : [],
  );
}

class Rating {
  final double? average;

  Rating(this.average);
}

class Network {
  final double? id;
  final String name;
  final Country? country;
  final String? officialSite;

  Network({
    required this.id,
    required this.name,
    this.country,
    this.officialSite,
  });

  factory Network.fromJson(Map<String, dynamic> json) => Network(
    id: (json['id'] as num?)?.toDouble() ?? 0.0,
    name: json['name'] ?? '',
    country: json['country'] is Map<String, dynamic>
        ? Country.fromJson(json['country'])
        : null,
    officialSite: json['officialSite'],
  );
}

class Country {
  final String name;
  final String code;
  final String timezone;

  Country({
    required this.name,
    required this.code,
    required this.timezone,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    name: json['name'] ?? '',
    code: json['code'] ?? '',
    timezone: json['timezone'] ?? '',
  );
}

class Externals {
  final dynamic tvrage;
  final dynamic thetvdb;
  final String? imdb;

  Externals({
    this.tvrage,
    this.thetvdb,
    this.imdb,
  });

  factory Externals.fromJson(Map<String, dynamic> json) => Externals(
    tvrage: json['tvrage'],
    thetvdb: json['thetvdb'],
    imdb: json['imdb'],
  );
}

class Image {
  final String medium;
  final String? original;

  Image({
    required this.medium,
    required this.original,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    medium: json['medium'] ?? '',
    original: json['original'] ?? 'https://th.bing.com/th/id/OIP.nGagK8mwO46xtXvHXjcJbwHaD4?rs=1&pid=ImgDetMain',
  );
}
