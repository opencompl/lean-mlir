import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  fold-phi-load-metadata
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def phi_load_metadata_before := [llvmfunc|
  llvm.func @phi_load_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.icmp "eq" %arg2, %0 : i32
    llvm.cond_br %5, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.getelementptr inbounds %arg1[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.S2", (f32, i32)>
    %7 = llvm.load %6 invariant {alias_scopes = [#alias_scope, #alias_scope1], alignment = 4 : i64, noalias_scopes = [#alias_scope2, #alias_scope3], tbaa = [#tbaa_tag]} : !llvm.ptr -> i32]

    %8 = llvm.load %arg3 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb3(%7, %8 : i32, !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %9 = llvm.load %arg0 invariant {alias_scopes = [#alias_scope, #alias_scope2], alignment = 4 : i64, noalias_scopes = [#alias_scope1, #alias_scope3], tbaa = [#tbaa_tag1]} : !llvm.ptr -> i32]

    %10 = llvm.load %arg4 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    llvm.br ^bb3(%9, %10 : i32, !llvm.ptr)
  ^bb3(%11: i32, %12: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    llvm.store %12, %4 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return %11 : i32
  }]

def phi_load_metadata_combined := [llvmfunc|
  llvm.func @phi_load_metadata(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32, %arg3: !llvm.ptr, %arg4: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.zero : !llvm.ptr
    %4 = llvm.mlir.addressof @g1 : !llvm.ptr
    %5 = llvm.icmp "eq" %arg2, %0 : i32
    llvm.cond_br %5, ^bb2, ^bb1
  ^bb1:  // pred: ^bb0
    %6 = llvm.getelementptr inbounds %arg1[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.S2", (f32, i32)>
    llvm.br ^bb3(%6, %arg3 : !llvm.ptr, !llvm.ptr)
  ^bb2:  // pred: ^bb0
    llvm.br ^bb3(%arg0, %arg4 : !llvm.ptr, !llvm.ptr)
  ^bb3(%7: !llvm.ptr, %8: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.load %8 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %10 = llvm.load %7 invariant {alias_scopes = [#alias_scope, #alias_scope1, #alias_scope2], alignment = 4 : i64, noalias_scopes = [#alias_scope3], tbaa = [#tbaa_tag]} : !llvm.ptr -> i32
    llvm.store %9, %4 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %10 : i32
  }]

theorem inst_combine_phi_load_metadata   : phi_load_metadata_before  ⊑  phi_load_metadata_combined := by
  unfold phi_load_metadata_before phi_load_metadata_combined
  simp_alive_peephole
  sorry
