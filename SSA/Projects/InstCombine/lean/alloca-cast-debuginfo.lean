import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  alloca-cast-debuginfo
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def f_before := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"struct.Foo", (i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr]

    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i64]

    llvm.store %2, %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i64, !llvm.ptr]

    llvm.call @escape(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

def f_combined := [llvmfunc|
  llvm.func @f(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.struct<"struct.Foo", (i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    %2 = llvm.load %arg0 {alignment = 8 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i64
    llvm.store %2, %1 {alignment = 4 : i64, tbaa = [#tbaa_tag]} : i64, !llvm.ptr
    llvm.call @escape(%1) : (!llvm.ptr) -> ()
    llvm.return
  }]

theorem inst_combine_f   : f_before  ⊑  f_combined := by
  unfold f_before f_combined
  simp_alive_peephole
  sorry
