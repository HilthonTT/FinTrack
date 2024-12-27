enum SecurityOption {
  faceId(0),
  pin(1),
  password(2);

  final int value;
  const SecurityOption(this.value);
}
