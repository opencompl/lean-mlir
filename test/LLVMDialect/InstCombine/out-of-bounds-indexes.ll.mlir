module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_out_of_bounds(%arg0: i32, %arg1: i1, %arg2: i1) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.icmp "eq" %4, %2 : i32
    "llvm.intr.assume"(%5) : (i1) -> ()
    llvm.return %3 : i32
  }
  llvm.func @test_non64bit(%arg0: i128) -> i128 {
    %0 = llvm.mlir.constant(3 : i128) : i128
    %1 = llvm.mlir.constant(-1 : i128) : i128
    %2 = llvm.mlir.constant(1 : i128) : i128
    %3 = llvm.and %arg0, %0  : i128
    %4 = llvm.lshr %3, %1  : i128
    %5 = llvm.icmp "eq" %4, %2 : i128
    "llvm.intr.assume"(%5) : (i1) -> ()
    llvm.return %3 : i128
  }
  llvm.func @inselt_bad_index(%arg0: vector<4xf64>) -> vector<4xf64> {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.insertelement %0, %arg0[%1 : i64] : vector<4xf64>
    llvm.return %2 : vector<4xf64>
  }
}
