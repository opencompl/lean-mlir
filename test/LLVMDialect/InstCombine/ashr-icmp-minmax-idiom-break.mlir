module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @dont_break_minmax_i64(%arg0: i64, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(348731 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mul %arg0, %arg1 overflow<nsw>  : i64
    %4 = llvm.ashr %3, %0  : i64
    %5 = llvm.icmp "sgt" %4, %1 : i64
    %6 = llvm.icmp "ult" %5, %2 : i1
    %7 = llvm.select %6, %4, %1 : i1, i64
    llvm.return %7 : i64
  }
}
