module {
  func.func @main() -> i64 attributes {seed = 183 : index} {
    %c-7139959042225150780_i64 = arith.constant -7139959042225150780 : i64
    %c-5533462602492950974_i64 = arith.constant -5533462602492950974 : i64
    %0 = arith.maxui %c-7139959042225150780_i64, %c-5533462602492950974_i64 : i64
    %1 = arith.divui %0, %0 : i64
    return %1 : i64
  }
}
