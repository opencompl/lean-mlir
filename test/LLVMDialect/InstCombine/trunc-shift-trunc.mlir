module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @trunc_lshr_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_shl_trunc(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[9, 7]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.shl %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_trunc_uniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_trunc_nonuniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_lshr_trunc_uniform_poison(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.lshr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @trunc_lshr_trunc_outofrange(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.lshr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_lshr_trunc_nonuniform_outofrange(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 25]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.lshr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_ashr_trunc(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_ashr_trunc_exact(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(8 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_ashr_trunc_uniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_ashr_trunc_nonuniform(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 23]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_ashr_trunc_uniform_poison(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.poison : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %8 = llvm.ashr %7, %6  : vector<2xi32>
    %9 = llvm.trunc %8 : vector<2xi32> to vector<2xi8>
    llvm.return %9 : vector<2xi8>
  }
  llvm.func @trunc_ashr_trunc_outofrange(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.return %3 : i8
  }
  llvm.func @trunc_ashr_trunc_nonuniform_outofrange(%arg0: vector<2xi64>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[8, 25]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.ashr %1, %0  : vector<2xi32>
    %3 = llvm.trunc %2 : vector<2xi32> to vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }
  llvm.func @trunc_ashr_trunc_multiuse(%arg0: i64) -> i8 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.ashr %1, %0  : i32
    %3 = llvm.trunc %2 : i32 to i8
    llvm.call @use(%2) : (i32) -> ()
    llvm.return %3 : i8
  }
}
