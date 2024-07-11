import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr41164
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z8wyhash64v_before := [llvmfunc|
  llvm.func @_Z8wyhash64v() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @wyhash64_x : !llvm.ptr
    %2 = llvm.mlir.constant(6971258582664805397 : i64) : i64
    %3 = llvm.mlir.constant(11795372955171141389 : i128) : i128
    %4 = llvm.mlir.constant(64 : i128) : i128
    %5 = llvm.mlir.constant(1946526487930394057 : i128) : i128
    %6 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> i64]

    %7 = llvm.add %6, %2  : i64
    llvm.store %7, %1 {alignment = 8 : i64} : i64, !llvm.ptr]

    %8 = llvm.zext %7 : i64 to i128
    %9 = llvm.mul %8, %3  : i128
    %10 = llvm.lshr %9, %4  : i128
    %11 = llvm.xor %10, %9  : i128
    %12 = llvm.trunc %11 : i128 to i64
    %13 = llvm.zext %12 : i64 to i128
    %14 = llvm.mul %13, %5  : i128
    %15 = llvm.lshr %14, %4  : i128
    %16 = llvm.xor %15, %14  : i128
    %17 = llvm.trunc %16 : i128 to i64
    llvm.return %17 : i64
  }]

def _Z8wyhash64v_combined := [llvmfunc|
  llvm.func @_Z8wyhash64v() -> i64 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @wyhash64_x : !llvm.ptr
    %2 = llvm.mlir.constant(6971258582664805397 : i64) : i64
    %3 = llvm.mlir.constant(11795372955171141389 : i128) : i128
    %4 = llvm.mlir.constant(64 : i128) : i128
    %5 = llvm.mlir.constant(18446744073709551615 : i128) : i128
    %6 = llvm.mlir.constant(1946526487930394057 : i128) : i128
    %7 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> i64]

theorem inst_combine__Z8wyhash64v   : _Z8wyhash64v_before  ⊑  _Z8wyhash64v_combined := by
  unfold _Z8wyhash64v_before _Z8wyhash64v_combined
  simp_alive_peephole
  sorry
    %8 = llvm.add %7, %2  : i64
    llvm.store %8, %1 {alignment = 8 : i64} : i64, !llvm.ptr]

theorem inst_combine__Z8wyhash64v   : _Z8wyhash64v_before  ⊑  _Z8wyhash64v_combined := by
  unfold _Z8wyhash64v_before _Z8wyhash64v_combined
  simp_alive_peephole
  sorry
    %9 = llvm.zext %8 : i64 to i128
    %10 = llvm.mul %9, %3 overflow<nuw>  : i128
    %11 = llvm.lshr %10, %4  : i128
    %12 = llvm.and %10, %5  : i128
    %13 = llvm.xor %11, %12  : i128
    %14 = llvm.mul %13, %6 overflow<nsw, nuw>  : i128
    %15 = llvm.lshr %14, %4  : i128
    %16 = llvm.xor %15, %14  : i128
    %17 = llvm.trunc %16 : i128 to i64
    llvm.return %17 : i64
  }]

theorem inst_combine__Z8wyhash64v   : _Z8wyhash64v_before  ⊑  _Z8wyhash64v_combined := by
  unfold _Z8wyhash64v_before _Z8wyhash64v_combined
  simp_alive_peephole
  sorry
