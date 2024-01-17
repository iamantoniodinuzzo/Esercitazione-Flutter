enum MediaType {
  movie;

  MediaType fromValue(String value) {
    return MediaType.values.byName(value);
  }
}
