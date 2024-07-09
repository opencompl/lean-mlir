module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f() -> vector<2xi32> {
    %0 = llvm.mlir.undef : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }
  llvm.func @g() -> i32 {
    %0 = llvm.mlir.addressof @f : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }
}
