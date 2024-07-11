import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2011-05-02-VectorBoolean
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def entry_before := [llvmfunc|
  llvm.func @entry(%arg0: vector<2xi16>) -> vector<2xi16> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i16) : i16
    %2 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    %3 = llvm.alloca %0 x vector<2xi16> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.alloca %0 x vector<2xi16> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.store %arg0, %3 {alignment = 4 : i64} : vector<2xi16>, !llvm.ptr]

    %5 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>]

    llvm.store %2, %4 {alignment = 4 : i64} : vector<2xi16>, !llvm.ptr]

    %6 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> vector<2xi16>]

    %7 = llvm.icmp "uge" %5, %6 : vector<2xi16>
    %8 = llvm.sext %7 : vector<2xi1> to vector<2xi16>
    llvm.return %8 : vector<2xi16>
  }]

def entry_combined := [llvmfunc|
  llvm.func @entry(%arg0: vector<2xi16>) -> vector<2xi16> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi16>) : vector<2xi16>
    llvm.return %0 : vector<2xi16>
  }]

theorem inst_combine_entry   : entry_before  ⊑  entry_combined := by
  unfold entry_before entry_combined
  simp_alive_peephole
  sorry
