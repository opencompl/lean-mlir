import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-xor-merge
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg2, %arg0  : i32
    %1 = llvm.and %arg2, %arg1  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def test2_before := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.and %arg1, %arg0  : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.xor %0, %1  : i32
    llvm.return %2 : i32
  }]

def PR38781_before := [llvmfunc|
  llvm.func @PR38781(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.xor %2, %1  : i32
    %4 = llvm.lshr %arg1, %0  : i32
    %5 = llvm.xor %4, %1  : i32
    %6 = llvm.and %5, %3  : i32
    llvm.return %6 : i32
  }]

def PR75692_1_before := [llvmfunc|
  llvm.func @PR75692_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def PR75692_2_before := [llvmfunc|
  llvm.func @PR75692_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def PR75692_3_before := [llvmfunc|
  llvm.func @PR75692_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg0, %arg1  : i32
    %1 = llvm.and %0, %arg2  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test2_combined := [llvmfunc|
  llvm.func @test2(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.xor %arg1, %arg0  : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test2   : test2_before  ⊑  test2_combined := by
  unfold test2_before test2_combined
  simp_alive_peephole
  sorry
def PR38781_combined := [llvmfunc|
  llvm.func @PR38781(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.or %arg1, %arg0  : i32
    %2 = llvm.icmp "sgt" %1, %0 : i32
    %3 = llvm.zext %2 : i1 to i32
    llvm.return %3 : i32
  }]

theorem inst_combine_PR38781   : PR38781_before  ⊑  PR38781_combined := by
  unfold PR38781_before PR38781_combined
  simp_alive_peephole
  sorry
def PR75692_1_combined := [llvmfunc|
  llvm.func @PR75692_1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_PR75692_1   : PR75692_1_before  ⊑  PR75692_1_combined := by
  unfold PR75692_1_before PR75692_1_combined
  simp_alive_peephole
  sorry
def PR75692_2_combined := [llvmfunc|
  llvm.func @PR75692_2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg0, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_PR75692_2   : PR75692_2_before  ⊑  PR75692_2_combined := by
  unfold PR75692_2_before PR75692_2_combined
  simp_alive_peephole
  sorry
def PR75692_3_combined := [llvmfunc|
  llvm.func @PR75692_3(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(4 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.and %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_PR75692_3   : PR75692_3_before  ⊑  PR75692_3_combined := by
  unfold PR75692_3_before PR75692_3_combined
  simp_alive_peephole
  sorry
