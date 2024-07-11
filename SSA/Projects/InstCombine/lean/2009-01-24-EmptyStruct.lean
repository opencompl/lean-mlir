import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2009-01-24-EmptyStruct
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def handle_event_before := [llvmfunc|
  llvm.func @handle_event(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, 1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.inode", (i32, struct<"struct.mutex", (struct<"struct.atomic_t", (i32)>, struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>, struct<"struct.list_head", (ptr, ptr)>)>)>
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return
  }]

def handle_event_combined := [llvmfunc|
  llvm.func @handle_event(%arg0: !llvm.ptr) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.getelementptr %arg0[%0, 1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct.inode", (i32, struct<"struct.mutex", (struct<"struct.atomic_t", (i32)>, struct<"struct.rwlock_t", (struct<"struct.lock_class_key", ()>)>, struct<"struct.list_head", (ptr, ptr)>)>)>
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }]

theorem inst_combine_handle_event   : handle_event_before  ⊑  handle_event_combined := by
  unfold handle_event_before handle_event_combined
  simp_alive_peephole
  sorry
