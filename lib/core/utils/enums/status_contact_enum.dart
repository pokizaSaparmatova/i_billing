enum StatusContactEnum{
  first(name: "Paid"),
  second(name: "In process"),
  third(name:"Rejected by Payme"),
  fourth(name: "Rejected by IQ");

  final String name;
  const StatusContactEnum({required this.name});
}