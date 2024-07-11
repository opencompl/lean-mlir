import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-10-23-ConstFoldWithoutMask
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def tstid_before := [llvmfunc|
  llvm.func @tstid() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }]

def tstid_combined := [llvmfunc|
  llvm.func @tstid() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_tstid   : tstid_before  ⊑  tstid_combined := by
  unfold tstid_before tstid_combined
  simp_alive_peephole
  sorry
