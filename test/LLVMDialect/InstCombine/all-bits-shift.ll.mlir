module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.mlir.global external @d(15 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global external @b() {addr_space = 0 : i32, alignment = 8 : i64} : !llvm.ptr {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.mlir.global common @a(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @main() -> (i32 {llvm.signext}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(2072 : i32) : i32
    %6 = llvm.mlir.constant(7 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %10 = llvm.icmp "eq" %9, %3 : i32
    %11 = llvm.zext %10 : i1 to i32
    %12 = llvm.lshr %5, %11  : i32
    %13 = llvm.lshr %12, %6  : i32
    %14 = llvm.and %13, %7  : i32
    %15 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %16 = llvm.or %14, %15  : i32
    llvm.store %16, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    %17 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    %18 = llvm.icmp "eq" %17, %3 : i32
    %19 = llvm.zext %18 : i1 to i32
    %20 = llvm.lshr %5, %19  : i32
    %21 = llvm.lshr %20, %6  : i32
    %22 = llvm.and %21, %7  : i32
    %23 = llvm.or %22, %16  : i32
    llvm.store %23, %8 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %23 : i32
  }
}
