import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  phi-select-constant
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_before := [llvmfunc|
  llvm.func @foo(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.addressof @A : !llvm.ptr
    %2 = llvm.mlir.addressof @B : !llvm.ptr
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i1), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.icmp "eq" %1, %2 : !llvm.ptr
    llvm.br ^bb2(%5 : i1)
  ^bb2(%6: i1):  // 2 preds: ^bb0, ^bb1
    %7 = llvm.select %6, %3, %4 : i1, i32
    llvm.return %7 : i32
  }]

def vec1_before := [llvmfunc|
  llvm.func @vec1(%arg0: i1) -> vector<4xi64> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(dense<true> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.mlir.constant(dense<[true, true, false, false]> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %6 = llvm.mlir.constant(dense<[124, 125, 126, 127]> : vector<4xi64>) : vector<4xi64>
    llvm.cond_br %arg0, ^bb2(%1 : vector<4xi1>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3 : vector<4xi1>)
  ^bb2(%7: vector<4xi1>):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.select %7, %5, %6 : vector<4xi1>, vector<4xi64>
    llvm.return %8 : vector<4xi64>
  }]

def vec2_before := [llvmfunc|
  llvm.func @vec2(%arg0: i1) -> vector<4xi64> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<4xi1>) : vector<4xi1>
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.mlir.constant(dense<[true, false, true, false]> : vector<4xi1>) : vector<4xi1>
    %4 = llvm.mlir.constant(0 : i64) : i64
    %5 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %6 = llvm.mlir.constant(dense<[124, 125, 126, 127]> : vector<4xi64>) : vector<4xi64>
    llvm.cond_br %arg0, ^bb2(%1 : vector<4xi1>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3 : vector<4xi1>)
  ^bb2(%7: vector<4xi1>):  // 2 preds: ^bb0, ^bb1
    %8 = llvm.select %7, %5, %6 : vector<4xi1>, vector<4xi64>
    llvm.return %8 : vector<4xi64>
  }]

