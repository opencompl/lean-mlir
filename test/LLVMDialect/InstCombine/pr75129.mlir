module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @or_and_add_and() -> i16 {
    %0 = llvm.mlir.constant(32 : i16) : i16
    %1 = llvm.mlir.constant(48 : i16) : i16
    %2 = llvm.mlir.constant(15 : i16) : i16
    %3 = llvm.call @dummy() : () -> i16
    %4 = llvm.add %0, %3  : i16
    %5 = llvm.and %4, %1  : i16
    %6 = llvm.and %3, %2  : i16
    %7 = llvm.or %5, %6  : i16
    llvm.return %7 : i16
  }
  llvm.func @dummy() -> i16
}
