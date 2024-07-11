import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assume-loop-align
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(1648 : i32) : i32
    %5 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %6 = llvm.and %5, %0  : i64
    %7 = llvm.icmp "eq" %6, %1 : i64
    "llvm.intr.assume"(%7) : (i1) -> ()
    %8 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %9 = llvm.and %8, %0  : i64
    %10 = llvm.icmp "eq" %9, %1 : i64
    "llvm.intr.assume"(%10) : (i1) -> ()
    llvm.br ^bb1(%1 : i64)
  ^bb1(%11: i64):  // 2 preds: ^bb0, ^bb1
    %12 = llvm.getelementptr inbounds %arg1[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %14 = llvm.add %13, %2 overflow<nsw>  : i32
    %15 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

    %16 = llvm.add %11, %3 overflow<nsw, nuw>  : i64
    %17 = llvm.trunc %16 : i64 to i32
    %18 = llvm.icmp "slt" %17, %4 : i32
    llvm.cond_br %18, ^bb1(%16 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: !llvm.ptr, %arg1: !llvm.ptr) attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(63 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(16 : i64) : i64
    %4 = llvm.mlir.constant(1648 : i32) : i32
    %5 = llvm.ptrtoint %arg0 : !llvm.ptr to i64
    %6 = llvm.and %5, %0  : i64
    %7 = llvm.icmp "eq" %6, %1 : i64
    "llvm.intr.assume"(%7) : (i1) -> ()
    %8 = llvm.ptrtoint %arg1 : !llvm.ptr to i64
    %9 = llvm.and %8, %0  : i64
    %10 = llvm.icmp "eq" %9, %1 : i64
    "llvm.intr.assume"(%10) : (i1) -> ()
    llvm.br ^bb1(%1 : i64)
  ^bb1(%11: i64):  // 2 preds: ^bb0, ^bb1
    %12 = llvm.getelementptr inbounds %arg1[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> i32]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    %14 = llvm.add %13, %2 overflow<nsw>  : i32
    %15 = llvm.getelementptr inbounds %arg0[%11] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    llvm.store %14, %15 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
    %16 = llvm.add %11, %3 overflow<nsw, nuw>  : i64
    %17 = llvm.trunc %16 : i64 to i32
    %18 = llvm.icmp "slt" %17, %4 : i32
    llvm.cond_br %18, ^bb1(%16 : i64), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
