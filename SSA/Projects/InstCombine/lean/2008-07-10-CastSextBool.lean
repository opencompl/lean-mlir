import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-07-10-CastSextBool
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR2539_A_before := [llvmfunc|
  llvm.func @PR2539_A(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.zext %arg0 : i1 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def PR2539_B_before := [llvmfunc|
  llvm.func @PR2539_B(%arg0: i1 {llvm.zeroext}) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.icmp "slt" %arg0, %0 : i1
    llvm.return %1 : i1
  }]

def PR2539_A_combined := [llvmfunc|
  llvm.func @PR2539_A(%arg0: i1) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.xor %arg0, %0  : i1
    llvm.return %1 : i1
  }]

theorem inst_combine_PR2539_A   : PR2539_A_before  ⊑  PR2539_A_combined := by
  unfold PR2539_A_before PR2539_A_combined
  simp_alive_peephole
  sorry
def PR2539_B_combined := [llvmfunc|
  llvm.func @PR2539_B(%arg0: i1 {llvm.zeroext}) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_PR2539_B   : PR2539_B_before  ⊑  PR2539_B_combined := by
  unfold PR2539_B_before PR2539_B_combined
  simp_alive_peephole
  sorry
