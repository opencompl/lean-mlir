import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  max-of-nots
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def umin_of_nots_before := [llvmfunc|
  llvm.func @umin_of_nots(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "ult" %1, %2 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def smin_of_nots_before := [llvmfunc|
  llvm.func @smin_of_nots(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.xor %arg0, %0  : vector<2xi32>
    %2 = llvm.xor %arg1, %0  : vector<2xi32>
    %3 = llvm.icmp "sle" %1, %2 : vector<2xi32>
    %4 = llvm.select %3, %1, %2 : vector<2xi1>, vector<2xi32>
    llvm.return %4 : vector<2xi32>
  }]

def compute_min_2_before := [llvmfunc|
  llvm.func @compute_min_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.icmp "sgt" %1, %2 : i32
    %4 = llvm.select %3, %1, %2 : i1, i32
    %5 = llvm.sub %0, %4  : i32
    llvm.return %5 : i32
  }]

def umin_not_1_extra_use_before := [llvmfunc|
  llvm.func @umin_not_1_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.return %4 : i8
  }]

def umin_not_2_extra_use_before := [llvmfunc|
  llvm.func @umin_not_2_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.icmp "ult" %1, %2 : i8
    %4 = llvm.select %3, %1, %2 : i1, i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.call @extra_use(%2) : (i8) -> ()
    llvm.return %4 : i8
  }]

def umin3_not_before := [llvmfunc|
  llvm.func @umin3_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %arg1, %arg0 : i8
    %5 = llvm.icmp "ult" %1, %3 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "ult" %2, %3 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    llvm.return %9 : i8
  }]

def umin3_not_more_uses_before := [llvmfunc|
  llvm.func @umin3_not_more_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    %5 = llvm.select %4, %1, %3 : i1, i8
    %6 = llvm.icmp "ult" %2, %3 : i8
    %7 = llvm.select %6, %2, %3 : i1, i8
    %8 = llvm.icmp "ult" %arg1, %arg0 : i8
    %9 = llvm.select %8, %5, %7 : i1, i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.call @extra_use(%2) : (i8) -> ()
    llvm.return %9 : i8
  }]

def umin3_not_all_ops_extra_uses_before := [llvmfunc|
  llvm.func @umin3_not_all_ops_extra_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %1, %3 : i8
    %5 = llvm.select %4, %1, %3 : i1, i8
    %6 = llvm.icmp "ult" %5, %2 : i8
    %7 = llvm.select %6, %5, %2 : i1, i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.call @use8(%2) : (i8) -> ()
    llvm.call @use8(%3) : (i8) -> ()
    llvm.return %7 : i8
  }]

def compute_min_3_before := [llvmfunc|
  llvm.func @compute_min_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.sub %0, %arg2  : i32
    %4 = llvm.icmp "sgt" %1, %2 : i32
    %5 = llvm.select %4, %1, %2 : i1, i32
    %6 = llvm.icmp "sgt" %5, %3 : i32
    %7 = llvm.select %6, %5, %3 : i1, i32
    %8 = llvm.sub %0, %7  : i32
    llvm.return %8 : i32
  }]

def compute_min_arithmetic_before := [llvmfunc|
  llvm.func @compute_min_arithmetic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    llvm.return %5 : i32
  }]

def compute_min_pessimization_before := [llvmfunc|
  llvm.func @compute_min_pessimization(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @fake_use(%2) : (i32) -> ()
    %3 = llvm.sub %1, %arg1  : i32
    %4 = llvm.icmp "sgt" %2, %3 : i32
    %5 = llvm.select %4, %2, %3 : i1, i32
    %6 = llvm.sub %1, %5  : i32
    llvm.return %6 : i32
  }]

def max_of_nots_before := [llvmfunc|
  llvm.func @max_of_nots(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.icmp "sgt" %arg1, %0 : i32
    %3 = llvm.xor %arg1, %1  : i32
    %4 = llvm.select %2, %3, %1 : i1, i32
    %5 = llvm.xor %arg0, %1  : i32
    %6 = llvm.icmp "slt" %4, %5 : i32
    %7 = llvm.select %6, %5, %4 : i1, i32
    llvm.return %7 : i32
  }]

