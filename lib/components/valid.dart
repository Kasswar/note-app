validInput(String val, int min, int max) {
  if (val.length > max) {
    return "لا يجب أن يكون أكبر من $max";
  }else if (val.isEmpty) {
    return "لا يجب أن يكون فارغ";
  }else if (val.length < min) {
    return "لا يجب أن يكون أصغر من $min";
  }
}
