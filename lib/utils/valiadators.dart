class FieldValidator {
  static String validateBlank(String value) {
    print("value : $value ");
    if (value.isEmpty) return "Field is required";
    return null;
  }
}