def abs_of_min_of_not_before := [llvmfunc|
  llvm.func @abs_of_min_of_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.xor %arg0, %0  : i32
    %4 = llvm.add %arg1, %1  : i32
    %5 = llvm.icmp "sge" %4, %3 : i32
    %6 = llvm.select %5, %3, %4 : i1, i32
    %7 = llvm.icmp "sgt" %6, %0 : i32
    %8 = llvm.sub %2, %6  : i32
    %9 = llvm.select %7, %6, %8 : i1, i32
    llvm.return %9 : i32
  }]

def max_of_nots_vec_before := [llvmfunc|
  llvm.func @max_of_nots_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.icmp "sgt" %arg1, %1 : vector<2xi32>
    %4 = llvm.xor %arg1, %2  : vector<2xi32>
    %5 = llvm.select %3, %4, %2 : vector<2xi1>, vector<2xi32>
    %6 = llvm.xor %arg0, %2  : vector<2xi32>
    %7 = llvm.icmp "slt" %5, %6 : vector<2xi32>
    %8 = llvm.select %7, %6, %5 : vector<2xi1>, vector<2xi32>
    llvm.return %8 : vector<2xi32>
  }]

def max_of_nots_weird_type_vec_before := [llvmfunc|
  llvm.func @max_of_nots_weird_type_vec(%arg0: vector<2xi37>, %arg1: vector<2xi37>) -> vector<2xi37> {
    %0 = llvm.mlir.constant(0 : i37) : i37
    %1 = llvm.mlir.constant(dense<0> : vector<2xi37>) : vector<2xi37>
    %2 = llvm.mlir.constant(-1 : i37) : i37
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi37>) : vector<2xi37>
    %4 = llvm.icmp "sgt" %arg1, %1 : vector<2xi37>
    %5 = llvm.xor %arg1, %3  : vector<2xi37>
    %6 = llvm.select %4, %5, %3 : vector<2xi1>, vector<2xi37>
    %7 = llvm.xor %arg0, %3  : vector<2xi37>
    %8 = llvm.icmp "slt" %6, %7 : vector<2xi37>
    %9 = llvm.select %8, %7, %6 : vector<2xi1>, vector<2xi37>
    llvm.return %9 : vector<2xi37>
  }]

def max_of_min_before := [llvmfunc|
  llvm.func @max_of_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }]

def max_of_min_swap_before := [llvmfunc|
  llvm.func @max_of_min_swap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    %5 = llvm.icmp "sgt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }]

def min_of_max_before := [llvmfunc|
  llvm.func @min_of_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "slt" %arg0, %1 : i32
    %4 = llvm.select %3, %2, %0 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }]

def min_of_max_swap_before := [llvmfunc|
  llvm.func @min_of_max_swap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.xor %arg0, %0  : i32
    %3 = llvm.icmp "sgt" %arg0, %1 : i32
    %4 = llvm.select %3, %0, %2 : i1, i32
    %5 = llvm.icmp "slt" %4, %0 : i32
    %6 = llvm.select %5, %4, %0 : i1, i32
    llvm.return %6 : i32
  }]

def max_of_min_vec_before := [llvmfunc|
  llvm.func @max_of_min_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.xor %arg0, %0  : vector<2xi32>
    %4 = llvm.icmp "sgt" %arg0, %2 : vector<2xi32>
    %5 = llvm.select %4, %3, %0 : vector<2xi1>, vector<2xi32>
    %6 = llvm.icmp "sgt" %5, %0 : vector<2xi32>
    %7 = llvm.select %6, %5, %0 : vector<2xi1>, vector<2xi32>
    llvm.return %7 : vector<2xi32>
  }]

