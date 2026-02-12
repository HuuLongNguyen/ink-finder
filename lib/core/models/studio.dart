class Studio {
  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewsCount;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final bool isPremium;
  final int startingPrice;
  final String phone;
  final String zaloId;

  Studio({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewsCount,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    this.isPremium = false,
    this.startingPrice = 500000,
    required this.phone,
    required this.zaloId,
  });

  factory Studio.fromJson(Map<String, dynamic> json) {
    return Studio(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewsCount: json['reviews_count'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      isPremium: json['is_premium'] ?? false,
      startingPrice: json['starting_price'] ?? 500000,
      phone: json['phone'] ?? '',
      zaloId: json['zalo_id'] ?? '',
    );
  }
}

class TattooStyle {
  final String id;
  final String name;
  final String imageUrl;

  TattooStyle({required this.id, required this.name, required this.imageUrl});
}

// Mock Data
final List<TattooStyle> mockStyles = [
  TattooStyle(id: '1', name: 'Traditional', imageUrl: 'https://images.unsplash.com/photo-1598371839696-5c5bb00bdc28?q=80&w=2671&auto=format&fit=crop'),
  TattooStyle(id: '2', name: 'Blackwork', imageUrl: 'https://images.unsplash.com/photo-1611501275019-9b5cda974a42?q=80&w=2574&auto=format&fit=crop'),
  TattooStyle(id: '3', name: 'Realism', imageUrl: 'https://images.unsplash.com/photo-1562962230-16e4623d36e6?q=80&w=2574&auto=format&fit=crop'),
  TattooStyle(id: '4', name: 'Japanese', imageUrl: 'https://images.unsplash.com/photo-1560707303-4e9803d16649?q=80&w=2669&auto=format&fit=crop'),
];

final List<Studio> mockStudios = [
  Studio(
    id: '1',
    name: 'Dragon Ink Saigon',
    address: '123 Bui Vien, District 1, HCMC',
    rating: 4.8,
    reviewsCount: 124,
    imageUrl: 'https://images.unsplash.com/photo-1590247813693-5541d1c609fd?q=80&w=2609&auto=format&fit=crop',
    latitude: 10.768451,
    longitude: 106.6943626,
    isPremium: true,
    phone: '0901234567',
    zaloId: 'dragon_ink_saigon',
  ),
  Studio(
    id: '2',
    name: 'Black Pearl Tattoo',
    address: '45 Thao Dien, District 2, HCMC',
    rating: 4.5,
    reviewsCount: 89,
    imageUrl: 'https://images.unsplash.com/photo-1536059540012-f2ed455f2291?q=80&w=2574&auto=format&fit=crop',
    latitude: 10.800000,
    longitude: 106.733333,
    phone: '0909876543',
    zaloId: 'black_pearl',
  ),
];
