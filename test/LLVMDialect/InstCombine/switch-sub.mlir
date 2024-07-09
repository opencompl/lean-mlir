module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_switch_with_neg(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.sub %0, %arg0  : i32
    llvm.switch %3 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }
  llvm.func @test_switch_with_sub(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(37 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.sub %0, %arg0  : i32
    llvm.switch %3 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %1 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i1
  }
  llvm.func @test_switch_with_sub_nonconst(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.sub %arg1, %arg0  : i32
    llvm.switch %2 : i32, ^bb2 [
      37: ^bb1,
      38: ^bb1,
      39: ^bb1
    ]
  ^bb1:  // 3 preds: ^bb0, ^bb0, ^bb0
    llvm.return %0 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }
}
