import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  demorgan-sink-not-into-xor
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def positive_easyinvert_before := [llvmfunc|
  llvm.func @positive_easyinvert(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.icmp "slt" %arg0, %0 : i16
    %4 = llvm.icmp "slt" %arg1, %1 : i8
    %5 = llvm.xor %4, %3  : i1
    %6 = llvm.xor %5, %2  : i1
    llvm.return %6 : i1
  }]

def positive_easyinvert0_before := [llvmfunc|
  llvm.func @positive_easyinvert0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.xor %3, %2  : i1
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

def positive_easyinvert1_before := [llvmfunc|
  llvm.func @positive_easyinvert1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.xor %2, %3  : i1
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

def oneuse_easyinvert_0_before := [llvmfunc|
  llvm.func @oneuse_easyinvert_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

def oneuse_easyinvert_1_before := [llvmfunc|
  llvm.func @oneuse_easyinvert_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.xor %2, %3  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

def oneuse_easyinvert_2_before := [llvmfunc|
  llvm.func @oneuse_easyinvert_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

def negative_before := [llvmfunc|
  llvm.func @negative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

def positive_easyinvert_combined := [llvmfunc|
  llvm.func @positive_easyinvert(%arg0: i16, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i16) : i16
    %2 = llvm.icmp "slt" %arg1, %0 : i8
    %3 = llvm.icmp "sgt" %arg0, %1 : i16
    %4 = llvm.xor %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_positive_easyinvert   : positive_easyinvert_before  ⊑  positive_easyinvert_combined := by
  unfold positive_easyinvert_before positive_easyinvert_combined
  simp_alive_peephole
  sorry
def positive_easyinvert0_combined := [llvmfunc|
  llvm.func @positive_easyinvert0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.xor %2, %1  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_positive_easyinvert0   : positive_easyinvert0_before  ⊑  positive_easyinvert0_combined := by
  unfold positive_easyinvert0_before positive_easyinvert0_combined
  simp_alive_peephole
  sorry
def positive_easyinvert1_combined := [llvmfunc|
  llvm.func @positive_easyinvert1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.call @gen1() : () -> i1
    %2 = llvm.icmp "sgt" %arg0, %0 : i8
    %3 = llvm.xor %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_positive_easyinvert1   : positive_easyinvert1_before  ⊑  positive_easyinvert1_combined := by
  unfold positive_easyinvert1_before positive_easyinvert1_combined
  simp_alive_peephole
  sorry
def oneuse_easyinvert_0_combined := [llvmfunc|
  llvm.func @oneuse_easyinvert_0(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_oneuse_easyinvert_0   : oneuse_easyinvert_0_before  ⊑  oneuse_easyinvert_0_combined := by
  unfold oneuse_easyinvert_0_before oneuse_easyinvert_0_combined
  simp_alive_peephole
  sorry
def oneuse_easyinvert_1_combined := [llvmfunc|
  llvm.func @oneuse_easyinvert_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    %4 = llvm.xor %2, %3  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_oneuse_easyinvert_1   : oneuse_easyinvert_1_before  ⊑  oneuse_easyinvert_1_combined := by
  unfold oneuse_easyinvert_1_before oneuse_easyinvert_1_combined
  simp_alive_peephole
  sorry
def oneuse_easyinvert_2_combined := [llvmfunc|
  llvm.func @oneuse_easyinvert_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.call @gen1() : () -> i1
    %3 = llvm.icmp "slt" %arg0, %0 : i8
    llvm.call @use1(%3) : (i1) -> ()
    %4 = llvm.xor %2, %3  : i1
    llvm.call @use1(%4) : (i1) -> ()
    %5 = llvm.xor %4, %1  : i1
    llvm.return %5 : i1
  }]

theorem inst_combine_oneuse_easyinvert_2   : oneuse_easyinvert_2_before  ⊑  oneuse_easyinvert_2_combined := by
  unfold oneuse_easyinvert_2_before oneuse_easyinvert_2_combined
  simp_alive_peephole
  sorry
def negative_combined := [llvmfunc|
  llvm.func @negative(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %arg1  : i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_negative   : negative_before  ⊑  negative_combined := by
  unfold negative_before negative_combined
  simp_alive_peephole
  sorry
