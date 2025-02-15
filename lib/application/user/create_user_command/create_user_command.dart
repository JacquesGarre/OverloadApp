class CreateUserCommand {
  final String username;
  final int age;
  final num weight;
  final String gender;

  CreateUserCommand({
    required this.username,
    required this.age,
    required this.weight,
    required this.gender,
  });
}
