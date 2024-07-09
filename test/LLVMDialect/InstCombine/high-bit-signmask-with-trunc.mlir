module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @t1_exact(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @t2(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @t3_exact(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @t4(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<63> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.lshr %arg0, %0  : vector<2xi64>
    %4 = llvm.trunc %3 : vector<2xi64> to vector<2xi32>
    %5 = llvm.sub %2, %4  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }
  llvm.func @t5(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.undef : i64
    %1 = llvm.mlir.constant(63 : i64) : i64
    %2 = llvm.mlir.undef : vector<2xi64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi64>
    %7 = llvm.mlir.undef : i32
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.mlir.undef : vector<2xi32>
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.insertelement %8, %9[%10 : i32] : vector<2xi32>
    %12 = llvm.mlir.constant(1 : i32) : i32
    %13 = llvm.insertelement %7, %11[%12 : i32] : vector<2xi32>
    %14 = llvm.lshr %arg0, %6  : vector<2xi64>
    %15 = llvm.trunc %14 : vector<2xi64> to vector<2xi32>
    %16 = llvm.sub %13, %15  : vector<2xi32>
    llvm.return %16 : vector<2xi32>
  }
  llvm.func @use64(i64)
  llvm.func @use32(i32)
  llvm.func @t6(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n7(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n8(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    llvm.call @use64(%2) : (i64) -> ()
    %3 = llvm.trunc %2 : i64 to i32
    llvm.call @use32(%3) : (i32) -> ()
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n9(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(62 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @n10(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i64
    %3 = llvm.trunc %2 : i64 to i32
    %4 = llvm.sub %1, %3  : i32
    llvm.return %4 : i32
  }
}
