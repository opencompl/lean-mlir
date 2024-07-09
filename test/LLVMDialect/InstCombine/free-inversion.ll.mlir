module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use.i8(i8)
  llvm.func @use.i1(i1)
  llvm.func @xor_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.xor %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @xor_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.xor %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @xor_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg2, %0  : i8
    %2 = llvm.select %arg1, %1, %arg3 : i1, i8
    %3 = llvm.xor %arg0, %2  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }
  llvm.func @add_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.add %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @add_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.add %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @add_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.xor %arg2, %arg0  : i8
    %3 = llvm.xor %arg3, %0  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.add %arg0, %4  : i8
    %6 = llvm.xor %5, %1  : i8
    llvm.return %6 : i8
  }
  llvm.func @sub_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.sub %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @sub_2(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.sub %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @sub_3(%arg0: i128, %arg1: i1, %arg2: i128, %arg3: i128) -> i128 {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.mlir.constant(123 : i128) : i128
    %2 = llvm.xor %arg2, %0  : i128
    %3 = llvm.xor %arg3, %1  : i128
    %4 = llvm.select %arg1, %2, %3 : i1, i128
    %5 = llvm.sub %arg0, %4  : i128
    %6 = llvm.xor %5, %0  : i128
    llvm.return %6 : i128
  }
  llvm.func @sub_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    llvm.call @use.i8(%2) : (i8) -> ()
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.sub %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @ashr_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.ashr %4, %arg0  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @ashr_2_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.ashr %arg0, %4  : i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @select_1(%arg0: i1, %arg1: i8, %arg2: i8, %arg3: i1, %arg4: i8, %arg5: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(45 : i8) : i8
    %3 = llvm.xor %arg4, %0  : i8
    %4 = llvm.xor %arg5, %1  : i8
    %5 = llvm.select %arg3, %3, %4 : i1, i8
    %6 = llvm.xor %arg1, %2  : i8
    %7 = llvm.xor %arg2, %6  : i8
    %8 = llvm.select %arg0, %7, %5 : i1, i8
    %9 = llvm.xor %8, %0  : i8
    llvm.return %9 : i8
  }
  llvm.func @select_2(%arg0: i1, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(45 : i8) : i8
    %3 = llvm.xor %arg3, %0  : i8
    %4 = llvm.xor %arg4, %1  : i8
    %5 = llvm.select %arg2, %3, %4 : i1, i8
    %6 = llvm.xor %arg1, %2  : i8
    %7 = llvm.select %arg0, %5, %6 : i1, i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @select_logic_or_fail(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.xor %arg2, %0  : i1
    %4 = llvm.icmp "eq" %arg3, %1 : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i1
    %6 = llvm.select %arg0, %5, %2 : i1, i1
    %7 = llvm.xor %6, %0  : i1
    llvm.return %7 : i1
  }
  llvm.func @select_logic_and_fail(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i1
    %3 = llvm.icmp "eq" %arg3, %1 : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i1
    %5 = llvm.select %arg0, %0, %4 : i1, i1
    %6 = llvm.xor %5, %0  : i1
    llvm.return %6 : i1
  }
  llvm.func @smin_1(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.xor %arg4, %1  : i8
    %4 = llvm.select %arg2, %2, %3 : i1, i8
    %5 = llvm.xor %arg1, %0  : i8
    %6 = llvm.add %arg0, %5  : i8
    %7 = llvm.intr.smin(%6, %4)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @smin_1_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg2, %0  : i8
    %3 = llvm.xor %arg3, %1  : i8
    %4 = llvm.select %arg1, %2, %3 : i1, i8
    %5 = llvm.intr.smin(%arg0, %4)  : (i8, i8) -> i8
    %6 = llvm.xor %5, %0  : i8
    llvm.return %6 : i8
  }
  llvm.func @umin_1_fail(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(85 : i8) : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.select %arg0, %2, %arg2 : i1, i8
    %4 = llvm.intr.umin(%3, %1)  : (i8, i8) -> i8
    %5 = llvm.xor %4, %0  : i8
    llvm.return %5 : i8
  }
  llvm.func @smax_1(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.xor %arg4, %1  : i8
    %4 = llvm.select %arg2, %2, %3 : i1, i8
    %5 = llvm.xor %arg1, %0  : i8
    %6 = llvm.sub %5, %arg0  : i8
    %7 = llvm.intr.smax(%6, %4)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @smax_1_fail(%arg0: i8, %arg1: i8, %arg2: i1, %arg3: i8, %arg4: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.xor %arg3, %0  : i8
    %3 = llvm.xor %arg4, %1  : i8
    llvm.call @use.i8(%3) : (i8) -> ()
    %4 = llvm.select %arg2, %2, %3 : i1, i8
    %5 = llvm.xor %arg1, %0  : i8
    %6 = llvm.sub %5, %arg0  : i8
    %7 = llvm.intr.smax(%6, %4)  : (i8, i8) -> i8
    %8 = llvm.xor %7, %0  : i8
    llvm.return %8 : i8
  }
  llvm.func @umax_1(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(85 : i8) : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %1  : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i8
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.xor %6, %0  : i8
    llvm.return %7 : i8
  }
  llvm.func @umax_1_fail(%arg0: i8, %arg1: i1, %arg2: i8, %arg3: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(123 : i8) : i8
    %2 = llvm.mlir.constant(85 : i8) : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.xor %arg3, %1  : i8
    %5 = llvm.select %arg1, %3, %4 : i1, i8
    llvm.call @use.i8(%5) : (i8) -> ()
    %6 = llvm.intr.umax(%5, %2)  : (i8, i8) -> i8
    %7 = llvm.xor %6, %0  : i8
    llvm.return %7 : i8
  }
  llvm.func @sub_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.sub %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @add_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.add %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.add %arg0, %0  : i8
    %3 = llvm.add %arg1, %1  : i8
    %4 = llvm.xor %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @ashr_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @select_both_freely_invertable_always(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %1  : i8
    %4 = llvm.select %arg0, %2, %3 : i1, i8
    llvm.return %4 : i8
  }
  llvm.func @umin_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.umin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @umax_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.umax(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @smin_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.smin(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @smax_both_freely_invertable_always(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(123 : i8) : i8
    %1 = llvm.mlir.constant(45 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.xor %arg1, %1  : i8
    %4 = llvm.intr.smax(%2, %3)  : (i8, i8) -> i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_nneg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.icmp "slt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.xor %arg0, %1  : i8
    %4 = llvm.lshr %3, %arg1  : i8
    %5 = llvm.xor %4, %1  : i8
    llvm.return %5 : i8
  }
  llvm.func @lshr_not_nneg(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.lshr %1, %arg1  : i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }
  llvm.func @lshr_not_nneg2(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.xor %arg0, %0  : i8
    %3 = llvm.lshr %2, %1  : i8
    %4 = llvm.xor %3, %0  : i8
    llvm.return %4 : i8
  }
  llvm.func @test_inv_free(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  ^bb6:  // pred: ^bb4
    llvm.return %0 : i1
  }
  llvm.func @test_inv_free_i32(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i32), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i32
    llvm.br ^bb4(%2 : i32)
  ^bb4(%3: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %4 = llvm.xor %arg3, %1  : i32
    %5 = llvm.xor %3, %4  : i32
    llvm.return %5 : i32
  }
  llvm.func @test_inv_free_multiuse(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 3 preds: ^bb1, ^bb2, ^bb3
    llvm.call @use.i1(%3) : (i1) -> ()
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    llvm.cond_br %5, ^bb5, ^bb6
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  ^bb6:  // pred: ^bb4
    llvm.return %0 : i1
  }
  llvm.func @test_inv_free_i32_newinst(%arg0: i1, %arg1: i1, %arg2: i32, %arg3: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(-8 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i32), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i32)
  ^bb3:  // pred: ^bb1
    %3 = llvm.ashr %2, %arg2  : i32
    llvm.br ^bb4(%3 : i32)
  ^bb4(%4: i32):  // 3 preds: ^bb1, ^bb2, ^bb3
    %5 = llvm.xor %arg3, %1  : i32
    %6 = llvm.xor %4, %5  : i32
    llvm.return %6 : i32
  }
  llvm.func @test_inv_free_loop(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i1) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb4(%1 : i1), ^bb3
  ^bb2:  // pred: ^bb0
    llvm.br ^bb4(%0 : i1)
  ^bb3:  // pred: ^bb1
    %2 = llvm.xor %arg2, %1  : i1
    llvm.br ^bb4(%2 : i1)
  ^bb4(%3: i1):  // 4 preds: ^bb1, ^bb2, ^bb3, ^bb4
    %4 = llvm.xor %arg3, %1  : i1
    %5 = llvm.or %3, %4  : i1
    %6 = llvm.xor %3, %1  : i1
    llvm.cond_br %5, ^bb4(%6 : i1), ^bb5
  ^bb5:  // pred: ^bb4
    llvm.return %1 : i1
  }
}
