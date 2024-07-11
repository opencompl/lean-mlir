import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bittest
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z12h000007_testv_before := [llvmfunc|
  llvm.func @_Z12h000007_testv(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @b_rec.0 : !llvm.ptr
    %1 = llvm.mlir.constant(-989855744 : i32) : i32
    %2 = llvm.mlir.constant(-805306369 : i32) : i32
    %3 = llvm.mlir.constant(-973078529 : i32) : i32
    %4 = llvm.mlir.constant(-1073741824 : i32) : i32
    %5 = llvm.mlir.constant(100663295 : i32) : i32
    %6 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %7 = llvm.or %6, %1  : i32
    %8 = llvm.and %7, %2  : i32
    %9 = llvm.and %7, %3  : i32
    llvm.store %9, %0 {alignment = 4 : i64} : i32, !llvm.ptr]

    %10 = llvm.bitcast %8 : i32 to i32
    %11 = llvm.and %10, %4  : i32
    %12 = llvm.icmp "eq" %11, %4 : i32
    llvm.cond_br %12, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @abort() : () -> ()
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %13 = llvm.bitcast %8 : i32 to i32
    %14 = llvm.and %13, %5  : i32
    llvm.store %14, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def _Z12h000007_testv_combined := [llvmfunc|
  llvm.func @_Z12h000007_testv(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @b_rec.0 : !llvm.ptr
    %1 = llvm.mlir.constant(-989855744 : i32) : i32
    %2 = llvm.mlir.constant(-973078529 : i32) : i32
    %3 = llvm.mlir.constant(100663295 : i32) : i32
    %4 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine__Z12h000007_testv   : _Z12h000007_testv_before  ⊑  _Z12h000007_testv_combined := by
  unfold _Z12h000007_testv_before _Z12h000007_testv_combined
  simp_alive_peephole
  sorry
    %5 = llvm.or %4, %1  : i32
    %6 = llvm.and %5, %2  : i32
    llvm.store %6, %0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z12h000007_testv   : _Z12h000007_testv_before  ⊑  _Z12h000007_testv_combined := by
  unfold _Z12h000007_testv_before _Z12h000007_testv_combined
  simp_alive_peephole
  sorry
    %7 = llvm.and %5, %3  : i32
    llvm.store %7, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z12h000007_testv   : _Z12h000007_testv_before  ⊑  _Z12h000007_testv_combined := by
  unfold _Z12h000007_testv_before _Z12h000007_testv_combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine__Z12h000007_testv   : _Z12h000007_testv_before  ⊑  _Z12h000007_testv_combined := by
  unfold _Z12h000007_testv_before _Z12h000007_testv_combined
  simp_alive_peephole
  sorry
