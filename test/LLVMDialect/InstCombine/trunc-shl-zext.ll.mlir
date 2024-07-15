module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @trunc_shl_zext_32(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.trunc %arg0 : i32 to i16
    %2 = llvm.shl %1, %0  : i16
    %3 = llvm.zext %2 : i16 to i32
    llvm.return %3 : i32
  }
  llvm.func @trunc_shl_zext_64(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.trunc %arg0 : i64 to i8
    %2 = llvm.shl %1, %0  : i8
    %3 = llvm.zext %2 : i8 to i64
    llvm.return %3 : i64
  }
}
