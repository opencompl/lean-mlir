module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %4 = llvm.sub %3, %0  : i8
    %5 = llvm.icmp "ugt" %4, %1 : i8
    %6 = llvm.sub %3, %2  : i8
    %7 = llvm.icmp "ugt" %6, %1 : i8
    %8 = llvm.and %5, %7  : i1
    llvm.cond_br %8, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    llvm.return
  }
  llvm.func @f_logical(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.mlir.constant(10 : i8) : i8
    %3 = llvm.mlir.constant(false) : i1
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %4 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %5 = llvm.sub %4, %0  : i8
    %6 = llvm.icmp "ugt" %5, %1 : i8
    %7 = llvm.sub %4, %2  : i8
    %8 = llvm.icmp "ugt" %7, %1 : i8
    %9 = llvm.select %6, %8, %3 : i1, i1
    llvm.cond_br %9, ^bb3, ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  ^bb3:  // pred: ^bb1
    llvm.return
  }
}
