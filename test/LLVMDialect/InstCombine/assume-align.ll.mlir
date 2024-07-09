module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @f1(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(true) : i1
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.mlir.constant(4 : i32) : i32
    %6 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.and %7, %1  : i64
    %9 = llvm.icmp "eq" %8, %2 : i64
    llvm.cond_br %9, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    "llvm.intr.assume"(%3) : (i1) -> ()
    %10 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %11 = llvm.and %10, %1  : i64
    %12 = llvm.icmp "eq" %11, %2 : i64
    llvm.cond_br %12, ^bb2, ^bb3
  ^bb2:  // pred: ^bb1
    llvm.store %5, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb4
  ^bb3:  // pred: ^bb1
    llvm.store %4, %6 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb4
  ^bb4:  // 3 preds: ^bb0, ^bb2, ^bb3
    llvm.return
  }
  llvm.func @f2(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(8 : i64) : i64
    %2 = llvm.mlir.constant(15 : i64) : i64
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.mlir.constant(1 : i8) : i8
    %5 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.assume"(%0) : (i1) -> ()
    %6 = llvm.getelementptr inbounds %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.and %7, %2  : i64
    %9 = llvm.icmp "eq" %8, %3 : i64
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %5, %6 {alignment = 4 : i64} : i64, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %4, %6 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return
  }
  llvm.func @f3(%arg0: i64, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    "llvm.intr.assume"(%0) : (i1) -> ()
    %2 = llvm.add %arg0, %1  : i64
    llvm.call @g(%2) : (i64) -> ()
    llvm.return
  }
  llvm.func @g(i64)
  llvm.func @assume_align_zero(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %1 : i8
  }
  llvm.func @assume_align_non_pow2(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    "llvm.intr.assume"(%0) : (i1) -> ()
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %1 : i8
  }
}
