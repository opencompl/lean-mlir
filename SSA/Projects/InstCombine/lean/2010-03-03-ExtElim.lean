import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2010-03-03-ExtElim
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def PR6486_before := [llvmfunc|
  llvm.func @PR6486() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.array<2 x ptr> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.array<2 x ptr> 
    %5 = llvm.mlir.addressof @g_92 : !llvm.ptr
    %6 = llvm.getelementptr %5[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %7 = llvm.mlir.addressof @g_177 : !llvm.ptr
    %8 = llvm.mlir.constant(0 : i32) : i32
    %9 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr]

    %10 = llvm.icmp "ne" %1, %9 : !llvm.ptr
    %11 = llvm.zext %10 : i1 to i32
    %12 = llvm.icmp "sle" %8, %11 : i32
    llvm.return %12 : i1
  }]

def PR16462_1_before := [llvmfunc|
  llvm.func @PR16462_1() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @d : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(65535 : i32) : i32
    %6 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %7 = llvm.select %6, %0, %4 : i1, i32
    %8 = llvm.trunc %7 : i32 to i16
    %9 = llvm.sext %8 : i16 to i32
    %10 = llvm.icmp "sgt" %9, %5 : i32
    llvm.return %10 : i1
  }]

def PR16462_2_before := [llvmfunc|
  llvm.func @PR16462_2() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<1xi32>) : !llvm.array<1 x i32>
    %2 = llvm.mlir.addressof @a : !llvm.ptr
    %3 = llvm.mlir.addressof @d : !llvm.ptr
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.mlir.constant(42 : i16) : i16
    %6 = llvm.icmp "eq" %2, %3 : !llvm.ptr
    %7 = llvm.select %6, %0, %4 : i1, i32
    %8 = llvm.trunc %7 : i32 to i16
    %9 = llvm.icmp "sgt" %8, %5 : i16
    llvm.return %9 : i1
  }]

def PR6486_combined := [llvmfunc|
  llvm.func @PR6486() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_PR6486   : PR6486_before  ⊑  PR6486_combined := by
  unfold PR6486_before PR6486_combined
  simp_alive_peephole
  sorry
def PR16462_1_combined := [llvmfunc|
  llvm.func @PR16462_1() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_PR16462_1   : PR16462_1_before  ⊑  PR16462_1_combined := by
  unfold PR16462_1_before PR16462_1_combined
  simp_alive_peephole
  sorry
def PR16462_2_combined := [llvmfunc|
  llvm.func @PR16462_2() -> i1 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_PR16462_2   : PR16462_2_before  ⊑  PR16462_2_combined := by
  unfold PR16462_2_before PR16462_2_combined
  simp_alive_peephole
  sorry
