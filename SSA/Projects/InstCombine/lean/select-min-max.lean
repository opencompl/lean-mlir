import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-min-max
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def smin_smin_common_op_00_before := [llvmfunc|
  llvm.func @smin_smin_common_op_00(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.intr.smin(%arg3, %arg1)  : (i5, i5) -> i5
    %1 = llvm.intr.smin(%arg3, %arg2)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

def smax_smax_common_op_01_before := [llvmfunc|
  llvm.func @smax_smax_common_op_01(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.intr.smax(%arg3, %arg1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %1 = llvm.intr.smax(%arg2, %arg3)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

def umin_umin_common_op_10_before := [llvmfunc|
  llvm.func @umin_umin_common_op_10(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg1, %arg3)  : (i5, i5) -> i5
    llvm.store %0, %arg4 {alignment = 1 : i64} : i5, !llvm.ptr]

    %1 = llvm.intr.umin(%arg3, %arg2)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

def umax_umax_common_op_11_before := [llvmfunc|
  llvm.func @umax_umax_common_op_11(%arg0: i1, %arg1: vector<3xi5>, %arg2: vector<3xi5>, %arg3: vector<3xi5>, %arg4: !llvm.ptr) -> vector<3xi5> {
    %0 = llvm.intr.umax(%arg1, %arg3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    %1 = llvm.intr.umax(%arg2, %arg3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.store %1, %arg4 {alignment = 2 : i64} : vector<3xi5>, !llvm.ptr]

    %2 = llvm.select %arg0, %0, %1 : i1, vector<3xi5>
    llvm.return %2 : vector<3xi5>
  }]

def smin_umin_common_op_11_before := [llvmfunc|
  llvm.func @smin_umin_common_op_11(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.intr.smin(%arg1, %arg3)  : (i5, i5) -> i5
    %1 = llvm.intr.umin(%arg2, %arg3)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

def smin_smin_no_common_op_before := [llvmfunc|
  llvm.func @smin_smin_no_common_op(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: i5) -> i5 {
    %0 = llvm.intr.smin(%arg3, %arg1)  : (i5, i5) -> i5
    %1 = llvm.intr.smin(%arg4, %arg2)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

def umin_umin_common_op_10_uses_before := [llvmfunc|
  llvm.func @umin_umin_common_op_10_uses(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: !llvm.ptr, %arg5: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg1, %arg3)  : (i5, i5) -> i5
    llvm.store %0, %arg4 {alignment = 1 : i64} : i5, !llvm.ptr]

    %1 = llvm.intr.umin(%arg3, %arg2)  : (i5, i5) -> i5
    llvm.store %1, %arg5 {alignment = 1 : i64} : i5, !llvm.ptr]

    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

def smin_select_const_const_before := [llvmfunc|
  llvm.func @smin_select_const_const(%arg0: i1) -> i5 {
    %0 = llvm.mlir.constant(-3 : i5) : i5
    %1 = llvm.mlir.constant(8 : i5) : i5
    %2 = llvm.mlir.constant(5 : i5) : i5
    %3 = llvm.select %arg0, %0, %1 : i1, i5
    %4 = llvm.intr.smin(%3, %2)  : (i5, i5) -> i5
    llvm.return %4 : i5
  }]

def smax_select_const_const_before := [llvmfunc|
  llvm.func @smax_select_const_const(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 43]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.mlir.constant(dense<[0, 42]> : vector<2xi8>) : vector<2xi8>
    %3 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi8>
    %4 = llvm.intr.smax(%3, %2)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %4 : vector<2xi8>
  }]

def umin_select_const_const_before := [llvmfunc|
  llvm.func @umin_select_const_const(%arg0: i1) -> i5 {
    %0 = llvm.mlir.constant(8 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.mlir.constant(4 : i5) : i5
    %3 = llvm.select %arg0, %0, %1 : i1, i5
    %4 = llvm.intr.umin(%2, %3)  : (i5, i5) -> i5
    llvm.return %4 : i5
  }]

def umax_select_const_const_before := [llvmfunc|
  llvm.func @umax_select_const_const(%arg0: vector<3xi1>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.mlir.constant(2 : i5) : i5
    %3 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.constant(9 : i5) : i5
    %5 = llvm.mlir.constant(8 : i5) : i5
    %6 = llvm.mlir.constant(7 : i5) : i5
    %7 = llvm.mlir.constant(dense<[7, 8, 9]> : vector<3xi5>) : vector<3xi5>
    %8 = llvm.mlir.constant(-16 : i5) : i5
    %9 = llvm.mlir.constant(5 : i5) : i5
    %10 = llvm.mlir.constant(dense<[5, 8, -16]> : vector<3xi5>) : vector<3xi5>
    %11 = llvm.select %arg0, %3, %7 : vector<3xi1>, vector<3xi5>
    %12 = llvm.intr.umax(%10, %11)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.return %12 : vector<3xi5>
  }]

def smin_select_const_before := [llvmfunc|
  llvm.func @smin_select_const(%arg0: i1, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(-3 : i5) : i5
    %1 = llvm.mlir.constant(5 : i5) : i5
    %2 = llvm.select %arg0, %0, %arg1 : i1, i5
    %3 = llvm.intr.smin(%2, %1)  : (i5, i5) -> i5
    llvm.return %3 : i5
  }]

def smax_select_const_before := [llvmfunc|
  llvm.func @smax_select_const(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[5, 43]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[0, 42]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.select %arg0, %arg1, %0 : vector<2xi1>, vector<2xi8>
    %3 = llvm.intr.smax(%2, %1)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

def umin_select_const_before := [llvmfunc|
  llvm.func @umin_select_const(%arg0: i1, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(3 : i5) : i5
    %1 = llvm.mlir.constant(4 : i5) : i5
    %2 = llvm.select %arg0, %arg1, %0 : i1, i5
    %3 = llvm.intr.umin(%1, %2)  : (i5, i5) -> i5
    llvm.return %3 : i5
  }]

def umax_select_const_before := [llvmfunc|
  llvm.func @umax_select_const(%arg0: vector<3xi1>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.mlir.constant(2 : i5) : i5
    %3 = llvm.mlir.constant(dense<[2, 3, 4]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.constant(1 : i5) : i5
    %5 = llvm.mlir.constant(8 : i5) : i5
    %6 = llvm.mlir.constant(5 : i5) : i5
    %7 = llvm.mlir.constant(dense<[5, 8, 1]> : vector<3xi5>) : vector<3xi5>
    %8 = llvm.select %arg0, %3, %arg1 : vector<3xi1>, vector<3xi5>
    %9 = llvm.intr.umax(%7, %8)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.return %9 : vector<3xi5>
  }]

def smax_smin_before := [llvmfunc|
  llvm.func @smax_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.intr.smax(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def smin_smax_before := [llvmfunc|
  llvm.func @smin_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(-2 : i32) : i32
    %2 = llvm.intr.smin(%arg0, %0)  : (i32, i32) -> i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %1 : i1, i32
    llvm.return %4 : i32
  }]

def umax_umin_before := [llvmfunc|
  llvm.func @umax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(-127 : i8) : i8
    %2 = llvm.intr.umax(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "ult" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }]

def umin_umax_before := [llvmfunc|
  llvm.func @umin_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(126 : i8) : i8
    %2 = llvm.intr.umin(%arg0, %0)  : (i8, i8) -> i8
    %3 = llvm.icmp "ugt" %arg0, %1 : i8
    %4 = llvm.select %3, %2, %1 : i1, i8
    llvm.return %4 : i8
  }]

def not_smax_before := [llvmfunc|
  llvm.func @not_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %0, %2 : i1, i8
    llvm.return %3 : i8
  }]

def not_smax_swap_before := [llvmfunc|
  llvm.func @not_smax_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %0 : i1, i8
    llvm.return %3 : i8
  }]

def not_smin_before := [llvmfunc|
  llvm.func @not_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %0, %2 : i1, i8
    llvm.return %3 : i8
  }]

def not_smin_swap_before := [llvmfunc|
  llvm.func @not_smin_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %0 : i1, i8
    llvm.return %3 : i8
  }]

def smin_smin_common_op_00_combined := [llvmfunc|
  llvm.func @smin_smin_common_op_00(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.select %arg0, %arg1, %arg2 : i1, i5
    %1 = llvm.intr.smin(%0, %arg3)  : (i5, i5) -> i5
    llvm.return %1 : i5
  }]

theorem inst_combine_smin_smin_common_op_00   : smin_smin_common_op_00_before  ⊑  smin_smin_common_op_00_combined := by
  unfold smin_smin_common_op_00_before smin_smin_common_op_00_combined
  simp_alive_peephole
  sorry
def smax_smax_common_op_01_combined := [llvmfunc|
  llvm.func @smax_smax_common_op_01(%arg0: vector<2xi1>, %arg1: vector<2xi8>, %arg2: vector<2xi8>, %arg3: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.select %arg0, %arg1, %arg2 : vector<2xi1>, vector<2xi8>
    %1 = llvm.intr.smax(%0, %arg3)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    llvm.return %1 : vector<2xi8>
  }]

theorem inst_combine_smax_smax_common_op_01   : smax_smax_common_op_01_before  ⊑  smax_smax_common_op_01_combined := by
  unfold smax_smax_common_op_01_before smax_smax_common_op_01_combined
  simp_alive_peephole
  sorry
def umin_umin_common_op_10_combined := [llvmfunc|
  llvm.func @umin_umin_common_op_10(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg1, %arg3)  : (i5, i5) -> i5
    llvm.store %0, %arg4 {alignment = 1 : i64} : i5, !llvm.ptr]

theorem inst_combine_umin_umin_common_op_10   : umin_umin_common_op_10_before  ⊑  umin_umin_common_op_10_combined := by
  unfold umin_umin_common_op_10_before umin_umin_common_op_10_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, i5
    %2 = llvm.intr.umin(%1, %arg3)  : (i5, i5) -> i5
    llvm.return %2 : i5
  }]

theorem inst_combine_umin_umin_common_op_10   : umin_umin_common_op_10_before  ⊑  umin_umin_common_op_10_combined := by
  unfold umin_umin_common_op_10_before umin_umin_common_op_10_combined
  simp_alive_peephole
  sorry
def umax_umax_common_op_11_combined := [llvmfunc|
  llvm.func @umax_umax_common_op_11(%arg0: i1, %arg1: vector<3xi5>, %arg2: vector<3xi5>, %arg3: vector<3xi5>, %arg4: !llvm.ptr) -> vector<3xi5> {
    %0 = llvm.intr.umax(%arg2, %arg3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.store %0, %arg4 {alignment = 2 : i64} : vector<3xi5>, !llvm.ptr]

theorem inst_combine_umax_umax_common_op_11   : umax_umax_common_op_11_before  ⊑  umax_umax_common_op_11_combined := by
  unfold umax_umax_common_op_11_before umax_umax_common_op_11_combined
  simp_alive_peephole
  sorry
    %1 = llvm.select %arg0, %arg1, %arg2 : i1, vector<3xi5>
    %2 = llvm.intr.umax(%1, %arg3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    llvm.return %2 : vector<3xi5>
  }]

theorem inst_combine_umax_umax_common_op_11   : umax_umax_common_op_11_before  ⊑  umax_umax_common_op_11_combined := by
  unfold umax_umax_common_op_11_before umax_umax_common_op_11_combined
  simp_alive_peephole
  sorry
def smin_umin_common_op_11_combined := [llvmfunc|
  llvm.func @smin_umin_common_op_11(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5) -> i5 {
    %0 = llvm.intr.smin(%arg1, %arg3)  : (i5, i5) -> i5
    %1 = llvm.intr.umin(%arg2, %arg3)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

theorem inst_combine_smin_umin_common_op_11   : smin_umin_common_op_11_before  ⊑  smin_umin_common_op_11_combined := by
  unfold smin_umin_common_op_11_before smin_umin_common_op_11_combined
  simp_alive_peephole
  sorry
def smin_smin_no_common_op_combined := [llvmfunc|
  llvm.func @smin_smin_no_common_op(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: i5) -> i5 {
    %0 = llvm.intr.smin(%arg3, %arg1)  : (i5, i5) -> i5
    %1 = llvm.intr.smin(%arg4, %arg2)  : (i5, i5) -> i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

theorem inst_combine_smin_smin_no_common_op   : smin_smin_no_common_op_before  ⊑  smin_smin_no_common_op_combined := by
  unfold smin_smin_no_common_op_before smin_smin_no_common_op_combined
  simp_alive_peephole
  sorry
def umin_umin_common_op_10_uses_combined := [llvmfunc|
  llvm.func @umin_umin_common_op_10_uses(%arg0: i1, %arg1: i5, %arg2: i5, %arg3: i5, %arg4: !llvm.ptr, %arg5: !llvm.ptr) -> i5 {
    %0 = llvm.intr.umin(%arg1, %arg3)  : (i5, i5) -> i5
    llvm.store %0, %arg4 {alignment = 1 : i64} : i5, !llvm.ptr]

theorem inst_combine_umin_umin_common_op_10_uses   : umin_umin_common_op_10_uses_before  ⊑  umin_umin_common_op_10_uses_combined := by
  unfold umin_umin_common_op_10_uses_before umin_umin_common_op_10_uses_combined
  simp_alive_peephole
  sorry
    %1 = llvm.intr.umin(%arg3, %arg2)  : (i5, i5) -> i5
    llvm.store %1, %arg5 {alignment = 1 : i64} : i5, !llvm.ptr]

theorem inst_combine_umin_umin_common_op_10_uses   : umin_umin_common_op_10_uses_before  ⊑  umin_umin_common_op_10_uses_combined := by
  unfold umin_umin_common_op_10_uses_before umin_umin_common_op_10_uses_combined
  simp_alive_peephole
  sorry
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

theorem inst_combine_umin_umin_common_op_10_uses   : umin_umin_common_op_10_uses_before  ⊑  umin_umin_common_op_10_uses_combined := by
  unfold umin_umin_common_op_10_uses_before umin_umin_common_op_10_uses_combined
  simp_alive_peephole
  sorry
def smin_select_const_const_combined := [llvmfunc|
  llvm.func @smin_select_const_const(%arg0: i1) -> i5 {
    %0 = llvm.mlir.constant(-3 : i5) : i5
    %1 = llvm.mlir.constant(5 : i5) : i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

theorem inst_combine_smin_select_const_const   : smin_select_const_const_before  ⊑  smin_select_const_const_combined := by
  unfold smin_select_const_const_before smin_select_const_const_combined
  simp_alive_peephole
  sorry
def smax_select_const_const_combined := [llvmfunc|
  llvm.func @smax_select_const_const(%arg0: vector<2xi1>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[1, 42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 43]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.select %arg0, %0, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %2 : vector<2xi8>
  }]

theorem inst_combine_smax_select_const_const   : smax_select_const_const_before  ⊑  smax_select_const_const_combined := by
  unfold smax_select_const_const_before smax_select_const_const_combined
  simp_alive_peephole
  sorry
def umin_select_const_const_combined := [llvmfunc|
  llvm.func @umin_select_const_const(%arg0: i1) -> i5 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.select %arg0, %0, %1 : i1, i5
    llvm.return %2 : i5
  }]

theorem inst_combine_umin_select_const_const   : umin_select_const_const_before  ⊑  umin_select_const_const_combined := by
  unfold umin_select_const_const_before umin_select_const_const_combined
  simp_alive_peephole
  sorry
def umax_select_const_const_combined := [llvmfunc|
  llvm.func @umax_select_const_const(%arg0: vector<3xi1>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(-16 : i5) : i5
    %1 = llvm.mlir.constant(8 : i5) : i5
    %2 = llvm.mlir.constant(5 : i5) : i5
    %3 = llvm.mlir.constant(dense<[5, 8, -16]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.constant(7 : i5) : i5
    %5 = llvm.mlir.constant(dense<[7, 8, -16]> : vector<3xi5>) : vector<3xi5>
    %6 = llvm.select %arg0, %3, %5 : vector<3xi1>, vector<3xi5>
    llvm.return %6 : vector<3xi5>
  }]

theorem inst_combine_umax_select_const_const   : umax_select_const_const_before  ⊑  umax_select_const_const_combined := by
  unfold umax_select_const_const_before umax_select_const_const_combined
  simp_alive_peephole
  sorry
def smin_select_const_combined := [llvmfunc|
  llvm.func @smin_select_const(%arg0: i1, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(5 : i5) : i5
    %1 = llvm.mlir.constant(-3 : i5) : i5
    %2 = llvm.intr.smin(%arg1, %0)  : (i5, i5) -> i5
    %3 = llvm.select %arg0, %1, %2 : i1, i5
    llvm.return %3 : i5
  }]

theorem inst_combine_smin_select_const   : smin_select_const_before  ⊑  smin_select_const_combined := by
  unfold smin_select_const_before smin_select_const_combined
  simp_alive_peephole
  sorry
def smax_select_const_combined := [llvmfunc|
  llvm.func @smax_select_const(%arg0: vector<2xi1>, %arg1: vector<2xi8>) -> vector<2xi8> {
    %0 = llvm.mlir.constant(dense<[0, 42]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.mlir.constant(dense<[5, 43]> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.intr.smax(%arg1, %0)  : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    %3 = llvm.select %arg0, %2, %1 : vector<2xi1>, vector<2xi8>
    llvm.return %3 : vector<2xi8>
  }]

theorem inst_combine_smax_select_const   : smax_select_const_before  ⊑  smax_select_const_combined := by
  unfold smax_select_const_before smax_select_const_combined
  simp_alive_peephole
  sorry
def umin_select_const_combined := [llvmfunc|
  llvm.func @umin_select_const(%arg0: i1, %arg1: i5) -> i5 {
    %0 = llvm.mlir.constant(4 : i5) : i5
    %1 = llvm.mlir.constant(3 : i5) : i5
    %2 = llvm.intr.umin(%arg1, %0)  : (i5, i5) -> i5
    %3 = llvm.select %arg0, %2, %1 : i1, i5
    llvm.return %3 : i5
  }]

theorem inst_combine_umin_select_const   : umin_select_const_before  ⊑  umin_select_const_combined := by
  unfold umin_select_const_before umin_select_const_combined
  simp_alive_peephole
  sorry
def umax_select_const_combined := [llvmfunc|
  llvm.func @umax_select_const(%arg0: vector<3xi1>, %arg1: vector<3xi5>) -> vector<3xi5> {
    %0 = llvm.mlir.constant(1 : i5) : i5
    %1 = llvm.mlir.constant(8 : i5) : i5
    %2 = llvm.mlir.constant(5 : i5) : i5
    %3 = llvm.mlir.constant(dense<[5, 8, 1]> : vector<3xi5>) : vector<3xi5>
    %4 = llvm.mlir.constant(4 : i5) : i5
    %5 = llvm.mlir.constant(dense<[5, 8, 4]> : vector<3xi5>) : vector<3xi5>
    %6 = llvm.intr.umax(%arg1, %3)  : (vector<3xi5>, vector<3xi5>) -> vector<3xi5>
    %7 = llvm.select %arg0, %5, %6 : vector<3xi1>, vector<3xi5>
    llvm.return %7 : vector<3xi5>
  }]

theorem inst_combine_umax_select_const   : umax_select_const_before  ⊑  umax_select_const_combined := by
  unfold umax_select_const_before umax_select_const_combined
  simp_alive_peephole
  sorry
def smax_smin_combined := [llvmfunc|
  llvm.func @smax_smin(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.icmp "sgt" %arg0, %0 : i32
    %2 = llvm.zext %1 : i1 to i32
    llvm.return %2 : i32
  }]

theorem inst_combine_smax_smin   : smax_smin_before  ⊑  smax_smin_combined := by
  unfold smax_smin_before smax_smin_combined
  simp_alive_peephole
  sorry
def smin_smax_combined := [llvmfunc|
  llvm.func @smin_smax(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg0, %0 : i32
    %3 = llvm.select %2, %1, %0 : i1, i32
    llvm.return %3 : i32
  }]

theorem inst_combine_smin_smax   : smin_smax_before  ⊑  smin_smax_combined := by
  unfold smin_smax_before smin_smax_combined
  simp_alive_peephole
  sorry
def umax_umin_combined := [llvmfunc|
  llvm.func @umax_umin(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(-127 : i8) : i8
    %1 = llvm.mlir.constant(-128 : i8) : i8
    %2 = llvm.icmp "ult" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umax_umin   : umax_umin_before  ⊑  umax_umin_combined := by
  unfold umax_umin_before umax_umin_combined
  simp_alive_peephole
  sorry
def umin_umax_combined := [llvmfunc|
  llvm.func @umin_umax(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(126 : i8) : i8
    %1 = llvm.mlir.constant(127 : i8) : i8
    %2 = llvm.icmp "ugt" %arg0, %0 : i8
    %3 = llvm.select %2, %1, %0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_umax   : umin_umax_before  ⊑  umin_umax_combined := by
  unfold umin_umax_before umin_umax_combined
  simp_alive_peephole
  sorry
def not_smax_combined := [llvmfunc|
  llvm.func @not_smax(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %0, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_smax   : not_smax_before  ⊑  not_smax_combined := by
  unfold not_smax_before not_smax_combined
  simp_alive_peephole
  sorry
def not_smax_swap_combined := [llvmfunc|
  llvm.func @not_smax_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_smax_swap   : not_smax_swap_before  ⊑  not_smax_swap_combined := by
  unfold not_smax_swap_before not_smax_swap_combined
  simp_alive_peephole
  sorry
def not_smin_combined := [llvmfunc|
  llvm.func @not_smin(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %0, %2 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_smin   : not_smin_before  ⊑  not_smin_combined := by
  unfold not_smin_before not_smin_combined
  simp_alive_peephole
  sorry
def not_smin_swap_combined := [llvmfunc|
  llvm.func @not_smin_swap(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.sub %arg0, %arg1 overflow<nsw>  : i8
    %3 = llvm.select %1, %2, %0 : i1, i8
    llvm.return %3 : i8
  }]

theorem inst_combine_not_smin_swap   : not_smin_swap_before  ⊑  not_smin_swap_combined := by
  unfold not_smin_swap_before not_smin_swap_combined
  simp_alive_peephole
  sorry
