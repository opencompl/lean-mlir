module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @SwitchTest(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.switch %arg0 : i32, ^bb1 [
      0: ^bb2(%0 : i32),
      1: ^bb3(%1 : i32)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb3(%2 : i32)
  ^bb3(%3: i32):  // 2 preds: ^bb0, ^bb2
    %4 = llvm.icmp "ugt" %3, %0 : i32
    llvm.return %4 : i1
  }
  llvm.func @BranchTest(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1, %arg4: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(134 : i32) : i32
    %3 = llvm.mlir.constant(128 : i32) : i32
    %4 = llvm.mlir.constant(127 : i32) : i32
    %5 = llvm.mlir.constant(126 : i32) : i32
    llvm.cond_br %arg0, ^bb6(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb6(%1 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.cond_br %arg2, ^bb6(%2 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.cond_br %arg3, ^bb5(%3 : i32), ^bb4
  ^bb4:  // pred: ^bb3
    %6 = llvm.select %arg4, %4, %5 : i1, i32
    llvm.br ^bb5(%6 : i32)
  ^bb5(%7: i32):  // 2 preds: ^bb3, ^bb4
    llvm.br ^bb6(%7 : i32)
  ^bb6(%8: i32):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb5
    %9 = llvm.icmp "ult" %8, %1 : i32
    llvm.return %9 : i1
  }
}
