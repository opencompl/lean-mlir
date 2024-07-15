module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @ecp() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr
  llvm.func @strnlen(!llvm.ptr, i64) -> i64
  llvm.func @deref_strnlen_ecp_3() -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %3 = llvm.call @strnlen(%2, %1) : (!llvm.ptr, i64) -> i64
    llvm.return %3 : i64
  }
  llvm.func @deref_strnlen_ecp_nz(%arg0: i64) -> i64 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.addressof @ecp : !llvm.ptr
    %2 = llvm.or %arg0, %0  : i64
    %3 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.call @strnlen(%3, %2) : (!llvm.ptr, i64) -> i64
    llvm.return %4 : i64
  }
  llvm.func @noderef_strnlen_ecp_n(%arg0: i64) -> i64 {
    %0 = llvm.mlir.addressof @ecp : !llvm.ptr
    %1 = llvm.load %0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %2 = llvm.call @strnlen(%1, %arg0) : (!llvm.ptr, i64) -> i64
    llvm.return %2 : i64
  }
}
