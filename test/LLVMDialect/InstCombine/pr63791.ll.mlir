module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal constant @j(4 : i32) {addr_space = 0 : i32, dso_local} : i32
  llvm.func @y() {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.addressof @j : !llvm.ptr
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.mlir.constant(41 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(-1020499714 : i32) : i32
    %7 = llvm.mlir.constant(-1020499638 : i32) : i32
    %8 = llvm.mlir.zero : !llvm.ptr
    %9 = llvm.mlir.constant(0 : i64) : i64
    llvm.br ^bb1(%1 : !llvm.ptr)
  ^bb1(%10: !llvm.ptr):  // 3 preds: ^bb0, ^bb1, ^bb2
    %11 = llvm.load %10 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.cond_br %2, ^bb1(%1 : !llvm.ptr), ^bb3(%11 : i32)
  ^bb2:  // 2 preds: ^bb3, ^bb4
    %12 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32
    %13 = llvm.sext %12 : i32 to i64
    %14 = llvm.icmp "eq" %9, %13 : i64
    llvm.cond_br %14, ^bb1(%8 : !llvm.ptr), ^bb3(%5 : i32)
  ^bb3(%15: i32):  // 2 preds: ^bb1, ^bb2
    %16 = llvm.or %11, %3  : i32
    %17 = llvm.icmp "sgt" %11, %4 : i32
    %18 = llvm.select %17, %16, %5 : i1, i32
    %19 = llvm.add %18, %3  : i32
    %20 = llvm.icmp "sgt" %18, %5 : i32
    %21 = llvm.select %20, %19, %5 : i1, i32
    %22 = llvm.icmp "eq" %19, %5 : i32
    %23 = llvm.or %19, %16  : i32
    %24 = llvm.icmp "sgt" %23, %5 : i32
    %25 = llvm.select %17, %24, %2 : i1, i1
    %26 = llvm.select %25, %5, %21 : i1, i32
    %27 = llvm.select %22, %5, %26 : i1, i32
    %28 = llvm.or %27, %6  : i32
    %29 = llvm.icmp "sgt" %28, %7 : i32
    llvm.cond_br %29, ^bb4, ^bb2
  ^bb4:  // 2 preds: ^bb3, ^bb4
    llvm.cond_br %25, ^bb4, ^bb2
  }
}
