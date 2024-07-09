module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @xor_logic_and_logic_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg2 : i1, i1
    %3 = llvm.select %arg0, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_logic_and_logic_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg0, %arg1, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_logic_and_logic_or3(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg2, %0, %arg0 : i1, i1
    %3 = llvm.select %arg1, %arg0, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_logic_and_logic_or4(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.select %arg0, %0, %arg2 : i1, i1
    %3 = llvm.select %arg1, %arg0, %1 : i1, i1
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }
  llvm.func @xor_logic_and_logic_or_vector1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg0, %arg1, %3 : vector<3xi1>, vector<3xi1>
    %6 = llvm.xor %5, %4  : vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }
  llvm.func @xor_logic_and_logic_or_vector2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %4 = llvm.select %arg2, %1, %arg0 : vector<3xi1>, vector<3xi1>
    %5 = llvm.select %arg1, %arg0, %3 : vector<3xi1>, vector<3xi1>
    %6 = llvm.xor %5, %4  : vector<3xi1>
    llvm.return %6 : vector<3xi1>
  }
  llvm.func @xor_logic_and_logic_or_vector_poison1(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.poison : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.undef : vector<3xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<3xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(false) : i1
    %10 = llvm.mlir.constant(dense<false> : vector<3xi1>) : vector<3xi1>
    %11 = llvm.select %arg0, %8, %arg2 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %10 : vector<3xi1>, vector<3xi1>
    %13 = llvm.xor %12, %11  : vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @xor_logic_and_logic_or_vector_poison2(%arg0: vector<3xi1>, %arg1: vector<3xi1>, %arg2: vector<3xi1>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<3xi1>) : vector<3xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.poison : i1
    %4 = llvm.mlir.undef : vector<3xi1>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %2, %4[%5 : i32] : vector<3xi1>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<3xi1>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %2, %8[%9 : i32] : vector<3xi1>
    %11 = llvm.select %arg0, %1, %arg2 : vector<3xi1>, vector<3xi1>
    %12 = llvm.select %arg0, %arg1, %10 : vector<3xi1>, vector<3xi1>
    %13 = llvm.xor %12, %11  : vector<3xi1>
    llvm.return %13 : vector<3xi1>
  }
  llvm.func @xor_and_logic_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg0, %0, %arg2 : i1, i1
    %2 = llvm.and %arg0, %arg1  : i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @xor_and_logic_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.select %arg2, %0, %arg0 : i1, i1
    %2 = llvm.and %arg1, %arg0  : i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @xor_and_logic_or_vector(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.select %arg0, %1, %arg2 : vector<2xi1>, vector<2xi1>
    %3 = llvm.and %arg0, %arg1  : vector<2xi1>
    %4 = llvm.xor %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @xor_and_logic_or_vector_poison(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.select %arg0, %6, %arg2 : vector<2xi1>, vector<2xi1>
    %8 = llvm.and %arg0, %arg1  : vector<2xi1>
    %9 = llvm.xor %8, %7  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @xor_logic_and_or1(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg2, %arg0  : i1
    %2 = llvm.select %arg0, %arg1, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @xor_logic_and_or2(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.or %arg0, %arg2  : i1
    %2 = llvm.select %arg1, %arg0, %0 : i1, i1
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }
  llvm.func @xor_logic_and_or_vector(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %2 = llvm.or %arg2, %arg0  : vector<2xi1>
    %3 = llvm.select %arg0, %arg1, %1 : vector<2xi1>, vector<2xi1>
    %4 = llvm.xor %3, %2  : vector<2xi1>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @xor_logic_and_or_vector_poison(%arg0: vector<2xi1>, %arg1: vector<2xi1>, %arg2: vector<2xi1>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.poison : i1
    %2 = llvm.mlir.undef : vector<2xi1>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi1>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi1>
    %7 = llvm.or %arg2, %arg0  : vector<2xi1>
    %8 = llvm.select %arg0, %arg1, %6 : vector<2xi1>, vector<2xi1>
    %9 = llvm.xor %8, %7  : vector<2xi1>
    llvm.return %9 : vector<2xi1>
  }
  llvm.func @xor_and_or(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg2, %arg0  : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.return %2 : i1
  }
  llvm.func @xor_and_or_vector(%arg0: vector<4xi1>, %arg1: vector<4xi1>, %arg2: vector<4xi1>) -> vector<4xi1> {
    %0 = llvm.or %arg2, %arg0  : vector<4xi1>
    %1 = llvm.and %arg0, %arg1  : vector<4xi1>
    %2 = llvm.xor %1, %0  : vector<4xi1>
    llvm.return %2 : vector<4xi1>
  }
  llvm.func @xor_and_or_negative_oneuse(%arg0: i1, %arg1: i1, %arg2: i1) -> i1 {
    %0 = llvm.or %arg2, %arg0  : i1
    %1 = llvm.and %arg0, %arg1  : i1
    %2 = llvm.xor %1, %0  : i1
    llvm.call @use(%0) : (i1) -> ()
    llvm.return %2 : i1
  }
  llvm.func @use(i1)
}
