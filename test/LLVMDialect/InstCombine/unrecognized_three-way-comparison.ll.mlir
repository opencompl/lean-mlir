module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(i32)
  llvm.func @compare_against_arbitrary_value(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_zero(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_one(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %0 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_two(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_three(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_four(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_five(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(5 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_six(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_arbitrary_value_non_idiomatic_1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-6 : i32) : i32
    %1 = llvm.mlir.constant(425 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_zero_non_idiomatic_add(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.mlir.constant(425 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_arbitrary_value_non_idiomatic_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-5 : i32) : i32
    %1 = llvm.mlir.constant(425 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_zero_non_idiomatic_or(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.mlir.constant(425 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %0 : i32
    %5 = llvm.icmp "slt" %arg0, %0 : i32
    %6 = llvm.select %5, %1, %2 : i1, i32
    %7 = llvm.select %4, %0, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %0 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_arbitrary_value_type_mismatch(%arg0: i64, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i64
    %5 = llvm.icmp "slt" %arg0, %arg1 : i64
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_zero_type_mismatch_idiomatic(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.icmp "slt" %arg0, %0 : i64
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_zero_type_mismatch_non_idiomatic_1(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-7 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.icmp "slt" %arg0, %0 : i64
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_zero_type_mismatch_non_idiomatic_2(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(-6 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(42 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i64
    %6 = llvm.icmp "slt" %arg0, %0 : i64
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @use1(i1)
  llvm.func @compare_against_fortytwo_commutatibility_0(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(84 : i32) : i32
    %5 = llvm.icmp "eq" %arg0, %0 : i32
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %3, %7 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_fortytwo_commutatibility_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.constant(84 : i32) : i32
    %5 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use1(%5) : (i1) -> ()
    %6 = llvm.icmp "slt" %arg0, %0 : i32
    %7 = llvm.select %6, %1, %2 : i1, i32
    %8 = llvm.select %5, %7, %3 : i1, i32
    %9 = llvm.icmp "sgt" %8, %3 : i32
    llvm.cond_br %9, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%8) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @compare_against_fortytwo_commutatibility_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(84 : i32) : i32
    %6 = llvm.icmp "eq" %arg0, %0 : i32
    %7 = llvm.icmp "sgt" %arg0, %1 : i32
    %8 = llvm.select %7, %2, %3 : i1, i32
    %9 = llvm.select %6, %4, %8 : i1, i32
    %10 = llvm.icmp "sgt" %9, %4 : i32
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%9) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }
  llvm.func @compare_against_fortytwo_commutatibility_3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(41 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.constant(84 : i32) : i32
    %6 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.call @use1(%6) : (i1) -> ()
    %7 = llvm.icmp "sgt" %arg0, %1 : i32
    %8 = llvm.select %7, %2, %3 : i1, i32
    %9 = llvm.select %6, %8, %4 : i1, i32
    %10 = llvm.icmp "sgt" %9, %4 : i32
    llvm.cond_br %10, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%9) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %5 : i32
  }
  llvm.func @compare_against_arbitrary_value_commutativity0(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_arbitrary_value_commutativity1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "eq" %arg0, %arg1 : i32
    %5 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %2, %6 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_arbitrary_value_commutativity2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "slt" %arg0, %arg1 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %6, %2 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
  llvm.func @compare_against_arbitrary_value_commutativity3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(42 : i32) : i32
    %4 = llvm.icmp "ne" %arg0, %arg1 : i32
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.icmp "sgt" %arg1, %arg0 : i32
    %6 = llvm.select %5, %0, %1 : i1, i32
    %7 = llvm.select %4, %6, %2 : i1, i32
    %8 = llvm.icmp "sgt" %7, %2 : i32
    llvm.cond_br %8, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.call @foo(%7) : (i32) -> ()
    llvm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : i32
  }
}
