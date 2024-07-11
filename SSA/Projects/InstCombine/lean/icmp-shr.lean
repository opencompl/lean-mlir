import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  icmp-shr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def lshr_eq_msb_low_last_zero_before := [llvmfunc|
  llvm.func @lshr_eq_msb_low_last_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_eq_msb_low_last_zero_vec_before := [llvmfunc|
  llvm.func @lshr_eq_msb_low_last_zero_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.icmp "eq" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def ashr_eq_msb_low_second_zero_before := [llvmfunc|
  llvm.func @ashr_eq_msb_low_second_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_ne_msb_low_last_zero_before := [llvmfunc|
  llvm.func @lshr_ne_msb_low_last_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ne_msb_low_second_zero_before := [llvmfunc|
  llvm.func @ashr_ne_msb_low_second_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_eq_both_equal_before := [llvmfunc|
  llvm.func @ashr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ashr_ne_both_equal_before := [llvmfunc|
  llvm.func @ashr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def lshr_eq_both_equal_before := [llvmfunc|
  llvm.func @lshr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def lshr_ne_both_equal_before := [llvmfunc|
  llvm.func @lshr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def exact_ashr_eq_both_equal_before := [llvmfunc|
  llvm.func @exact_ashr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def exact_ashr_ne_both_equal_before := [llvmfunc|
  llvm.func @exact_ashr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.ashr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def exact_lshr_eq_both_equal_before := [llvmfunc|
  llvm.func @exact_lshr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "eq" %1, %0 : i8
    llvm.return %2 : i1
  }]

def exact_lshr_ne_both_equal_before := [llvmfunc|
  llvm.func @exact_lshr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "ne" %1, %0 : i8
    llvm.return %2 : i1
  }]

def exact_lshr_eq_opposite_msb_before := [llvmfunc|
  llvm.func @exact_lshr_eq_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_eq_opposite_msb_before := [llvmfunc|
  llvm.func @lshr_eq_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_lshr_ne_opposite_msb_before := [llvmfunc|
  llvm.func @exact_lshr_ne_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_ne_opposite_msb_before := [llvmfunc|
  llvm.func @lshr_ne_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_ashr_eq_before := [llvmfunc|
  llvm.func @exact_ashr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_ashr_ne_before := [llvmfunc|
  llvm.func @exact_ashr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_lshr_eq_before := [llvmfunc|
  llvm.func @exact_lshr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_lshr_ne_before := [llvmfunc|
  llvm.func @exact_lshr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_eq_before := [llvmfunc|
  llvm.func @nonexact_ashr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_ne_before := [llvmfunc|
  llvm.func @nonexact_ashr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_eq_before := [llvmfunc|
  llvm.func @nonexact_lshr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_ne_before := [llvmfunc|
  llvm.func @nonexact_lshr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_lshr_eq_exactdiv_before := [llvmfunc|
  llvm.func @exact_lshr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_lshr_ne_exactdiv_before := [llvmfunc|
  llvm.func @exact_lshr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_eq_exactdiv_before := [llvmfunc|
  llvm.func @nonexact_lshr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_ne_exactdiv_before := [llvmfunc|
  llvm.func @nonexact_lshr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_ashr_eq_exactdiv_before := [llvmfunc|
  llvm.func @exact_ashr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_ashr_ne_exactdiv_before := [llvmfunc|
  llvm.func @exact_ashr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_eq_exactdiv_before := [llvmfunc|
  llvm.func @nonexact_ashr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_ne_exactdiv_before := [llvmfunc|
  llvm.func @nonexact_ashr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-5 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_lshr_eq_noexactdiv_before := [llvmfunc|
  llvm.func @exact_lshr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_lshr_ne_noexactdiv_before := [llvmfunc|
  llvm.func @exact_lshr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_eq_noexactdiv_before := [llvmfunc|
  llvm.func @nonexact_lshr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_ne_noexactdiv_before := [llvmfunc|
  llvm.func @nonexact_lshr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(80 : i8) : i8
    %1 = llvm.mlir.constant(31 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_ashr_eq_noexactdiv_before := [llvmfunc|
  llvm.func @exact_ashr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exact_ashr_ne_noexactdiv_before := [llvmfunc|
  llvm.func @exact_ashr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_eq_noexactdiv_before := [llvmfunc|
  llvm.func @nonexact_ashr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_ne_noexactdiv_before := [llvmfunc|
  llvm.func @nonexact_ashr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-80 : i8) : i8
    %1 = llvm.mlir.constant(-31 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_eq_noexactlog_before := [llvmfunc|
  llvm.func @nonexact_lshr_eq_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(90 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_lshr_ne_noexactlog_before := [llvmfunc|
  llvm.func @nonexact_lshr_ne_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(90 : i8) : i8
    %1 = llvm.mlir.constant(30 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_eq_noexactlog_before := [llvmfunc|
  llvm.func @nonexact_ashr_eq_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-90 : i8) : i8
    %1 = llvm.mlir.constant(-30 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def nonexact_ashr_ne_noexactlog_before := [llvmfunc|
  llvm.func @nonexact_ashr_ne_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-90 : i8) : i8
    %1 = llvm.mlir.constant(-30 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def PR20945_before := [llvmfunc|
  llvm.func @PR20945(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-9 : i32) : i32
    %1 = llvm.mlir.constant(-5 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.icmp "ne" %2, %1 : i32
    llvm.return %3 : i1
  }]

def PR21222_before := [llvmfunc|
  llvm.func @PR21222(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(-93 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.ashr %0, %arg0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

def PR24873_before := [llvmfunc|
  llvm.func @PR24873(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(-4611686018427387904 : i64) : i64
    %1 = llvm.mlir.constant(-1 : i64) : i64
    %2 = llvm.ashr %0, %arg0  : i64
    %3 = llvm.icmp "eq" %2, %1 : i64
    llvm.return %3 : i1
  }]

def exact_multiuse_before := [llvmfunc|
  llvm.func @exact_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(1024 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.call @foo(%2) : (i32) -> ()
    llvm.return %3 : i1
  }]

def ashr_exact_eq_0_before := [llvmfunc|
  llvm.func @ashr_exact_eq_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ashr %arg0, %arg1  : i32
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ashr_exact_ne_0_uses_before := [llvmfunc|
  llvm.func @ashr_exact_ne_0_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @foo(%1) : (i32) -> ()
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def ashr_exact_eq_0_vec_before := [llvmfunc|
  llvm.func @ashr_exact_eq_0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.ashr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "eq" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def lshr_exact_ne_0_before := [llvmfunc|
  llvm.func @lshr_exact_ne_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    %2 = llvm.icmp "ne" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lshr_exact_eq_0_uses_before := [llvmfunc|
  llvm.func @lshr_exact_eq_0_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @foo(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lshr_exact_ne_0_vec_before := [llvmfunc|
  llvm.func @lshr_exact_ne_0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.lshr %arg0, %arg1  : vector<2xi32>
    %3 = llvm.icmp "ne" %2, %1 : vector<2xi32>
    llvm.return %3 : vector<2xi1>
  }]

def ashr_ugt_0_before := [llvmfunc|
  llvm.func @ashr_ugt_0(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_0_multiuse_before := [llvmfunc|
  llvm.func @ashr_ugt_0_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr]

    llvm.return %3 : i1
  }]

def ashr_ugt_1_before := [llvmfunc|
  llvm.func @ashr_ugt_1(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashr_ugt_2_before := [llvmfunc|
  llvm.func @ashr_ugt_2(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_3_before := [llvmfunc|
  llvm.func @ashr_ugt_3(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_4_before := [llvmfunc|
  llvm.func @ashr_ugt_4(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_5_before := [llvmfunc|
  llvm.func @ashr_ugt_5(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_6_before := [llvmfunc|
  llvm.func @ashr_ugt_6(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_7_before := [llvmfunc|
  llvm.func @ashr_ugt_7(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_8_before := [llvmfunc|
  llvm.func @ashr_ugt_8(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_9_before := [llvmfunc|
  llvm.func @ashr_ugt_9(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_10_before := [llvmfunc|
  llvm.func @ashr_ugt_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_11_before := [llvmfunc|
  llvm.func @ashr_ugt_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_12_before := [llvmfunc|
  llvm.func @ashr_ugt_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_13_before := [llvmfunc|
  llvm.func @ashr_ugt_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_14_before := [llvmfunc|
  llvm.func @ashr_ugt_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ugt_15_before := [llvmfunc|
  llvm.func @ashr_ugt_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ugt" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_0_before := [llvmfunc|
  llvm.func @ashr_ult_0(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(0 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_1_before := [llvmfunc|
  llvm.func @ashr_ult_1(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "ult" %1, %0 : i4
    llvm.return %2 : i1
  }]

def ashr_ult_2_before := [llvmfunc|
  llvm.func @ashr_ult_2(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_2_multiuse_before := [llvmfunc|
  llvm.func @ashr_ult_2_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr]

    llvm.return %3 : i1
  }]

def ashr_ult_3_before := [llvmfunc|
  llvm.func @ashr_ult_3(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_4_before := [llvmfunc|
  llvm.func @ashr_ult_4(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_5_before := [llvmfunc|
  llvm.func @ashr_ult_5(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_6_before := [llvmfunc|
  llvm.func @ashr_ult_6(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_7_before := [llvmfunc|
  llvm.func @ashr_ult_7(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_8_before := [llvmfunc|
  llvm.func @ashr_ult_8(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-8 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_9_before := [llvmfunc|
  llvm.func @ashr_ult_9(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-7 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_10_before := [llvmfunc|
  llvm.func @ashr_ult_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-6 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_11_before := [llvmfunc|
  llvm.func @ashr_ult_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-5 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_12_before := [llvmfunc|
  llvm.func @ashr_ult_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-4 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_13_before := [llvmfunc|
  llvm.func @ashr_ult_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-3 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_14_before := [llvmfunc|
  llvm.func @ashr_ult_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def ashr_ult_15_before := [llvmfunc|
  llvm.func @ashr_ult_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(-1 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.return %3 : i1
  }]

def lshr_eq_0_multiuse_before := [llvmfunc|
  llvm.func @lshr_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_ne_0_multiuse_before := [llvmfunc|
  llvm.func @lshr_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_eq_0_multiuse_before := [llvmfunc|
  llvm.func @ashr_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_ne_0_multiuse_before := [llvmfunc|
  llvm.func @ashr_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_exact_eq_0_multiuse_before := [llvmfunc|
  llvm.func @lshr_exact_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_exact_ne_0_multiuse_before := [llvmfunc|
  llvm.func @lshr_exact_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_exact_eq_0_multiuse_before := [llvmfunc|
  llvm.func @ashr_exact_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_exact_ne_0_multiuse_before := [llvmfunc|
  llvm.func @ashr_exact_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ugt_before := [llvmfunc|
  llvm.func @lshr_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ugt_use_before := [llvmfunc|
  llvm.func @lshr_pow2_ugt_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ugt_vec_before := [llvmfunc|
  llvm.func @lshr_pow2_ugt_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ugt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def lshr_not_pow2_ugt_before := [llvmfunc|
  llvm.func @lshr_not_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ugt1_before := [llvmfunc|
  llvm.func @lshr_pow2_ugt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def ashr_pow2_ugt_before := [llvmfunc|
  llvm.func @ashr_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-96 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_sgt_before := [llvmfunc|
  llvm.func @lshr_pow2_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ult_before := [llvmfunc|
  llvm.func @lshr_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ult_use_before := [llvmfunc|
  llvm.func @lshr_pow2_ult_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ult_vec_before := [llvmfunc|
  llvm.func @lshr_pow2_ult_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<8> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.icmp "ult" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def lshr_not_pow2_ult_before := [llvmfunc|
  llvm.func @lshr_not_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_ult_equal_constants_before := [llvmfunc|
  llvm.func @lshr_pow2_ult_equal_constants(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(16 : i32) : i32
    %1 = llvm.lshr %0, %arg0  : i32
    %2 = llvm.icmp "ult" %1, %0 : i32
    llvm.return %2 : i1
  }]

def lshr_pow2_ult_smin_before := [llvmfunc|
  llvm.func @lshr_pow2_ult_smin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.lshr %0, %arg0  : i8
    %2 = llvm.icmp "ult" %1, %0 : i8
    llvm.return %2 : i1
  }]

def ashr_pow2_ult_before := [llvmfunc|
  llvm.func @ashr_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-96 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_pow2_slt_before := [llvmfunc|
  llvm.func @lshr_pow2_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_neg_sgt_minus_1_before := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_neg_sgt_minus_1_vector_before := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_1_vector(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-17> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %0, %arg0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %2, %1 : vector<2xi8>
    llvm.return %3 : vector<2xi1>
  }]

def lshr_neg_sgt_minus_1_extra_use_before := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_1_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_neg_sgt_minus_2_before := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_neg_slt_minus_1_before := [llvmfunc|
  llvm.func @lshr_neg_slt_minus_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_neg_slt_zero_before := [llvmfunc|
  llvm.func @lshr_neg_slt_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_neg_slt_zero_vector_before := [llvmfunc|
  llvm.func @lshr_neg_slt_zero_vector(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-17> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.lshr %0, %arg0  : vector<2xi8>
    %4 = llvm.icmp "slt" %3, %2 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }]

def lshr_neg_slt_zero_extra_use_before := [llvmfunc|
  llvm.func @lshr_neg_slt_zero_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def "lshr_neg_slt_non-zero"_before := [llvmfunc|
  llvm.func @"lshr_neg_slt_non-zero"(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def lshr_neg_sgt_zero_before := [llvmfunc|
  llvm.func @lshr_neg_sgt_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

def exactly_one_set_signbit_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def exactly_one_set_signbit_use1_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def same_signbit_before := [llvmfunc|
  llvm.func @same_signbit(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.lshr %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg1, %1 : vector<2xi8>
    %4 = llvm.zext %3 : vector<2xi1> to vector<2xi8>
    %5 = llvm.icmp "ne" %2, %4 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def same_signbit_use2_before := [llvmfunc|
  llvm.func @same_signbit_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

def same_signbit_use3_before := [llvmfunc|
  llvm.func @same_signbit_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

def same_signbit_poison_elts_before := [llvmfunc|
  llvm.func @same_signbit_poison_elts(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(-1 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.lshr %arg0, %6  : vector<2xi8>
    %14 = llvm.icmp "sgt" %arg1, %12 : vector<2xi8>
    %15 = llvm.zext %14 : vector<2xi1> to vector<2xi8>
    %16 = llvm.icmp "ne" %13, %15 : vector<2xi8>
    llvm.return %16 : vector<2xi1>
  }]

def same_signbit_wrong_type_before := [llvmfunc|
  llvm.func @same_signbit_wrong_type(%arg0: i8, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i32
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

def exactly_one_set_signbit_wrong_shamt_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_shamt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def exactly_one_set_signbit_wrong_shr_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_shr(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def exactly_one_set_signbit_wrong_pred_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_pred(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "sgt" %2, %4 : i8
    llvm.return %5 : i1
  }]

def exactly_one_set_signbit_signed_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def exactly_one_set_signbit_use1_signed_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit_use1_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def same_signbit_signed_before := [llvmfunc|
  llvm.func @same_signbit_signed(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<7> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.ashr %arg0, %0  : vector<2xi8>
    %3 = llvm.icmp "sgt" %arg1, %1 : vector<2xi8>
    %4 = llvm.sext %3 : vector<2xi1> to vector<2xi8>
    %5 = llvm.icmp "ne" %2, %4 : vector<2xi8>
    llvm.return %5 : vector<2xi1>
  }]

def same_signbit_use2_signed_before := [llvmfunc|
  llvm.func @same_signbit_use2_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

def same_signbit_use3_signed_before := [llvmfunc|
  llvm.func @same_signbit_use3_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

def same_signbit_poison_elts_signed_before := [llvmfunc|
  llvm.func @same_signbit_poison_elts_signed(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(7 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(-1 : i8) : i8
    %8 = llvm.mlir.undef : vector<2xi8>
    %9 = llvm.mlir.constant(0 : i32) : i32
    %10 = llvm.insertelement %7, %8[%9 : i32] : vector<2xi8>
    %11 = llvm.mlir.constant(1 : i32) : i32
    %12 = llvm.insertelement %0, %10[%11 : i32] : vector<2xi8>
    %13 = llvm.ashr %arg0, %6  : vector<2xi8>
    %14 = llvm.icmp "sgt" %arg1, %12 : vector<2xi8>
    %15 = llvm.sext %14 : vector<2xi1> to vector<2xi8>
    %16 = llvm.icmp "ne" %13, %15 : vector<2xi8>
    llvm.return %16 : vector<2xi1>
  }]

def same_signbit_wrong_type_signed_before := [llvmfunc|
  llvm.func @same_signbit_wrong_type_signed(%arg0: i8, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i32
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

def exactly_one_set_signbit_wrong_shamt_signed_before := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_shamt_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

def slt_zero_ult_i1_before := [llvmfunc|
  llvm.func @slt_zero_ult_i1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }]

def slt_zero_ult_i1_fail1_before := [llvmfunc|
  llvm.func @slt_zero_ult_i1_fail1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }]

def slt_zero_ult_i1_fail2_before := [llvmfunc|
  llvm.func @slt_zero_ult_i1_fail2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "ult" %1, %2 : i32
    llvm.return %3 : i1
  }]

def slt_zero_slt_i1_fail_before := [llvmfunc|
  llvm.func @slt_zero_slt_i1_fail(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "slt" %1, %2 : i32
    llvm.return %3 : i1
  }]

def slt_zero_eq_i1_signed_before := [llvmfunc|
  llvm.func @slt_zero_eq_i1_signed(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def slt_zero_eq_i1_fail_signed_before := [llvmfunc|
  llvm.func @slt_zero_eq_i1_fail_signed(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %1, %2 : i32
    llvm.return %3 : i1
  }]

def lshr_eq_msb_low_last_zero_combined := [llvmfunc|
  llvm.func @lshr_eq_msb_low_last_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_eq_msb_low_last_zero   : lshr_eq_msb_low_last_zero_before  ⊑  lshr_eq_msb_low_last_zero_combined := by
  unfold lshr_eq_msb_low_last_zero_before lshr_eq_msb_low_last_zero_combined
  simp_alive_peephole
  sorry
def lshr_eq_msb_low_last_zero_vec_combined := [llvmfunc|
  llvm.func @lshr_eq_msb_low_last_zero_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<6> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ugt" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_lshr_eq_msb_low_last_zero_vec   : lshr_eq_msb_low_last_zero_vec_before  ⊑  lshr_eq_msb_low_last_zero_vec_combined := by
  unfold lshr_eq_msb_low_last_zero_vec_before lshr_eq_msb_low_last_zero_vec_combined
  simp_alive_peephole
  sorry
def ashr_eq_msb_low_second_zero_combined := [llvmfunc|
  llvm.func @ashr_eq_msb_low_second_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_eq_msb_low_second_zero   : ashr_eq_msb_low_second_zero_before  ⊑  ashr_eq_msb_low_second_zero_combined := by
  unfold ashr_eq_msb_low_second_zero_before ashr_eq_msb_low_second_zero_combined
  simp_alive_peephole
  sorry
def lshr_ne_msb_low_last_zero_combined := [llvmfunc|
  llvm.func @lshr_ne_msb_low_last_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_ne_msb_low_last_zero   : lshr_ne_msb_low_last_zero_before  ⊑  lshr_ne_msb_low_last_zero_combined := by
  unfold lshr_ne_msb_low_last_zero_before lshr_ne_msb_low_last_zero_combined
  simp_alive_peephole
  sorry
def ashr_ne_msb_low_second_zero_combined := [llvmfunc|
  llvm.func @ashr_ne_msb_low_second_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ne_msb_low_second_zero   : ashr_ne_msb_low_second_zero_before  ⊑  ashr_ne_msb_low_second_zero_combined := by
  unfold ashr_ne_msb_low_second_zero_before ashr_ne_msb_low_second_zero_combined
  simp_alive_peephole
  sorry
def ashr_eq_both_equal_combined := [llvmfunc|
  llvm.func @ashr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_eq_both_equal   : ashr_eq_both_equal_before  ⊑  ashr_eq_both_equal_combined := by
  unfold ashr_eq_both_equal_before ashr_eq_both_equal_combined
  simp_alive_peephole
  sorry
def ashr_ne_both_equal_combined := [llvmfunc|
  llvm.func @ashr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ne_both_equal   : ashr_ne_both_equal_before  ⊑  ashr_ne_both_equal_combined := by
  unfold ashr_ne_both_equal_before ashr_ne_both_equal_combined
  simp_alive_peephole
  sorry
def lshr_eq_both_equal_combined := [llvmfunc|
  llvm.func @lshr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_eq_both_equal   : lshr_eq_both_equal_before  ⊑  lshr_eq_both_equal_combined := by
  unfold lshr_eq_both_equal_before lshr_eq_both_equal_combined
  simp_alive_peephole
  sorry
def lshr_ne_both_equal_combined := [llvmfunc|
  llvm.func @lshr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_ne_both_equal   : lshr_ne_both_equal_before  ⊑  lshr_ne_both_equal_combined := by
  unfold lshr_ne_both_equal_before lshr_ne_both_equal_combined
  simp_alive_peephole
  sorry
def exact_ashr_eq_both_equal_combined := [llvmfunc|
  llvm.func @exact_ashr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_ashr_eq_both_equal   : exact_ashr_eq_both_equal_before  ⊑  exact_ashr_eq_both_equal_combined := by
  unfold exact_ashr_eq_both_equal_before exact_ashr_eq_both_equal_combined
  simp_alive_peephole
  sorry
def exact_ashr_ne_both_equal_combined := [llvmfunc|
  llvm.func @exact_ashr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_ashr_ne_both_equal   : exact_ashr_ne_both_equal_before  ⊑  exact_ashr_ne_both_equal_combined := by
  unfold exact_ashr_ne_both_equal_before exact_ashr_ne_both_equal_combined
  simp_alive_peephole
  sorry
def exact_lshr_eq_both_equal_combined := [llvmfunc|
  llvm.func @exact_lshr_eq_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_eq_both_equal   : exact_lshr_eq_both_equal_before  ⊑  exact_lshr_eq_both_equal_combined := by
  unfold exact_lshr_eq_both_equal_before exact_lshr_eq_both_equal_combined
  simp_alive_peephole
  sorry
def exact_lshr_ne_both_equal_combined := [llvmfunc|
  llvm.func @exact_lshr_ne_both_equal(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_ne_both_equal   : exact_lshr_ne_both_equal_before  ⊑  exact_lshr_ne_both_equal_combined := by
  unfold exact_lshr_ne_both_equal_before exact_lshr_ne_both_equal_combined
  simp_alive_peephole
  sorry
def exact_lshr_eq_opposite_msb_combined := [llvmfunc|
  llvm.func @exact_lshr_eq_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_eq_opposite_msb   : exact_lshr_eq_opposite_msb_before  ⊑  exact_lshr_eq_opposite_msb_combined := by
  unfold exact_lshr_eq_opposite_msb_before exact_lshr_eq_opposite_msb_combined
  simp_alive_peephole
  sorry
def lshr_eq_opposite_msb_combined := [llvmfunc|
  llvm.func @lshr_eq_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_eq_opposite_msb   : lshr_eq_opposite_msb_before  ⊑  lshr_eq_opposite_msb_combined := by
  unfold lshr_eq_opposite_msb_before lshr_eq_opposite_msb_combined
  simp_alive_peephole
  sorry
def exact_lshr_ne_opposite_msb_combined := [llvmfunc|
  llvm.func @exact_lshr_ne_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_ne_opposite_msb   : exact_lshr_ne_opposite_msb_before  ⊑  exact_lshr_ne_opposite_msb_combined := by
  unfold exact_lshr_ne_opposite_msb_before exact_lshr_ne_opposite_msb_combined
  simp_alive_peephole
  sorry
def lshr_ne_opposite_msb_combined := [llvmfunc|
  llvm.func @lshr_ne_opposite_msb(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_ne_opposite_msb   : lshr_ne_opposite_msb_before  ⊑  lshr_ne_opposite_msb_combined := by
  unfold lshr_ne_opposite_msb_before lshr_ne_opposite_msb_combined
  simp_alive_peephole
  sorry
def exact_ashr_eq_combined := [llvmfunc|
  llvm.func @exact_ashr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_ashr_eq   : exact_ashr_eq_before  ⊑  exact_ashr_eq_combined := by
  unfold exact_ashr_eq_before exact_ashr_eq_combined
  simp_alive_peephole
  sorry
def exact_ashr_ne_combined := [llvmfunc|
  llvm.func @exact_ashr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_ashr_ne   : exact_ashr_ne_before  ⊑  exact_ashr_ne_combined := by
  unfold exact_ashr_ne_before exact_ashr_ne_combined
  simp_alive_peephole
  sorry
def exact_lshr_eq_combined := [llvmfunc|
  llvm.func @exact_lshr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_eq   : exact_lshr_eq_before  ⊑  exact_lshr_eq_combined := by
  unfold exact_lshr_eq_before exact_lshr_eq_combined
  simp_alive_peephole
  sorry
def exact_lshr_ne_combined := [llvmfunc|
  llvm.func @exact_lshr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_ne   : exact_lshr_ne_before  ⊑  exact_lshr_ne_combined := by
  unfold exact_lshr_ne_before exact_lshr_ne_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_eq_combined := [llvmfunc|
  llvm.func @nonexact_ashr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_ashr_eq   : nonexact_ashr_eq_before  ⊑  nonexact_ashr_eq_combined := by
  unfold nonexact_ashr_eq_before nonexact_ashr_eq_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_ne_combined := [llvmfunc|
  llvm.func @nonexact_ashr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_ashr_ne   : nonexact_ashr_ne_before  ⊑  nonexact_ashr_ne_combined := by
  unfold nonexact_ashr_ne_before nonexact_ashr_ne_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_eq_combined := [llvmfunc|
  llvm.func @nonexact_lshr_eq(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_lshr_eq   : nonexact_lshr_eq_before  ⊑  nonexact_lshr_eq_combined := by
  unfold nonexact_lshr_eq_before nonexact_lshr_eq_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_ne_combined := [llvmfunc|
  llvm.func @nonexact_lshr_ne(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_lshr_ne   : nonexact_lshr_ne_before  ⊑  nonexact_lshr_ne_combined := by
  unfold nonexact_lshr_ne_before nonexact_lshr_ne_combined
  simp_alive_peephole
  sorry
def exact_lshr_eq_exactdiv_combined := [llvmfunc|
  llvm.func @exact_lshr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_eq_exactdiv   : exact_lshr_eq_exactdiv_before  ⊑  exact_lshr_eq_exactdiv_combined := by
  unfold exact_lshr_eq_exactdiv_before exact_lshr_eq_exactdiv_combined
  simp_alive_peephole
  sorry
def exact_lshr_ne_exactdiv_combined := [llvmfunc|
  llvm.func @exact_lshr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_lshr_ne_exactdiv   : exact_lshr_ne_exactdiv_before  ⊑  exact_lshr_ne_exactdiv_combined := by
  unfold exact_lshr_ne_exactdiv_before exact_lshr_ne_exactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_eq_exactdiv_combined := [llvmfunc|
  llvm.func @nonexact_lshr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_lshr_eq_exactdiv   : nonexact_lshr_eq_exactdiv_before  ⊑  nonexact_lshr_eq_exactdiv_combined := by
  unfold nonexact_lshr_eq_exactdiv_before nonexact_lshr_eq_exactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_ne_exactdiv_combined := [llvmfunc|
  llvm.func @nonexact_lshr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_lshr_ne_exactdiv   : nonexact_lshr_ne_exactdiv_before  ⊑  nonexact_lshr_ne_exactdiv_combined := by
  unfold nonexact_lshr_ne_exactdiv_before nonexact_lshr_ne_exactdiv_combined
  simp_alive_peephole
  sorry
def exact_ashr_eq_exactdiv_combined := [llvmfunc|
  llvm.func @exact_ashr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_ashr_eq_exactdiv   : exact_ashr_eq_exactdiv_before  ⊑  exact_ashr_eq_exactdiv_combined := by
  unfold exact_ashr_eq_exactdiv_before exact_ashr_eq_exactdiv_combined
  simp_alive_peephole
  sorry
def exact_ashr_ne_exactdiv_combined := [llvmfunc|
  llvm.func @exact_ashr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_exact_ashr_ne_exactdiv   : exact_ashr_ne_exactdiv_before  ⊑  exact_ashr_ne_exactdiv_combined := by
  unfold exact_ashr_ne_exactdiv_before exact_ashr_ne_exactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_eq_exactdiv_combined := [llvmfunc|
  llvm.func @nonexact_ashr_eq_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_ashr_eq_exactdiv   : nonexact_ashr_eq_exactdiv_before  ⊑  nonexact_ashr_eq_exactdiv_combined := by
  unfold nonexact_ashr_eq_exactdiv_before nonexact_ashr_eq_exactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_ne_exactdiv_combined := [llvmfunc|
  llvm.func @nonexact_ashr_ne_exactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(4 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_nonexact_ashr_ne_exactdiv   : nonexact_ashr_ne_exactdiv_before  ⊑  nonexact_ashr_ne_exactdiv_combined := by
  unfold nonexact_ashr_ne_exactdiv_before nonexact_ashr_ne_exactdiv_combined
  simp_alive_peephole
  sorry
def exact_lshr_eq_noexactdiv_combined := [llvmfunc|
  llvm.func @exact_lshr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_exact_lshr_eq_noexactdiv   : exact_lshr_eq_noexactdiv_before  ⊑  exact_lshr_eq_noexactdiv_combined := by
  unfold exact_lshr_eq_noexactdiv_before exact_lshr_eq_noexactdiv_combined
  simp_alive_peephole
  sorry
def exact_lshr_ne_noexactdiv_combined := [llvmfunc|
  llvm.func @exact_lshr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_exact_lshr_ne_noexactdiv   : exact_lshr_ne_noexactdiv_before  ⊑  exact_lshr_ne_noexactdiv_combined := by
  unfold exact_lshr_ne_noexactdiv_before exact_lshr_ne_noexactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_eq_noexactdiv_combined := [llvmfunc|
  llvm.func @nonexact_lshr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_lshr_eq_noexactdiv   : nonexact_lshr_eq_noexactdiv_before  ⊑  nonexact_lshr_eq_noexactdiv_combined := by
  unfold nonexact_lshr_eq_noexactdiv_before nonexact_lshr_eq_noexactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_ne_noexactdiv_combined := [llvmfunc|
  llvm.func @nonexact_lshr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_lshr_ne_noexactdiv   : nonexact_lshr_ne_noexactdiv_before  ⊑  nonexact_lshr_ne_noexactdiv_combined := by
  unfold nonexact_lshr_ne_noexactdiv_before nonexact_lshr_ne_noexactdiv_combined
  simp_alive_peephole
  sorry
def exact_ashr_eq_noexactdiv_combined := [llvmfunc|
  llvm.func @exact_ashr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_exact_ashr_eq_noexactdiv   : exact_ashr_eq_noexactdiv_before  ⊑  exact_ashr_eq_noexactdiv_combined := by
  unfold exact_ashr_eq_noexactdiv_before exact_ashr_eq_noexactdiv_combined
  simp_alive_peephole
  sorry
def exact_ashr_ne_noexactdiv_combined := [llvmfunc|
  llvm.func @exact_ashr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_exact_ashr_ne_noexactdiv   : exact_ashr_ne_noexactdiv_before  ⊑  exact_ashr_ne_noexactdiv_combined := by
  unfold exact_ashr_ne_noexactdiv_before exact_ashr_ne_noexactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_eq_noexactdiv_combined := [llvmfunc|
  llvm.func @nonexact_ashr_eq_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_ashr_eq_noexactdiv   : nonexact_ashr_eq_noexactdiv_before  ⊑  nonexact_ashr_eq_noexactdiv_combined := by
  unfold nonexact_ashr_eq_noexactdiv_before nonexact_ashr_eq_noexactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_ne_noexactdiv_combined := [llvmfunc|
  llvm.func @nonexact_ashr_ne_noexactdiv(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_ashr_ne_noexactdiv   : nonexact_ashr_ne_noexactdiv_before  ⊑  nonexact_ashr_ne_noexactdiv_combined := by
  unfold nonexact_ashr_ne_noexactdiv_before nonexact_ashr_ne_noexactdiv_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_eq_noexactlog_combined := [llvmfunc|
  llvm.func @nonexact_lshr_eq_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_lshr_eq_noexactlog   : nonexact_lshr_eq_noexactlog_before  ⊑  nonexact_lshr_eq_noexactlog_combined := by
  unfold nonexact_lshr_eq_noexactlog_before nonexact_lshr_eq_noexactlog_combined
  simp_alive_peephole
  sorry
def nonexact_lshr_ne_noexactlog_combined := [llvmfunc|
  llvm.func @nonexact_lshr_ne_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_lshr_ne_noexactlog   : nonexact_lshr_ne_noexactlog_before  ⊑  nonexact_lshr_ne_noexactlog_combined := by
  unfold nonexact_lshr_ne_noexactlog_before nonexact_lshr_ne_noexactlog_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_eq_noexactlog_combined := [llvmfunc|
  llvm.func @nonexact_ashr_eq_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_ashr_eq_noexactlog   : nonexact_ashr_eq_noexactlog_before  ⊑  nonexact_ashr_eq_noexactlog_combined := by
  unfold nonexact_ashr_eq_noexactlog_before nonexact_ashr_eq_noexactlog_combined
  simp_alive_peephole
  sorry
def nonexact_ashr_ne_noexactlog_combined := [llvmfunc|
  llvm.func @nonexact_ashr_ne_noexactlog(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_nonexact_ashr_ne_noexactlog   : nonexact_ashr_ne_noexactlog_before  ⊑  nonexact_ashr_ne_noexactlog_combined := by
  unfold nonexact_ashr_ne_noexactlog_before nonexact_ashr_ne_noexactlog_combined
  simp_alive_peephole
  sorry
def PR20945_combined := [llvmfunc|
  llvm.func @PR20945(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR20945   : PR20945_before  ⊑  PR20945_combined := by
  unfold PR20945_before PR20945_combined
  simp_alive_peephole
  sorry
def PR21222_combined := [llvmfunc|
  llvm.func @PR21222(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(6 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_PR21222   : PR21222_before  ⊑  PR21222_combined := by
  unfold PR21222_before PR21222_combined
  simp_alive_peephole
  sorry
def PR24873_combined := [llvmfunc|
  llvm.func @PR24873(%arg0: i64) -> i1 {
    %0 = llvm.mlir.constant(61 : i64) : i64
    %1 = llvm.icmp "ugt" %arg0, %0 : i64
    llvm.return %1 : i1
  }]

theorem inst_combine_PR24873   : PR24873_before  ⊑  PR24873_combined := by
  unfold PR24873_before PR24873_combined
  simp_alive_peephole
  sorry
def exact_multiuse_combined := [llvmfunc|
  llvm.func @exact_multiuse(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(131072 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %arg0, %1 : i32
    llvm.call @foo(%2) : (i32) -> ()
    llvm.return %3 : i1
  }]

theorem inst_combine_exact_multiuse   : exact_multiuse_before  ⊑  exact_multiuse_combined := by
  unfold exact_multiuse_before exact_multiuse_combined
  simp_alive_peephole
  sorry
def ashr_exact_eq_0_combined := [llvmfunc|
  llvm.func @ashr_exact_eq_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_exact_eq_0   : ashr_exact_eq_0_before  ⊑  ashr_exact_eq_0_combined := by
  unfold ashr_exact_eq_0_before ashr_exact_eq_0_combined
  simp_alive_peephole
  sorry
def ashr_exact_ne_0_uses_combined := [llvmfunc|
  llvm.func @ashr_exact_ne_0_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.ashr %arg0, %arg1  : i32
    llvm.call @foo(%1) : (i32) -> ()
    %2 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_ashr_exact_ne_0_uses   : ashr_exact_ne_0_uses_before  ⊑  ashr_exact_ne_0_uses_combined := by
  unfold ashr_exact_ne_0_uses_before ashr_exact_ne_0_uses_combined
  simp_alive_peephole
  sorry
def ashr_exact_eq_0_vec_combined := [llvmfunc|
  llvm.func @ashr_exact_eq_0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_ashr_exact_eq_0_vec   : ashr_exact_eq_0_vec_before  ⊑  ashr_exact_eq_0_vec_combined := by
  unfold ashr_exact_eq_0_vec_before ashr_exact_eq_0_vec_combined
  simp_alive_peephole
  sorry
def lshr_exact_ne_0_combined := [llvmfunc|
  llvm.func @lshr_exact_ne_0(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_exact_ne_0   : lshr_exact_ne_0_before  ⊑  lshr_exact_ne_0_combined := by
  unfold lshr_exact_ne_0_before lshr_exact_ne_0_combined
  simp_alive_peephole
  sorry
def lshr_exact_eq_0_uses_combined := [llvmfunc|
  llvm.func @lshr_exact_eq_0_uses(%arg0: i32, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.lshr %arg0, %arg1  : i32
    llvm.call @foo(%1) : (i32) -> ()
    %2 = llvm.icmp "eq" %arg0, %0 : i32
    llvm.return %2 : i1
  }]

theorem inst_combine_lshr_exact_eq_0_uses   : lshr_exact_eq_0_uses_before  ⊑  lshr_exact_eq_0_uses_combined := by
  unfold lshr_exact_eq_0_uses_before lshr_exact_eq_0_uses_combined
  simp_alive_peephole
  sorry
def lshr_exact_ne_0_vec_combined := [llvmfunc|
  llvm.func @lshr_exact_ne_0_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi32>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lshr_exact_ne_0_vec   : lshr_exact_ne_0_vec_before  ⊑  lshr_exact_ne_0_vec_combined := by
  unfold lshr_exact_ne_0_vec_before lshr_exact_ne_0_vec_combined
  simp_alive_peephole
  sorry
def ashr_ugt_0_combined := [llvmfunc|
  llvm.func @ashr_ugt_0(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_0   : ashr_ugt_0_before  ⊑  ashr_ugt_0_combined := by
  unfold ashr_ugt_0_before ashr_ugt_0_combined
  simp_alive_peephole
  sorry
def ashr_ugt_0_multiuse_combined := [llvmfunc|
  llvm.func @ashr_ugt_0_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.ashr %arg0, %0  : i4
    %2 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.store %1, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr
    llvm.return %2 : i1
  }]

theorem inst_combine_ashr_ugt_0_multiuse   : ashr_ugt_0_multiuse_before  ⊑  ashr_ugt_0_multiuse_combined := by
  unfold ashr_ugt_0_multiuse_before ashr_ugt_0_multiuse_combined
  simp_alive_peephole
  sorry
def ashr_ugt_1_combined := [llvmfunc|
  llvm.func @ashr_ugt_1(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(3 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_1   : ashr_ugt_1_before  ⊑  ashr_ugt_1_combined := by
  unfold ashr_ugt_1_before ashr_ugt_1_combined
  simp_alive_peephole
  sorry
def ashr_ugt_2_combined := [llvmfunc|
  llvm.func @ashr_ugt_2(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(5 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_2   : ashr_ugt_2_before  ⊑  ashr_ugt_2_combined := by
  unfold ashr_ugt_2_before ashr_ugt_2_combined
  simp_alive_peephole
  sorry
def ashr_ugt_3_combined := [llvmfunc|
  llvm.func @ashr_ugt_3(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_3   : ashr_ugt_3_before  ⊑  ashr_ugt_3_combined := by
  unfold ashr_ugt_3_before ashr_ugt_3_combined
  simp_alive_peephole
  sorry
def ashr_ugt_4_combined := [llvmfunc|
  llvm.func @ashr_ugt_4(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_4   : ashr_ugt_4_before  ⊑  ashr_ugt_4_combined := by
  unfold ashr_ugt_4_before ashr_ugt_4_combined
  simp_alive_peephole
  sorry
def ashr_ugt_5_combined := [llvmfunc|
  llvm.func @ashr_ugt_5(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_5   : ashr_ugt_5_before  ⊑  ashr_ugt_5_combined := by
  unfold ashr_ugt_5_before ashr_ugt_5_combined
  simp_alive_peephole
  sorry
def ashr_ugt_6_combined := [llvmfunc|
  llvm.func @ashr_ugt_6(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_6   : ashr_ugt_6_before  ⊑  ashr_ugt_6_combined := by
  unfold ashr_ugt_6_before ashr_ugt_6_combined
  simp_alive_peephole
  sorry
def ashr_ugt_7_combined := [llvmfunc|
  llvm.func @ashr_ugt_7(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_7   : ashr_ugt_7_before  ⊑  ashr_ugt_7_combined := by
  unfold ashr_ugt_7_before ashr_ugt_7_combined
  simp_alive_peephole
  sorry
def ashr_ugt_8_combined := [llvmfunc|
  llvm.func @ashr_ugt_8(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_8   : ashr_ugt_8_before  ⊑  ashr_ugt_8_combined := by
  unfold ashr_ugt_8_before ashr_ugt_8_combined
  simp_alive_peephole
  sorry
def ashr_ugt_9_combined := [llvmfunc|
  llvm.func @ashr_ugt_9(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_9   : ashr_ugt_9_before  ⊑  ashr_ugt_9_combined := by
  unfold ashr_ugt_9_before ashr_ugt_9_combined
  simp_alive_peephole
  sorry
def ashr_ugt_10_combined := [llvmfunc|
  llvm.func @ashr_ugt_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_10   : ashr_ugt_10_before  ⊑  ashr_ugt_10_combined := by
  unfold ashr_ugt_10_before ashr_ugt_10_combined
  simp_alive_peephole
  sorry
def ashr_ugt_11_combined := [llvmfunc|
  llvm.func @ashr_ugt_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(0 : i4) : i4
    %1 = llvm.icmp "slt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_11   : ashr_ugt_11_before  ⊑  ashr_ugt_11_combined := by
  unfold ashr_ugt_11_before ashr_ugt_11_combined
  simp_alive_peephole
  sorry
def ashr_ugt_12_combined := [llvmfunc|
  llvm.func @ashr_ugt_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-7 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_12   : ashr_ugt_12_before  ⊑  ashr_ugt_12_combined := by
  unfold ashr_ugt_12_before ashr_ugt_12_combined
  simp_alive_peephole
  sorry
def ashr_ugt_13_combined := [llvmfunc|
  llvm.func @ashr_ugt_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-5 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_13   : ashr_ugt_13_before  ⊑  ashr_ugt_13_combined := by
  unfold ashr_ugt_13_before ashr_ugt_13_combined
  simp_alive_peephole
  sorry
def ashr_ugt_14_combined := [llvmfunc|
  llvm.func @ashr_ugt_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-3 : i4) : i4
    %1 = llvm.icmp "ugt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ugt_14   : ashr_ugt_14_before  ⊑  ashr_ugt_14_combined := by
  unfold ashr_ugt_14_before ashr_ugt_14_combined
  simp_alive_peephole
  sorry
def ashr_ugt_15_combined := [llvmfunc|
  llvm.func @ashr_ugt_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashr_ugt_15   : ashr_ugt_15_before  ⊑  ashr_ugt_15_combined := by
  unfold ashr_ugt_15_before ashr_ugt_15_combined
  simp_alive_peephole
  sorry
def ashr_ult_0_combined := [llvmfunc|
  llvm.func @ashr_ult_0(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ashr_ult_0   : ashr_ult_0_before  ⊑  ashr_ult_0_combined := by
  unfold ashr_ult_0_before ashr_ult_0_combined
  simp_alive_peephole
  sorry
def ashr_ult_1_combined := [llvmfunc|
  llvm.func @ashr_ult_1(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(2 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_1   : ashr_ult_1_before  ⊑  ashr_ult_1_combined := by
  unfold ashr_ult_1_before ashr_ult_1_combined
  simp_alive_peephole
  sorry
def ashr_ult_2_combined := [llvmfunc|
  llvm.func @ashr_ult_2(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_2   : ashr_ult_2_before  ⊑  ashr_ult_2_combined := by
  unfold ashr_ult_2_before ashr_ult_2_combined
  simp_alive_peephole
  sorry
def ashr_ult_2_multiuse_combined := [llvmfunc|
  llvm.func @ashr_ult_2_multiuse(%arg0: i4, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i4) : i4
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.ashr %arg0, %0  : i4
    %3 = llvm.icmp "ult" %2, %1 : i4
    llvm.store %2, %arg1 {alignment = 1 : i64} : i4, !llvm.ptr
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_ult_2_multiuse   : ashr_ult_2_multiuse_before  ⊑  ashr_ult_2_multiuse_combined := by
  unfold ashr_ult_2_multiuse_before ashr_ult_2_multiuse_combined
  simp_alive_peephole
  sorry
def ashr_ult_3_combined := [llvmfunc|
  llvm.func @ashr_ult_3(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(6 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_3   : ashr_ult_3_before  ⊑  ashr_ult_3_combined := by
  unfold ashr_ult_3_before ashr_ult_3_combined
  simp_alive_peephole
  sorry
def ashr_ult_4_combined := [llvmfunc|
  llvm.func @ashr_ult_4(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_4   : ashr_ult_4_before  ⊑  ashr_ult_4_combined := by
  unfold ashr_ult_4_before ashr_ult_4_combined
  simp_alive_peephole
  sorry
def ashr_ult_5_combined := [llvmfunc|
  llvm.func @ashr_ult_5(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_5   : ashr_ult_5_before  ⊑  ashr_ult_5_combined := by
  unfold ashr_ult_5_before ashr_ult_5_combined
  simp_alive_peephole
  sorry
def ashr_ult_6_combined := [llvmfunc|
  llvm.func @ashr_ult_6(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_6   : ashr_ult_6_before  ⊑  ashr_ult_6_combined := by
  unfold ashr_ult_6_before ashr_ult_6_combined
  simp_alive_peephole
  sorry
def ashr_ult_7_combined := [llvmfunc|
  llvm.func @ashr_ult_7(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_7   : ashr_ult_7_before  ⊑  ashr_ult_7_combined := by
  unfold ashr_ult_7_before ashr_ult_7_combined
  simp_alive_peephole
  sorry
def ashr_ult_8_combined := [llvmfunc|
  llvm.func @ashr_ult_8(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_8   : ashr_ult_8_before  ⊑  ashr_ult_8_combined := by
  unfold ashr_ult_8_before ashr_ult_8_combined
  simp_alive_peephole
  sorry
def ashr_ult_9_combined := [llvmfunc|
  llvm.func @ashr_ult_9(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_9   : ashr_ult_9_before  ⊑  ashr_ult_9_combined := by
  unfold ashr_ult_9_before ashr_ult_9_combined
  simp_alive_peephole
  sorry
def ashr_ult_10_combined := [llvmfunc|
  llvm.func @ashr_ult_10(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_10   : ashr_ult_10_before  ⊑  ashr_ult_10_combined := by
  unfold ashr_ult_10_before ashr_ult_10_combined
  simp_alive_peephole
  sorry
def ashr_ult_11_combined := [llvmfunc|
  llvm.func @ashr_ult_11(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_11   : ashr_ult_11_before  ⊑  ashr_ult_11_combined := by
  unfold ashr_ult_11_before ashr_ult_11_combined
  simp_alive_peephole
  sorry
def ashr_ult_12_combined := [llvmfunc|
  llvm.func @ashr_ult_12(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-1 : i4) : i4
    %1 = llvm.icmp "sgt" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_12   : ashr_ult_12_before  ⊑  ashr_ult_12_combined := by
  unfold ashr_ult_12_before ashr_ult_12_combined
  simp_alive_peephole
  sorry
def ashr_ult_13_combined := [llvmfunc|
  llvm.func @ashr_ult_13(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-6 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_13   : ashr_ult_13_before  ⊑  ashr_ult_13_combined := by
  unfold ashr_ult_13_before ashr_ult_13_combined
  simp_alive_peephole
  sorry
def ashr_ult_14_combined := [llvmfunc|
  llvm.func @ashr_ult_14(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-4 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_14   : ashr_ult_14_before  ⊑  ashr_ult_14_combined := by
  unfold ashr_ult_14_before ashr_ult_14_combined
  simp_alive_peephole
  sorry
def ashr_ult_15_combined := [llvmfunc|
  llvm.func @ashr_ult_15(%arg0: i4) -> i1 {
    %0 = llvm.mlir.constant(-2 : i4) : i4
    %1 = llvm.icmp "ult" %arg0, %0 : i4
    llvm.return %1 : i1
  }]

theorem inst_combine_ashr_ult_15   : ashr_ult_15_before  ⊑  ashr_ult_15_combined := by
  unfold ashr_ult_15_before ashr_ult_15_combined
  simp_alive_peephole
  sorry
def lshr_eq_0_multiuse_combined := [llvmfunc|
  llvm.func @lshr_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_eq_0_multiuse   : lshr_eq_0_multiuse_before  ⊑  lshr_eq_0_multiuse_combined := by
  unfold lshr_eq_0_multiuse_before lshr_eq_0_multiuse_combined
  simp_alive_peephole
  sorry
def lshr_ne_0_multiuse_combined := [llvmfunc|
  llvm.func @lshr_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_ne_0_multiuse   : lshr_ne_0_multiuse_before  ⊑  lshr_ne_0_multiuse_combined := by
  unfold lshr_ne_0_multiuse_before lshr_ne_0_multiuse_combined
  simp_alive_peephole
  sorry
def ashr_eq_0_multiuse_combined := [llvmfunc|
  llvm.func @ashr_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_eq_0_multiuse   : ashr_eq_0_multiuse_before  ⊑  ashr_eq_0_multiuse_combined := by
  unfold ashr_eq_0_multiuse_before ashr_eq_0_multiuse_combined
  simp_alive_peephole
  sorry
def ashr_ne_0_multiuse_combined := [llvmfunc|
  llvm.func @ashr_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_ne_0_multiuse   : ashr_ne_0_multiuse_before  ⊑  ashr_ne_0_multiuse_combined := by
  unfold ashr_ne_0_multiuse_before ashr_ne_0_multiuse_combined
  simp_alive_peephole
  sorry
def lshr_exact_eq_0_multiuse_combined := [llvmfunc|
  llvm.func @lshr_exact_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_exact_eq_0_multiuse   : lshr_exact_eq_0_multiuse_before  ⊑  lshr_exact_eq_0_multiuse_combined := by
  unfold lshr_exact_eq_0_multiuse_before lshr_exact_eq_0_multiuse_combined
  simp_alive_peephole
  sorry
def lshr_exact_ne_0_multiuse_combined := [llvmfunc|
  llvm.func @lshr_exact_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_exact_ne_0_multiuse   : lshr_exact_ne_0_multiuse_before  ⊑  lshr_exact_ne_0_multiuse_combined := by
  unfold lshr_exact_ne_0_multiuse_before lshr_exact_ne_0_multiuse_combined
  simp_alive_peephole
  sorry
def ashr_exact_eq_0_multiuse_combined := [llvmfunc|
  llvm.func @ashr_exact_eq_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_exact_eq_0_multiuse   : ashr_exact_eq_0_multiuse_before  ⊑  ashr_exact_eq_0_multiuse_combined := by
  unfold ashr_exact_eq_0_multiuse_before ashr_exact_eq_0_multiuse_combined
  simp_alive_peephole
  sorry
def ashr_exact_ne_0_multiuse_combined := [llvmfunc|
  llvm.func @ashr_exact_ne_0_multiuse(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(2 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_exact_ne_0_multiuse   : ashr_exact_ne_0_multiuse_before  ⊑  ashr_exact_ne_0_multiuse_combined := by
  unfold ashr_exact_ne_0_multiuse_before ashr_exact_ne_0_multiuse_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ugt_combined := [llvmfunc|
  llvm.func @lshr_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_pow2_ugt   : lshr_pow2_ugt_before  ⊑  lshr_pow2_ugt_combined := by
  unfold lshr_pow2_ugt_before lshr_pow2_ugt_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ugt_use_combined := [llvmfunc|
  llvm.func @lshr_pow2_ugt_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(5 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_pow2_ugt_use   : lshr_pow2_ugt_use_before  ⊑  lshr_pow2_ugt_use_combined := by
  unfold lshr_pow2_ugt_use_before lshr_pow2_ugt_use_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ugt_vec_combined := [llvmfunc|
  llvm.func @lshr_pow2_ugt_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lshr_pow2_ugt_vec   : lshr_pow2_ugt_vec_before  ⊑  lshr_pow2_ugt_vec_combined := by
  unfold lshr_pow2_ugt_vec_before lshr_pow2_ugt_vec_combined
  simp_alive_peephole
  sorry
def lshr_not_pow2_ugt_combined := [llvmfunc|
  llvm.func @lshr_not_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_not_pow2_ugt   : lshr_not_pow2_ugt_before  ⊑  lshr_not_pow2_ugt_combined := by
  unfold lshr_not_pow2_ugt_before lshr_not_pow2_ugt_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ugt1_combined := [llvmfunc|
  llvm.func @lshr_pow2_ugt1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_pow2_ugt1   : lshr_pow2_ugt1_before  ⊑  lshr_pow2_ugt1_combined := by
  unfold lshr_pow2_ugt1_before lshr_pow2_ugt1_combined
  simp_alive_peephole
  sorry
def ashr_pow2_ugt_combined := [llvmfunc|
  llvm.func @ashr_pow2_ugt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-96 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ugt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_pow2_ugt   : ashr_pow2_ugt_before  ⊑  ashr_pow2_ugt_combined := by
  unfold ashr_pow2_ugt_before ashr_pow2_ugt_combined
  simp_alive_peephole
  sorry
def lshr_pow2_sgt_combined := [llvmfunc|
  llvm.func @lshr_pow2_sgt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_pow2_sgt   : lshr_pow2_sgt_before  ⊑  lshr_pow2_sgt_combined := by
  unfold lshr_pow2_sgt_before lshr_pow2_sgt_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ult_combined := [llvmfunc|
  llvm.func @lshr_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_pow2_ult   : lshr_pow2_ult_before  ⊑  lshr_pow2_ult_combined := by
  unfold lshr_pow2_ult_before lshr_pow2_ult_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ult_use_combined := [llvmfunc|
  llvm.func @lshr_pow2_ult_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(4 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_pow2_ult_use   : lshr_pow2_ult_use_before  ⊑  lshr_pow2_ult_use_combined := by
  unfold lshr_pow2_ult_use_before lshr_pow2_ult_use_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ult_vec_combined := [llvmfunc|
  llvm.func @lshr_pow2_ult_vec(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lshr_pow2_ult_vec   : lshr_pow2_ult_vec_before  ⊑  lshr_pow2_ult_vec_combined := by
  unfold lshr_pow2_ult_vec_before lshr_pow2_ult_vec_combined
  simp_alive_peephole
  sorry
def lshr_not_pow2_ult_combined := [llvmfunc|
  llvm.func @lshr_not_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_not_pow2_ult   : lshr_not_pow2_ult_before  ⊑  lshr_not_pow2_ult_combined := by
  unfold lshr_not_pow2_ult_before lshr_not_pow2_ult_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ult_equal_constants_combined := [llvmfunc|
  llvm.func @lshr_pow2_ult_equal_constants(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "ne" %arg0, %0 : i32
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_pow2_ult_equal_constants   : lshr_pow2_ult_equal_constants_before  ⊑  lshr_pow2_ult_equal_constants_combined := by
  unfold lshr_pow2_ult_equal_constants_before lshr_pow2_ult_equal_constants_combined
  simp_alive_peephole
  sorry
def lshr_pow2_ult_smin_combined := [llvmfunc|
  llvm.func @lshr_pow2_ult_smin(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_pow2_ult_smin   : lshr_pow2_ult_smin_before  ⊑  lshr_pow2_ult_smin_combined := by
  unfold lshr_pow2_ult_smin_before lshr_pow2_ult_smin_combined
  simp_alive_peephole
  sorry
def ashr_pow2_ult_combined := [llvmfunc|
  llvm.func @ashr_pow2_ult(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-96 : i8) : i8
    %2 = llvm.ashr %0, %arg0  : i8
    %3 = llvm.icmp "ult" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_ashr_pow2_ult   : ashr_pow2_ult_before  ⊑  ashr_pow2_ult_combined := by
  unfold ashr_pow2_ult_before ashr_pow2_ult_combined
  simp_alive_peephole
  sorry
def lshr_pow2_slt_combined := [llvmfunc|
  llvm.func @lshr_pow2_slt(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(3 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_pow2_slt   : lshr_pow2_slt_before  ⊑  lshr_pow2_slt_combined := by
  unfold lshr_pow2_slt_before lshr_pow2_slt_combined
  simp_alive_peephole
  sorry
def lshr_neg_sgt_minus_1_combined := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_neg_sgt_minus_1   : lshr_neg_sgt_minus_1_before  ⊑  lshr_neg_sgt_minus_1_combined := by
  unfold lshr_neg_sgt_minus_1_before lshr_neg_sgt_minus_1_combined
  simp_alive_peephole
  sorry
def lshr_neg_sgt_minus_1_vector_combined := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_1_vector(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ne" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lshr_neg_sgt_minus_1_vector   : lshr_neg_sgt_minus_1_vector_before  ⊑  lshr_neg_sgt_minus_1_vector_combined := by
  unfold lshr_neg_sgt_minus_1_vector_before lshr_neg_sgt_minus_1_vector_combined
  simp_alive_peephole
  sorry
def lshr_neg_sgt_minus_1_extra_use_combined := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_1_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "ne" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_neg_sgt_minus_1_extra_use   : lshr_neg_sgt_minus_1_extra_use_before  ⊑  lshr_neg_sgt_minus_1_extra_use_combined := by
  unfold lshr_neg_sgt_minus_1_extra_use_before lshr_neg_sgt_minus_1_extra_use_combined
  simp_alive_peephole
  sorry
def lshr_neg_sgt_minus_2_combined := [llvmfunc|
  llvm.func @lshr_neg_sgt_minus_2(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_neg_sgt_minus_2   : lshr_neg_sgt_minus_2_before  ⊑  lshr_neg_sgt_minus_2_combined := by
  unfold lshr_neg_sgt_minus_2_before lshr_neg_sgt_minus_2_combined
  simp_alive_peephole
  sorry
def lshr_neg_slt_minus_1_combined := [llvmfunc|
  llvm.func @lshr_neg_slt_minus_1(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_neg_slt_minus_1   : lshr_neg_slt_minus_1_before  ⊑  lshr_neg_slt_minus_1_combined := by
  unfold lshr_neg_slt_minus_1_before lshr_neg_slt_minus_1_combined
  simp_alive_peephole
  sorry
def lshr_neg_slt_zero_combined := [llvmfunc|
  llvm.func @lshr_neg_slt_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_lshr_neg_slt_zero   : lshr_neg_slt_zero_before  ⊑  lshr_neg_slt_zero_combined := by
  unfold lshr_neg_slt_zero_before lshr_neg_slt_zero_combined
  simp_alive_peephole
  sorry
def lshr_neg_slt_zero_vector_combined := [llvmfunc|
  llvm.func @lshr_neg_slt_zero_vector(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_lshr_neg_slt_zero_vector   : lshr_neg_slt_zero_vector_before  ⊑  lshr_neg_slt_zero_vector_combined := by
  unfold lshr_neg_slt_zero_vector_before lshr_neg_slt_zero_vector_combined
  simp_alive_peephole
  sorry
def lshr_neg_slt_zero_extra_use_combined := [llvmfunc|
  llvm.func @lshr_neg_slt_zero_extra_use(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "eq" %arg0, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_neg_slt_zero_extra_use   : lshr_neg_slt_zero_extra_use_before  ⊑  lshr_neg_slt_zero_extra_use_combined := by
  unfold lshr_neg_slt_zero_extra_use_before lshr_neg_slt_zero_extra_use_combined
  simp_alive_peephole
  sorry
def "lshr_neg_slt_non-zero"_combined := [llvmfunc|
  llvm.func @"lshr_neg_slt_non-zero"(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(2 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "slt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_"lshr_neg_slt_non-zero"   : "lshr_neg_slt_non-zero"_before  ⊑  "lshr_neg_slt_non-zero"_combined := by
  unfold "lshr_neg_slt_non-zero"_before "lshr_neg_slt_non-zero"_combined
  simp_alive_peephole
  sorry
def lshr_neg_sgt_zero_combined := [llvmfunc|
  llvm.func @lshr_neg_sgt_zero(%arg0: i8) -> i1 {
    %0 = llvm.mlir.constant(-17 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %0, %arg0  : i8
    %3 = llvm.icmp "sgt" %2, %1 : i8
    llvm.return %3 : i1
  }]

theorem inst_combine_lshr_neg_sgt_zero   : lshr_neg_sgt_zero_before  ⊑  lshr_neg_sgt_zero_combined := by
  unfold lshr_neg_sgt_zero_before lshr_neg_sgt_zero_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_exactly_one_set_signbit   : exactly_one_set_signbit_before  ⊑  exactly_one_set_signbit_combined := by
  unfold exactly_one_set_signbit_before exactly_one_set_signbit_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_use1_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit_use1(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %arg1  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_exactly_one_set_signbit_use1   : exactly_one_set_signbit_use1_before  ⊑  exactly_one_set_signbit_use1_combined := by
  unfold exactly_one_set_signbit_use1_before exactly_one_set_signbit_use1_combined
  simp_alive_peephole
  sorry
def same_signbit_combined := [llvmfunc|
  llvm.func @same_signbit(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_same_signbit   : same_signbit_before  ⊑  same_signbit_combined := by
  unfold same_signbit_before same_signbit_combined
  simp_alive_peephole
  sorry
def same_signbit_use2_combined := [llvmfunc|
  llvm.func @same_signbit_use2(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %0 : i8
    %2 = llvm.zext %1 : i1 to i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %arg1  : i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_same_signbit_use2   : same_signbit_use2_before  ⊑  same_signbit_use2_combined := by
  unfold same_signbit_use2_before same_signbit_use2_combined
  simp_alive_peephole
  sorry
def same_signbit_use3_combined := [llvmfunc|
  llvm.func @same_signbit_use3(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_same_signbit_use3   : same_signbit_use3_before  ⊑  same_signbit_use3_combined := by
  unfold same_signbit_use3_before same_signbit_use3_combined
  simp_alive_peephole
  sorry
def same_signbit_poison_elts_combined := [llvmfunc|
  llvm.func @same_signbit_poison_elts(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.icmp "sgt" %arg1, %6 : vector<2xi8>
    %10 = llvm.icmp "slt" %arg0, %8 : vector<2xi8>
    %11 = llvm.xor %10, %9  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_same_signbit_poison_elts   : same_signbit_poison_elts_before  ⊑  same_signbit_poison_elts_combined := by
  unfold same_signbit_poison_elts_before same_signbit_poison_elts_combined
  simp_alive_peephole
  sorry
def same_signbit_wrong_type_combined := [llvmfunc|
  llvm.func @same_signbit_wrong_type(%arg0: i8, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_same_signbit_wrong_type   : same_signbit_wrong_type_before  ⊑  same_signbit_wrong_type_combined := by
  unfold same_signbit_wrong_type_before same_signbit_wrong_type_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_wrong_shamt_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_shamt(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_exactly_one_set_signbit_wrong_shamt   : exactly_one_set_signbit_wrong_shamt_before  ⊑  exactly_one_set_signbit_wrong_shamt_combined := by
  unfold exactly_one_set_signbit_wrong_shamt_before exactly_one_set_signbit_wrong_shamt_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_wrong_shr_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_shr(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.zext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_exactly_one_set_signbit_wrong_shr   : exactly_one_set_signbit_wrong_shr_before  ⊑  exactly_one_set_signbit_wrong_shr_combined := by
  unfold exactly_one_set_signbit_wrong_shr_before exactly_one_set_signbit_wrong_shr_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_wrong_pred_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_pred(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.and %arg1, %arg0  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_exactly_one_set_signbit_wrong_pred   : exactly_one_set_signbit_wrong_pred_before  ⊑  exactly_one_set_signbit_wrong_pred_combined := by
  unfold exactly_one_set_signbit_wrong_pred_before exactly_one_set_signbit_wrong_pred_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_signed_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.xor %arg0, %arg1  : i8
    %2 = llvm.icmp "slt" %1, %0 : i8
    llvm.return %2 : i1
  }]

theorem inst_combine_exactly_one_set_signbit_signed   : exactly_one_set_signbit_signed_before  ⊑  exactly_one_set_signbit_signed_combined := by
  unfold exactly_one_set_signbit_signed_before exactly_one_set_signbit_signed_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_use1_signed_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit_use1_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %arg1  : i8
    %4 = llvm.icmp "slt" %3, %1 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_exactly_one_set_signbit_use1_signed   : exactly_one_set_signbit_use1_signed_before  ⊑  exactly_one_set_signbit_use1_signed_combined := by
  unfold exactly_one_set_signbit_use1_signed_before exactly_one_set_signbit_use1_signed_combined
  simp_alive_peephole
  sorry
def same_signbit_signed_combined := [llvmfunc|
  llvm.func @same_signbit_signed(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.xor %arg0, %arg1  : vector<2xi8>
    %2 = llvm.icmp "sgt" %1, %0 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }]

theorem inst_combine_same_signbit_signed   : same_signbit_signed_before  ⊑  same_signbit_signed_combined := by
  unfold same_signbit_signed_before same_signbit_signed_combined
  simp_alive_peephole
  sorry
def same_signbit_use2_signed_combined := [llvmfunc|
  llvm.func @same_signbit_use2_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %0 : i8
    %2 = llvm.sext %1 : i1 to i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.xor %arg0, %arg1  : i8
    %4 = llvm.icmp "sgt" %3, %0 : i8
    llvm.return %4 : i1
  }]

theorem inst_combine_same_signbit_use2_signed   : same_signbit_use2_signed_before  ⊑  same_signbit_use2_signed_combined := by
  unfold same_signbit_use2_signed_before same_signbit_use2_signed_combined
  simp_alive_peephole
  sorry
def same_signbit_use3_signed_combined := [llvmfunc|
  llvm.func @same_signbit_use3_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(7 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    llvm.call @use(%2) : (i8) -> ()
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    llvm.call @use(%4) : (i8) -> ()
    %5 = llvm.icmp "ne" %2, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_same_signbit_use3_signed   : same_signbit_use3_signed_before  ⊑  same_signbit_use3_signed_combined := by
  unfold same_signbit_use3_signed_before same_signbit_use3_signed_combined
  simp_alive_peephole
  sorry
def same_signbit_poison_elts_signed_combined := [llvmfunc|
  llvm.func @same_signbit_poison_elts_signed(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.mlir.undef : vector<2xi8>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xi8>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xi8>
    %7 = llvm.mlir.constant(0 : i8) : i8
    %8 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %9 = llvm.icmp "sgt" %arg1, %6 : vector<2xi8>
    %10 = llvm.icmp "slt" %arg0, %8 : vector<2xi8>
    %11 = llvm.xor %10, %9  : vector<2xi1>
    llvm.return %11 : vector<2xi1>
  }]

theorem inst_combine_same_signbit_poison_elts_signed   : same_signbit_poison_elts_signed_before  ⊑  same_signbit_poison_elts_signed_combined := by
  unfold same_signbit_poison_elts_signed_before same_signbit_poison_elts_signed_combined
  simp_alive_peephole
  sorry
def same_signbit_wrong_type_signed_combined := [llvmfunc|
  llvm.func @same_signbit_wrong_type_signed(%arg0: i8, %arg1: i32) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i8
    %4 = llvm.xor %3, %2  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_same_signbit_wrong_type_signed   : same_signbit_wrong_type_signed_before  ⊑  same_signbit_wrong_type_signed_combined := by
  unfold same_signbit_wrong_type_signed_before same_signbit_wrong_type_signed_combined
  simp_alive_peephole
  sorry
def exactly_one_set_signbit_wrong_shamt_signed_combined := [llvmfunc|
  llvm.func @exactly_one_set_signbit_wrong_shamt_signed(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(6 : i8) : i8
    %1 = llvm.mlir.constant(-1 : i8) : i8
    %2 = llvm.ashr %arg0, %0  : i8
    %3 = llvm.icmp "sgt" %arg1, %1 : i8
    %4 = llvm.sext %3 : i1 to i8
    %5 = llvm.icmp "eq" %2, %4 : i8
    llvm.return %5 : i1
  }]

theorem inst_combine_exactly_one_set_signbit_wrong_shamt_signed   : exactly_one_set_signbit_wrong_shamt_signed_before  ⊑  exactly_one_set_signbit_wrong_shamt_signed_combined := by
  unfold exactly_one_set_signbit_wrong_shamt_signed_before exactly_one_set_signbit_wrong_shamt_signed_combined
  simp_alive_peephole
  sorry
def slt_zero_ult_i1_combined := [llvmfunc|
  llvm.func @slt_zero_ult_i1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.xor %arg1, %1  : i1
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_slt_zero_ult_i1   : slt_zero_ult_i1_before  ⊑  slt_zero_ult_i1_combined := by
  unfold slt_zero_ult_i1_before slt_zero_ult_i1_combined
  simp_alive_peephole
  sorry
def slt_zero_ult_i1_fail1_combined := [llvmfunc|
  llvm.func @slt_zero_ult_i1_fail1(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(30 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_zero_ult_i1_fail1   : slt_zero_ult_i1_fail1_before  ⊑  slt_zero_ult_i1_fail1_combined := by
  unfold slt_zero_ult_i1_fail1_before slt_zero_ult_i1_fail1_combined
  simp_alive_peephole
  sorry
def slt_zero_ult_i1_fail2_combined := [llvmfunc|
  llvm.func @slt_zero_ult_i1_fail2(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.zext %arg1 : i1 to i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.icmp "ugt" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_zero_ult_i1_fail2   : slt_zero_ult_i1_fail2_before  ⊑  slt_zero_ult_i1_fail2_combined := by
  unfold slt_zero_ult_i1_fail2_before slt_zero_ult_i1_fail2_combined
  simp_alive_peephole
  sorry
def slt_zero_slt_i1_fail_combined := [llvmfunc|
  llvm.func @slt_zero_slt_i1_fail(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %0 : i32
    %3 = llvm.xor %arg1, %1  : i1
    %4 = llvm.and %2, %3  : i1
    llvm.return %4 : i1
  }]

theorem inst_combine_slt_zero_slt_i1_fail   : slt_zero_slt_i1_fail_before  ⊑  slt_zero_slt_i1_fail_combined := by
  unfold slt_zero_slt_i1_fail_before slt_zero_slt_i1_fail_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_i1_signed_combined := [llvmfunc|
  llvm.func @slt_zero_eq_i1_signed(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.xor %1, %arg1  : i1
    llvm.return %2 : i1
  }]

theorem inst_combine_slt_zero_eq_i1_signed   : slt_zero_eq_i1_signed_before  ⊑  slt_zero_eq_i1_signed_combined := by
  unfold slt_zero_eq_i1_signed_before slt_zero_eq_i1_signed_combined
  simp_alive_peephole
  sorry
def slt_zero_eq_i1_fail_signed_combined := [llvmfunc|
  llvm.func @slt_zero_eq_i1_fail_signed(%arg0: i32, %arg1: i1) -> i1 {
    %0 = llvm.mlir.constant(31 : i32) : i32
    %1 = llvm.sext %arg1 : i1 to i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.icmp "eq" %2, %1 : i32
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_zero_eq_i1_fail_signed   : slt_zero_eq_i1_fail_signed_before  ⊑  slt_zero_eq_i1_fail_signed_combined := by
  unfold slt_zero_eq_i1_fail_signed_before slt_zero_eq_i1_fail_signed_combined
  simp_alive_peephole
  sorry
