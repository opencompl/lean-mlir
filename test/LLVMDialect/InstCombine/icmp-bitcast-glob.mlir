module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @b() {addr_space = 0 : i32} : i32
  llvm.func @f32(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @f64(!llvm.ptr, !llvm.ptr) -> i32
  llvm.func @icmp_func() -> i1 {
    %0 = llvm.mlir.addressof @f32 : !llvm.ptr
    %1 = llvm.mlir.addressof @f64 : !llvm.ptr
    %2 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @icmp_fptr(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.addressof @f32 : !llvm.ptr
    %1 = llvm.icmp "ne" %0, %arg0 : !llvm.ptr
    llvm.return %1 : i1
  }
  llvm.func @icmp_glob(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.addressof @icmp_glob : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.icmp "eq" %0, %1 : !llvm.ptr
    %3 = llvm.select %2, %arg0, %arg1 : i1, i32
    llvm.return %3 : i32
  }
}
