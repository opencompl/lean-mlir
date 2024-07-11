import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  shufflevec-constant-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def __inff4_before := [llvmfunc|
  llvm.func @__inff4() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<0x7F800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.bitcast %0 : vector<2xf32> to vector<1xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.poison : vector<2xf32>
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %6 = llvm.extractelement %1[%2 : i32] : vector<1xf64>
    %7 = llvm.bitcast %6 : f64 to i64
    %8 = llvm.bitcast %7 : i64 to vector<2xf32>
    %9 = llvm.shufflevector %8, %3 [0, 1, -1, -1] : vector<2xf32> 
    %10 = llvm.shufflevector %5, %9 [0, 1, 4, 5] : vector<4xf32> 
    llvm.return %10 : vector<4xf32>
  }]

def __inff4_combined := [llvmfunc|
  llvm.func @__inff4() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 0.000000e+00, 0x7F800000, 0x7F800000]> : vector<4xf32>) : vector<4xf32>
    llvm.return %0 : vector<4xf32>
  }]

theorem inst_combine___inff4   : __inff4_before  ⊑  __inff4_combined := by
  unfold __inff4_before __inff4_combined
  simp_alive_peephole
  sorry
