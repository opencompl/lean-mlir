module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @pow_exp(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i1 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    %3 = llvm.intr.pow(%2, %arg1)  {fastmathFlags = #llvm.fastmath<fast>} : (f64, f64) -> f64
    %4 = llvm.fcmp "ule" %2, %3 : f64
    llvm.store %4, %1 {alignment = 1 : i64} : i1, !llvm.ptr
    llvm.return %3 : f64
  }
  llvm.func @exp(f64) -> f64
}
