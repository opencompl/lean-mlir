import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-add-shl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def and_add_shl_before := [llvmfunc|
  llvm.func @and_add_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(32 : i8) : i8
    %4 = llvm.icmp "ule" %arg0, %0 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.shl %1, %arg0  : i8
    %6 = llvm.add %5, %2  : i8
    %7 = llvm.and %6, %3  : i8
    llvm.return %7 : i8
  }]

def and_not_shl_before := [llvmfunc|
  llvm.func @and_not_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(5 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.icmp "ule" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.shl %1, %arg0  : i8
    %5 = llvm.xor %4, %1  : i8
    %6 = llvm.and %5, %2  : i8
    llvm.return %6 : i8
  }]

def and_add_shl_overlap_before := [llvmfunc|
  llvm.func @and_add_shl_overlap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(32 : i8) : i8
    %4 = llvm.icmp "ule" %arg0, %0 : i8
    "llvm.intr.assume"(%4) : (i1) -> ()
    %5 = llvm.shl %1, %arg0  : i8
    %6 = llvm.add %5, %2  : i8
    %7 = llvm.and %6, %3  : i8
    llvm.return %7 : i8
  }]

def and_add_shl_combined := [llvmfunc|
  llvm.func @and_add_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.icmp "ult" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.xor %5, %2  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_and_add_shl   : and_add_shl_before  ⊑  and_add_shl_combined := by
  unfold and_add_shl_before and_add_shl_combined
  simp_alive_peephole
  sorry
def and_not_shl_combined := [llvmfunc|
  llvm.func @and_not_shl(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.icmp "ult" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.xor %5, %2  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_and_not_shl   : and_not_shl_before  ⊑  and_not_shl_combined := by
  unfold and_not_shl_before and_not_shl_combined
  simp_alive_peephole
  sorry
def and_add_shl_overlap_combined := [llvmfunc|
  llvm.func @and_add_shl_overlap(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.constant(32 : i8) : i8
    %3 = llvm.icmp "ult" %arg0, %0 : i8
    "llvm.intr.assume"(%3) : (i1) -> ()
    %4 = llvm.shl %1, %arg0 overflow<nsw>  : i8
    %5 = llvm.and %4, %2  : i8
    %6 = llvm.xor %5, %2  : i8
    llvm.return %6 : i8
  }]

theorem inst_combine_and_add_shl_overlap   : and_add_shl_overlap_before  ⊑  and_add_shl_overlap_combined := by
  unfold and_add_shl_overlap_before and_add_shl_overlap_combined
  simp_alive_peephole
  sorry
