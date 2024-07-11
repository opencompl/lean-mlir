import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assoc-cast-assoc
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def XorZextXor_before := [llvmfunc|
  llvm.func @XorZextXor(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(12 : i5) : i5
    %2 = llvm.xor %arg0, %0  : i3
    %3 = llvm.zext %2 : i3 to i5
    %4 = llvm.xor %3, %1  : i5
    llvm.return %4 : i5
  }]

def XorZextXorVec_before := [llvmfunc|
  llvm.func @XorZextXorVec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<[3, 1]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.xor %arg0, %2  : vector<2xi1>
    %5 = llvm.zext %4 : vector<2xi1> to vector<2xi32>
    %6 = llvm.xor %5, %3  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def OrZextOr_before := [llvmfunc|
  llvm.func @OrZextOr(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(8 : i5) : i5
    %2 = llvm.or %arg0, %0  : i3
    %3 = llvm.zext %2 : i3 to i5
    %4 = llvm.or %3, %1  : i5
    llvm.return %4 : i5
  }]

def OrZextOrVec_before := [llvmfunc|
  llvm.func @OrZextOrVec(%arg0: vector<2xi2>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i2) : i2
    %1 = llvm.mlir.constant(-2 : i2) : i2
    %2 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi2>) : vector<2xi2>
    %3 = llvm.mlir.constant(dense<[1, 5]> : vector<2xi32>) : vector<2xi32>
    %4 = llvm.or %arg0, %2  : vector<2xi2>
    %5 = llvm.zext %4 : vector<2xi2> to vector<2xi32>
    %6 = llvm.or %5, %3  : vector<2xi32>
    llvm.return %6 : vector<2xi32>
  }]

def AndZextAnd_before := [llvmfunc|
  llvm.func @AndZextAnd(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(14 : i5) : i5
    %2 = llvm.and %arg0, %0  : i3
    %3 = llvm.zext %2 : i3 to i5
    %4 = llvm.and %3, %1  : i5
    llvm.return %4 : i5
  }]

def AndZextAndVec_before := [llvmfunc|
  llvm.func @AndZextAndVec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[7, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[261, 1]> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.and %arg0, %0  : vector<2xi8>
    %3 = llvm.zext %2 : vector<2xi8> to vector<2xi32>
    %4 = llvm.and %3, %1  : vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def zext_nneg_before := [llvmfunc|
  llvm.func @zext_nneg(%arg0: i16) -> i24 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mlir.constant(8388607 : i24) : i24
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.zext %2 : i16 to i24
    %4 = llvm.and %3, %1  : i24
    llvm.return %4 : i24
  }]

def XorZextXor_combined := [llvmfunc|
  llvm.func @XorZextXor(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(15 : i5) : i5
    %1 = llvm.zext %arg0 : i3 to i5
    %2 = llvm.xor %1, %0  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_XorZextXor   : XorZextXor_before  ⊑  XorZextXor_combined := by
  unfold XorZextXor_before XorZextXor_combined
  simp_alive_peephole
  sorry
def XorZextXorVec_combined := [llvmfunc|
  llvm.func @XorZextXorVec(%arg0: vector<2xi1>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[2, 1]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi1> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_XorZextXorVec   : XorZextXorVec_before  ⊑  XorZextXorVec_combined := by
  unfold XorZextXorVec_before XorZextXorVec_combined
  simp_alive_peephole
  sorry
def OrZextOr_combined := [llvmfunc|
  llvm.func @OrZextOr(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(11 : i5) : i5
    %1 = llvm.zext %arg0 : i3 to i5
    %2 = llvm.or %1, %0  : i5
    llvm.return %2 : i5
  }]

theorem inst_combine_OrZextOr   : OrZextOr_before  ⊑  OrZextOr_combined := by
  unfold OrZextOr_before OrZextOr_combined
  simp_alive_peephole
  sorry
def OrZextOrVec_combined := [llvmfunc|
  llvm.func @OrZextOrVec(%arg0: vector<2xi2>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[3, 5]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.zext %arg0 : vector<2xi2> to vector<2xi32>
    %2 = llvm.or %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_OrZextOrVec   : OrZextOrVec_before  ⊑  OrZextOrVec_combined := by
  unfold OrZextOrVec_before OrZextOrVec_combined
  simp_alive_peephole
  sorry
def AndZextAnd_combined := [llvmfunc|
  llvm.func @AndZextAnd(%arg0: i3) -> i5 {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.and %arg0, %0  : i3
    %2 = llvm.zext %1 : i3 to i5
    llvm.return %2 : i5
  }]

theorem inst_combine_AndZextAnd   : AndZextAnd_before  ⊑  AndZextAnd_combined := by
  unfold AndZextAnd_before AndZextAnd_combined
  simp_alive_peephole
  sorry
def AndZextAndVec_combined := [llvmfunc|
  llvm.func @AndZextAndVec(%arg0: vector<2xi8>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[5, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.and %arg0, %0  : vector<2xi8>
    %2 = llvm.zext %1 : vector<2xi8> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_AndZextAndVec   : AndZextAndVec_before  ⊑  AndZextAndVec_combined := by
  unfold AndZextAndVec_before AndZextAndVec_combined
  simp_alive_peephole
  sorry
def zext_nneg_combined := [llvmfunc|
  llvm.func @zext_nneg(%arg0: i16) -> i24 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.zext %1 : i16 to i24
    llvm.return %2 : i24
  }]

theorem inst_combine_zext_nneg   : zext_nneg_before  ⊑  zext_nneg_combined := by
  unfold zext_nneg_before zext_nneg_combined
  simp_alive_peephole
  sorry
