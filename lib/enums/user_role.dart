enum UserRole { admin, teacher, student }

extension UserRoleExtension on UserRole {
  String get name {
    switch (this) {
      case UserRole.admin:
        return "Admin";
      case UserRole.teacher:
        return "Teacher";
      case UserRole.student:
        return "Student";
    }
  }
}
