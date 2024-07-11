import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assume-inseltpoison
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR40940_before := [llvmfunc|
  llvm.func @PR40940(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 2, 3] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : i32
  }]

def PR40940_combined := [llvmfunc|
  llvm.func @PR40940(%arg0: vector<4xi8>) -> i32 {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(65536 : i32) : i32
    %2 = llvm.shufflevector %arg0, %0 [1, 1, 2, 3] : vector<4xi8> 
    %3 = llvm.bitcast %2 : vector<4xi8> to i32
    %4 = llvm.icmp "ult" %3, %1 : i32
    "llvm.intr.assume"(%4) : (i1) -> ()
    llvm.return %3 : i32
  }]

theorem inst_combine_PR40940   : PR40940_before  ⊑  PR40940_combined := by
  unfold PR40940_before PR40940_combined
  simp_alive_peephole
  sorry
