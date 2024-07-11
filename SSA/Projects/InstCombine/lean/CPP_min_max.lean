import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  CPP_min_max
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z5test1RiS__before := [llvmfunc|
  llvm.func @_Z5test1RiS_(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %2 = llvm.icmp "slt" %0, %1 : i32
    %3 = llvm.select %2, %arg1, %arg0 : i1, !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %4, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def _Z5test2RiS__before := [llvmfunc|
  llvm.func @_Z5test2RiS_(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %2, %1 {alignment = 4 : i64} : i32, !llvm.ptr]

    %3 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %4 = llvm.icmp "slt" %2, %3 : i32
    %5 = llvm.select %4, %arg1, %1 : i1, !llvm.ptr
    %6 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> i32]

    llvm.store %6, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def _Z5test1RiS__combined := [llvmfunc|
  llvm.func @_Z5test1RiS_(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine__Z5test1RiS_   : _Z5test1RiS__before  ⊑  _Z5test1RiS__combined := by
  unfold _Z5test1RiS__before _Z5test1RiS__combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine__Z5test1RiS_   : _Z5test1RiS__before  ⊑  _Z5test1RiS__combined := by
  unfold _Z5test1RiS__before _Z5test1RiS__combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.smin(%0, %1)  : (i32, i32) -> i32
    llvm.store %2, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z5test1RiS_   : _Z5test1RiS__before  ⊑  _Z5test1RiS__combined := by
  unfold _Z5test1RiS__before _Z5test1RiS__combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine__Z5test1RiS_   : _Z5test1RiS__before  ⊑  _Z5test1RiS__combined := by
  unfold _Z5test1RiS__before _Z5test1RiS__combined
  simp_alive_peephole
  sorry
def _Z5test2RiS__combined := [llvmfunc|
  llvm.func @_Z5test2RiS_(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine__Z5test2RiS_   : _Z5test2RiS__before  ⊑  _Z5test2RiS__combined := by
  unfold _Z5test2RiS__before _Z5test2RiS__combined
  simp_alive_peephole
  sorry
    %1 = llvm.load %arg1 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine__Z5test2RiS_   : _Z5test2RiS__before  ⊑  _Z5test2RiS__combined := by
  unfold _Z5test2RiS__before _Z5test2RiS__combined
  simp_alive_peephole
  sorry
    %2 = llvm.intr.smax(%0, %1)  : (i32, i32) -> i32
    llvm.store %2, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine__Z5test2RiS_   : _Z5test2RiS__before  ⊑  _Z5test2RiS__combined := by
  unfold _Z5test2RiS__before _Z5test2RiS__combined
  simp_alive_peephole
  sorry
    llvm.return
  }]

theorem inst_combine__Z5test2RiS_   : _Z5test2RiS__before  ⊑  _Z5test2RiS__combined := by
  unfold _Z5test2RiS__before _Z5test2RiS__combined
  simp_alive_peephole
  sorry
