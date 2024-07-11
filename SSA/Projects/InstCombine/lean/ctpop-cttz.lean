import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ctpop-cttz
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ctpop1_before := [llvmfunc|
  llvm.func @ctpop1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    llvm.return %5 : i32
  }]

def ctpop1v_before := [llvmfunc|
  llvm.func @ctpop1v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.sub %1, %arg0  : vector<2xi32>
    %3 = llvm.or %2, %arg0  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ctpop1_multiuse_before := [llvmfunc|
  llvm.func @ctpop1_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(32 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %arg0, %2  : i32
    %4 = llvm.intr.ctpop(%3)  : (i32) -> i32
    %5 = llvm.sub %1, %4  : i32
    %6 = llvm.add %5, %3  : i32
    llvm.return %6 : i32
  }]

def ctpop2_before := [llvmfunc|
  llvm.func @ctpop2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %arg0, %1  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    llvm.return %5 : i32
  }]

def ctpop2v_before := [llvmfunc|
  llvm.func @ctpop2v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.add %arg0, %0  : vector<2xi32>
    %3 = llvm.and %1, %2  : vector<2xi32>
    %4 = llvm.intr.ctpop(%3)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def ctpop2_multiuse_before := [llvmfunc|
  llvm.func @ctpop2_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.sub %arg0, %1  : i32
    %4 = llvm.and %3, %2  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    %6 = llvm.add %5, %4  : i32
    llvm.return %6 : i32
  }]

def ctpop3_before := [llvmfunc|
  llvm.func @ctpop3(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.and %2, %arg0  : i32
    %4 = llvm.add %3, %1  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    llvm.return %5 : i32
  }]

def ctpop3v_before := [llvmfunc|
  llvm.func @ctpop3v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.sub %1, %arg0  : vector<2xi32>
    %4 = llvm.and %3, %arg0  : vector<2xi32>
    %5 = llvm.add %4, %2  : vector<2xi32>
    %6 = llvm.intr.ctpop(%5)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def ctpop3v_poison_before := [llvmfunc|
  llvm.func @ctpop3v_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.poison : i32
    %3 = llvm.mlir.constant(-1 : i32) : i32
    %4 = llvm.mlir.undef : vector<2xi32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %2, %6[%7 : i32] : vector<2xi32>
    %9 = llvm.sub %1, %arg0  : vector<2xi32>
    %10 = llvm.and %9, %arg0  : vector<2xi32>
    %11 = llvm.add %10, %8  : vector<2xi32>
    %12 = llvm.intr.ctpop(%11)  : (vector<2xi32>) -> vector<2xi32>
    llvm.return %12 : vector<2xi32>
  }]

def ctpop1_combined := [llvmfunc|
  llvm.func @ctpop1(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctpop1   : ctpop1_before  ⊑  ctpop1_combined := by
  unfold ctpop1_before ctpop1_combined
  simp_alive_peephole
  sorry
def ctpop1v_combined := [llvmfunc|
  llvm.func @ctpop1v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<32> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    %2 = llvm.sub %0, %1 overflow<nsw, nuw>  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_ctpop1v   : ctpop1v_before  ⊑  ctpop1v_combined := by
  unfold ctpop1v_before ctpop1v_combined
  simp_alive_peephole
  sorry
def ctpop1_multiuse_combined := [llvmfunc|
  llvm.func @ctpop1_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.or %2, %arg0  : i32
    %4 = llvm.xor %3, %1  : i32
    %5 = llvm.intr.ctpop(%4)  : (i32) -> i32
    %6 = llvm.add %5, %3  : i32
    llvm.return %6 : i32
  }]

theorem inst_combine_ctpop1_multiuse   : ctpop1_multiuse_before  ⊑  ctpop1_multiuse_combined := by
  unfold ctpop1_multiuse_before ctpop1_multiuse_combined
  simp_alive_peephole
  sorry
def ctpop2_combined := [llvmfunc|
  llvm.func @ctpop2(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctpop2   : ctpop2_before  ⊑  ctpop2_combined := by
  unfold ctpop2_before ctpop2_combined
  simp_alive_peephole
  sorry
def ctpop2v_combined := [llvmfunc|
  llvm.func @ctpop2v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ctpop2v   : ctpop2v_before  ⊑  ctpop2v_combined := by
  unfold ctpop2v_before ctpop2v_combined
  simp_alive_peephole
  sorry
def ctpop2_multiuse_combined := [llvmfunc|
  llvm.func @ctpop2_multiuse(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.xor %arg0, %0  : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    %5 = llvm.add %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_ctpop2_multiuse   : ctpop2_multiuse_before  ⊑  ctpop2_multiuse_combined := by
  unfold ctpop2_multiuse_before ctpop2_multiuse_combined
  simp_alive_peephole
  sorry
def ctpop3_combined := [llvmfunc|
  llvm.func @ctpop3(%arg0: i32) -> i32 {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_ctpop3   : ctpop3_before  ⊑  ctpop3_combined := by
  unfold ctpop3_before ctpop3_combined
  simp_alive_peephole
  sorry
def ctpop3v_combined := [llvmfunc|
  llvm.func @ctpop3v(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ctpop3v   : ctpop3v_before  ⊑  ctpop3v_combined := by
  unfold ctpop3v_before ctpop3v_combined
  simp_alive_peephole
  sorry
def ctpop3v_poison_combined := [llvmfunc|
  llvm.func @ctpop3v_poison(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = "llvm.intr.cttz"(%arg0) <{is_zero_poison = false}> : (vector<2xi32>) -> vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_ctpop3v_poison   : ctpop3v_poison_before  ⊑  ctpop3v_poison_combined := by
  unfold ctpop3v_poison_before ctpop3v_poison_combined
  simp_alive_peephole
  sorry
