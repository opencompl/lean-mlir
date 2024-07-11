import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  signed-comparison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def scalar_zext_slt_before := [llvmfunc|
  llvm.func @scalar_zext_slt(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(500 : i32) : i32
    %1 = llvm.zext %arg0 : i16 to i32
    %2 = llvm.icmp "slt" %1, %0 : i32
    llvm.return %2 : i1
  }]

def vector_zext_slt_before := [llvmfunc|
  llvm.func @vector_zext_slt(%arg0: vector<4xi16>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[500, 0, 501, 65535]> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.zext %arg0 : vector<4xi16> to vector<4xi32>
    %2 = llvm.icmp "slt" %1, %0 : vector<4xi32>
    llvm.return %2 : vector<4xi1>
  }]

def scalar_zext_slt_combined := [llvmfunc|
  llvm.func @scalar_zext_slt(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(500 : i16) : i16
    %1 = llvm.icmp "ult" %arg0, %0 : i16
    llvm.return %1 : i1
  }]

theorem inst_combine_scalar_zext_slt   : scalar_zext_slt_before  ⊑  scalar_zext_slt_combined := by
  unfold scalar_zext_slt_before scalar_zext_slt_combined
  simp_alive_peephole
  sorry
def vector_zext_slt_combined := [llvmfunc|
  llvm.func @vector_zext_slt(%arg0: vector<4xi16>) -> vector<4xi1> {
    %0 = llvm.mlir.constant(dense<[500, 0, 501, -1]> : vector<4xi16>) : vector<4xi16>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<4xi16>
    llvm.return %1 : vector<4xi1>
  }]

theorem inst_combine_vector_zext_slt   : vector_zext_slt_before  ⊑  vector_zext_slt_combined := by
  unfold vector_zext_slt_before vector_zext_slt_combined
  simp_alive_peephole
  sorry
