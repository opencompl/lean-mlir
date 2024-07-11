import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  vector-type
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def vselect1_before := [llvmfunc|
  llvm.func @vselect1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.bitcast %arg0 : i32 to vector<2xi16>
    %3 = llvm.bitcast %arg1 : i32 to vector<2xi16>
    %4 = llvm.bitcast %arg2 : i32 to vector<2xi16>
    %5 = llvm.icmp "sge" %4, %1 : vector<2xi16>
    %6 = llvm.select %5, %2, %3 : vector<2xi1>, vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to i32
    llvm.return %7 : i32
  }]

def vselect1_combined := [llvmfunc|
  llvm.func @vselect1(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %2 = llvm.bitcast %arg0 : i32 to vector<2xi16>
    %3 = llvm.bitcast %arg1 : i32 to vector<2xi16>
    %4 = llvm.bitcast %arg2 : i32 to vector<2xi16>
    %5 = llvm.icmp "slt" %4, %1 : vector<2xi16>
    %6 = llvm.select %5, %3, %2 : vector<2xi1>, vector<2xi16>
    %7 = llvm.bitcast %6 : vector<2xi16> to i32
    llvm.return %7 : i32
  }]

theorem inst_combine_vselect1   : vselect1_before  ⊑  vselect1_combined := by
  unfold vselect1_before vselect1_combined
  simp_alive_peephole
  sorry
