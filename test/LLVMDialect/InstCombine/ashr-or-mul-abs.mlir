module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @ashr_or_mul_to_abs(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.mul %3, %arg0 overflow<nsw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_or_mul_to_abs2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.mul %3, %arg0  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_or_mul_to_abs3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(31 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.sdiv %0, %arg0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.or %4, %2  : i32
    %6 = llvm.mul %3, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @ashr_or_mul_to_abs_vec(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.or %2, %1  : vector<4xi32>
    %4 = llvm.mul %3, %arg0  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @ashr_or_mul_to_abs_vec2(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<31> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.ashr %arg0, %0  : vector<4xi32>
    %3 = llvm.or %2, %1  : vector<4xi32>
    %4 = llvm.mul %3, %arg0 overflow<nsw>  : vector<4xi32>
    llvm.return %4 : vector<4xi32>
  }
  llvm.func @ashr_or_mul_to_abs_vec3_poison(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.poison : i32
    %2 = llvm.mlir.undef : vector<4xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<4xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<4xi32>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<4xi32>
    %9 = llvm.mlir.constant(3 : i32) : i32
    %10 = llvm.insertelement %0, %8[%9 : i32] : vector<4xi32>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.mlir.undef : vector<4xi32>
    %13 = llvm.mlir.constant(0 : i32) : i32
    %14 = llvm.insertelement %11, %12[%13 : i32] : vector<4xi32>
    %15 = llvm.mlir.constant(1 : i32) : i32
    %16 = llvm.insertelement %11, %14[%15 : i32] : vector<4xi32>
    %17 = llvm.mlir.constant(2 : i32) : i32
    %18 = llvm.insertelement %11, %16[%17 : i32] : vector<4xi32>
    %19 = llvm.mlir.constant(3 : i32) : i32
    %20 = llvm.insertelement %1, %18[%19 : i32] : vector<4xi32>
    %21 = llvm.ashr %arg0, %10  : vector<4xi32>
    %22 = llvm.or %21, %20  : vector<4xi32>
    %23 = llvm.mul %22, %arg0  : vector<4xi32>
    llvm.return %23 : vector<4xi32>
  }
  llvm.func @ashr_or_mul_to_abs_neg(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.mul %3, %arg0 overflow<nsw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_or_mul_to_abs_neg2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.mul %3, %arg0 overflow<nsw>  : i32
    llvm.return %4 : i32
  }
  llvm.func @ashr_or_mul_to_abs_neg3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.or %2, %1  : i32
    %4 = llvm.mul %3, %arg1 overflow<nsw>  : i32
    llvm.return %4 : i32
  }
}
