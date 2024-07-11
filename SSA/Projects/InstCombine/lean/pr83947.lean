import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr83947
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def masked_scatter1_before := [llvmfunc|
  llvm.func @masked_scatter1() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.mlir.poison : !llvm.vec<? x 4 x  ptr>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.addressof @c : !llvm.ptr
    %13 = llvm.insertelement %12, %10[%11 : i64] : !llvm.vec<? x 4 x  ptr>
    %14 = llvm.shufflevector %13, %10 [0, 0, 0, 0] : !llvm.vec<? x 4 x  ptr> 
    %15 = llvm.mlir.poison : !llvm.vec<? x 4 x  i1>
    %16 = llvm.mlir.addressof @b : !llvm.ptr
    %17 = llvm.ptrtoint %16 : !llvm.ptr to i1
    %18 = llvm.insertelement %17, %15[%11 : i64] : !llvm.vec<? x 4 x  i1>
    %19 = llvm.shufflevector %18, %15 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i1> 
    %20 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %9, %14, %19 {alignment = 4 : i32} : !llvm.vec<? x 4 x  i32>, vector<[4]xi1> into !llvm.vec<? x 4 x  ptr>]

    llvm.return
  }]

def masked_scatter2_before := [llvmfunc|
  llvm.func @masked_scatter2() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(true) : i1
    %9 = llvm.mlir.constant(dense<true> : vector<2xi1>) : vector<2xi1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %9 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def masked_scatter3_before := [llvmfunc|
  llvm.func @masked_scatter3() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.undef : vector<2xi1>
    %9 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %8 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def masked_scatter4_before := [llvmfunc|
  llvm.func @masked_scatter4() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    %10 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %9 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def masked_scatter5_before := [llvmfunc|
  llvm.func @masked_scatter5() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.constant(true) : i1
    %10 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    %11 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %10 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def masked_scatter6_before := [llvmfunc|
  llvm.func @masked_scatter6() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.constant(false) : i1
    %9 = llvm.mlir.undef : i1
    %10 = llvm.mlir.undef : vector<2xi1>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi1>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %8, %12[%13 : i32] : vector<2xi1>
    %15 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %14 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def masked_scatter7_before := [llvmfunc|
  llvm.func @masked_scatter7() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.addressof @b : !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i1
    %10 = llvm.mlir.undef : vector<2xi1>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi1>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %9, %12[%13 : i32] : vector<2xi1>
    %15 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %14 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>]

    llvm.return
  }]

def masked_scatter1_combined := [llvmfunc|
  llvm.func @masked_scatter1() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.vec<? x 4 x  i32>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<? x 4 x  i32>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<? x 4 x  i32>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<? x 4 x  i32>
    %10 = llvm.mlir.poison : !llvm.vec<? x 4 x  ptr>
    %11 = llvm.mlir.constant(0 : i64) : i64
    %12 = llvm.mlir.addressof @c : !llvm.ptr
    %13 = llvm.insertelement %12, %10[%11 : i64] : !llvm.vec<? x 4 x  ptr>
    %14 = llvm.shufflevector %13, %10 [0, 0, 0, 0] : !llvm.vec<? x 4 x  ptr> 
    %15 = llvm.mlir.poison : !llvm.vec<? x 4 x  i1>
    %16 = llvm.mlir.addressof @b : !llvm.ptr
    %17 = llvm.ptrtoint %16 : !llvm.ptr to i1
    %18 = llvm.insertelement %17, %15[%11 : i64] : !llvm.vec<? x 4 x  i1>
    %19 = llvm.shufflevector %18, %15 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i1> 
    %20 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %9, %14, %19 {alignment = 4 : i32} : !llvm.vec<? x 4 x  i32>, vector<[4]xi1> into !llvm.vec<? x 4 x  ptr>
    llvm.return
  }]

theorem inst_combine_masked_scatter1   : masked_scatter1_before  ⊑  masked_scatter1_combined := by
  unfold masked_scatter1_before masked_scatter1_combined
  simp_alive_peephole
  sorry
def masked_scatter2_combined := [llvmfunc|
  llvm.func @masked_scatter2() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_masked_scatter2   : masked_scatter2_before  ⊑  masked_scatter2_combined := by
  unfold masked_scatter2_before masked_scatter2_combined
  simp_alive_peephole
  sorry
def masked_scatter3_combined := [llvmfunc|
  llvm.func @masked_scatter3() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_masked_scatter3   : masked_scatter3_before  ⊑  masked_scatter3_combined := by
  unfold masked_scatter3_before masked_scatter3_combined
  simp_alive_peephole
  sorry
def masked_scatter4_combined := [llvmfunc|
  llvm.func @masked_scatter4() {
    llvm.return
  }]

theorem inst_combine_masked_scatter4   : masked_scatter4_before  ⊑  masked_scatter4_combined := by
  unfold masked_scatter4_before masked_scatter4_combined
  simp_alive_peephole
  sorry
def masked_scatter5_combined := [llvmfunc|
  llvm.func @masked_scatter5() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_masked_scatter5   : masked_scatter5_before  ⊑  masked_scatter5_combined := by
  unfold masked_scatter5_before masked_scatter5_combined
  simp_alive_peephole
  sorry
def masked_scatter6_combined := [llvmfunc|
  llvm.func @masked_scatter6() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    llvm.store %0, %1 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_masked_scatter6   : masked_scatter6_before  ⊑  masked_scatter6_combined := by
  unfold masked_scatter6_before masked_scatter6_combined
  simp_alive_peephole
  sorry
def masked_scatter7_combined := [llvmfunc|
  llvm.func @masked_scatter7() {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.addressof @c : !llvm.ptr
    %3 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %2, %5[%6 : i32] : !llvm.vec<2 x ptr>
    %8 = llvm.mlir.addressof @b : !llvm.ptr
    %9 = llvm.ptrtoint %8 : !llvm.ptr to i1
    %10 = llvm.mlir.undef : vector<2xi1>
    %11 = llvm.mlir.constant(0 : i32) : i32
    %12 = llvm.insertelement %9, %10[%11 : i32] : vector<2xi1>
    %13 = llvm.mlir.constant(1 : i32) : i32
    %14 = llvm.insertelement %9, %12[%13 : i32] : vector<2xi1>
    %15 = llvm.mlir.constant(4 : i32) : i32
    llvm.intr.masked.scatter %1, %7, %14 {alignment = 4 : i32} : vector<2xi32>, vector<2xi1> into !llvm.vec<2 x ptr>
    llvm.return
  }]

theorem inst_combine_masked_scatter7   : masked_scatter7_before  ⊑  masked_scatter7_combined := by
  unfold masked_scatter7_before masked_scatter7_combined
  simp_alive_peephole
  sorry
