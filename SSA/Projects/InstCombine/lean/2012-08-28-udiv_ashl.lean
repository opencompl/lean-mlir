import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2012-08-28-udiv_ashl
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def udiv400_before := [llvmfunc|
  llvm.func @udiv400(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.udiv %2, %1  : i32
    llvm.return %3 : i32
  }]

def udiv400_no_before := [llvmfunc|
  llvm.func @udiv400_no(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.udiv %2, %1  : i32
    llvm.return %3 : i32
  }]

def sdiv400_yes_before := [llvmfunc|
  llvm.func @sdiv400_yes(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.sdiv %2, %1  : i32
    llvm.return %3 : i32
  }]

def udiv_i80_before := [llvmfunc|
  llvm.func @udiv_i80(%arg0: i80) -> i80 {
    %0 = llvm.mlir.constant(2 : i80) : i80
    %1 = llvm.mlir.constant(100 : i80) : i80
    %2 = llvm.lshr %arg0, %0  : i80
    %3 = llvm.udiv %2, %1  : i80
    llvm.return %3 : i80
  }]

def no_crash_notconst_udiv_before := [llvmfunc|
  llvm.func @no_crash_notconst_udiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }]

def udiv400_combined := [llvmfunc|
  llvm.func @udiv400(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(400 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_udiv400   : udiv400_before  ⊑  udiv400_combined := by
  unfold udiv400_before udiv400_combined
  simp_alive_peephole
  sorry
def udiv400_no_combined := [llvmfunc|
  llvm.func @udiv400_no(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(100 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.udiv %2, %1  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_udiv400_no   : udiv400_no_before  ⊑  udiv400_no_combined := by
  unfold udiv400_no_before udiv400_no_combined
  simp_alive_peephole
  sorry
def sdiv400_yes_combined := [llvmfunc|
  llvm.func @sdiv400_yes(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(400 : i32) : i32
    %1 = llvm.udiv %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_sdiv400_yes   : sdiv400_yes_before  ⊑  sdiv400_yes_combined := by
  unfold sdiv400_yes_before sdiv400_yes_combined
  simp_alive_peephole
  sorry
def udiv_i80_combined := [llvmfunc|
  llvm.func @udiv_i80(%arg0: i80) -> i80 {
    %0 = llvm.mlir.constant(400 : i80) : i80
    %1 = llvm.udiv %arg0, %0  : i80
    llvm.return %1 : i80
  }]

theorem inst_combine_udiv_i80   : udiv_i80_before  ⊑  udiv_i80_combined := by
  unfold udiv_i80_before udiv_i80_combined
  simp_alive_peephole
  sorry
def no_crash_notconst_udiv_combined := [llvmfunc|
  llvm.func @no_crash_notconst_udiv(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.udiv %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_no_crash_notconst_udiv   : no_crash_notconst_udiv_before  ⊑  no_crash_notconst_udiv_combined := by
  unfold no_crash_notconst_udiv_before no_crash_notconst_udiv_combined
  simp_alive_peephole
  sorry
