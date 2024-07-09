module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(i32)
  llvm.func @sideeffect()
  llvm.func @add_const_incoming0_speculative(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_const_incoming0_nonspeculative(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @sub_const_incoming0(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sub %3, %2  : i32
    llvm.return %4 : i32
  }
  llvm.func @sub_const_incoming1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @mul_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.mul %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @and_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @xor_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @or_const_incoming1(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @or_const_incoming01(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @or_const_incoming10(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg2, %arg1 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @ashr_const_incoming0_speculative(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @ashr_const_incoming0(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @lshr_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @shl_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.shl %2, %3 overflow<nsw, nuw>  : i8
    llvm.return %4 : i8
  }
  llvm.func @sdiv_not_safe_to_speculate(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sdiv %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @sdiv_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sdiv %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.udiv %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @srem_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.srem %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @urem_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.urem %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @fmul_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.fmul %2, %3  : f32
    llvm.return %4 : f32
  }
  llvm.func @fadd_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.return %4 : f32
  }
  llvm.func @fsub_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32
    llvm.return %4 : f32
  }
  llvm.func @frem_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.frem %2, %3  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.return %4 : f32
  }
  llvm.func @add_const_incoming0_use1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.call @use(%2) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @add_const_incoming0_use2(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    llvm.call @use(%3) : (i32) -> ()
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }
  llvm.func @or_notconst_incoming(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(43 : i64) : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %0 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1, %arg2 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }
  llvm.func @mul_const_incoming0_speculatable(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    llvm.call @sideeffect() : () -> ()
    %4 = llvm.mul %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_const_incoming0_not_speculatable(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    llvm.call @sideeffect() : () -> ()
    %4 = llvm.udiv %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @udiv_const_incoming0_different_block(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb3
  ^bb3:  // pred: ^bb2
    %4 = llvm.udiv %2, %3  : i8
    llvm.return %4 : i8
  }
  llvm.func @ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<(i64, i32)> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-4294967296 : i64) : i64
    %3 = llvm.mlir.constant(4294901760 : i64) : i64
    %4 = llvm.mlir.constant(65280 : i64) : i64
    %5 = llvm.mlir.constant(255 : i64) : i64
    %6 = llvm.mlir.poison : !llvm.struct<(i64, i32)>
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %0, %0, %0, %1 : i64, i64, i64, i64, i32)
  ^bb1:  // pred: ^bb0
    %7 = llvm.call %arg1() : !llvm.ptr, () -> !llvm.struct<(i64, i32)>
    %8 = llvm.extractvalue %7[0] : !llvm.struct<(i64, i32)> 
    %9 = llvm.extractvalue %7[1] : !llvm.struct<(i64, i32)> 
    %10 = llvm.and %8, %2  : i64
    %11 = llvm.and %8, %3  : i64
    %12 = llvm.and %8, %4  : i64
    %13 = llvm.and %8, %5  : i64
    llvm.br ^bb2(%13, %12, %11, %10, %9 : i64, i64, i64, i64, i32)
  ^bb2(%14: i64, %15: i64, %16: i64, %17: i64, %18: i32):  // 2 preds: ^bb0, ^bb1
    %19 = llvm.or %15, %14  : i64
    %20 = llvm.or %19, %16  : i64
    %21 = llvm.or %20, %17  : i64
    %22 = llvm.insertvalue %21, %6[0] : !llvm.struct<(i64, i32)> 
    %23 = llvm.insertvalue %18, %22[1] : !llvm.struct<(i64, i32)> 
    llvm.return %23 : !llvm.struct<(i64, i32)>
  }
}
