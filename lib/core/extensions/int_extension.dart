extension X on int? {
  getValue() {
    if (this != null) {
      return toString();
    }
    return "0";
  }
}

extension Y on double? {
  getValue() {
    if (this != null) {
      return toString();
    }
    return "0";
  }
}

extension Z on String? {
  getValue() {
    if (this != null) {
      return toString();
    }
    return "";
  }
}
