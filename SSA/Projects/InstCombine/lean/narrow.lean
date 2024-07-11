import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  narrow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i32
    %1 = llvm.zext %0 : i1 to i32
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i32
    %3 = llvm.zext %2 : i1 to i32
    %4 = llvm.and %1, %3  : i32
    %5 = llvm.trunc %4 : i32 to i1
    llvm.return %5 : i1
  }]

def shrink_xor_before := [llvmfunc|
  llvm.func @shrink_xor(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.xor %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i32
    llvm.return %2 : i32
  }]

def shrink_xor_vec_before := [llvmfunc|
  llvm.func @shrink_xor_vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi64>) : vector<2xi64>
    %1 = llvm.xor %arg0, %0  : vector<2xi64>
    %2 = llvm.trunc %1 : vector<2xi64> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

def shrink_or_before := [llvmfunc|
  llvm.func @shrink_or(%arg0: i6) -> i3 {
    %0 = llvm.mlir.constant(-31 : i6) : i6
    %1 = llvm.or %arg0, %0  : i6
    %2 = llvm.trunc %1 : i6 to i3
    llvm.return %2 : i3
  }]

def shrink_or_vec_before := [llvmfunc|
  llvm.func @shrink_or_vec(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-1, 256]> : vector<2xi16>) : vector<2xi16>
    %1 = llvm.or %arg0, %0  : vector<2xi16>
    %2 = llvm.trunc %1 : vector<2xi16> to vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def shrink_and_before := [llvmfunc|
  llvm.func @shrink_and(%arg0: i64) -> i31 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i31
    llvm.return %2 : i31
  }]

