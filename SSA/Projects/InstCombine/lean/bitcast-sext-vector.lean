import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  bitcast-sext-vector
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def t_before := [llvmfunc|
  llvm.func @t(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<4xi8>
    %1 = llvm.sext %0 : vector<4xi1> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

def t_combined := [llvmfunc|
  llvm.func @t(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> i32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.icmp "eq" %arg0, %arg1 : vector<4xi8>
    %1 = llvm.sext %0 : vector<4xi1> to vector<4xi8>
    %2 = llvm.bitcast %1 : vector<4xi8> to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_t   : t_before  ⊑  t_combined := by
  unfold t_before t_combined
  simp_alive_peephole
  sorry
