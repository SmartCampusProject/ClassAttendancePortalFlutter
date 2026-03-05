enum UserRole {
  admin("Admin"),
  student("Student"),
  teacher("Teacher");

  final String name;

  const UserRole(this.name);

  @override
  String toString() => name;
}
