import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector-mul
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def Zero_i8_before := [llvmfunc|
  llvm.func @Zero_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.mul %arg0, %1  : vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }]

def Identity_i8_before := [llvmfunc|
  llvm.func @Identity_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def AddToSelf_i8_before := [llvmfunc|
  llvm.func @AddToSelf_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def SplatPow2Test1_i8_before := [llvmfunc|
  llvm.func @SplatPow2Test1_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def SplatPow2Test2_i8_before := [llvmfunc|
  llvm.func @SplatPow2Test2_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def MulTest1_i8_before := [llvmfunc|
  llvm.func @MulTest1_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def MulTest2_i8_before := [llvmfunc|
  llvm.func @MulTest2_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def MulTest3_i8_before := [llvmfunc|
  llvm.func @MulTest3_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def MulTest4_i8_before := [llvmfunc|
  llvm.func @MulTest4_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

def Zero_i16_before := [llvmfunc|
  llvm.func @Zero_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.mul %arg0, %1  : vector<4xi16>
    llvm.return %2 : vector<4xi16>
  }]

def Identity_i16_before := [llvmfunc|
  llvm.func @Identity_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def AddToSelf_i16_before := [llvmfunc|
  llvm.func @AddToSelf_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def SplatPow2Test1_i16_before := [llvmfunc|
  llvm.func @SplatPow2Test1_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def SplatPow2Test2_i16_before := [llvmfunc|
  llvm.func @SplatPow2Test2_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def MulTest1_i16_before := [llvmfunc|
  llvm.func @MulTest1_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def MulTest2_i16_before := [llvmfunc|
  llvm.func @MulTest2_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def MulTest3_i16_before := [llvmfunc|
  llvm.func @MulTest3_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def MulTest4_i16_before := [llvmfunc|
  llvm.func @MulTest4_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 2]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

def Zero_i32_before := [llvmfunc|
  llvm.func @Zero_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mul %arg0, %1  : vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }]

def Identity_i32_before := [llvmfunc|
  llvm.func @Identity_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def AddToSelf_i32_before := [llvmfunc|
  llvm.func @AddToSelf_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def SplatPow2Test1_i32_before := [llvmfunc|
  llvm.func @SplatPow2Test1_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def SplatPow2Test2_i32_before := [llvmfunc|
  llvm.func @SplatPow2Test2_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def MulTest1_i32_before := [llvmfunc|
  llvm.func @MulTest1_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def MulTest2_i32_before := [llvmfunc|
  llvm.func @MulTest2_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def MulTest3_i32_before := [llvmfunc|
  llvm.func @MulTest3_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def MulTest4_i32_before := [llvmfunc|
  llvm.func @MulTest4_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

def Zero_i64_before := [llvmfunc|
  llvm.func @Zero_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.mul %arg0, %1  : vector<4xi64>
    llvm.return %2 : vector<4xi64>
  }]

def Identity_i64_before := [llvmfunc|
  llvm.func @Identity_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def AddToSelf_i64_before := [llvmfunc|
  llvm.func @AddToSelf_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def SplatPow2Test1_i64_before := [llvmfunc|
  llvm.func @SplatPow2Test1_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<4> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def SplatPow2Test2_i64_before := [llvmfunc|
  llvm.func @SplatPow2Test2_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<8> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def MulTest1_i64_before := [llvmfunc|
  llvm.func @MulTest1_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[1, 2, 4, 8]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def MulTest2_i64_before := [llvmfunc|
  llvm.func @MulTest2_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def MulTest3_i64_before := [llvmfunc|
  llvm.func @MulTest3_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[4, 4, 2, 2]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def MulTest4_i64_before := [llvmfunc|
  llvm.func @MulTest4_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

def ShiftMulTest1_before := [llvmfunc|
  llvm.func @ShiftMulTest1(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shl %arg0, %0  : vector<4xi8>
    %3 = llvm.mul %2, %1  : vector<4xi8>
    llvm.return %3 : vector<4xi8>
  }]

def ShiftMulTest2_before := [llvmfunc|
  llvm.func @ShiftMulTest2(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi16>) : vector<4xi16>
    %2 = llvm.shl %arg0, %0  : vector<4xi16>
    %3 = llvm.mul %2, %1  : vector<4xi16>
    llvm.return %3 : vector<4xi16>
  }]

def ShiftMulTest3_before := [llvmfunc|
  llvm.func @ShiftMulTest3(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.shl %arg0, %0  : vector<4xi32>
    %3 = llvm.mul %2, %1  : vector<4xi32>
    llvm.return %3 : vector<4xi32>
  }]

def ShiftMulTest4_before := [llvmfunc|
  llvm.func @ShiftMulTest4(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<3> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.shl %arg0, %0  : vector<4xi64>
    %3 = llvm.mul %2, %1  : vector<4xi64>
    llvm.return %3 : vector<4xi64>
  }]

def Zero_i8_combined := [llvmfunc|
  llvm.func @Zero_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<4xi8>) : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_Zero_i8   : Zero_i8_before  ⊑  Zero_i8_combined := by
  unfold Zero_i8_before Zero_i8_combined
  simp_alive_peephole
  sorry
def Identity_i8_combined := [llvmfunc|
  llvm.func @Identity_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    llvm.return %arg0 : vector<4xi8>
  }]

theorem inst_combine_Identity_i8   : Identity_i8_before  ⊑  Identity_i8_combined := by
  unfold Identity_i8_before Identity_i8_combined
  simp_alive_peephole
  sorry
def AddToSelf_i8_combined := [llvmfunc|
  llvm.func @AddToSelf_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.shl %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_AddToSelf_i8   : AddToSelf_i8_before  ⊑  AddToSelf_i8_combined := by
  unfold AddToSelf_i8_before AddToSelf_i8_combined
  simp_alive_peephole
  sorry
def SplatPow2Test1_i8_combined := [llvmfunc|
  llvm.func @SplatPow2Test1_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.shl %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_SplatPow2Test1_i8   : SplatPow2Test1_i8_before  ⊑  SplatPow2Test1_i8_combined := by
  unfold SplatPow2Test1_i8_before SplatPow2Test1_i8_combined
  simp_alive_peephole
  sorry
def SplatPow2Test2_i8_combined := [llvmfunc|
  llvm.func @SplatPow2Test2_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.shl %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_SplatPow2Test2_i8   : SplatPow2Test2_i8_before  ⊑  SplatPow2Test2_i8_combined := by
  unfold SplatPow2Test2_i8_before SplatPow2Test2_i8_combined
  simp_alive_peephole
  sorry
def MulTest1_i8_combined := [llvmfunc|
  llvm.func @MulTest1_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.shl %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_MulTest1_i8   : MulTest1_i8_before  ⊑  MulTest1_i8_combined := by
  unfold MulTest1_i8_before MulTest1_i8_combined
  simp_alive_peephole
  sorry
def MulTest2_i8_combined := [llvmfunc|
  llvm.func @MulTest2_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_MulTest2_i8   : MulTest2_i8_before  ⊑  MulTest2_i8_combined := by
  unfold MulTest2_i8_before MulTest2_i8_combined
  simp_alive_peephole
  sorry
def MulTest3_i8_combined := [llvmfunc|
  llvm.func @MulTest3_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[2, 2, 1, 1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.shl %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_MulTest3_i8   : MulTest3_i8_before  ⊑  MulTest3_i8_combined := by
  unfold MulTest3_i8_before MulTest3_i8_combined
  simp_alive_peephole
  sorry
def MulTest4_i8_combined := [llvmfunc|
  llvm.func @MulTest4_i8(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_MulTest4_i8   : MulTest4_i8_before  ⊑  MulTest4_i8_combined := by
  unfold MulTest4_i8_before MulTest4_i8_combined
  simp_alive_peephole
  sorry
def Zero_i16_combined := [llvmfunc|
  llvm.func @Zero_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<4xi16>) : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_Zero_i16   : Zero_i16_before  ⊑  Zero_i16_combined := by
  unfold Zero_i16_before Zero_i16_combined
  simp_alive_peephole
  sorry
def Identity_i16_combined := [llvmfunc|
  llvm.func @Identity_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    llvm.return %arg0 : vector<4xi16>
  }]

theorem inst_combine_Identity_i16   : Identity_i16_before  ⊑  Identity_i16_combined := by
  unfold Identity_i16_before Identity_i16_combined
  simp_alive_peephole
  sorry
def AddToSelf_i16_combined := [llvmfunc|
  llvm.func @AddToSelf_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.shl %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_AddToSelf_i16   : AddToSelf_i16_before  ⊑  AddToSelf_i16_combined := by
  unfold AddToSelf_i16_before AddToSelf_i16_combined
  simp_alive_peephole
  sorry
def SplatPow2Test1_i16_combined := [llvmfunc|
  llvm.func @SplatPow2Test1_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.shl %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_SplatPow2Test1_i16   : SplatPow2Test1_i16_before  ⊑  SplatPow2Test1_i16_combined := by
  unfold SplatPow2Test1_i16_before SplatPow2Test1_i16_combined
  simp_alive_peephole
  sorry
def SplatPow2Test2_i16_combined := [llvmfunc|
  llvm.func @SplatPow2Test2_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.shl %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_SplatPow2Test2_i16   : SplatPow2Test2_i16_before  ⊑  SplatPow2Test2_i16_combined := by
  unfold SplatPow2Test2_i16_before SplatPow2Test2_i16_combined
  simp_alive_peephole
  sorry
def MulTest1_i16_combined := [llvmfunc|
  llvm.func @MulTest1_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.shl %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_MulTest1_i16   : MulTest1_i16_before  ⊑  MulTest1_i16_combined := by
  unfold MulTest1_i16_before MulTest1_i16_combined
  simp_alive_peephole
  sorry
def MulTest2_i16_combined := [llvmfunc|
  llvm.func @MulTest2_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_MulTest2_i16   : MulTest2_i16_before  ⊑  MulTest2_i16_combined := by
  unfold MulTest2_i16_before MulTest2_i16_combined
  simp_alive_peephole
  sorry
def MulTest3_i16_combined := [llvmfunc|
  llvm.func @MulTest3_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[2, 2, 1, 1]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.shl %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_MulTest3_i16   : MulTest3_i16_before  ⊑  MulTest3_i16_combined := by
  unfold MulTest3_i16_before MulTest3_i16_combined
  simp_alive_peephole
  sorry
def MulTest4_i16_combined := [llvmfunc|
  llvm.func @MulTest4_i16(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 2]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_MulTest4_i16   : MulTest4_i16_before  ⊑  MulTest4_i16_combined := by
  unfold MulTest4_i16_before MulTest4_i16_combined
  simp_alive_peephole
  sorry
def Zero_i32_combined := [llvmfunc|
  llvm.func @Zero_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_Zero_i32   : Zero_i32_before  ⊑  Zero_i32_combined := by
  unfold Zero_i32_before Zero_i32_combined
  simp_alive_peephole
  sorry
def Identity_i32_combined := [llvmfunc|
  llvm.func @Identity_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    llvm.return %arg0 : vector<4xi32>
  }]

theorem inst_combine_Identity_i32   : Identity_i32_before  ⊑  Identity_i32_combined := by
  unfold Identity_i32_before Identity_i32_combined
  simp_alive_peephole
  sorry
def AddToSelf_i32_combined := [llvmfunc|
  llvm.func @AddToSelf_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_AddToSelf_i32   : AddToSelf_i32_before  ⊑  AddToSelf_i32_combined := by
  unfold AddToSelf_i32_before AddToSelf_i32_combined
  simp_alive_peephole
  sorry
def SplatPow2Test1_i32_combined := [llvmfunc|
  llvm.func @SplatPow2Test1_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_SplatPow2Test1_i32   : SplatPow2Test1_i32_before  ⊑  SplatPow2Test1_i32_combined := by
  unfold SplatPow2Test1_i32_before SplatPow2Test1_i32_combined
  simp_alive_peephole
  sorry
def SplatPow2Test2_i32_combined := [llvmfunc|
  llvm.func @SplatPow2Test2_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_SplatPow2Test2_i32   : SplatPow2Test2_i32_before  ⊑  SplatPow2Test2_i32_combined := by
  unfold SplatPow2Test2_i32_before SplatPow2Test2_i32_combined
  simp_alive_peephole
  sorry
def MulTest1_i32_combined := [llvmfunc|
  llvm.func @MulTest1_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_MulTest1_i32   : MulTest1_i32_before  ⊑  MulTest1_i32_combined := by
  unfold MulTest1_i32_before MulTest1_i32_combined
  simp_alive_peephole
  sorry
def MulTest2_i32_combined := [llvmfunc|
  llvm.func @MulTest2_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_MulTest2_i32   : MulTest2_i32_before  ⊑  MulTest2_i32_combined := by
  unfold MulTest2_i32_before MulTest2_i32_combined
  simp_alive_peephole
  sorry
def MulTest3_i32_combined := [llvmfunc|
  llvm.func @MulTest3_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[2, 2, 1, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.shl %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_MulTest3_i32   : MulTest3_i32_before  ⊑  MulTest3_i32_combined := by
  unfold MulTest3_i32_before MulTest3_i32_combined
  simp_alive_peephole
  sorry
def MulTest4_i32_combined := [llvmfunc|
  llvm.func @MulTest4_i32(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_MulTest4_i32   : MulTest4_i32_before  ⊑  MulTest4_i32_combined := by
  unfold MulTest4_i32_before MulTest4_i32_combined
  simp_alive_peephole
  sorry
def Zero_i64_combined := [llvmfunc|
  llvm.func @Zero_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_Zero_i64   : Zero_i64_before  ⊑  Zero_i64_combined := by
  unfold Zero_i64_before Zero_i64_combined
  simp_alive_peephole
  sorry
def Identity_i64_combined := [llvmfunc|
  llvm.func @Identity_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    llvm.return %arg0 : vector<4xi64>
  }]

theorem inst_combine_Identity_i64   : Identity_i64_before  ⊑  Identity_i64_combined := by
  unfold Identity_i64_before Identity_i64_combined
  simp_alive_peephole
  sorry
def AddToSelf_i64_combined := [llvmfunc|
  llvm.func @AddToSelf_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<1> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.shl %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_AddToSelf_i64   : AddToSelf_i64_before  ⊑  AddToSelf_i64_combined := by
  unfold AddToSelf_i64_before AddToSelf_i64_combined
  simp_alive_peephole
  sorry
def SplatPow2Test1_i64_combined := [llvmfunc|
  llvm.func @SplatPow2Test1_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<2> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.shl %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_SplatPow2Test1_i64   : SplatPow2Test1_i64_before  ⊑  SplatPow2Test1_i64_combined := by
  unfold SplatPow2Test1_i64_before SplatPow2Test1_i64_combined
  simp_alive_peephole
  sorry
def SplatPow2Test2_i64_combined := [llvmfunc|
  llvm.func @SplatPow2Test2_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.shl %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_SplatPow2Test2_i64   : SplatPow2Test2_i64_before  ⊑  SplatPow2Test2_i64_combined := by
  unfold SplatPow2Test2_i64_before SplatPow2Test2_i64_combined
  simp_alive_peephole
  sorry
def MulTest1_i64_combined := [llvmfunc|
  llvm.func @MulTest1_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[0, 1, 2, 3]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.shl %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_MulTest1_i64   : MulTest1_i64_before  ⊑  MulTest1_i64_combined := by
  unfold MulTest1_i64_before MulTest1_i64_combined
  simp_alive_peephole
  sorry
def MulTest2_i64_combined := [llvmfunc|
  llvm.func @MulTest2_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<3> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_MulTest2_i64   : MulTest2_i64_before  ⊑  MulTest2_i64_combined := by
  unfold MulTest2_i64_before MulTest2_i64_combined
  simp_alive_peephole
  sorry
def MulTest3_i64_combined := [llvmfunc|
  llvm.func @MulTest3_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[2, 2, 1, 1]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.shl %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_MulTest3_i64   : MulTest3_i64_before  ⊑  MulTest3_i64_combined := by
  unfold MulTest3_i64_before MulTest3_i64_combined
  simp_alive_peephole
  sorry
def MulTest4_i64_combined := [llvmfunc|
  llvm.func @MulTest4_i64(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[4, 4, 0, 1]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_MulTest4_i64   : MulTest4_i64_before  ⊑  MulTest4_i64_combined := by
  unfold MulTest4_i64_before MulTest4_i64_combined
  simp_alive_peephole
  sorry
def ShiftMulTest1_combined := [llvmfunc|
  llvm.func @ShiftMulTest1(%arg0: vector<4xi8>) -> vector<4xi8> {
    %0 = llvm.mlir.constant(dense<12> : vector<4xi8>) : vector<4xi8>
    %1 = llvm.mul %arg0, %0  : vector<4xi8>
    llvm.return %1 : vector<4xi8>
  }]

theorem inst_combine_ShiftMulTest1   : ShiftMulTest1_before  ⊑  ShiftMulTest1_combined := by
  unfold ShiftMulTest1_before ShiftMulTest1_combined
  simp_alive_peephole
  sorry
def ShiftMulTest2_combined := [llvmfunc|
  llvm.func @ShiftMulTest2(%arg0: vector<4xi16>) -> vector<4xi16> {
    %0 = llvm.mlir.constant(dense<12> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.mul %arg0, %0  : vector<4xi16>
    llvm.return %1 : vector<4xi16>
  }]

theorem inst_combine_ShiftMulTest2   : ShiftMulTest2_before  ⊑  ShiftMulTest2_combined := by
  unfold ShiftMulTest2_before ShiftMulTest2_combined
  simp_alive_peephole
  sorry
def ShiftMulTest3_combined := [llvmfunc|
  llvm.func @ShiftMulTest3(%arg0: vector<4xi32>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(dense<12> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mul %arg0, %0  : vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }]

theorem inst_combine_ShiftMulTest3   : ShiftMulTest3_before  ⊑  ShiftMulTest3_combined := by
  unfold ShiftMulTest3_before ShiftMulTest3_combined
  simp_alive_peephole
  sorry
def ShiftMulTest4_combined := [llvmfunc|
  llvm.func @ShiftMulTest4(%arg0: vector<4xi64>) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<12> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mul %arg0, %0  : vector<4xi64>
    llvm.return %1 : vector<4xi64>
  }]

theorem inst_combine_ShiftMulTest4   : ShiftMulTest4_before  ⊑  ShiftMulTest4_combined := by
  unfold ShiftMulTest4_before ShiftMulTest4_combined
  simp_alive_peephole
  sorry
