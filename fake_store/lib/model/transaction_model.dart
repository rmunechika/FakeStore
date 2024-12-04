class Transaction {
  final String id;
  final String userName;
  final String email;
  final double totalPayment;
  final DateTime dateTime;

  Transaction({
    required this.id,
    required this.userName,
    required this.email,
    required this.totalPayment,
    required this.dateTime,
  });
}
