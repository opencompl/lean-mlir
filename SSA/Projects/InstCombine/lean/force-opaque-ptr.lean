import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  force-opaque-ptr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def gep_constexpr_gv_1_before := [llvmfunc|
  llvm.func @gep_constexpr_gv_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %4 = llvm.mlir.addressof @g : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    llvm.return %5 : !llvm.ptr
  }]

def gep_constexpr_gv_2_before := [llvmfunc|
  llvm.func @gep_constexpr_gv_2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(10 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %5 = llvm.mlir.addressof @g : !llvm.ptr
    %6 = llvm.getelementptr inbounds %5[%2, %1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    %7 = llvm.getelementptr %6[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.return %7 : !llvm.ptr
  }]

def gep_constexpr_inttoptr_before := [llvmfunc|
  llvm.func @gep_constexpr_inttoptr() -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(2 : i64) : i64
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %5 = llvm.mlir.addressof @g : !llvm.ptr
    %6 = llvm.ptrtoint %5 : !llvm.ptr to i64
    %7 = llvm.mul %6, %2  : i64
    %8 = llvm.inttoptr %7 : i64 to !llvm.ptr
    %9 = llvm.getelementptr %8[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    llvm.return %9 : !llvm.ptr
  }]

def gep_constexpr_gv_1_combined := [llvmfunc|
  llvm.func @gep_constexpr_gv_1() -> !llvm.ptr {
    %0 = llvm.mlir.constant(10 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %4 = llvm.mlir.addressof @g : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_constexpr_gv_1   : gep_constexpr_gv_1_before  ⊑  gep_constexpr_gv_1_combined := by
  unfold gep_constexpr_gv_1_before gep_constexpr_gv_1_combined
  simp_alive_peephole
  sorry
def gep_constexpr_gv_2_combined := [llvmfunc|
  llvm.func @gep_constexpr_gv_2() -> !llvm.ptr {
    %0 = llvm.mlir.constant(12 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %4 = llvm.mlir.addressof @g : !llvm.ptr
    %5 = llvm.getelementptr inbounds %4[%1, %0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<16 x i16>
    llvm.return %5 : !llvm.ptr
  }]

theorem inst_combine_gep_constexpr_gv_2   : gep_constexpr_gv_2_before  ⊑  gep_constexpr_gv_2_combined := by
  unfold gep_constexpr_gv_2_before gep_constexpr_gv_2_combined
  simp_alive_peephole
  sorry
def gep_constexpr_inttoptr_combined := [llvmfunc|
  llvm.func @gep_constexpr_inttoptr() -> !llvm.ptr {
    %0 = llvm.mlir.constant(20 : i64) : i64
    %1 = llvm.mlir.constant(2 : i64) : i64
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant(dense<0> : tensor<16xi16>) : !llvm.array<16 x i16>
    %4 = llvm.mlir.addressof @g : !llvm.ptr
    %5 = llvm.ptrtoint %4 : !llvm.ptr to i64
    %6 = llvm.mul %5, %1  : i64
    %7 = llvm.inttoptr %6 : i64 to !llvm.ptr
    %8 = llvm.getelementptr %7[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %8 : !llvm.ptr
  }]

theorem inst_combine_gep_constexpr_inttoptr   : gep_constexpr_inttoptr_before  ⊑  gep_constexpr_inttoptr_combined := by
  unfold gep_constexpr_inttoptr_before gep_constexpr_inttoptr_combined
  simp_alive_peephole
  sorry
