module {
  func.func @main(%arg0: i64) -> i64 attributes {seed = 49 : index} {
    %c3220996587549851491_i64 = arith.constant 3220996587549851491 : i64
    %0 = arith.floordivsi %c3220996587549851491_i64, %arg0 : i64
    %1 = arith.shrui %0, %0 : i64
    %2 = arith.ceildivsi %1, %arg0 : i64
    %3 = arith.minui %2, %1 : i64
    %4 = arith.ori %3, %0 : i64
    return %4 : i64
  }
}
