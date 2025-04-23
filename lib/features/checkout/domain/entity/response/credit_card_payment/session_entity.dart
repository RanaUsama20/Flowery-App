


class SessionEntity {
  final String id;
  final String object;
  final int amount_subtotal;
  final int amount_total;
  final String currency;
  final String status;
  final String payment_status;
  final String? customer_email;
  final String url;

  SessionEntity({
    required this.id,
    required this.object,
    required this.amount_subtotal,
    required this.amount_total,
    required this.currency,
    required this.status,
    required this.payment_status,
    this.customer_email,
    required this.url,
  });


}