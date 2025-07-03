class RestObject {
  final String id;
  final String name;
  final Map<String, dynamic> data;
  final String imageUrl;

  RestObject({
    required this.id,
    required this.name,
    required this.data,
    required this.imageUrl,
  });

  factory RestObject.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    final safeData = rawData is Map<String, dynamic> ? rawData : <String, dynamic>{};
    return RestObject(
      id: json['id'].toString(),
      name: json['name'] ?? 'Unknown',
      data: safeData,
      imageUrl: '', // Will be updated later
    );
  }

  RestObject copyWith({
    String? id,
    String? name,
    Map<String, dynamic>? data,
    String? imageUrl,
  }) {
    return RestObject(
      id: id ?? this.id,
      name: name ?? this.name,
      data: data ?? this.data,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