def shrink_and_vec_before := [llvmfunc|
  llvm.func @shrink_and_vec(%arg0: vector<2xi33>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(6 : i33) : i33
    %1 = llvm.mlir.constant(-4294967296 : i33) : i33
    %2 = llvm.mlir.constant(dense<[-4294967296, 6]> : vector<2xi33>) : vector<2xi33>
    %3 = llvm.and %arg0, %2  : vector<2xi33>
    %4 = llvm.trunc %3 : vector<2xi33> to vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def searchArray1_before := [llvmfunc|
  llvm.func @searchArray1(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1000 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i8)
  ^bb1(%4: i32, %5: i8):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.getelementptr %arg1[%4] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %8 = llvm.icmp "eq" %7, %arg0 : i32
    %9 = llvm.zext %8 : i1 to i8
    %10 = llvm.or %5, %9  : i8
    %11 = llvm.add %4, %2  : i32
    %12 = llvm.icmp "eq" %11, %3 : i32
    llvm.cond_br %12, ^bb2, ^bb1(%11, %10 : i32, i8)
  ^bb2:  // pred: ^bb1
    %13 = llvm.icmp "ne" %10, %1 : i8
    llvm.return %13 : i1
  }]

def searchArray2_before := [llvmfunc|
  llvm.func @searchArray2(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(1 : i64) : i64
    %3 = llvm.mlir.constant(1000 : i64) : i64
    %4 = llvm.mlir.constant(0 : i8) : i8
    llvm.br ^bb1(%0, %1 : i64, i8)
  ^bb1(%5: i64, %6: i8):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.getelementptr %arg1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %9 = llvm.icmp "eq" %8, %arg0 : i32
    %10 = llvm.zext %9 : i1 to i8
    %11 = llvm.and %6, %10  : i8
    %12 = llvm.add %5, %2  : i64
    %13 = llvm.icmp "eq" %12, %3 : i64
    llvm.cond_br %13, ^bb2, ^bb1(%12, %11 : i64, i8)
  ^bb2:  // pred: ^bb1
    %14 = llvm.icmp "ne" %11, %4 : i8
    llvm.return %14 : i1
  }]

def shrinkLogicAndPhi1_before := [llvmfunc|
  llvm.func @shrinkLogicAndPhi1(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

def shrinkLogicAndPhi2_before := [llvmfunc|
  llvm.func @shrinkLogicAndPhi2(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.xor %3, %2  : i32
    llvm.return %4 : i32
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def shrink_xor_combined := [llvmfunc|
  llvm.func @shrink_xor(%arg0: i64) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.trunc %arg0 : i64 to i32
    %2 = llvm.xor %1, %0  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_shrink_xor   : shrink_xor_before  ⊑  shrink_xor_combined := by
  unfold shrink_xor_before shrink_xor_combined
  simp_alive_peephole
  sorry
def shrink_xor_vec_combined := [llvmfunc|
  llvm.func @shrink_xor_vec(%arg0: vector<2xi64>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi64> to vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_shrink_xor_vec   : shrink_xor_vec_before  ⊑  shrink_xor_vec_combined := by
  unfold shrink_xor_vec_before shrink_xor_vec_combined
  simp_alive_peephole
  sorry
def shrink_or_combined := [llvmfunc|
  llvm.func @shrink_or(%arg0: i6) -> i3 {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.trunc %arg0 : i6 to i3
    %2 = llvm.or %1, %0  : i3
    llvm.return %2 : i3
  }]

theorem inst_combine_shrink_or   : shrink_or_before  ⊑  shrink_or_combined := by
  unfold shrink_or_before shrink_or_combined
  simp_alive_peephole
  sorry
def shrink_or_vec_combined := [llvmfunc|
  llvm.func @shrink_or_vec(%arg0: vector<2xi16>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[-1, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.trunc %arg0 : vector<2xi16> to vector<2xi8>
    %2 = llvm.or %1, %0  : vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_shrink_or_vec   : shrink_or_vec_before  ⊑  shrink_or_vec_combined := by
  unfold shrink_or_vec_before shrink_or_vec_combined
  simp_alive_peephole
  sorry
def shrink_and_combined := [llvmfunc|
  llvm.func @shrink_and(%arg0: i64) -> i31 {
    %0 = llvm.mlir.constant(42 : i64) : i64
    %1 = llvm.and %arg0, %0  : i64
    %2 = llvm.trunc %1 : i64 to i31
    llvm.return %2 : i31
  }]

theorem inst_combine_shrink_and   : shrink_and_before  ⊑  shrink_and_combined := by
  unfold shrink_and_before shrink_and_combined
  simp_alive_peephole
  sorry
def shrink_and_vec_combined := [llvmfunc|
  llvm.func @shrink_and_vec(%arg0: vector<2xi33>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<[0, 6]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.trunc %arg0 : vector<2xi33> to vector<2xi32>
    %2 = llvm.and %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_shrink_and_vec   : shrink_and_vec_before  ⊑  shrink_and_vec_combined := by
  unfold shrink_and_vec_before shrink_and_vec_combined
  simp_alive_peephole
  sorry
def searchArray1_combined := [llvmfunc|
  llvm.func @searchArray1(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(1000 : i32) : i32
    llvm.br ^bb1(%0, %1 : i32, i8)
  ^bb1(%4: i32, %5: i8):  // 2 preds: ^bb0, ^bb1
    %6 = llvm.sext %4 : i32 to i64
    %7 = llvm.getelementptr %arg1[%6] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_searchArray1   : searchArray1_before  ⊑  searchArray1_combined := by
  unfold searchArray1_before searchArray1_combined
  simp_alive_peephole
  sorry
    %9 = llvm.icmp "eq" %8, %arg0 : i32
    %10 = llvm.zext %9 : i1 to i8
    %11 = llvm.or %5, %10  : i8
    %12 = llvm.add %4, %2  : i32
    %13 = llvm.icmp "eq" %12, %3 : i32
    llvm.cond_br %13, ^bb2, ^bb1(%12, %11 : i32, i8)
  ^bb2:  // pred: ^bb1
    %14 = llvm.icmp "ne" %11, %1 : i8
    llvm.return %14 : i1
  }]

theorem inst_combine_searchArray1   : searchArray1_before  ⊑  searchArray1_combined := by
  unfold searchArray1_before searchArray1_combined
  simp_alive_peephole
  sorry
def searchArray2_combined := [llvmfunc|
  llvm.func @searchArray2(%arg0: i32, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.constant(0 : i8) : i8
    %3 = llvm.mlir.constant(1 : i64) : i64
    %4 = llvm.mlir.constant(1000 : i64) : i64
    llvm.br ^bb1(%0, %1 : i64, i8)
  ^bb1(%5: i64, %6: i8):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.getelementptr %arg1[%5] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_searchArray2   : searchArray2_before  ⊑  searchArray2_combined := by
  unfold searchArray2_before searchArray2_combined
  simp_alive_peephole
  sorry
    %9 = llvm.icmp "eq" %8, %arg0 : i32
    %10 = llvm.select %9, %6, %2 : i1, i8
    %11 = llvm.add %5, %3  : i64
    %12 = llvm.icmp "eq" %11, %4 : i64
    llvm.cond_br %12, ^bb2, ^bb1(%11, %10 : i64, i8)
  ^bb2:  // pred: ^bb1
    %13 = llvm.icmp "ne" %10, %2 : i8
    llvm.return %13 : i1
  }]

theorem inst_combine_searchArray2   : searchArray2_before  ⊑  searchArray2_combined := by
  unfold searchArray2_before searchArray2_combined
  simp_alive_peephole
  sorry
def shrinkLogicAndPhi1_combined := [llvmfunc|
  llvm.func @shrinkLogicAndPhi1(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_shrinkLogicAndPhi1   : shrinkLogicAndPhi1_before  ⊑  shrinkLogicAndPhi1_combined := by
  unfold shrinkLogicAndPhi1_before shrinkLogicAndPhi1_combined
  simp_alive_peephole
  sorry
def shrinkLogicAndPhi2_combined := [llvmfunc|
  llvm.func @shrinkLogicAndPhi2(%arg0: i8, %arg1: i1) -> i32 {
    %0 = llvm.mlir.constant(21 : i32) : i32
    %1 = llvm.mlir.constant(33 : i32) : i32
    llvm.cond_br %arg1, ^bb1, ^bb2(%0 : i32)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : i32)
  ^bb2(%2: i32):  // 2 preds: ^bb0, ^bb1
    %3 = llvm.zext %arg0 : i8 to i32
    %4 = llvm.xor %2, %3  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_shrinkLogicAndPhi2   : shrinkLogicAndPhi2_before  ⊑  shrinkLogicAndPhi2_combined := by
  unfold shrinkLogicAndPhi2_before shrinkLogicAndPhi2_combined
  simp_alive_peephole
  sorry
