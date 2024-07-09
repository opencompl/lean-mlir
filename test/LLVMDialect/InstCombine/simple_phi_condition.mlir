module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_direct_implication(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i1
  }
  llvm.func @test_inverted_implication(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%0 : i1)
  ^bb3(%2: i1):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : i1
  }
  llvm.func @test_edge_dominance(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb2(%0 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i1)
  ^bb2(%2: i1):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i1
  }
  llvm.func @test_direct_implication_complex_cfg(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.add %4, %2  : i32
    %6 = llvm.icmp "slt" %5, %arg1 : i32
    llvm.cond_br %6, ^bb2(%5 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%3 : i1)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%0 : i1)
  ^bb5(%7: i1):  // 2 preds: ^bb3, ^bb4
    llvm.return %7 : i1
  }
  llvm.func @test_inverted_implication_complex_cfg(%arg0: i1, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb1, ^bb2
    %5 = llvm.add %4, %2  : i32
    %6 = llvm.icmp "slt" %5, %arg1 : i32
    llvm.cond_br %6, ^bb2(%5 : i32), ^bb3
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%3 : i1)
  ^bb4:  // pred: ^bb0
    llvm.br ^bb5(%0 : i1)
  ^bb5(%7: i1):  // 2 preds: ^bb3, ^bb4
    llvm.return %7 : i1
  }
  llvm.func @test_multiple_predecessors(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%0 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%0 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }
  llvm.func @test_multiple_predecessors_wrong_value(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%1 : i1)
  ^bb2:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%0 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }
  llvm.func @test_multiple_predecessors_no_edge_domination(%arg0: i1, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb5(%0 : i1), ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.cond_br %arg1, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb4:  // pred: ^bb2
    llvm.br ^bb5(%1 : i1)
  ^bb5(%2: i1):  // 3 preds: ^bb1, ^bb3, ^bb4
    llvm.return %2 : i1
  }
  llvm.func @test_switch(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%0 : i8)
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }
  llvm.func @test_switch_direct_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb4(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb4(%4: i8):  // 3 preds: ^bb0, ^bb1, ^bb2
    llvm.return %4 : i8
  }
  llvm.func @test_switch_duplicate_direct_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb2 [
      1: ^bb1,
      7: ^bb3(%0 : i8),
      19: ^bb3(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb3(%3: i8):  // 3 preds: ^bb0, ^bb0, ^bb1
    llvm.return %3 : i8
  }
  llvm.func @test_switch_subset(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(24 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.return %0 : i8
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 2 preds: ^bb1, ^bb2
    llvm.return %4 : i8
  }
  llvm.func @test_switch_wrong_value(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(10 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%0 : i8)
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }
  llvm.func @test_switch_inverted(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-3 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4 [
      0: ^bb1,
      1: ^bb2,
      2: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb5(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb5(%1 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb5(%0 : i8)
  ^bb4:  // pred: ^bb0
    llvm.return %3 : i8
  ^bb5(%4: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }
  llvm.func @test_switch_duplicate_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb2
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb2:  // 2 preds: ^bb0, ^bb0
    llvm.br ^bb4(%0 : i8)
  ^bb3:  // pred: ^bb0
    llvm.return %2 : i8
  ^bb4(%3: i8):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i8
  }
  llvm.func @test_switch_default_edge(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(19 : i8) : i8
    %2 = llvm.mlir.constant(7 : i8) : i8
    %3 = llvm.mlir.constant(1 : i8) : i8
    llvm.switch %arg0 : i8, ^bb4(%0 : i8) [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%3 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb3:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb4(%4: i8):  // 4 preds: ^bb0, ^bb1, ^bb2, ^bb3
    llvm.return %4 : i8
  }
  llvm.func @test_switch_default_edge_direct(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(19 : i8) : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.constant(1 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3(%0 : i8) [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3(%0 : i8)
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb3(%2 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%1 : i8)
  ^bb3(%3: i8):  // 4 preds: ^bb0, ^bb0, ^bb1, ^bb2
    llvm.return %3 : i8
  }
  llvm.func @test_switch_default_edge_duplicate(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(19 : i8) : i8
    llvm.switch %arg0 : i8, ^bb3 [
      1: ^bb1,
      7: ^bb2,
      19: ^bb3
    ]
  ^bb1:  // pred: ^bb0
    llvm.br ^bb4(%1 : i8)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i8)
  ^bb3:  // 2 preds: ^bb0, ^bb0
    llvm.br ^bb4(%2 : i8)
  ^bb4(%3: i8):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.return %3 : i8
  }
}
