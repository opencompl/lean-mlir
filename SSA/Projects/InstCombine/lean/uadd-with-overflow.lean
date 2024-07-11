import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  uadd-with-overflow
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def simple_fold(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @simple_fold(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(13 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(-56 : i8) : i8
    %1 = llvm.mlir.constant(55 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }]

def no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(-56 : i8) : i8
    %1 = llvm.mlir.constant(56 : i8) : i8
    %2 = llvm.add %arg0, %0 overflow<nuw>  : i8
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %3 : !llvm.struct<(i8, i1)>
  }]

def no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[-57, -56]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<55> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi8>, vector<2xi1>)>
  }]

def no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[-56, -55]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<55> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi8>, vector<2xi1>)>
  }]

def fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

def no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.add %arg0, %6 overflow<nuw>  : vector<2xi32>
    %9 = "llvm.intr.uadd.with.overflow"(%8, %7) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %9 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

def no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : vector<2xi32>
    %2 = "llvm.intr.uadd.with.overflow"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %2 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

def fold_nuwnsw(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @fold_nuwnsw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw, nuw>  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def no_fold_nsw(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @no_fold_nsw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%1, %2) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

def fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

def fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<_before := [llvmfunc|
  llvm.func @fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

def simple_fold(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @simple_fold(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(20 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_simple_fold(%arg0: i32) -> !llvm.struct<   : simple_fold(%arg0: i32) -> !llvm.struct<_before  ⊑  simple_fold(%arg0: i32) -> !llvm.struct<_combined := by
  unfold simple_fold(%arg0: i32) -> !llvm.struct<_before simple_fold(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i8, i8) -> !llvm.struct<(i8, i1)>
    llvm.return %1 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<   : fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<_before fold_on_constant_add_no_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<(i8, i1)> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.undef : !llvm.struct<(i8, i1)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<(i8, i1)> 
    %4 = llvm.insertvalue %0, %3[1] : !llvm.struct<(i8, i1)> 
    %5 = llvm.insertvalue %arg0, %4[0] : !llvm.struct<(i8, i1)> 
    llvm.return %5 : !llvm.struct<(i8, i1)>
  }]

theorem inst_combine_no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<   : no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<_before  ⊑  no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<_combined := by
  unfold no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<_before no_fold_on_constant_add_overflow(%arg0: i8) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[-57, -56]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<55> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi8>, vector<2xi1>)>
  }]

theorem inst_combine_no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<   : no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_before  ⊑  no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_combined := by
  unfold no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_before no_fold_vector_no_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<[-56, -55]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<55> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.add %arg0, %0 overflow<nuw>  : vector<2xi8>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi8>, vector<2xi8>) -> !llvm.struct<(vector<2xi8>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi8>, vector<2xi1>)>
  }]

theorem inst_combine_no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<   : no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_before  ⊑  no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_combined := by
  unfold no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_before no_fold_vector_overflow(%arg0: vector<2xi8>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<42> : vector<2xi32>) : vector<2xi32>
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %1 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

theorem inst_combine_fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<   : fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before  ⊑  fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined := by
  unfold fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before fold_simple_splat_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.undef : i32
    %1 = llvm.mlir.constant(12 : i32) : i32
    %2 = llvm.mlir.undef : vector<2xi32>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi32>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi32>
    %7 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %8 = llvm.add %arg0, %6 overflow<nuw>  : vector<2xi32>
    %9 = "llvm.intr.uadd.with.overflow"(%8, %7) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %9 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

theorem inst_combine_no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<   : no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before  ⊑  no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined := by
  unfold no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before no_fold_splat_undef_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.add %arg0, %arg1 overflow<nuw>  : vector<2xi32>
    %2 = "llvm.intr.uadd.with.overflow"(%1, %0) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %2 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

theorem inst_combine_no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<   : no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<_before  ⊑  no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<_combined := by
  unfold no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<_before no_fold_splat_not_constant(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def fold_nuwnsw(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @fold_nuwnsw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = "llvm.intr.uadd.with.overflow"(%arg0, %0) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %1 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_fold_nuwnsw(%arg0: i32) -> !llvm.struct<   : fold_nuwnsw(%arg0: i32) -> !llvm.struct<_before  ⊑  fold_nuwnsw(%arg0: i32) -> !llvm.struct<_combined := by
  unfold fold_nuwnsw(%arg0: i32) -> !llvm.struct<_before fold_nuwnsw(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def no_fold_nsw(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @no_fold_nsw(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0 overflow<nsw>  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_no_fold_nsw(%arg0: i32) -> !llvm.struct<   : no_fold_nsw(%arg0: i32) -> !llvm.struct<_before  ⊑  no_fold_nsw(%arg0: i32) -> !llvm.struct<_combined := by
  unfold no_fold_nsw(%arg0: i32) -> !llvm.struct<_before no_fold_nsw(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<(i32, i1)> {
    %0 = llvm.mlir.constant(12 : i32) : i32
    %1 = llvm.mlir.constant(30 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (i32, i32) -> !llvm.struct<(i32, i1)>
    llvm.return %3 : !llvm.struct<(i32, i1)>
  }]

theorem inst_combine_no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<   : no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<_before  ⊑  no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<_combined := by
  unfold no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<_before no_fold_wrapped_add(%arg0: i32) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

theorem inst_combine_fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<   : fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before  ⊑  fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined := by
  unfold fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<_before fold_simple_splat_with_disjoint_or_constant(%arg0: vector<2xi32>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
def fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<_combined := [llvmfunc|
  llvm.func @fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)> {
    %0 = llvm.mlir.constant(dense<12> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(dense<30> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.or %arg0, %0  : vector<2xi32>
    %3 = "llvm.intr.uadd.with.overflow"(%2, %1) : (vector<2xi32>, vector<2xi32>) -> !llvm.struct<(vector<2xi32>, vector<2xi1>)>
    llvm.return %3 : !llvm.struct<(vector<2xi32>, vector<2xi1>)>
  }]

theorem inst_combine_fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<   : fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<_before  ⊑  fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<_combined := by
  unfold fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<_before fold_simple_splat_constant_with_or_fail(%arg0: vector<2xi32>) -> !llvm.struct<_combined
  simp_alive_peephole
  sorry
