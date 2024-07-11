import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2011-02-14-InfLoop
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def m_387_before := [llvmfunc|
  llvm.func @m_387(%arg0: !llvm.ptr {llvm.noalias, llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}, %arg2: vector<4xi1>) -> vector<4xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<-1> : vector<4xi32>) : vector<4xi32>
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.undef : i32
    %3 = llvm.mlir.undef : vector<4xi32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : vector<4xi32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi32>
    %12 = llvm.mlir.constant(0 : i32) : i32
    %13 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %14 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %15 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %16 = llvm.sext %arg2 : vector<4xi1> to vector<4xi32>
    %17 = llvm.xor %16, %0  : vector<4xi32>
    %18 = llvm.and %17, %11  : vector<4xi32>
    %19 = llvm.or %18, %13  : vector<4xi32>
    %20 = llvm.bitcast %19 : vector<4xi32> to vector<4xf32>
    %21 = llvm.shufflevector %15, %20 [0, 1, 2, 7] : vector<4xf32> 
    llvm.return %21 : vector<4xf32>
  }]

def m_387_combined := [llvmfunc|
  llvm.func @m_387(%arg0: !llvm.ptr {llvm.noalias, llvm.nocapture}, %arg1: !llvm.ptr {llvm.nocapture}, %arg2: vector<4xi1>) -> vector<4xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.undef : vector<4xf32>
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.insertelement %3, %4[%5 : i32] : vector<4xf32>
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.insertelement %3, %6[%7 : i32] : vector<4xf32>
    %9 = llvm.mlir.constant(2 : i32) : i32
    %10 = llvm.insertelement %3, %8[%9 : i32] : vector<4xf32>
    %11 = llvm.mlir.constant(3 : i32) : i32
    %12 = llvm.insertelement %2, %10[%11 : i32] : vector<4xf32>
    %13 = llvm.xor %arg2, %1  : vector<4xi1>
    %14 = llvm.sext %13 : vector<4xi1> to vector<4xi32>
    %15 = llvm.bitcast %14 : vector<4xi32> to vector<4xf32>
    %16 = llvm.shufflevector %12, %15 [0, 1, 2, 7] : vector<4xf32> 
    llvm.return %16 : vector<4xf32>
  }]

theorem inst_combine_m_387   : m_387_before  ⊑  m_387_combined := by
  unfold m_387_before m_387_combined
  simp_alive_peephole
  sorry
