class TopArtists {
  TopArtists({
    required this.artists,
  });

  Artists artists;
}

class Artists {
  Artists({
    required this.artist,
    required this.attr,
  });

  List<Artist> artist;
  Attr attr;
}

class Artist {
  Artist({
    required this.name,
    required this.playcount,
    required this.listeners,
    required this.mbid,
    required this.url,
    required this.streamable,
    required this.image,
  });

  String name;
  String playcount;
  String listeners;
  String mbid;
  String url;
  String streamable;
  List<Image> image;
}

class Image {
  Image({
    required this.text,
    required this.size,
  });

  String text;
  Size size;
}

enum Size { SMALL, MEDIUM, LARGE, EXTRALARGE, MEGA }

class Attr {
  Attr({
    required this.page,
    required this.perPage,
    required this.totalPages,
    required this.total,
  });

  String page;
  String perPage;
  String totalPages;
  String total;
}
