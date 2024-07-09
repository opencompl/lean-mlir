module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i1)
  llvm.func @logic_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg0, %arg1, %1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %3, %5 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }
  llvm.func @logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg0, %arg1, %1 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %10, %12 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %10 = llvm.mlir.constant(true) : i1
    %11 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %8 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %arg2, %9 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %11, %13 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }
  llvm.func @logic_and_logic_or_vector_poison3(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.undef : vector<3xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : vector<3xi1>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi1>
    %10 = llvm.mlir.constant(true) : i1
    %11 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %arg2, %9 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %11, %13 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }
  llvm.func @logic_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %arg2, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @and_logic_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.and %arg0, %arg1  : vector<3xi1>
    %5 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %3, %5 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }
  llvm.func @and_logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(true) : i1
    %10 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %11 = llvm.and %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %arg2, %8 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %10, %12 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @and_logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.and %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %arg2, %1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %10, %12 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @and_logic_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %arg0, %0 : i1, i1
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }
  llvm.func @and_and_logic_or_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.and %arg0, %arg2  : i1
    %3 = llvm.select %1, %0, %2 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_and_logic_or_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.and %arg0, %arg2  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @and_and_logic_or_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.and %arg0, %arg1  : vector<3xi1>
    %3 = llvm.and %arg0, %arg2  : vector<3xi1>
    %4 = llvm.select %2, %1, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %4 : vector<3xi1>
  }
  llvm.func @and_and_logic_or_vector_poison(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.and %arg0, %arg1  : vector<3xi1>
    %10 = llvm.and %arg0, %arg2  : vector<3xi1>
    %11 = llvm.select %9, %8, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %11 : vector<3xi1>
  }
  llvm.func @and_and_logic_or_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.and %arg1, %arg0  : i1
    %2 = llvm.and %arg0, %arg2  : i1
    %3 = llvm.select %2, %0, %1 : i1, i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }
  llvm.func @logic_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg1, %0, %arg0 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @logic_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg0, %1, %arg1 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %5, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }
  llvm.func @logic_or_logic_and_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %10 = llvm.mlir.constant(false) : i1
    %11 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %8, %arg1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %9, %arg2 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %13, %11 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }
  llvm.func @logic_or_logic_and_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.undef : vector<3xi1>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : vector<3xi1>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi1>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi1>
    %10 = llvm.mlir.constant(false) : i1
    %11 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %12 = llvm.select %arg0, %1, %arg1 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %arg0, %9, %arg2 : vector<3xi1>, vector<3xi1>
    %14 = llvm.select %12, %13, %11 : vector<3xi1>, vector<3xi1>
    llvm.return %14 : vector<3xi1>
  }
  llvm.func @logic_or_logic_and_vector_poison3(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg0, %1, %arg1 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %12, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @logic_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg1 : i1, i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_5(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_6(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_7(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg0, %0, %arg2 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_8(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg1, %arg0  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }
  llvm.func @or_logic_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.or %arg0, %arg1  : vector<3xi1>
    %5 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %6 = llvm.select %4, %5, %3 : vector<3xi1>, vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }
  llvm.func @or_logic_or_logic_and_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(false) : i1
    %10 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %11 = llvm.or %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %8, %arg2 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %12, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @or_logic_or_logic_and_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.poison : i1
    %3 = llvm.mlir.constant(false) : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.or %arg0, %arg1  : vector<3xi1>
    %12 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %13 = llvm.select %11, %12, %10 : vector<3xi1>, vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @or_logic_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.or %arg0, %arg1  : i1
    %3 = llvm.select %arg2, %0, %arg0 : i1, i1
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.call @use(%2) : (i1) -> ()
    llvm.call @use(%3) : (i1) -> ()
    llvm.return %4 : i1
  }
  llvm.func @or_or_logic_and_1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.or %arg2, %arg0  : i1
    %3 = llvm.select %1, %2, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_or_logic_and_2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.or %arg2, %arg0  : i1
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.return %3 : i1
  }
  llvm.func @or_or_logic_and_vector(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.or %arg0, %arg1  : vector<3xi1>
    %3 = llvm.or %arg2, %arg0  : vector<3xi1>
    %4 = llvm.select %2, %3, %1 : vector<3xi1>, vector<3xi1>
    llvm.return %4 : vector<3xi1>
  }
  llvm.func @or_or_logic_and_vector_poison(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.or %arg0, %arg1  : vector<3xi1>
    %10 = llvm.or %arg2, %arg0  : vector<3xi1>
    %11 = llvm.select %9, %10, %8 : vector<3xi1>, vector<3xi1>
    llvm.return %11 : vector<3xi1>
  }
  llvm.func @or_or_logic_and_not_one_use(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg1  : i1
    %2 = llvm.or %arg2, %arg0  : i1
    %3 = llvm.select %2, %1, %0 : i1, i1
    llvm.call @use(%1) : (i1) -> ()
    llvm.call @use(%2) : (i1) -> ()
    llvm.return %3 : i1
  }
}
