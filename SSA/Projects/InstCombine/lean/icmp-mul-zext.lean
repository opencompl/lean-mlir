import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-mul-zext
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def sterix_before := [llvmfunc|
  llvm.func @sterix(%arg0: i32, %arg1: i8, %arg2: i64) -> i32 {
    %0 = llvm.mlir.constant(1945964878 : i32) : i32
    %1 = llvm.mlir.constant(4294967295 : i64) : i64
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.zext %arg0 : i32 to i64
    %5 = llvm.sext %arg1 : i8 to i32
    %6 = llvm.mul %5, %0  : i32
    %7 = llvm.trunc %arg2 : i64 to i32
    %8 = llvm.lshr %6, %7  : i32
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.mul %4, %9 overflow<nsw, nuw>  : i64
    %11 = llvm.and %10, %1  : i64
    %12 = llvm.icmp "ne" %11, %10 : i64
    llvm.cond_br %12, ^bb2(%2 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %13 = llvm.and %arg2, %10  : i64
    %14 = llvm.trunc %13 : i64 to i32
    %15 = llvm.icmp "ne" %14, %3 : i32
    %16 = llvm.xor %15, %2  : i1
    llvm.br ^bb2(%16 : i1)
  ^bb2(%17: i1):  // 2 preds: ^bb0, ^bb1
    %18 = llvm.zext %17 : i1 to i32
    llvm.return %18 : i32
  }]

def PR33765_before := [llvmfunc|
  llvm.func @PR33765(%arg0: i8) {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.addressof @glob : !llvm.ptr
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.mul %2, %2 overflow<nsw, nuw>  : i32
    %4 = llvm.and %3, %0  : i32
    %5 = llvm.icmp "ne" %3, %4 : i32
    llvm.cond_br %5, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %6 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16]

    %7 = llvm.sext %6 : i16 to i32
    %8 = llvm.and %3, %7  : i32
    %9 = llvm.trunc %8 : i32 to i16
    llvm.store %9, %1 {alignment = 2 : i64} : i16, !llvm.ptr]

    llvm.return
  }]

def iter_breaker_before := [llvmfunc|
  llvm.func @iter_breaker(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(65535 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.zext %arg1 : i16 to i32
    %3 = llvm.mul %1, %2  : i32
    %4 = llvm.trunc %3 : i32 to i8
    %5 = llvm.trunc %3 : i32 to i16
    %6 = llvm.icmp "ugt" %3, %0 : i32
    llvm.cond_br %6, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %7 = llvm.call @aux(%4) : (i8) -> i16
    llvm.return %7 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %5 : i16
  }]

def PR46561_before := [llvmfunc|
  llvm.func @PR46561(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    %2 = llvm.trunc %arg3 : i8 to i1
    %3 = llvm.zext %arg1 : i1 to i32
    %4 = llvm.zext %arg2 : i1 to i32
    %5 = llvm.zext %2 : i1 to i32
    %6 = llvm.mul %3, %4  : i32
    %7 = llvm.xor %6, %5  : i32
    llvm.br ^bb2(%7 : i32)
  ^bb2(%8: i32):  // 2 preds: ^bb0, ^bb1
    %9 = llvm.icmp "eq" %8, %1 : i32
    llvm.return %9 : i1
  }]

def sterix_combined := [llvmfunc|
  llvm.func @sterix(%arg0: i32, %arg1: i8, %arg2: i64) -> i32 {
    %0 = llvm.mlir.constant(1945964878 : i32) : i32
    %1 = llvm.mlir.constant(4294967296 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i64) : i64
    %4 = llvm.zext %arg0 : i32 to i64
    %5 = llvm.sext %arg1 : i8 to i32
    %6 = llvm.mul %5, %0  : i32
    %7 = llvm.trunc %arg2 : i64 to i32
    %8 = llvm.lshr %6, %7  : i32
    %9 = llvm.zext %8 : i32 to i64
    %10 = llvm.mul %4, %9 overflow<nsw, nuw>  : i64
    %11 = llvm.icmp "ult" %10, %1 : i64
    llvm.cond_br %11, ^bb1, ^bb2(%2 : i32)
  ^bb1:  // pred: ^bb0
    %12 = llvm.and %10, %arg2  : i64
    %13 = llvm.icmp "eq" %12, %3 : i64
    %14 = llvm.zext %13 : i1 to i32
    llvm.br ^bb2(%14 : i32)
  ^bb2(%15: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %15 : i32
  }]

theorem inst_combine_sterix   : sterix_before  ⊑  sterix_combined := by
  unfold sterix_before sterix_combined
  simp_alive_peephole
  sorry
def PR33765_combined := [llvmfunc|
  llvm.func @PR33765(%arg0: i8) {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.addressof @glob : !llvm.ptr
    llvm.cond_br %0, ^bb1, ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb0
    %2 = llvm.zext %arg0 : i8 to i32
    %3 = llvm.mul %2, %2 overflow<nsw, nuw>  : i32
    %4 = llvm.load %1 {alignment = 2 : i64} : !llvm.ptr -> i16
    %5 = llvm.trunc %3 : i32 to i16
    %6 = llvm.and %4, %5  : i16
    llvm.store %6, %1 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_PR33765   : PR33765_before  ⊑  PR33765_combined := by
  unfold PR33765_before PR33765_combined
  simp_alive_peephole
  sorry
def iter_breaker_combined := [llvmfunc|
  llvm.func @iter_breaker(%arg0: i16, %arg1: i16) -> i16 {
    %0 = "llvm.intr.umul.with.overflow"(%arg0, %arg1) : (i16, i16) -> !llvm.struct<(i16, i1)>
    %1 = llvm.extractvalue %0[0] : !llvm.struct<(i16, i1)> 
    %2 = llvm.extractvalue %0[1] : !llvm.struct<(i16, i1)> 
    llvm.cond_br %2, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.trunc %1 : i16 to i8
    %4 = llvm.call @aux(%3) : (i8) -> i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i16
  }]

theorem inst_combine_iter_breaker   : iter_breaker_before  ⊑  iter_breaker_combined := by
  unfold iter_breaker_before iter_breaker_combined
  simp_alive_peephole
  sorry
def PR46561_combined := [llvmfunc|
  llvm.func @PR46561(%arg0: i1, %arg1: i1, %arg2: i1, %arg3: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    llvm.cond_br %arg0, ^bb1, ^bb2(%0 : i1)
  ^bb1:  // pred: ^bb0
    %3 = llvm.and %arg1, %arg2  : i1
    %4 = llvm.and %arg3, %1  : i8
    %5 = llvm.icmp "eq" %4, %2 : i8
    %6 = llvm.xor %3, %5  : i1
    llvm.br ^bb2(%6 : i1)
  ^bb2(%7: i1):  // 2 preds: ^bb0, ^bb1
    llvm.return %7 : i1
  }]

theorem inst_combine_PR46561   : PR46561_before  ⊑  PR46561_combined := by
  unfold PR46561_before PR46561_combined
  simp_alive_peephole
  sorry