def vec3_before := [llvmfunc|
  llvm.func @vec3(%arg0: i1, %arg1: i1, %arg2: vector<2xi1>, %arg3: vector<2xi8>, %arg4: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<[false, true]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    llvm.cond_br %arg0, ^bb1, ^bb3(%2 : vector<2xi1>)
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3(%3 : vector<2xi1>)
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%arg2 : vector<2xi1>)
  ^bb3(%4: vector<2xi1>):  // 3 preds: ^bb0, ^bb1, ^bb2
    %5 = llvm.select %4, %arg3, %arg4 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

def PR48369_before := [llvmfunc|
  llvm.func @PR48369(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.br ^bb1(%1 : i1)
  ^bb1(%4: i1):  // pred: ^bb0
    %5 = llvm.select %4, %2, %0 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

def sink_to_unreachable_crash_before := [llvmfunc|
  llvm.func @sink_to_unreachable_crash(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.select %arg0, %0, %1 : i1, i16
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb1
  }]

def phi_trans_before := [llvmfunc|
  llvm.func @phi_trans(%arg0: i1, %arg1: i1, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(true) : i1
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg2, %1  : i32
    %4 = llvm.shl %arg2, %1  : i32
    llvm.br ^bb3(%2, %3, %4 : i1, i32, i32)
  ^bb2:  // pred: ^bb0
    %5 = llvm.mul %arg2, %0  : i32
    %6 = llvm.lshr %arg2, %1  : i32
    llvm.br ^bb3(%arg1, %5, %6 : i1, i32, i32)
  ^bb3(%7: i1, %8: i32, %9: i32):  // 2 preds: ^bb1, ^bb2
    %10 = llvm.select %7, %8, %9 : i1, i32
    llvm.return %10 : i32
  }]

def foo_combined := [llvmfunc|
  llvm.func @foo(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @B : !llvm.ptr
    %2 = llvm.mlir.addressof @A : !llvm.ptr
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    %4 = llvm.mlir.constant(2 : i32) : i32
    llvm.cond_br %arg0, ^bb2(%0 : i32), ^bb1
  ^bb1:  // pred: ^bb0
    %5 = llvm.select %3, %4, %0 : i1, i32
    llvm.br ^bb2(%5 : i32)
  ^bb2(%6: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %6 : i32
  }]

theorem inst_combine_foo   : foo_before  ⊑  foo_combined := by
  unfold foo_before foo_combined
  simp_alive_peephole
  sorry
def vec1_combined := [llvmfunc|
  llvm.func @vec1(%arg0: i1) -> vector<4xi64> {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.constant(dense<0> : vector<4xi64>) : vector<4xi64>
    %2 = llvm.mlir.constant(dense<[0, 0, 126, 127]> : vector<4xi64>) : vector<4xi64>
    llvm.cond_br %arg0, ^bb2(%1 : vector<4xi64>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%2 : vector<4xi64>)
  ^bb2(%3: vector<4xi64>):  // 2 preds: ^bb0, ^bb1
    llvm.return %3 : vector<4xi64>
  }]

theorem inst_combine_vec1   : vec1_before  ⊑  vec1_combined := by
  unfold vec1_before vec1_combined
  simp_alive_peephole
  sorry
def vec2_combined := [llvmfunc|
  llvm.func @vec2(%arg0: i1) -> vector<4xi64> {
    %0 = llvm.mlir.constant(dense<[124, 125, 126, 127]> : vector<4xi64>) : vector<4xi64>
    %1 = llvm.mlir.constant(dense<[0, 125, 0, 127]> : vector<4xi64>) : vector<4xi64>
    llvm.cond_br %arg0, ^bb2(%0 : vector<4xi64>), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%1 : vector<4xi64>)
  ^bb2(%2: vector<4xi64>):  // 2 preds: ^bb0, ^bb1
    llvm.return %2 : vector<4xi64>
  }]

theorem inst_combine_vec2   : vec2_before  ⊑  vec2_combined := by
  unfold vec2_before vec2_combined
  simp_alive_peephole
  sorry
def vec3_combined := [llvmfunc|
  llvm.func @vec3(%arg0: i1, %arg1: i1, %arg2: vector<2xi1>, %arg3: vector<2xi8>, %arg4: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(true) : i1
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(dense<[false, true]> : vector<2xi1>) : vector<2xi1>
    %3 = llvm.mlir.constant(dense<[true, false]> : vector<2xi1>) : vector<2xi1>
    llvm.cond_br %arg0, ^bb1, ^bb3(%2 : vector<2xi1>)
  ^bb1:  // pred: ^bb0
    llvm.cond_br %arg1, ^bb2, ^bb3(%3 : vector<2xi1>)
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%arg2 : vector<2xi1>)
  ^bb3(%4: vector<2xi1>):  // 3 preds: ^bb0, ^bb1, ^bb2
    %5 = llvm.select %4, %arg3, %arg4 : vector<2xi1>, vector<2xi8>
    llvm.return %5 : vector<2xi8>
  }]

theorem inst_combine_vec3   : vec3_before  ⊑  vec3_combined := by
  unfold vec3_before vec3_combined
  simp_alive_peephole
  sorry
def PR48369_combined := [llvmfunc|
  llvm.func @PR48369(%arg0: i32, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(256 : i32) : i32
    %3 = llvm.icmp "sgt" %arg0, %0 : i32
    llvm.br ^bb1(%1 : i1)
  ^bb1(%4: i1):  // pred: ^bb0
    %5 = llvm.select %4, %2, %0 : i1, i32
    llvm.store %5, %arg1 {alignment = 4 : i64} : i32, !llvm.ptr]

theorem inst_combine_PR48369   : PR48369_before  ⊑  PR48369_combined := by
  unfold PR48369_before PR48369_combined
  simp_alive_peephole
  sorry
    llvm.br ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return
  }]

theorem inst_combine_PR48369   : PR48369_before  ⊑  PR48369_combined := by
  unfold PR48369_before PR48369_combined
  simp_alive_peephole
  sorry
def sink_to_unreachable_crash_combined := [llvmfunc|
  llvm.func @sink_to_unreachable_crash(%arg0: i1) -> i16 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(5 : i16) : i16
    %2 = llvm.select %arg0, %0, %1 : i1, i16
    llvm.br ^bb1
  ^bb1:  // 2 preds: ^bb0, ^bb1
    llvm.br ^bb1
  }]

theorem inst_combine_sink_to_unreachable_crash   : sink_to_unreachable_crash_before  ⊑  sink_to_unreachable_crash_combined := by
  unfold sink_to_unreachable_crash_before sink_to_unreachable_crash_combined
  simp_alive_peephole
  sorry
def phi_trans_combined := [llvmfunc|
  llvm.func @phi_trans(%arg0: i1, %arg1: i1, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %2 = llvm.add %arg2, %1  : i32
    llvm.br ^bb3(%2 : i32)
  ^bb2:  // pred: ^bb0
    %3 = llvm.mul %arg2, %0  : i32
    %4 = llvm.lshr %arg2, %1  : i32
    %5 = llvm.select %arg1, %3, %4 : i1, i32
    llvm.br ^bb3(%5 : i32)
  ^bb3(%6: i32):  // 2 preds: ^bb1, ^bb2
    llvm.return %6 : i32
  }]

theorem inst_combine_phi_trans   : phi_trans_before  ⊑  phi_trans_combined := by
  unfold phi_trans_before phi_trans_combined
  simp_alive_peephole
  sorry
