module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_switch_with_shl_mask(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0  : i32
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }
  llvm.func @test_switch_with_shl_nuw_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0 overflow<nuw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }
  llvm.func @test_switch_with_shl_nsw_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0 overflow<nsw>  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }
  llvm.func @test_switch_with_shl_mask_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(24 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0  : i32
    llvm.call @use(%3) : (i32) -> ()
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }
  llvm.func @test_switch_with_shl_mask_unknown_shamt(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.shl %arg0, %arg1  : i32
    llvm.switch %2 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }
  llvm.func @test_switch_with_shl_mask_poison(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.shl %arg0, %0  : i32
    llvm.switch %3 : i32, ^bb2 [
      0: ^bb1,
      16777216: ^bb1,
      2147483648: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }
  llvm.func @use(i32)
}
