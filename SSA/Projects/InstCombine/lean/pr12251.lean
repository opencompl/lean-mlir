import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr12251
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> _before := [llvmfunc|
  llvm.func @_Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8]

    %3 = llvm.and %2, %0  : i8
    %4 = llvm.icmp "ne" %3, %1 : i8
    llvm.return %4 : i1
  }]

def _Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> _combined := [llvmfunc|
  llvm.func @_Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> (i1 {llvm.zeroext}) {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine__Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) ->    : _Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> _before  ⊑  _Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> _combined := by
  unfold _Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> _before _Z3fooPb(%arg0: !llvm.ptr {llvm.nocapture}) -> _combined
  simp_alive_peephole
  sorry
