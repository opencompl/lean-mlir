import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr34627
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def patatino_before := [llvmfunc|
  llvm.func @patatino() -> vector<2xi16> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.undef : vector<2xi16>
    %3 = llvm.getelementptr inbounds %0[%1, %2] : (!llvm.ptr, i16, vector<2xi16>) -> !llvm.vec<2 x ptr>, !llvm.array<1 x i16>
    %4 = llvm.ptrtoint %3 : !llvm.vec<2 x ptr> to vector<2xi16>
    llvm.return %4 : vector<2xi16>
  }]

def patatino_combined := [llvmfunc|
  llvm.func @patatino() -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_patatino   : patatino_before  ⊑  patatino_combined := by
  unfold patatino_before patatino_combined
  simp_alive_peephole
  sorry
