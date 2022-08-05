String normalizeHex(String hex) {
  hex.replaceAll('#', '');
  if (hex.length == 3) {
    return '${hex[0]}${hex[0]}${hex[1]}${hex[1]}${hex[2]}${hex[2]}';
  } else if (hex.length == 6) {
    return hex;
  } else {
    throw 'Invalid hex value: $hex';
  }
}
