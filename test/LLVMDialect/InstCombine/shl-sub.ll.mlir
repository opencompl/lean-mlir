module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @shl_sub_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_sub_multiuse_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_sub_i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.shl %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_sub_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.shl %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @shl_sub_i64_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %0, %arg0  : vector<2xi64>
    %3 = llvm.shl %1, %2  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @shl_sub_i64_vec_poison(%arg0: vector<3xi64>) -> vector<3xi64> {
    %0 = llvm.mlir.constant(dense<63> : vector<3xi64>) : vector<3xi64>
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.poison : i64
    %3 = llvm.mlir.undef : vector<3xi64>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<3xi64>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<3xi64>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %1, %7[%8 : i32] : vector<3xi64>
    %10 = llvm.sub %0, %arg0  : vector<3xi64>
    %11 = llvm.shl %9, %10  : vector<3xi64>
    llvm.return %11 : vector<3xi64>
  }
  llvm.func @shl_bad_sub_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @bad_shl_sub_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_bad_sub2_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @bad_shl2_sub_i32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.sub %arg0, %0  : i32
    %3 = llvm.shl %1, %2  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_bad_sub_i8(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.sub %0, %arg0  : i8
    %3 = llvm.shl %1, %2  : i8
    llvm.return %3 : i8
  }
  llvm.func @shl_bad_sub_i64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(67 : i64) : i64
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.sub %0, %arg0  : i64
    %3 = llvm.shl %1, %2  : i64
    llvm.return %3 : i64
  }
  llvm.func @shl_bad_sub_i64_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<53> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<1> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %0, %arg0  : vector<2xi64>
    %3 = llvm.shl %1, %2  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @bad_shl_sub_i64_vec(%arg0: vector<2xi64>) -> vector<2xi64> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %2 = llvm.sub %0, %arg0  : vector<2xi64>
    %3 = llvm.shl %1, %2  : vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @shl_sub_i64_vec_undef_bad(%arg0: vector<3xi64>) -> vector<3xi64> {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.undef : i64
    %2 = llvm.mlir.undef : vector<3xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi64>
    %9 = llvm.mlir.constant(dense<1> : vector<3xi64>) : vector<3xi64>
    %10 = llvm.sub %8, %arg0  : vector<3xi64>
    %11 = llvm.shl %9, %10  : vector<3xi64>
    llvm.return %11 : vector<3xi64>
  }
  llvm.func @shl_sub_i64_vec_poison_bad2(%arg0: vector<3xi64>) -> vector<3xi64> {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.poison : i64
    %2 = llvm.mlir.undef : vector<3xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %0, %2[%3 : i32] : vector<3xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %1, %4[%5 : i32] : vector<3xi64>
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.insertelement %0, %6[%7 : i32] : vector<3xi64>
    %9 = llvm.mlir.constant(1 : i64) : i64
    %10 = llvm.mlir.undef : vector<3xi64>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<3xi64>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %1, %12[%13 : i32] : vector<3xi64>
    %15 = llvm.mlir.constant(2 : i32) : i32
    %16 = llvm.insertelement %9, %14[%15 : i32] : vector<3xi64>
    %17 = llvm.sub %8, %arg0  : vector<3xi64>
    %18 = llvm.shl %16, %17  : vector<3xi64>
    llvm.return %18 : vector<3xi64>
  }
  llvm.func @shl_const_op1_sub_const_op0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }
  llvm.func @shl_const_op1_sub_const_op0_splat(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %0, %arg0  : vector<2xi32>
    %3 = llvm.shl %2, %1  : vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @shl_const_op1_sub_const_op0_use(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @use(%2) : (i32) -> ()
    %3 = llvm.shl %2, %1  : i32
    llvm.return %3 : i32
  }
}
