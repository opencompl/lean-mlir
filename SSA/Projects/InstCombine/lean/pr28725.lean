import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr28725
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test1_before := [llvmfunc|
  llvm.func @test1() -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<1> : vector<1xi32>) : vector<1xi32>
    %2 = llvm.bitcast %1 : vector<1xi32> to vector<2xi16>
    %3 = llvm.extractelement %2[%0 : i32] : vector<2xi16>
    %4 = llvm.mlir.constant(0 : i16) : i16
    %5 = llvm.mlir.undef : !llvm.struct<"S", (i16, i32)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<"S", (i16, i32)> 
    %7 = llvm.insertvalue %0, %6[1] : !llvm.struct<"S", (i16, i32)> 
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.mlir.undef : !llvm.struct<"S", (i16, i32)>
    %10 = llvm.insertvalue %4, %9[0] : !llvm.struct<"S", (i16, i32)> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.struct<"S", (i16, i32)> 
    %12 = llvm.mlir.undef : i16
    %13 = llvm.mlir.undef : vector<2xi16>
    %14 = llvm.mlir.constant(0 : i32) : i32
    %15 = llvm.insertelement %12, %13[%14 : i32] : vector<2xi16>
    %16 = llvm.mlir.constant(1 : i32) : i32
    %17 = llvm.insertelement %4, %15[%16 : i32] : vector<2xi16>
    %18 = llvm.icmp "eq" %3, %4 : i16
    %19 = llvm.select %18, %7, %11 : i1, !llvm.struct<"S", (i16, i32)>
    %20 = llvm.extractvalue %19[0] : !llvm.struct<"S", (i16, i32)> 
    %21 = llvm.insertelement %20, %17[%0 : i32] : vector<2xi16>
    llvm.return %21 : vector<2xi16>
  }]

def test1_combined := [llvmfunc|
  llvm.func @test1() -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
