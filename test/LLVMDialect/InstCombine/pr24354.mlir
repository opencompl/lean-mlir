module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @c(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global common @b(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.mlir.global common @a(0 : i16) {addr_space = 0 : i32, alignment = 2 : i64} : i16
  llvm.mlir.global common @d(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64} : i32
  llvm.func @fn3() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.addressof @b : !llvm.ptr
    %4 = llvm.mlir.constant(255 : i32) : i32
    %5 = llvm.mlir.constant(254 : i32) : i32
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.mlir.addressof @a : !llvm.ptr
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.addressof @d : !llvm.ptr
    %10 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    %11 = llvm.icmp "eq" %10, %0 : i32
    llvm.cond_br %11, ^bb1, ^bb2(%2 : i1)
  ^bb1:  // pred: ^bb0
    %12 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.add %4, %12 overflow<nsw>  : i32
    %14 = llvm.icmp "ugt" %13, %5 : i32
    llvm.br ^bb2(%14 : i1)
  ^bb2(%15: i1):  // 2 preds: ^bb0, ^bb1
    %16 = llvm.zext %15 : i1 to i32
    %17 = llvm.icmp "eq" %16, %0 : i32
    %18 = llvm.load %7 {alignment = 2 : i64} : !llvm.ptr -> i16
    %19 = llvm.icmp "ne" %18, %6 : i16
    %20 = llvm.select %17, %8, %19 : i1, i1
    %21 = llvm.zext %20 : i1 to i32
    llvm.store %21, %9 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
}
