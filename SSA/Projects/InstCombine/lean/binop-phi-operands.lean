import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  binop-phi-operands
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def add_const_incoming0_speculative_before := [llvmfunc|
  llvm.func @add_const_incoming0_speculative(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def add_const_incoming0_nonspeculative_before := [llvmfunc|
  llvm.func @add_const_incoming0_nonspeculative(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

def sub_const_incoming0_before := [llvmfunc|
  llvm.func @sub_const_incoming0(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sub %3, %2  : i32
    llvm.return %4 : i32
  }]

def sub_const_incoming1_before := [llvmfunc|
  llvm.func @sub_const_incoming1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sub %2, %3  : i32
    llvm.return %4 : i32
  }]

def mul_const_incoming1_before := [llvmfunc|
  llvm.func @mul_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.mul %2, %3  : i8
    llvm.return %4 : i8
  }]

def and_const_incoming1_before := [llvmfunc|
  llvm.func @and_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.and %2, %3  : i8
    llvm.return %4 : i8
  }]

def xor_const_incoming1_before := [llvmfunc|
  llvm.func @xor_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.xor %2, %3  : i8
    llvm.return %4 : i8
  }]

def or_const_incoming1_before := [llvmfunc|
  llvm.func @or_const_incoming1(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }]

def or_const_incoming01_before := [llvmfunc|
  llvm.func @or_const_incoming01(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.mlir.constant(16 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }]

def or_const_incoming10_before := [llvmfunc|
  llvm.func @or_const_incoming10(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    %1 = llvm.mlir.constant(3 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg2, %arg1 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }]

def ashr_const_incoming0_speculative_before := [llvmfunc|
  llvm.func @ashr_const_incoming0_speculative(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

def ashr_const_incoming0_before := [llvmfunc|
  llvm.func @ashr_const_incoming0(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

def lshr_const_incoming1_before := [llvmfunc|
  llvm.func @lshr_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.lshr %2, %3  : i8
    llvm.return %4 : i8
  }]

def shl_const_incoming1_before := [llvmfunc|
  llvm.func @shl_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.shl %2, %3 overflow<nsw, nuw>  : i8
    llvm.return %4 : i8
  }]

def sdiv_not_safe_to_speculate_before := [llvmfunc|
  llvm.func @sdiv_not_safe_to_speculate(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sdiv %2, %3  : i8
    llvm.return %4 : i8
  }]

def sdiv_const_incoming1_before := [llvmfunc|
  llvm.func @sdiv_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sdiv %2, %3  : i8
    llvm.return %4 : i8
  }]

def udiv_const_incoming1_before := [llvmfunc|
  llvm.func @udiv_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-42 : i8) : i8
    %1 = llvm.mlir.constant(17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.udiv %2, %3  : i8
    llvm.return %4 : i8
  }]

def srem_const_incoming1_before := [llvmfunc|
  llvm.func @srem_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.srem %2, %3  : i8
    llvm.return %4 : i8
  }]

def urem_const_incoming1_before := [llvmfunc|
  llvm.func @urem_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(-17 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.urem %2, %3  : i8
    llvm.return %4 : i8
  }]

def fmul_const_incoming1_before := [llvmfunc|
  llvm.func @fmul_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.fmul %2, %3  : f32
    llvm.return %4 : f32
  }]

def fadd_const_incoming1_before := [llvmfunc|
  llvm.func @fadd_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.fadd %2, %3  {fastmathFlags = #llvm.fastmath<fast>} : f32]

    llvm.return %4 : f32
  }]

def fsub_const_incoming1_before := [llvmfunc|
  llvm.func @fsub_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.fsub %2, %3  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32]

    llvm.return %4 : f32
  }]

def frem_const_incoming1_before := [llvmfunc|
  llvm.func @frem_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %1 = llvm.mlir.constant(1.700000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : f32, f32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%arg1, %arg2 : f32, f32)
  ^bb2(%2: f32, %3: f32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.frem %2, %3  {fastmathFlags = #llvm.fastmath<nsz>} : f32]

    llvm.return %4 : f32
  }]

def add_const_incoming0_use1_before := [llvmfunc|
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
  }]

def add_const_incoming0_use2_before := [llvmfunc|
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
  }]

def or_notconst_incoming_before := [llvmfunc|
  llvm.func @or_notconst_incoming(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(43 : i64) : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %0 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1, %arg2 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }]

def mul_const_incoming0_speculatable_before := [llvmfunc|
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
  }]

def udiv_const_incoming0_not_speculatable_before := [llvmfunc|
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
  }]

def udiv_const_incoming0_different_block_before := [llvmfunc|
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
  }]

def ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<_before := [llvmfunc|
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
  }]

