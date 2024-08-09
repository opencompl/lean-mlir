module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_ult_rhsc(%arg0: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }
  llvm.func @test_eq_lhsc(%arg0: i8) {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(6 : i8) : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %arg0 : i1, i8
    llvm.switch %3 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // pred: ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }
  llvm.func @test_ult_rhsc_invalid_cond(%arg0: i8, %arg1: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %arg1, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3,
      13: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }
  llvm.func @test_ult_rhsc_fail(%arg0: i8) {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(11 : i8) : i8
    %2 = llvm.mlir.constant(6 : i8) : i8
    %3 = llvm.add %arg0, %0 overflow<nsw>  : i8
    %4 = llvm.icmp "ult" %3, %1 : i8
    %5 = llvm.select %4, %3, %2 : i1, i8
    llvm.switch %5 : i8, ^bb1 [
      0: ^bb2,
      10: ^bb3,
      13: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.call @func1() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    llvm.call @func2() : () -> ()
    llvm.unreachable
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.call @func3() : () -> ()
    llvm.unreachable
  }
  llvm.func @func1()
  llvm.func @func2()
  llvm.func @func3()
}
