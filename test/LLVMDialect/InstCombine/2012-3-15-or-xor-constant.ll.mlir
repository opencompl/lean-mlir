module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global extern_weak @g() {addr_space = 0 : i32} : i32
  llvm.func @function(%arg0: i32) -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.inttoptr %1 : i64 to !llvm.ptr
    %3 = llvm.mlir.addressof @g : !llvm.ptr
    %4 = llvm.mlir.zero : !llvm.ptr
    %5 = llvm.xor %arg0, %0  : i32
    llvm.store volatile %5, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.icmp "eq" %3, %4 : !llvm.ptr
    %7 = llvm.zext %6 : i1 to i32
    %8 = llvm.or %7, %0  : i32
    %9 = llvm.or %8, %5  : i32
    llvm.return %9 : i32
  }
}
