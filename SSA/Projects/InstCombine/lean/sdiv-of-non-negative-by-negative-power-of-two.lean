import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  sdiv-of-non-negative-by-negative-power-of-two
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t0_before := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.icmp "sge" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %1  : i8
    llvm.return %3 : i8
  }]

def n1_before := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.icmp "sge" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %1  : i8
    llvm.return %3 : i8
  }]

def n2_before := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.icmp "sge" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %1  : i8
    llvm.return %3 : i8
  }]

def t0_combined := [llvmfunc|
  llvm.func @t0(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.icmp "sgt" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.lshr %arg0, %1  : i8
    %5 = llvm.sub %2, %4 overflow<nsw>  : i8
    llvm.return %5 : i8
  }]

theorem inst_combine_t0   : t0_before  ⊑  t0_combined := by
  unfold t0_before t0_combined
  simp_alive_peephole
  sorry
def n1_combined := [llvmfunc|
  llvm.func @n1(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(-32 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n1   : n1_before  ⊑  n1_combined := by
  unfold n1_before n1_combined
  simp_alive_peephole
  sorry
def n2_combined := [llvmfunc|
  llvm.func @n2(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    "llvm.intr.assume"(%2) : (i1) -> ()
    %3 = llvm.sdiv %arg0, %1  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_n2   : n2_before  ⊑  n2_combined := by
  unfold n2_before n2_combined
  simp_alive_peephole
  sorry
