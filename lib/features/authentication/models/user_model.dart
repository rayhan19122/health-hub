/// HealthHub — User Model
///
/// Represents a user in the system with role-based access.
enum UserRole { patient, hospitalAdmin, superAdmin }

class UserModel {
  const UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.role,
    this.email,
    this.avatarUrl,
    this.hospitalId,
  });

  final String uid;
  final String name;
  final String phone;
  final UserRole role;
  final String? email;
  final String? avatarUrl;
  final String? hospitalId; // For hospital admins

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'U';
  }

  String get roleName {
    switch (role) {
      case UserRole.patient:
        return 'Patient';
      case UserRole.hospitalAdmin:
        return 'Hospital Admin';
      case UserRole.superAdmin:
        return 'Super Admin';
    }
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? phone,
    UserRole? role,
    String? email,
    String? avatarUrl,
    String? hospitalId,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      hospitalId: hospitalId ?? this.hospitalId,
    );
  }

  /// Creates from Firestore document
  factory UserModel.fromMap(Map<String, dynamic> map, String uid) {
    return UserModel(
      uid: uid,
      name: map['name'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      role: UserRole.values.firstWhere(
        (r) => r.name == (map['role'] as String?),
        orElse: () => UserRole.patient,
      ),
      email: map['email'] as String?,
      avatarUrl: map['avatarUrl'] as String?,
      hospitalId: map['hospitalId'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'phone': phone,
        'role': role.name,
        'email': email,
        'avatarUrl': avatarUrl,
        'hospitalId': hospitalId,
      };
}