def add_const_incoming0_speculative_combined := [llvmfunc|
  llvm.func @add_const_incoming0_speculative(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.add %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_add_const_incoming0_speculative   : add_const_incoming0_speculative_before  ⊑  add_const_incoming0_speculative_combined := by
  unfold add_const_incoming0_speculative_before add_const_incoming0_speculative_combined
  simp_alive_peephole
  sorry
def add_const_incoming0_nonspeculative_combined := [llvmfunc|
  llvm.func @add_const_incoming0_nonspeculative(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(59 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.add %arg1, %arg2  : i32
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_add_const_incoming0_nonspeculative   : add_const_incoming0_nonspeculative_before  ⊑  add_const_incoming0_nonspeculative_combined := by
  unfold add_const_incoming0_nonspeculative_before add_const_incoming0_nonspeculative_combined
  simp_alive_peephole
  sorry
def sub_const_incoming0_combined := [llvmfunc|
  llvm.func @sub_const_incoming0(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i32, i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i32, i32)
  ^bb2(%2: i32, %3: i32):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sub %3, %2  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_sub_const_incoming0   : sub_const_incoming0_before  ⊑  sub_const_incoming0_combined := by
  unfold sub_const_incoming0_before sub_const_incoming0_combined
  simp_alive_peephole
  sorry
def sub_const_incoming1_combined := [llvmfunc|
  llvm.func @sub_const_incoming1(%arg0: i1, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(25 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.sub %arg1, %arg2  : i32
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i32
  }]

theorem inst_combine_sub_const_incoming1   : sub_const_incoming1_before  ⊑  sub_const_incoming1_combined := by
  unfold sub_const_incoming1_before sub_const_incoming1_combined
  simp_alive_peephole
  sorry
def mul_const_incoming1_combined := [llvmfunc|
  llvm.func @mul_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-54 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.mul %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_mul_const_incoming1   : mul_const_incoming1_before  ⊑  mul_const_incoming1_combined := by
  unfold mul_const_incoming1_before mul_const_incoming1_combined
  simp_alive_peephole
  sorry
def and_const_incoming1_combined := [llvmfunc|
  llvm.func @and_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.and %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_and_const_incoming1   : and_const_incoming1_before  ⊑  and_const_incoming1_combined := by
  unfold and_const_incoming1_before and_const_incoming1_combined
  simp_alive_peephole
  sorry
def xor_const_incoming1_combined := [llvmfunc|
  llvm.func @xor_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(59 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.xor %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_xor_const_incoming1   : xor_const_incoming1_before  ⊑  xor_const_incoming1_combined := by
  unfold xor_const_incoming1_before xor_const_incoming1_combined
  simp_alive_peephole
  sorry
def or_const_incoming1_combined := [llvmfunc|
  llvm.func @or_const_incoming1(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(19 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %1 = llvm.or %arg1, %arg2  : i64
    llvm.br ^bb2(%1 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

theorem inst_combine_or_const_incoming1   : or_const_incoming1_before  ⊑  or_const_incoming1_combined := by
  unfold or_const_incoming1_before or_const_incoming1_combined
  simp_alive_peephole
  sorry
def or_const_incoming01_combined := [llvmfunc|
  llvm.func @or_const_incoming01(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(19 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %1 = llvm.or %arg1, %arg2  : i64
    llvm.br ^bb2(%1 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

theorem inst_combine_or_const_incoming01   : or_const_incoming01_before  ⊑  or_const_incoming01_combined := by
  unfold or_const_incoming01_before or_const_incoming01_combined
  simp_alive_peephole
  sorry
def or_const_incoming10_combined := [llvmfunc|
  llvm.func @or_const_incoming10(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(19 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i64)
  ^bb1:  // pred: ^bb0
    %1 = llvm.or %arg2, %arg1  : i64
    llvm.br ^bb2(%1 : i64)
  ^bb2(%2: i64):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i64
  }]

theorem inst_combine_or_const_incoming10   : or_const_incoming10_before  ⊑  or_const_incoming10_combined := by
  unfold or_const_incoming10_before or_const_incoming10_combined
  simp_alive_peephole
  sorry
def ashr_const_incoming0_speculative_combined := [llvmfunc|
  llvm.func @ashr_const_incoming0_speculative(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.ashr %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_ashr_const_incoming0_speculative   : ashr_const_incoming0_speculative_before  ⊑  ashr_const_incoming0_speculative_combined := by
  unfold ashr_const_incoming0_speculative_before ashr_const_incoming0_speculative_combined
  simp_alive_peephole
  sorry
def ashr_const_incoming0_combined := [llvmfunc|
  llvm.func @ashr_const_incoming0(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.ashr %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_ashr_const_incoming0   : ashr_const_incoming0_before  ⊑  ashr_const_incoming0_combined := by
  unfold ashr_const_incoming0_before ashr_const_incoming0_combined
  simp_alive_peephole
  sorry
def lshr_const_incoming1_combined := [llvmfunc|
  llvm.func @lshr_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.lshr %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_lshr_const_incoming1   : lshr_const_incoming1_before  ⊑  lshr_const_incoming1_combined := by
  unfold lshr_const_incoming1_before lshr_const_incoming1_combined
  simp_alive_peephole
  sorry
def shl_const_incoming1_combined := [llvmfunc|
  llvm.func @shl_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.shl %arg1, %arg2 overflow<nsw, nuw>  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_shl_const_incoming1   : shl_const_incoming1_before  ⊑  shl_const_incoming1_combined := by
  unfold shl_const_incoming1_before shl_const_incoming1_combined
  simp_alive_peephole
  sorry
def sdiv_not_safe_to_speculate_combined := [llvmfunc|
  llvm.func @sdiv_not_safe_to_speculate(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %arg2 : i8, i8)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%0, %1 : i8, i8)
  ^bb2(%2: i8, %3: i8):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.sdiv %2, %3  : i8
    llvm.return %4 : i8
  }]

theorem inst_combine_sdiv_not_safe_to_speculate   : sdiv_not_safe_to_speculate_before  ⊑  sdiv_not_safe_to_speculate_combined := by
  unfold sdiv_not_safe_to_speculate_before sdiv_not_safe_to_speculate_combined
  simp_alive_peephole
  sorry
def sdiv_const_incoming1_combined := [llvmfunc|
  llvm.func @sdiv_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.sdiv %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_sdiv_const_incoming1   : sdiv_const_incoming1_before  ⊑  sdiv_const_incoming1_combined := by
  unfold sdiv_const_incoming1_before sdiv_const_incoming1_combined
  simp_alive_peephole
  sorry
def udiv_const_incoming1_combined := [llvmfunc|
  llvm.func @udiv_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(12 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.udiv %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_udiv_const_incoming1   : udiv_const_incoming1_before  ⊑  udiv_const_incoming1_combined := by
  unfold udiv_const_incoming1_before udiv_const_incoming1_combined
  simp_alive_peephole
  sorry
def srem_const_incoming1_combined := [llvmfunc|
  llvm.func @srem_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(8 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.srem %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_srem_const_incoming1   : srem_const_incoming1_before  ⊑  srem_const_incoming1_combined := by
  unfold srem_const_incoming1_before srem_const_incoming1_combined
  simp_alive_peephole
  sorry
def urem_const_incoming1_combined := [llvmfunc|
  llvm.func @urem_const_incoming1(%arg0: i1, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(42 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i8)
  ^bb1:  // pred: ^bb0
    %1 = llvm.urem %arg1, %arg2  : i8
    llvm.br ^bb2(%1 : i8)
  ^bb2(%2: i8):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : i8
  }]

theorem inst_combine_urem_const_incoming1   : urem_const_incoming1_before  ⊑  urem_const_incoming1_combined := by
  unfold urem_const_incoming1_before urem_const_incoming1_combined
  simp_alive_peephole
  sorry
def fmul_const_incoming1_combined := [llvmfunc|
  llvm.func @fmul_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(7.140000e+02 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : f32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.fmul %arg1, %arg2  : f32
    llvm.br ^bb2(%1 : f32)
  ^bb2(%2: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : f32
  }]

theorem inst_combine_fmul_const_incoming1   : fmul_const_incoming1_before  ⊑  fmul_const_incoming1_combined := by
  unfold fmul_const_incoming1_before fmul_const_incoming1_combined
  simp_alive_peephole
  sorry
def fadd_const_incoming1_combined := [llvmfunc|
  llvm.func @fadd_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(5.900000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : f32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.fadd %arg1, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.br ^bb2(%1 : f32)
  ^bb2(%2: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : f32
  }]

theorem inst_combine_fadd_const_incoming1   : fadd_const_incoming1_before  ⊑  fadd_const_incoming1_combined := by
  unfold fadd_const_incoming1_before fadd_const_incoming1_combined
  simp_alive_peephole
  sorry
def fsub_const_incoming1_combined := [llvmfunc|
  llvm.func @fsub_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(2.500000e+01 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : f32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.fsub %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nnan, ninf>} : f32
    llvm.br ^bb2(%1 : f32)
  ^bb2(%2: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : f32
  }]

theorem inst_combine_fsub_const_incoming1   : fsub_const_incoming1_before  ⊑  fsub_const_incoming1_combined := by
  unfold fsub_const_incoming1_before fsub_const_incoming1_combined
  simp_alive_peephole
  sorry
def frem_const_incoming1_combined := [llvmfunc|
  llvm.func @frem_const_incoming1(%arg0: i1, %arg1: f32, %arg2: f32) -> f32 {
    %0 = llvm.mlir.constant(8.000000e+00 : f32) : f32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : f32)
  ^bb1:  // pred: ^bb0
    %1 = llvm.frem %arg1, %arg2  {fastmathFlags = #llvm.fastmath<nsz>} : f32
    llvm.br ^bb2(%1 : f32)
  ^bb2(%2: f32):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : f32
  }]

theorem inst_combine_frem_const_incoming1   : frem_const_incoming1_before  ⊑  frem_const_incoming1_combined := by
  unfold frem_const_incoming1_before frem_const_incoming1_combined
  simp_alive_peephole
  sorry
def add_const_incoming0_use1_combined := [llvmfunc|
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
  }]

theorem inst_combine_add_const_incoming0_use1   : add_const_incoming0_use1_before  ⊑  add_const_incoming0_use1_combined := by
  unfold add_const_incoming0_use1_before add_const_incoming0_use1_combined
  simp_alive_peephole
  sorry
def add_const_incoming0_use2_combined := [llvmfunc|
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
  }]

theorem inst_combine_add_const_incoming0_use2   : add_const_incoming0_use2_before  ⊑  add_const_incoming0_use2_combined := by
  unfold add_const_incoming0_use2_before add_const_incoming0_use2_combined
  simp_alive_peephole
  sorry
def or_notconst_incoming_combined := [llvmfunc|
  llvm.func @or_notconst_incoming(%arg0: i1, %arg1: i64, %arg2: i64) -> i64 {
    %0 = llvm.mlir.constant(43 : i64) : i64
    %1 = llvm.mlir.constant(42 : i64) : i64
    llvm.cond_br %arg0, ^bb1, ^bb2(%arg1, %0 : i64, i64)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1, %arg2 : i64, i64)
  ^bb2(%2: i64, %3: i64):  // 2 preds: ^bb0, ^bb1
    %4 = llvm.or %2, %3  : i64
    llvm.return %4 : i64
  }]

theorem inst_combine_or_notconst_incoming   : or_notconst_incoming_before  ⊑  or_notconst_incoming_combined := by
  unfold or_notconst_incoming_before or_notconst_incoming_combined
  simp_alive_peephole
  sorry
def mul_const_incoming0_speculatable_combined := [llvmfunc|
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
  }]

theorem inst_combine_mul_const_incoming0_speculatable   : mul_const_incoming0_speculatable_before  ⊑  mul_const_incoming0_speculatable_combined := by
  unfold mul_const_incoming0_speculatable_before mul_const_incoming0_speculatable_combined
  simp_alive_peephole
  sorry
def udiv_const_incoming0_not_speculatable_combined := [llvmfunc|
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
  }]

theorem inst_combine_udiv_const_incoming0_not_speculatable   : udiv_const_incoming0_not_speculatable_before  ⊑  udiv_const_incoming0_not_speculatable_combined := by
  unfold udiv_const_incoming0_not_speculatable_before udiv_const_incoming0_not_speculatable_combined
  simp_alive_peephole
  sorry
def udiv_const_incoming0_different_block_combined := [llvmfunc|
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
  }]

theorem inst_combine_udiv_const_incoming0_different_block   : udiv_const_incoming0_different_block_before  ⊑  udiv_const_incoming0_different_block_combined := by
  unfold udiv_const_incoming0_different_block_before udiv_const_incoming0_different_block_combined
  simp_alive_peephole
  sorry
def ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<(i64, i32)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.poison : !llvm.struct<(i64, i32)>
    llvm.cond_br %arg0, ^bb1, ^bb2(%0, %1 : i32, i64)
  ^bb1:  // pred: ^bb0
    %3 = llvm.call %arg1() : !llvm.ptr, () -> !llvm.struct<(i64, i32)>
    %4 = llvm.extractvalue %3[0] : !llvm.struct<(i64, i32)> 
    %5 = llvm.extractvalue %3[1] : !llvm.struct<(i64, i32)> 
    llvm.br ^bb2(%5, %4 : i32, i64)
  ^bb2(%6: i32, %7: i64):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.insertvalue %7, %2[0] : !llvm.struct<(i64, i32)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(i64, i32)> 
    llvm.return %9 : !llvm.struct<(i64, i32)>
  }]

theorem inst_combine_ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<   : ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<_before  ⊑  ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<_combined := by
  unfold ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<_before ParseRetVal(%arg0: i1, %arg1: !llvm.ptr) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
