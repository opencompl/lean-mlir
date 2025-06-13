module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 124 : index} {
    %c-861827906971256433_i64 = arith.constant -861827906971256433 : i64
    %c4587139437073004161_i64 = arith.constant 4587139437073004161 : i64
    %0 = arith.ceildivsi %c4587139437073004161_i64, %arg0 : i64
    %1 = arith.remui %c-861827906971256433_i64, %0 : i64
    return %1 : i64
  }
}
