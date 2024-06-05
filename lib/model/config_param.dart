class Params {
  final int id;
  final String url;

  // constructor
  const Params({required this.id, required this.url});

  // map
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'url': url,
    };
  }

  //override
  @override
  String toString() {
    return 'Params{id: $id, url: $url}';
  }
}
