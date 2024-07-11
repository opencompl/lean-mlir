import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  ExtractCast
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def a_before := [llvmfunc|
  llvm.func @a(%arg0: vector<4xi64>) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.trunc %arg0 : vector<4xi64> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xi32>
    llvm.return %2 : i32
  }]

def b_before := [llvmfunc|
  llvm.func @b(%arg0: vector<4xf32>) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.fptosi %arg0 : vector<4xf32> to vector<4xi32>
    %2 = llvm.extractelement %1[%0 : i32] : vector<4xi32>
    llvm.return %2 : i32
  }]

def a_combined := [llvmfunc|
  llvm.func @a(%arg0: vector<4xi64>) -> i32 {
    %0 = llvm.mlir.constant(6 : i64) : i64
    %1 = llvm.bitcast %arg0 : vector<4xi64> to vector<8xi32>
    %2 = llvm.extractelement %1[%0 : i64] : vector<8xi32>
    llvm.return %2 : i32
  }]

theorem inst_combine_a   : a_before  ⊑  a_combined := by
  unfold a_before a_combined
  simp_alive_peephole
  sorry
def b_combined := [llvmfunc|
  llvm.func @b(%arg0: vector<4xf32>) -> i32 {
    %0 = llvm.mlir.constant(3 : i64) : i64
    %1 = llvm.extractelement %arg0[%0 : i64] : vector<4xf32>
    %2 = llvm.fptosi %1 : f32 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_b   : b_before  ⊑  b_combined := by
  unfold b_before b_combined
  simp_alive_peephole
  sorry
