module {
  func.func @main() -> i64 attributes {seed = 38 : index} {
    %c6184929394769412034_i64 = arith.constant 6184929394769412034 : i64
    %c1248357989847357726_i64 = arith.constant 1248357989847357726 : i64
    %0 = arith.muli %c6184929394769412034_i64, %c1248357989847357726_i64 : i64
    return %0 : i64
  }
}
