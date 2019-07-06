class Repo {
  String author;
  String name;
  String avatar;
  String url;
  String description;
  String language;
  String languageColor;
  int stars;
  int forks;
  int currentPeriodStars;
  List<BuiltBy> builtBy;

  Repo({
    this.author,
    this.name,
    this.avatar,
    this.url,
    this.description,
    this.language,
    this.languageColor,
    this.stars,
    this.forks,
    this.currentPeriodStars,
    this.builtBy,
  });

  factory Repo.fromJson(Map<String, dynamic> json) => new Repo(
    author: json["author"],
    name: json["name"],
    avatar: json["avatar"],
    url: json["url"],
    description: json["description"],
    language: json["language"],
    languageColor: json["languageColor"],
    stars: json["stars"],
    forks: json["forks"],
    currentPeriodStars: json["currentPeriodStars"],
    builtBy: new List<BuiltBy>.from(json["builtBy"].map((x) => BuiltBy.fromJson(x))),
  );
}

class BuiltBy {
  String href;
  String avatar;
  String username;

  BuiltBy({
    this.href,
    this.avatar,
    this.username,
  });

  factory BuiltBy.fromJson(Map<String, dynamic> json) => new BuiltBy(
    href: json["href"],
    avatar: json["avatar"],
    username: json["username"],
  );
}
