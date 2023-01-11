class MenuItem {
  MenuItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.link,
  });

  String id;
  String title;
  String icon;
  String link;

  factory MenuItem.fromMap(Map<String, dynamic> json) => MenuItem(
        id: json["_id"],
        title: json["title"],
        icon: json["icon"],
        link: json["link"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "icon": icon,
        "link": link,
      };

  factory MenuItem.empty() => MenuItem(
        id: "_",
        title: "",
        icon: "",
        link: "",
      );
}
