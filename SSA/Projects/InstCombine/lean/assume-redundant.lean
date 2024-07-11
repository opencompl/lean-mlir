import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  assume-redundant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _Z3fooR1s_before := [llvmfunc|
  llvm.func @_Z3fooR1s(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.nocapture, llvm.readonly}) attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(1599 : i64) : i64
    %6 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %7 = llvm.ptrtoint %6 : !llvm.ptr to i64
    %8 = llvm.and %7, %0  : i64
    %9 = llvm.icmp "eq" %8, %1 : i64
    llvm.br ^bb1(%1 : i64)
  ^bb1(%10: i64):  // 2 preds: ^bb0, ^bb1
    "llvm.intr.assume"(%9) : (i1) -> ()
    %11 = llvm.getelementptr inbounds %6[%10] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %12 = llvm.load %11 {alignment = 16 : i64} : !llvm.ptr -> f64]

    %13 = llvm.fadd %12, %2  : f64
    "llvm.intr.assume"(%9) : (i1) -> ()
    %14 = llvm.fmul %13, %3  : f64
    llvm.store %14, %11 {alignment = 16 : i64} : f64, !llvm.ptr]

    %15 = llvm.add %10, %4 overflow<nsw, nuw>  : i64
    "llvm.intr.assume"(%9) : (i1) -> ()
    %16 = llvm.getelementptr inbounds %6[%15] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %17 = llvm.load %16 {alignment = 8 : i64} : !llvm.ptr -> f64]

    %18 = llvm.fadd %17, %2  : f64
    "llvm.intr.assume"(%9) : (i1) -> ()
    %19 = llvm.fmul %18, %3  : f64
    llvm.store %19, %16 {alignment = 8 : i64} : f64, !llvm.ptr]

    %20 = llvm.add %15, %4 overflow<nsw, nuw>  : i64
    %21 = llvm.icmp "eq" %15, %5 : i64
    llvm.cond_br %21, ^bb2, ^bb1(%20 : i64)
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def test1_before := [llvmfunc|
  llvm.func @test1() {
    %0 = llvm.mlir.constant(7 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.call @get() : () -> !llvm.ptr
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i64
    %4 = llvm.and %3, %0  : i64
    %5 = llvm.icmp "eq" %4, %1 : i64
    "llvm.intr.assume"(%5) : (i1) -> ()
    llvm.return
  }]

def test3_before := [llvmfunc|
  llvm.func @test3() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(7 : i64) : i64
    %2 = llvm.mlir.constant(0 : i64) : i64
    %3 = llvm.alloca %0 x i8 {alignment = 8 : i64} : (i32) -> !llvm.ptr]

    %4 = llvm.ptrtoint %3 : !llvm.ptr to i64
    %5 = llvm.and %4, %1  : i64
    %6 = llvm.icmp "eq" %5, %2 : i64
    "llvm.intr.assume"(%6) : (i1) -> ()
    llvm.return
  }]

def _Z3fooR1s_combined := [llvmfunc|
  llvm.func @_Z3fooR1s(%arg0: !llvm.ptr {llvm.dereferenceable = 8 : i64, llvm.nocapture, llvm.readonly}) attributes {passthrough = ["nounwind", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(31 : i64) : i64
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %3 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %4 = llvm.mlir.constant(1 : i64) : i64
    %5 = llvm.mlir.constant(2 : i64) : i64
    %6 = llvm.mlir.constant(1599 : i64) : i64
    %7 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

theorem inst_combine__Z3fooR1s   : _Z3fooR1s_before  ⊑  _Z3fooR1s_combined := by
  unfold _Z3fooR1s_before _Z3fooR1s_combined
  simp_alive_peephole
  sorry
    %8 = llvm.ptrtoint %7 : !llvm.ptr to i64
    %9 = llvm.and %8, %0  : i64
    %10 = llvm.icmp "eq" %9, %1 : i64
    llvm.br ^bb1(%1 : i64)
  ^bb1(%11: i64):  // 2 preds: ^bb0, ^bb1
    %12 = llvm.getelementptr inbounds %7[%11] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %13 = llvm.load %12 {alignment = 16 : i64} : !llvm.ptr -> f64]

theorem inst_combine__Z3fooR1s   : _Z3fooR1s_before  ⊑  _Z3fooR1s_combined := by
  unfold _Z3fooR1s_before _Z3fooR1s_combined
  simp_alive_peephole
  sorry
    %14 = llvm.fadd %13, %2  : f64
    %15 = llvm.fmul %14, %3  : f64
    llvm.store %15, %12 {alignment = 16 : i64} : f64, !llvm.ptr]

theorem inst_combine__Z3fooR1s   : _Z3fooR1s_before  ⊑  _Z3fooR1s_combined := by
  unfold _Z3fooR1s_before _Z3fooR1s_combined
  simp_alive_peephole
  sorry
    %16 = llvm.or %11, %4  : i64
    %17 = llvm.getelementptr inbounds %7[%16] : (!llvm.ptr, i64) -> !llvm.ptr, f64
    %18 = llvm.load %17 {alignment = 8 : i64} : !llvm.ptr -> f64]

theorem inst_combine__Z3fooR1s   : _Z3fooR1s_before  ⊑  _Z3fooR1s_combined := by
  unfold _Z3fooR1s_before _Z3fooR1s_combined
  simp_alive_peephole
  sorry
    %19 = llvm.fadd %18, %2  : f64
    "llvm.intr.assume"(%10) : (i1) -> ()
    %20 = llvm.fmul %19, %3  : f64
    llvm.store %20, %17 {alignment = 8 : i64} : f64, !llvm.ptr]

theorem inst_combine__Z3fooR1s   : _Z3fooR1s_before  ⊑  _Z3fooR1s_combined := by
  unfold _Z3fooR1s_before _Z3fooR1s_combined
  simp_alive_peephole
  sorry
    %21 = llvm.add %11, %5 overflow<nsw, nuw>  : i64
    %22 = llvm.icmp "eq" %16, %6 : i64
    llvm.cond_br %22, ^bb2, ^bb1(%21 : i64)
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine__Z3fooR1s   : _Z3fooR1s_before  ⊑  _Z3fooR1s_combined := by
  unfold _Z3fooR1s_before _Z3fooR1s_combined
  simp_alive_peephole
  sorry
def test1_combined := [llvmfunc|
  llvm.func @test1() {
    %0 = llvm.call @get() : () -> !llvm.ptr
    llvm.return
  }]

theorem inst_combine_test1   : test1_before  ⊑  test1_combined := by
  unfold test1_before test1_combined
  simp_alive_peephole
  sorry
def test3_combined := [llvmfunc|
  llvm.func @test3() {
    llvm.return
  }]

theorem inst_combine_test3   : test3_before  ⊑  test3_combined := by
  unfold test3_before test3_combined
  simp_alive_peephole
  sorry
