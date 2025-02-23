class UpdateSessionCommand {
  final String id;
  final String notes;
  final DateTime? startDate;
  final DateTime? endDate;

  UpdateSessionCommand({
    required this.id,
    required this.notes,
    this.startDate,
    this.endDate,
  });
}
