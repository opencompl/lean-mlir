module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @a(0 : i8) {addr_space = 0 : i32, alignment = 1 : i64} : i8
  llvm.mlir.global external @b() {addr_space = 0 : i32} : i32
  llvm.func @tinkywinky() {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8
    %6 = llvm.icmp "ne" %5, %0 : i8
    %7 = llvm.xor %6, %2  : i1
    %8 = llvm.zext %7 : i1 to i32
    %9 = llvm.icmp "ne" %1, %3 : !llvm.ptr
    %10 = llvm.zext %9 : i1 to i32
    %11 = llvm.xor %10, %4  : i32
    %12 = llvm.or %11, %8  : i32
    llvm.store %12, %3 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