def cmyk_before := [llvmfunc|
  llvm.func @cmyk(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "slt" %1, %3 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "slt" %2, %3 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk2_before := [llvmfunc|
  llvm.func @cmyk2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "slt" %arg2, %arg0 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "slt" %arg2, %arg1 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk3_before := [llvmfunc|
  llvm.func @cmyk3(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "slt" %arg2, %arg1 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk4_before := [llvmfunc|
  llvm.func @cmyk4(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "slt" %arg1, %arg0 : i8
    %5 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "sgt" %arg1, %arg2 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk5_before := [llvmfunc|
  llvm.func @cmyk5(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %5 = llvm.icmp "sgt" %arg0, %arg2 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "sgt" %arg1, %arg2 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def cmyk6_before := [llvmfunc|
  llvm.func @cmyk6(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.icmp "ult" %arg1, %arg0 : i8
    %5 = llvm.icmp "ult" %arg2, %arg0 : i8
    %6 = llvm.select %5, %1, %3 : i1, i8
    %7 = llvm.icmp "ult" %arg2, %arg1 : i8
    %8 = llvm.select %7, %2, %3 : i1, i8
    %9 = llvm.select %4, %6, %8 : i1, i8
    %10 = llvm.sub %1, %9  : i8
    %11 = llvm.sub %2, %9  : i8
    %12 = llvm.sub %3, %9  : i8
    llvm.call @use(%10, %11, %12, %9) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

def umin_of_nots_combined := [llvmfunc|
  llvm.func @umin_of_nots(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.umax(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_umin_of_nots   : umin_of_nots_before  ⊑  umin_of_nots_combined := by
  unfold umin_of_nots_before umin_of_nots_combined
  simp_alive_peephole
  sorry
def smin_of_nots_combined := [llvmfunc|
  llvm.func @smin_of_nots(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.intr.smax(%arg0, %arg1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %2 = llvm.xor %1, %0  : vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }]

theorem inst_combine_smin_of_nots   : smin_of_nots_before  ⊑  smin_of_nots_combined := by
  unfold smin_of_nots_before smin_of_nots_combined
  simp_alive_peephole
  sorry
def compute_min_2_combined := [llvmfunc|
  llvm.func @compute_min_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    llvm.return %0 : i32
  }]

theorem inst_combine_compute_min_2   : compute_min_2_before  ⊑  compute_min_2_combined := by
  unfold compute_min_2_before compute_min_2_combined
  simp_alive_peephole
  sorry
def umin_not_1_extra_use_combined := [llvmfunc|
  llvm.func @umin_not_1_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.intr.umax(%arg1, %arg0)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_not_1_extra_use   : umin_not_1_extra_use_before  ⊑  umin_not_1_extra_use_combined := by
  unfold umin_not_1_extra_use_before umin_not_1_extra_use_combined
  simp_alive_peephole
  sorry
def umin_not_2_extra_use_combined := [llvmfunc|
  llvm.func @umin_not_2_extra_use(%arg0: i8, %arg1: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.intr.umin(%1, %2)  : (i8, i8) -> i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.call @extra_use(%2) : (i8) -> ()
    llvm.return %3 : i8
  }]

theorem inst_combine_umin_not_2_extra_use   : umin_not_2_extra_use_before  ⊑  umin_not_2_extra_use_combined := by
  unfold umin_not_2_extra_use_before umin_not_2_extra_use_combined
  simp_alive_peephole
  sorry
def umin3_not_combined := [llvmfunc|
  llvm.func @umin3_not(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.umax(%arg1, %arg0)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%1, %arg2)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    llvm.return %3 : i8
  }]

theorem inst_combine_umin3_not   : umin3_not_before  ⊑  umin3_not_combined := by
  unfold umin3_not_before umin3_not_combined
  simp_alive_peephole
  sorry
def umin3_not_more_uses_combined := [llvmfunc|
  llvm.func @umin3_not_more_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %4 = llvm.intr.umax(%arg2, %3)  : (i8, i8) -> i8
    %5 = llvm.xor %4, %0  : i8
    llvm.call @extra_use(%1) : (i8) -> ()
    llvm.call @extra_use(%2) : (i8) -> ()
    llvm.return %5 : i8
  }]

theorem inst_combine_umin3_not_more_uses   : umin3_not_more_uses_before  ⊑  umin3_not_more_uses_combined := by
  unfold umin3_not_more_uses_before umin3_not_more_uses_combined
  simp_alive_peephole
  sorry
def umin3_not_all_ops_extra_uses_combined := [llvmfunc|
  llvm.func @umin3_not_all_ops_extra_uses(%arg0: i8, %arg1: i8, %arg2: i8) -> i8 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.xor %arg0, %0  : i8
    %2 = llvm.xor %arg1, %0  : i8
    %3 = llvm.xor %arg2, %0  : i8
    %4 = llvm.intr.umin(%1, %3)  : (i8, i8) -> i8
    %5 = llvm.intr.umin(%4, %2)  : (i8, i8) -> i8
    llvm.call @use8(%1) : (i8) -> ()
    llvm.call @use8(%2) : (i8) -> ()
    llvm.call @use8(%3) : (i8) -> ()
    llvm.return %5 : i8
  }]

theorem inst_combine_umin3_not_all_ops_extra_uses   : umin3_not_all_ops_extra_uses_before  ⊑  umin3_not_all_ops_extra_uses_combined := by
  unfold umin3_not_all_ops_extra_uses_before umin3_not_all_ops_extra_uses_combined
  simp_alive_peephole
  sorry
def compute_min_3_combined := [llvmfunc|
  llvm.func @compute_min_3(%arg0: i32, %arg1: i32, %arg2: i32) -> i32 {
    %0 = llvm.intr.smin(%arg0, %arg1)  : (i32, i32) -> i32
    %1 = llvm.intr.smin(%0, %arg2)  : (i32, i32) -> i32
    llvm.return %1 : i32
  }]

theorem inst_combine_compute_min_3   : compute_min_3_before  ⊑  compute_min_3_combined := by
  unfold compute_min_3_before compute_min_3_combined
  simp_alive_peephole
  sorry
def compute_min_arithmetic_combined := [llvmfunc|
  llvm.func @compute_min_arithmetic(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-4 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.add %arg0, %0  : i32
    %3 = llvm.intr.smin(%arg1, %2)  : (i32, i32) -> i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_compute_min_arithmetic   : compute_min_arithmetic_before  ⊑  compute_min_arithmetic_combined := by
  unfold compute_min_arithmetic_before compute_min_arithmetic_combined
  simp_alive_peephole
  sorry
def compute_min_pessimization_combined := [llvmfunc|
  llvm.func @compute_min_pessimization(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(-4 : i32) : i32
    %2 = llvm.sub %0, %arg0  : i32
    llvm.call @fake_use(%2) : (i32) -> ()
    %3 = llvm.add %arg0, %1  : i32
    %4 = llvm.intr.smin(%arg1, %3)  : (i32, i32) -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_compute_min_pessimization   : compute_min_pessimization_before  ⊑  compute_min_pessimization_combined := by
  unfold compute_min_pessimization_before compute_min_pessimization_combined
  simp_alive_peephole
  sorry
def max_of_nots_combined := [llvmfunc|
  llvm.func @max_of_nots(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.intr.smax(%arg1, %0)  : (i32, i32) -> i32
    %3 = llvm.intr.smin(%2, %arg0)  : (i32, i32) -> i32
    %4 = llvm.xor %3, %1  : i32
    llvm.return %4 : i32
  }]

theorem inst_combine_max_of_nots   : max_of_nots_before  ⊑  max_of_nots_combined := by
  unfold max_of_nots_before max_of_nots_combined
  simp_alive_peephole
  sorry
def abs_of_min_of_not_combined := [llvmfunc|
  llvm.func @abs_of_min_of_not(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(-3 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.sub %0, %arg1  : i32
    %3 = llvm.intr.smax(%arg0, %2)  : (i32, i32) -> i32
    %4 = llvm.xor %3, %1  : i32
    %5 = "llvm.intr.abs"(%4) <{is_int_min_poison = false}> : (i32) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_abs_of_min_of_not   : abs_of_min_of_not_before  ⊑  abs_of_min_of_not_combined := by
  unfold abs_of_min_of_not_before abs_of_min_of_not_combined
  simp_alive_peephole
  sorry
def max_of_nots_vec_combined := [llvmfunc|
  llvm.func @max_of_nots_vec(%arg0: vector<2xi32>, %arg1: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<2xi32>) : vector<2xi32>
    %2 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    %3 = llvm.intr.smax(%arg1, %1)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %4 = llvm.intr.smin(%3, %arg0)  : (vector<2xi32>, vector<2xi32>) -> vector<2xi32>
    %5 = llvm.xor %4, %2  : vector<2xi32>
    llvm.return %5 : vector<2xi32>
  }]

theorem inst_combine_max_of_nots_vec   : max_of_nots_vec_before  ⊑  max_of_nots_vec_combined := by
  unfold max_of_nots_vec_before max_of_nots_vec_combined
  simp_alive_peephole
  sorry
def max_of_nots_weird_type_vec_combined := [llvmfunc|
  llvm.func @max_of_nots_weird_type_vec(%arg0: vector<2xi37>, %arg1: vector<2xi37>) -> vector<2xi37> {
    %0 = llvm.mlir.constant(0 : i37) : i37
    %1 = llvm.mlir.constant(dense<0> : vector<2xi37>) : vector<2xi37>
    %2 = llvm.mlir.constant(-1 : i37) : i37
    %3 = llvm.mlir.constant(dense<-1> : vector<2xi37>) : vector<2xi37>
    %4 = llvm.intr.smax(%arg1, %1)  : (vector<2xi37>, vector<2xi37>) -> vector<2xi37>
    %5 = llvm.intr.smin(%4, %arg0)  : (vector<2xi37>, vector<2xi37>) -> vector<2xi37>
    %6 = llvm.xor %5, %3  : vector<2xi37>
    llvm.return %6 : vector<2xi37>
  }]

theorem inst_combine_max_of_nots_weird_type_vec   : max_of_nots_weird_type_vec_before  ⊑  max_of_nots_weird_type_vec_combined := by
  unfold max_of_nots_weird_type_vec_before max_of_nots_weird_type_vec_combined
  simp_alive_peephole
  sorry
def max_of_min_combined := [llvmfunc|
  llvm.func @max_of_min(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_max_of_min   : max_of_min_before  ⊑  max_of_min_combined := by
  unfold max_of_min_before max_of_min_combined
  simp_alive_peephole
  sorry
def max_of_min_swap_combined := [llvmfunc|
  llvm.func @max_of_min_swap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_max_of_min_swap   : max_of_min_swap_before  ⊑  max_of_min_swap_combined := by
  unfold max_of_min_swap_before max_of_min_swap_combined
  simp_alive_peephole
  sorry
def min_of_max_combined := [llvmfunc|
  llvm.func @min_of_max(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_min_of_max   : min_of_max_before  ⊑  min_of_max_combined := by
  unfold min_of_max_before min_of_max_combined
  simp_alive_peephole
  sorry
def min_of_max_swap_combined := [llvmfunc|
  llvm.func @min_of_max_swap(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_min_of_max_swap   : min_of_max_swap_before  ⊑  min_of_max_swap_combined := by
  unfold min_of_max_swap_before min_of_max_swap_combined
  simp_alive_peephole
  sorry
def max_of_min_vec_combined := [llvmfunc|
  llvm.func @max_of_min_vec(%arg0: vector<2xi32>) -> vector<2xi32> {
    %0 = llvm.mlir.constant(dense<-1> : vector<2xi32>) : vector<2xi32>
    llvm.return %0 : vector<2xi32>
  }]

theorem inst_combine_max_of_min_vec   : max_of_min_vec_before  ⊑  max_of_min_vec_combined := by
  unfold max_of_min_vec_before max_of_min_vec_combined
  simp_alive_peephole
  sorry
def cmyk_combined := [llvmfunc|
  llvm.func @cmyk(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk   : cmyk_before  ⊑  cmyk_combined := by
  unfold cmyk_before cmyk_combined
  simp_alive_peephole
  sorry
def cmyk2_combined := [llvmfunc|
  llvm.func @cmyk2(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk2   : cmyk2_before  ⊑  cmyk2_combined := by
  unfold cmyk2_before cmyk2_combined
  simp_alive_peephole
  sorry
def cmyk3_combined := [llvmfunc|
  llvm.func @cmyk3(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk3   : cmyk3_before  ⊑  cmyk3_combined := by
  unfold cmyk3_before cmyk3_combined
  simp_alive_peephole
  sorry
def cmyk4_combined := [llvmfunc|
  llvm.func @cmyk4(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk4   : cmyk4_before  ⊑  cmyk4_combined := by
  unfold cmyk4_before cmyk4_combined
  simp_alive_peephole
  sorry
def cmyk5_combined := [llvmfunc|
  llvm.func @cmyk5(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.smax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.smax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk5   : cmyk5_before  ⊑  cmyk5_combined := by
  unfold cmyk5_before cmyk5_combined
  simp_alive_peephole
  sorry
def cmyk6_combined := [llvmfunc|
  llvm.func @cmyk6(%arg0: i8, %arg1: i8, %arg2: i8) {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.intr.umax(%arg0, %arg1)  : (i8, i8) -> i8
    %2 = llvm.intr.umax(%arg2, %1)  : (i8, i8) -> i8
    %3 = llvm.xor %2, %0  : i8
    %4 = llvm.sub %2, %arg0  : i8
    %5 = llvm.sub %2, %arg1  : i8
    %6 = llvm.sub %2, %arg2  : i8
    llvm.call @use(%4, %5, %6, %3) : (i8, i8, i8, i8) -> ()
    llvm.return
  }]

theorem inst_combine_cmyk6   : cmyk6_before  ⊑  cmyk6_combined := by
  unfold cmyk6_before cmyk6_combined
  simp_alive_peephole
  sorry
