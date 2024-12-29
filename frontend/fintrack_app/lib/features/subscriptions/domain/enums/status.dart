enum Status {
  active(0),
  canceled(1),
  expired(2);

  final int value;
  const Status(this.value);
}
