import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-or-icmp-min-max
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def slt_and_max_before := [llvmfunc|
  llvm.func @slt_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_and_max_logical_before := [llvmfunc|
  llvm.func @slt_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def slt_and_max_commute_before := [llvmfunc|
  llvm.func @slt_and_max_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<127> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "slt" %arg0, %arg1 : vector<2xi8>
    %2 = llvm.icmp "eq" %arg0, %0 : vector<2xi8>
    %3 = llvm.and %2, %1  : vector<2xi1>
    llvm.return %3 : vector<2xi1>
  }]

def slt_swap_and_max_before := [llvmfunc|
  llvm.func @slt_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_swap_and_max_logical_before := [llvmfunc|
  llvm.func @slt_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def slt_swap_and_max_commute_before := [llvmfunc|
  llvm.func @slt_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def slt_swap_and_max_commute_logical_before := [llvmfunc|
  llvm.func @slt_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_and_max_before := [llvmfunc|
  llvm.func @ult_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ult_and_max_logical_before := [llvmfunc|
  llvm.func @ult_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_and_max_commute_before := [llvmfunc|
  llvm.func @ult_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ult_and_max_commute_logical_before := [llvmfunc|
  llvm.func @ult_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_swap_and_max_before := [llvmfunc|
  llvm.func @ult_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ult_swap_and_max_logical_before := [llvmfunc|
  llvm.func @ult_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_swap_and_max_commute_before := [llvmfunc|
  llvm.func @ult_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ult_swap_and_max_commute_logical_before := [llvmfunc|
  llvm.func @ult_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_and_min_before := [llvmfunc|
  llvm.func @sgt_and_min(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(-256 : i9) : i9
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i9
    %2 = llvm.icmp "eq" %arg0, %0 : i9
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_and_min_logical_before := [llvmfunc|
  llvm.func @sgt_and_min_logical(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(-256 : i9) : i9
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i9
    %3 = llvm.icmp "eq" %arg0, %0 : i9
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_and_min_commute_before := [llvmfunc|
  llvm.func @sgt_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sgt_and_min_commute_logical_before := [llvmfunc|
  llvm.func @sgt_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_swap_and_min_before := [llvmfunc|
  llvm.func @sgt_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_swap_and_min_logical_before := [llvmfunc|
  llvm.func @sgt_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_swap_and_min_commute_before := [llvmfunc|
  llvm.func @sgt_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sgt_swap_and_min_commute_logical_before := [llvmfunc|
  llvm.func @sgt_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_min_before := [llvmfunc|
  llvm.func @ugt_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_and_min_logical_before := [llvmfunc|
  llvm.func @ugt_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_min_commute_before := [llvmfunc|
  llvm.func @ugt_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_min_before := [llvmfunc|
  llvm.func @ugt_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_min_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_min_commute_before := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sge_or_not_max_before := [llvmfunc|
  llvm.func @sge_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sge_or_not_max_logical_before := [llvmfunc|
  llvm.func @sge_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sge_or_not_max_commute_before := [llvmfunc|
  llvm.func @sge_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sge_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @sge_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sge_swap_or_not_max_before := [llvmfunc|
  llvm.func @sge_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sge_swap_or_not_max_logical_before := [llvmfunc|
  llvm.func @sge_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sge_swap_or_not_max_commute_before := [llvmfunc|
  llvm.func @sge_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sge_swap_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @sge_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def uge_or_not_max_before := [llvmfunc|
  llvm.func @uge_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def uge_or_not_max_logical_before := [llvmfunc|
  llvm.func @uge_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def uge_or_not_max_commute_before := [llvmfunc|
  llvm.func @uge_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def uge_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @uge_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def uge_swap_or_not_max_before := [llvmfunc|
  llvm.func @uge_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def uge_swap_or_not_max_logical_before := [llvmfunc|
  llvm.func @uge_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def uge_swap_or_not_max_commute_before := [llvmfunc|
  llvm.func @uge_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def uge_swap_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @uge_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sle_or_not_min_before := [llvmfunc|
  llvm.func @sle_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_or_not_min_logical_before := [llvmfunc|
  llvm.func @sle_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sle_or_not_min_commute_before := [llvmfunc|
  llvm.func @sle_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sle_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @sle_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sle_swap_or_not_min_before := [llvmfunc|
  llvm.func @sle_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_swap_or_not_min_logical_before := [llvmfunc|
  llvm.func @sle_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sle_swap_or_not_min_commute_before := [llvmfunc|
  llvm.func @sle_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sle_swap_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @sle_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_not_min_before := [llvmfunc|
  llvm.func @ule_or_not_min(%arg0: i427, %arg1: i427) -> i1 {
    %0 = llvm.mlir.constant(0 : i427) : i427
    %1 = llvm.icmp "ule" %arg0, %arg1 : i427
    %2 = llvm.icmp "ne" %arg0, %0 : i427
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_or_not_min_logical_before := [llvmfunc|
  llvm.func @ule_or_not_min_logical(%arg0: i427, %arg1: i427) -> i1 {
    %0 = llvm.mlir.constant(0 : i427) : i427
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i427
    %3 = llvm.icmp "ne" %arg0, %0 : i427
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_not_min_commute_before := [llvmfunc|
  llvm.func @ule_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_not_min_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_not_min_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_not_min_commute_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sge_and_max_before := [llvmfunc|
  llvm.func @sge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sge_and_max_logical_before := [llvmfunc|
  llvm.func @sge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sge_and_max_commute_before := [llvmfunc|
  llvm.func @sge_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sge_and_max_commute_logical_before := [llvmfunc|
  llvm.func @sge_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sge_swap_and_max_before := [llvmfunc|
  llvm.func @sge_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sge_swap_and_max_logical_before := [llvmfunc|
  llvm.func @sge_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sge_swap_and_max_commute_before := [llvmfunc|
  llvm.func @sge_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sge_swap_and_max_commute_logical_before := [llvmfunc|
  llvm.func @sge_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def uge_and_max_before := [llvmfunc|
  llvm.func @uge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def uge_and_max_logical_before := [llvmfunc|
  llvm.func @uge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def uge_and_max_commute_before := [llvmfunc|
  llvm.func @uge_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def uge_and_max_commute_logical_before := [llvmfunc|
  llvm.func @uge_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def uge_swap_and_max_before := [llvmfunc|
  llvm.func @uge_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def uge_swap_and_max_logical_before := [llvmfunc|
  llvm.func @uge_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def uge_swap_and_max_commute_before := [llvmfunc|
  llvm.func @uge_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def uge_swap_and_max_commute_logical_before := [llvmfunc|
  llvm.func @uge_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sle_and_min_before := [llvmfunc|
  llvm.func @sle_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_and_min_logical_before := [llvmfunc|
  llvm.func @sle_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sle_and_min_commute_before := [llvmfunc|
  llvm.func @sle_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sle_and_min_commute_logical_before := [llvmfunc|
  llvm.func @sle_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sle_swap_and_min_before := [llvmfunc|
  llvm.func @sle_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_swap_and_min_logical_before := [llvmfunc|
  llvm.func @sle_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sle_swap_and_min_commute_before := [llvmfunc|
  llvm.func @sle_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sle_swap_and_min_commute_logical_before := [llvmfunc|
  llvm.func @sle_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_and_min_before := [llvmfunc|
  llvm.func @ule_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_and_min_logical_before := [llvmfunc|
  llvm.func @ule_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_and_min_commute_before := [llvmfunc|
  llvm.func @ule_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_and_min_before := [llvmfunc|
  llvm.func @ule_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_swap_and_min_logical_before := [llvmfunc|
  llvm.func @ule_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_and_min_commute_before := [llvmfunc|
  llvm.func @ule_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_swap_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sge_or_max_before := [llvmfunc|
  llvm.func @sge_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sge_or_max_logical_before := [llvmfunc|
  llvm.func @sge_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sge_or_max_commute_before := [llvmfunc|
  llvm.func @sge_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sge_or_max_commute_logical_before := [llvmfunc|
  llvm.func @sge_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sge_swap_or_max_before := [llvmfunc|
  llvm.func @sge_swap_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sge_swap_or_max_logical_before := [llvmfunc|
  llvm.func @sge_swap_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sge_swap_or_max_commute_before := [llvmfunc|
  llvm.func @sge_swap_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sle" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sge_swap_or_max_commute_logical_before := [llvmfunc|
  llvm.func @sge_swap_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def uge_or_max_before := [llvmfunc|
  llvm.func @uge_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def uge_or_max_logical_before := [llvmfunc|
  llvm.func @uge_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def uge_or_max_commute_before := [llvmfunc|
  llvm.func @uge_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "uge" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def uge_or_max_commute_logical_before := [llvmfunc|
  llvm.func @uge_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def uge_swap_or_max_before := [llvmfunc|
  llvm.func @uge_swap_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def uge_swap_or_max_logical_before := [llvmfunc|
  llvm.func @uge_swap_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def uge_swap_or_max_commute_before := [llvmfunc|
  llvm.func @uge_swap_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ule" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def uge_swap_or_max_commute_logical_before := [llvmfunc|
  llvm.func @uge_swap_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sle_or_min_before := [llvmfunc|
  llvm.func @sle_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_or_min_logical_before := [llvmfunc|
  llvm.func @sle_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sle_or_min_commute_before := [llvmfunc|
  llvm.func @sle_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sle" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sle_or_min_commute_logical_before := [llvmfunc|
  llvm.func @sle_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sle_swap_or_min_before := [llvmfunc|
  llvm.func @sle_swap_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_swap_or_min_logical_before := [llvmfunc|
  llvm.func @sle_swap_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sle_swap_or_min_commute_before := [llvmfunc|
  llvm.func @sle_swap_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sle_swap_or_min_commute_logical_before := [llvmfunc|
  llvm.func @sle_swap_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_min_before := [llvmfunc|
  llvm.func @ule_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_or_min_logical_before := [llvmfunc|
  llvm.func @ule_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_min_commute_before := [llvmfunc|
  llvm.func @ule_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ule" %arg0, %arg1 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_or_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_min_before := [llvmfunc|
  llvm.func @ule_swap_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_min_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_min_commute_before := [llvmfunc|
  llvm.func @ule_swap_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "uge" %arg1, %arg0 : i8
    %2 = llvm.icmp "eq" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def slt_and_not_max_before := [llvmfunc|
  llvm.func @slt_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_and_not_max_logical_before := [llvmfunc|
  llvm.func @slt_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def slt_and_not_max_commute_before := [llvmfunc|
  llvm.func @slt_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def slt_and_not_max_commute_logical_before := [llvmfunc|
  llvm.func @slt_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def slt_swap_and_not_max_before := [llvmfunc|
  llvm.func @slt_swap_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_swap_and_not_max_logical_before := [llvmfunc|
  llvm.func @slt_swap_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def slt_swap_and_not_max_commute_before := [llvmfunc|
  llvm.func @slt_swap_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def slt_swap_and_not_max_commute_logical_before := [llvmfunc|
  llvm.func @slt_swap_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_and_not_max_before := [llvmfunc|
  llvm.func @ult_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ult_and_not_max_logical_before := [llvmfunc|
  llvm.func @ult_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_and_not_max_commute_before := [llvmfunc|
  llvm.func @ult_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ult_and_not_max_commute_logical_before := [llvmfunc|
  llvm.func @ult_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_swap_and_not_max_before := [llvmfunc|
  llvm.func @ult_swap_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ult_swap_and_not_max_logical_before := [llvmfunc|
  llvm.func @ult_swap_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ult_swap_and_not_max_commute_before := [llvmfunc|
  llvm.func @ult_swap_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ult_swap_and_not_max_commute_logical_before := [llvmfunc|
  llvm.func @ult_swap_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_and_not_min_before := [llvmfunc|
  llvm.func @sgt_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_and_not_min_logical_before := [llvmfunc|
  llvm.func @sgt_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_and_not_min_commute_before := [llvmfunc|
  llvm.func @sgt_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sgt_and_not_min_commute_logical_before := [llvmfunc|
  llvm.func @sgt_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_swap_and_not_min_before := [llvmfunc|
  llvm.func @sgt_swap_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_swap_and_not_min_logical_before := [llvmfunc|
  llvm.func @sgt_swap_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_swap_and_not_min_commute_before := [llvmfunc|
  llvm.func @sgt_swap_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def sgt_swap_and_not_min_commute_logical_before := [llvmfunc|
  llvm.func @sgt_swap_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_not_min_before := [llvmfunc|
  llvm.func @ugt_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_and_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_and_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_not_min_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def slt_or_not_max_before := [llvmfunc|
  llvm.func @slt_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_or_not_max_logical_before := [llvmfunc|
  llvm.func @slt_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def slt_or_not_max_commute_before := [llvmfunc|
  llvm.func @slt_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "slt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def slt_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @slt_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def slt_swap_or_not_max_before := [llvmfunc|
  llvm.func @slt_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_swap_or_not_max_logical_before := [llvmfunc|
  llvm.func @slt_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def slt_swap_or_not_max_commute_before := [llvmfunc|
  llvm.func @slt_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def slt_swap_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @slt_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ult_or_not_max_before := [llvmfunc|
  llvm.func @ult_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ult_or_not_max_logical_before := [llvmfunc|
  llvm.func @ult_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ult_or_not_max_commute_before := [llvmfunc|
  llvm.func @ult_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ult" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ult_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @ult_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ult_swap_or_not_max_before := [llvmfunc|
  llvm.func @ult_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ult_swap_or_not_max_logical_before := [llvmfunc|
  llvm.func @ult_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ult_swap_or_not_max_commute_before := [llvmfunc|
  llvm.func @ult_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ult_swap_or_not_max_commute_logical_before := [llvmfunc|
  llvm.func @ult_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_or_not_min_before := [llvmfunc|
  llvm.func @sgt_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_or_not_min_logical_before := [llvmfunc|
  llvm.func @sgt_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_or_not_min_commute_before := [llvmfunc|
  llvm.func @sgt_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sgt_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @sgt_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_swap_or_not_min_before := [llvmfunc|
  llvm.func @sgt_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_swap_or_not_min_logical_before := [llvmfunc|
  llvm.func @sgt_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_swap_or_not_min_commute_before := [llvmfunc|
  llvm.func @sgt_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "slt" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def sgt_swap_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @sgt_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_or_not_min_before := [llvmfunc|
  llvm.func @ugt_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_or_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_or_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_or_not_min_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ult" %arg1, %arg0 : i8
    %2 = llvm.icmp "ne" %arg0, %0 : i8
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_or_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_or_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute(%arg0: i823, %arg1: i823) -> i1 {
    %0 = llvm.mlir.constant(0 : i823) : i823
    %1 = llvm.icmp "ult" %arg1, %arg0 : i823
    %2 = llvm.icmp "ne" %arg0, %0 : i823
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute_logical(%arg0: i823, %arg1: i823) -> i1 {
    %0 = llvm.mlir.constant(0 : i823) : i823
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i823
    %3 = llvm.icmp "ne" %arg0, %0 : i823
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def slt_and_max_combined := [llvmfunc|
  llvm.func @slt_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_and_max   : slt_and_max_before  ⊑  slt_and_max_combined := by
  unfold slt_and_max_before slt_and_max_combined
  simp_alive_peephole
  sorry
def slt_and_max_logical_combined := [llvmfunc|
  llvm.func @slt_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_and_max_logical   : slt_and_max_logical_before  ⊑  slt_and_max_logical_combined := by
  unfold slt_and_max_logical_before slt_and_max_logical_combined
  simp_alive_peephole
  sorry
def slt_and_max_commute_combined := [llvmfunc|
  llvm.func @slt_and_max_commute(%arg0: vector<2xi8>, %arg1: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(dense<false> : vector<2xi1>) : vector<2xi1>
    llvm.return %1 : vector<2xi1>
  }]

theorem inst_combine_slt_and_max_commute   : slt_and_max_commute_before  ⊑  slt_and_max_commute_combined := by
  unfold slt_and_max_commute_before slt_and_max_commute_combined
  simp_alive_peephole
  sorry
def slt_swap_and_max_combined := [llvmfunc|
  llvm.func @slt_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_swap_and_max   : slt_swap_and_max_before  ⊑  slt_swap_and_max_combined := by
  unfold slt_swap_and_max_before slt_swap_and_max_combined
  simp_alive_peephole
  sorry
def slt_swap_and_max_logical_combined := [llvmfunc|
  llvm.func @slt_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_swap_and_max_logical   : slt_swap_and_max_logical_before  ⊑  slt_swap_and_max_logical_combined := by
  unfold slt_swap_and_max_logical_before slt_swap_and_max_logical_combined
  simp_alive_peephole
  sorry
def slt_swap_and_max_commute_combined := [llvmfunc|
  llvm.func @slt_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_swap_and_max_commute   : slt_swap_and_max_commute_before  ⊑  slt_swap_and_max_commute_combined := by
  unfold slt_swap_and_max_commute_before slt_swap_and_max_commute_combined
  simp_alive_peephole
  sorry
def slt_swap_and_max_commute_logical_combined := [llvmfunc|
  llvm.func @slt_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_swap_and_max_commute_logical   : slt_swap_and_max_commute_logical_before  ⊑  slt_swap_and_max_commute_logical_combined := by
  unfold slt_swap_and_max_commute_logical_before slt_swap_and_max_commute_logical_combined
  simp_alive_peephole
  sorry
def ult_and_max_combined := [llvmfunc|
  llvm.func @ult_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_and_max   : ult_and_max_before  ⊑  ult_and_max_combined := by
  unfold ult_and_max_before ult_and_max_combined
  simp_alive_peephole
  sorry
def ult_and_max_logical_combined := [llvmfunc|
  llvm.func @ult_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_and_max_logical   : ult_and_max_logical_before  ⊑  ult_and_max_logical_combined := by
  unfold ult_and_max_logical_before ult_and_max_logical_combined
  simp_alive_peephole
  sorry
def ult_and_max_commute_combined := [llvmfunc|
  llvm.func @ult_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_and_max_commute   : ult_and_max_commute_before  ⊑  ult_and_max_commute_combined := by
  unfold ult_and_max_commute_before ult_and_max_commute_combined
  simp_alive_peephole
  sorry
def ult_and_max_commute_logical_combined := [llvmfunc|
  llvm.func @ult_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_and_max_commute_logical   : ult_and_max_commute_logical_before  ⊑  ult_and_max_commute_logical_combined := by
  unfold ult_and_max_commute_logical_before ult_and_max_commute_logical_combined
  simp_alive_peephole
  sorry
def ult_swap_and_max_combined := [llvmfunc|
  llvm.func @ult_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_swap_and_max   : ult_swap_and_max_before  ⊑  ult_swap_and_max_combined := by
  unfold ult_swap_and_max_before ult_swap_and_max_combined
  simp_alive_peephole
  sorry
def ult_swap_and_max_logical_combined := [llvmfunc|
  llvm.func @ult_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_swap_and_max_logical   : ult_swap_and_max_logical_before  ⊑  ult_swap_and_max_logical_combined := by
  unfold ult_swap_and_max_logical_before ult_swap_and_max_logical_combined
  simp_alive_peephole
  sorry
def ult_swap_and_max_commute_combined := [llvmfunc|
  llvm.func @ult_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_swap_and_max_commute   : ult_swap_and_max_commute_before  ⊑  ult_swap_and_max_commute_combined := by
  unfold ult_swap_and_max_commute_before ult_swap_and_max_commute_combined
  simp_alive_peephole
  sorry
def ult_swap_and_max_commute_logical_combined := [llvmfunc|
  llvm.func @ult_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_swap_and_max_commute_logical   : ult_swap_and_max_commute_logical_before  ⊑  ult_swap_and_max_commute_logical_combined := by
  unfold ult_swap_and_max_commute_logical_before ult_swap_and_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sgt_and_min_combined := [llvmfunc|
  llvm.func @sgt_and_min(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_and_min   : sgt_and_min_before  ⊑  sgt_and_min_combined := by
  unfold sgt_and_min_before sgt_and_min_combined
  simp_alive_peephole
  sorry
def sgt_and_min_logical_combined := [llvmfunc|
  llvm.func @sgt_and_min_logical(%arg0: i9, %arg1: i9) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_and_min_logical   : sgt_and_min_logical_before  ⊑  sgt_and_min_logical_combined := by
  unfold sgt_and_min_logical_before sgt_and_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_and_min_commute_combined := [llvmfunc|
  llvm.func @sgt_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_and_min_commute   : sgt_and_min_commute_before  ⊑  sgt_and_min_commute_combined := by
  unfold sgt_and_min_commute_before sgt_and_min_commute_combined
  simp_alive_peephole
  sorry
def sgt_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @sgt_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_and_min_commute_logical   : sgt_and_min_commute_logical_before  ⊑  sgt_and_min_commute_logical_combined := by
  unfold sgt_and_min_commute_logical_before sgt_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_min_combined := [llvmfunc|
  llvm.func @sgt_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_swap_and_min   : sgt_swap_and_min_before  ⊑  sgt_swap_and_min_combined := by
  unfold sgt_swap_and_min_before sgt_swap_and_min_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_min_logical_combined := [llvmfunc|
  llvm.func @sgt_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_swap_and_min_logical   : sgt_swap_and_min_logical_before  ⊑  sgt_swap_and_min_logical_combined := by
  unfold sgt_swap_and_min_logical_before sgt_swap_and_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_min_commute_combined := [llvmfunc|
  llvm.func @sgt_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_swap_and_min_commute   : sgt_swap_and_min_commute_before  ⊑  sgt_swap_and_min_commute_combined := by
  unfold sgt_swap_and_min_commute_before sgt_swap_and_min_commute_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @sgt_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_swap_and_min_commute_logical   : sgt_swap_and_min_commute_logical_before  ⊑  sgt_swap_and_min_commute_logical_combined := by
  unfold sgt_swap_and_min_commute_logical_before sgt_swap_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_and_min_combined := [llvmfunc|
  llvm.func @ugt_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min   : ugt_and_min_before  ⊑  ugt_and_min_combined := by
  unfold ugt_and_min_before ugt_and_min_combined
  simp_alive_peephole
  sorry
def ugt_and_min_logical_combined := [llvmfunc|
  llvm.func @ugt_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min_logical   : ugt_and_min_logical_before  ⊑  ugt_and_min_logical_combined := by
  unfold ugt_and_min_logical_before ugt_and_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_and_min_commute_combined := [llvmfunc|
  llvm.func @ugt_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min_commute   : ugt_and_min_commute_before  ⊑  ugt_and_min_commute_combined := by
  unfold ugt_and_min_commute_before ugt_and_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min_commute_logical   : ugt_and_min_commute_logical_before  ⊑  ugt_and_min_commute_logical_combined := by
  unfold ugt_and_min_commute_logical_before ugt_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min   : ugt_swap_and_min_before  ⊑  ugt_swap_and_min_combined := by
  unfold ugt_swap_and_min_before ugt_swap_and_min_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min_logical   : ugt_swap_and_min_logical_before  ⊑  ugt_swap_and_min_logical_combined := by
  unfold ugt_swap_and_min_logical_before ugt_swap_and_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_commute_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min_commute   : ugt_swap_and_min_commute_before  ⊑  ugt_swap_and_min_commute_combined := by
  unfold ugt_swap_and_min_commute_before ugt_swap_and_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min_commute_logical   : ugt_swap_and_min_commute_logical_before  ⊑  ugt_swap_and_min_commute_logical_combined := by
  unfold ugt_swap_and_min_commute_logical_before ugt_swap_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sge_or_not_max_combined := [llvmfunc|
  llvm.func @sge_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_or_not_max   : sge_or_not_max_before  ⊑  sge_or_not_max_combined := by
  unfold sge_or_not_max_before sge_or_not_max_combined
  simp_alive_peephole
  sorry
def sge_or_not_max_logical_combined := [llvmfunc|
  llvm.func @sge_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_or_not_max_logical   : sge_or_not_max_logical_before  ⊑  sge_or_not_max_logical_combined := by
  unfold sge_or_not_max_logical_before sge_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def sge_or_not_max_commute_combined := [llvmfunc|
  llvm.func @sge_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_or_not_max_commute   : sge_or_not_max_commute_before  ⊑  sge_or_not_max_commute_combined := by
  unfold sge_or_not_max_commute_before sge_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def sge_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @sge_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_or_not_max_commute_logical   : sge_or_not_max_commute_logical_before  ⊑  sge_or_not_max_commute_logical_combined := by
  unfold sge_or_not_max_commute_logical_before sge_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sge_swap_or_not_max_combined := [llvmfunc|
  llvm.func @sge_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_swap_or_not_max   : sge_swap_or_not_max_before  ⊑  sge_swap_or_not_max_combined := by
  unfold sge_swap_or_not_max_before sge_swap_or_not_max_combined
  simp_alive_peephole
  sorry
def sge_swap_or_not_max_logical_combined := [llvmfunc|
  llvm.func @sge_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_swap_or_not_max_logical   : sge_swap_or_not_max_logical_before  ⊑  sge_swap_or_not_max_logical_combined := by
  unfold sge_swap_or_not_max_logical_before sge_swap_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def sge_swap_or_not_max_commute_combined := [llvmfunc|
  llvm.func @sge_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_swap_or_not_max_commute   : sge_swap_or_not_max_commute_before  ⊑  sge_swap_or_not_max_commute_combined := by
  unfold sge_swap_or_not_max_commute_before sge_swap_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def sge_swap_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @sge_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_swap_or_not_max_commute_logical   : sge_swap_or_not_max_commute_logical_before  ⊑  sge_swap_or_not_max_commute_logical_combined := by
  unfold sge_swap_or_not_max_commute_logical_before sge_swap_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def uge_or_not_max_combined := [llvmfunc|
  llvm.func @uge_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_or_not_max   : uge_or_not_max_before  ⊑  uge_or_not_max_combined := by
  unfold uge_or_not_max_before uge_or_not_max_combined
  simp_alive_peephole
  sorry
def uge_or_not_max_logical_combined := [llvmfunc|
  llvm.func @uge_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_or_not_max_logical   : uge_or_not_max_logical_before  ⊑  uge_or_not_max_logical_combined := by
  unfold uge_or_not_max_logical_before uge_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def uge_or_not_max_commute_combined := [llvmfunc|
  llvm.func @uge_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_or_not_max_commute   : uge_or_not_max_commute_before  ⊑  uge_or_not_max_commute_combined := by
  unfold uge_or_not_max_commute_before uge_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def uge_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @uge_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_or_not_max_commute_logical   : uge_or_not_max_commute_logical_before  ⊑  uge_or_not_max_commute_logical_combined := by
  unfold uge_or_not_max_commute_logical_before uge_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def uge_swap_or_not_max_combined := [llvmfunc|
  llvm.func @uge_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_swap_or_not_max   : uge_swap_or_not_max_before  ⊑  uge_swap_or_not_max_combined := by
  unfold uge_swap_or_not_max_before uge_swap_or_not_max_combined
  simp_alive_peephole
  sorry
def uge_swap_or_not_max_logical_combined := [llvmfunc|
  llvm.func @uge_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_swap_or_not_max_logical   : uge_swap_or_not_max_logical_before  ⊑  uge_swap_or_not_max_logical_combined := by
  unfold uge_swap_or_not_max_logical_before uge_swap_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def uge_swap_or_not_max_commute_combined := [llvmfunc|
  llvm.func @uge_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_swap_or_not_max_commute   : uge_swap_or_not_max_commute_before  ⊑  uge_swap_or_not_max_commute_combined := by
  unfold uge_swap_or_not_max_commute_before uge_swap_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def uge_swap_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @uge_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_swap_or_not_max_commute_logical   : uge_swap_or_not_max_commute_logical_before  ⊑  uge_swap_or_not_max_commute_logical_combined := by
  unfold uge_swap_or_not_max_commute_logical_before uge_swap_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sle_or_not_min_combined := [llvmfunc|
  llvm.func @sle_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_or_not_min   : sle_or_not_min_before  ⊑  sle_or_not_min_combined := by
  unfold sle_or_not_min_before sle_or_not_min_combined
  simp_alive_peephole
  sorry
def sle_or_not_min_logical_combined := [llvmfunc|
  llvm.func @sle_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_or_not_min_logical   : sle_or_not_min_logical_before  ⊑  sle_or_not_min_logical_combined := by
  unfold sle_or_not_min_logical_before sle_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def sle_or_not_min_commute_combined := [llvmfunc|
  llvm.func @sle_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_or_not_min_commute   : sle_or_not_min_commute_before  ⊑  sle_or_not_min_commute_combined := by
  unfold sle_or_not_min_commute_before sle_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def sle_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @sle_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_or_not_min_commute_logical   : sle_or_not_min_commute_logical_before  ⊑  sle_or_not_min_commute_logical_combined := by
  unfold sle_or_not_min_commute_logical_before sle_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sle_swap_or_not_min_combined := [llvmfunc|
  llvm.func @sle_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_swap_or_not_min   : sle_swap_or_not_min_before  ⊑  sle_swap_or_not_min_combined := by
  unfold sle_swap_or_not_min_before sle_swap_or_not_min_combined
  simp_alive_peephole
  sorry
def sle_swap_or_not_min_logical_combined := [llvmfunc|
  llvm.func @sle_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_swap_or_not_min_logical   : sle_swap_or_not_min_logical_before  ⊑  sle_swap_or_not_min_logical_combined := by
  unfold sle_swap_or_not_min_logical_before sle_swap_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def sle_swap_or_not_min_commute_combined := [llvmfunc|
  llvm.func @sle_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_swap_or_not_min_commute   : sle_swap_or_not_min_commute_before  ⊑  sle_swap_or_not_min_commute_combined := by
  unfold sle_swap_or_not_min_commute_before sle_swap_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def sle_swap_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @sle_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_swap_or_not_min_commute_logical   : sle_swap_or_not_min_commute_logical_before  ⊑  sle_swap_or_not_min_commute_logical_combined := by
  unfold sle_swap_or_not_min_commute_logical_before sle_swap_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_combined := [llvmfunc|
  llvm.func @ule_or_not_min(%arg0: i427, %arg1: i427) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min   : ule_or_not_min_before  ⊑  ule_or_not_min_combined := by
  unfold ule_or_not_min_before ule_or_not_min_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ule_or_not_min_logical(%arg0: i427, %arg1: i427) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min_logical   : ule_or_not_min_logical_before  ⊑  ule_or_not_min_logical_combined := by
  unfold ule_or_not_min_logical_before ule_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ule_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min_commute   : ule_or_not_min_commute_before  ⊑  ule_or_not_min_commute_combined := by
  unfold ule_or_not_min_commute_before ule_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min_commute_logical   : ule_or_not_min_commute_logical_before  ⊑  ule_or_not_min_commute_logical_combined := by
  unfold ule_or_not_min_commute_logical_before ule_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min   : ule_swap_or_not_min_before  ⊑  ule_swap_or_not_min_combined := by
  unfold ule_swap_or_not_min_before ule_swap_or_not_min_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min_logical   : ule_swap_or_not_min_logical_before  ⊑  ule_swap_or_not_min_logical_combined := by
  unfold ule_swap_or_not_min_logical_before ule_swap_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min_commute   : ule_swap_or_not_min_commute_before  ⊑  ule_swap_or_not_min_commute_combined := by
  unfold ule_swap_or_not_min_commute_before ule_swap_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min_commute_logical   : ule_swap_or_not_min_commute_logical_before  ⊑  ule_swap_or_not_min_commute_logical_combined := by
  unfold ule_swap_or_not_min_commute_logical_before ule_swap_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sge_and_max_combined := [llvmfunc|
  llvm.func @sge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_and_max   : sge_and_max_before  ⊑  sge_and_max_combined := by
  unfold sge_and_max_before sge_and_max_combined
  simp_alive_peephole
  sorry
def sge_and_max_logical_combined := [llvmfunc|
  llvm.func @sge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_and_max_logical   : sge_and_max_logical_before  ⊑  sge_and_max_logical_combined := by
  unfold sge_and_max_logical_before sge_and_max_logical_combined
  simp_alive_peephole
  sorry
def sge_and_max_commute_combined := [llvmfunc|
  llvm.func @sge_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_and_max_commute   : sge_and_max_commute_before  ⊑  sge_and_max_commute_combined := by
  unfold sge_and_max_commute_before sge_and_max_commute_combined
  simp_alive_peephole
  sorry
def sge_and_max_commute_logical_combined := [llvmfunc|
  llvm.func @sge_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_and_max_commute_logical   : sge_and_max_commute_logical_before  ⊑  sge_and_max_commute_logical_combined := by
  unfold sge_and_max_commute_logical_before sge_and_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sge_swap_and_max_combined := [llvmfunc|
  llvm.func @sge_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_swap_and_max   : sge_swap_and_max_before  ⊑  sge_swap_and_max_combined := by
  unfold sge_swap_and_max_before sge_swap_and_max_combined
  simp_alive_peephole
  sorry
def sge_swap_and_max_logical_combined := [llvmfunc|
  llvm.func @sge_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_swap_and_max_logical   : sge_swap_and_max_logical_before  ⊑  sge_swap_and_max_logical_combined := by
  unfold sge_swap_and_max_logical_before sge_swap_and_max_logical_combined
  simp_alive_peephole
  sorry
def sge_swap_and_max_commute_combined := [llvmfunc|
  llvm.func @sge_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_swap_and_max_commute   : sge_swap_and_max_commute_before  ⊑  sge_swap_and_max_commute_combined := by
  unfold sge_swap_and_max_commute_before sge_swap_and_max_commute_combined
  simp_alive_peephole
  sorry
def sge_swap_and_max_commute_logical_combined := [llvmfunc|
  llvm.func @sge_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sge_swap_and_max_commute_logical   : sge_swap_and_max_commute_logical_before  ⊑  sge_swap_and_max_commute_logical_combined := by
  unfold sge_swap_and_max_commute_logical_before sge_swap_and_max_commute_logical_combined
  simp_alive_peephole
  sorry
def uge_and_max_combined := [llvmfunc|
  llvm.func @uge_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_and_max   : uge_and_max_before  ⊑  uge_and_max_combined := by
  unfold uge_and_max_before uge_and_max_combined
  simp_alive_peephole
  sorry
def uge_and_max_logical_combined := [llvmfunc|
  llvm.func @uge_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_and_max_logical   : uge_and_max_logical_before  ⊑  uge_and_max_logical_combined := by
  unfold uge_and_max_logical_before uge_and_max_logical_combined
  simp_alive_peephole
  sorry
def uge_and_max_commute_combined := [llvmfunc|
  llvm.func @uge_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_and_max_commute   : uge_and_max_commute_before  ⊑  uge_and_max_commute_combined := by
  unfold uge_and_max_commute_before uge_and_max_commute_combined
  simp_alive_peephole
  sorry
def uge_and_max_commute_logical_combined := [llvmfunc|
  llvm.func @uge_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_and_max_commute_logical   : uge_and_max_commute_logical_before  ⊑  uge_and_max_commute_logical_combined := by
  unfold uge_and_max_commute_logical_before uge_and_max_commute_logical_combined
  simp_alive_peephole
  sorry
def uge_swap_and_max_combined := [llvmfunc|
  llvm.func @uge_swap_and_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_swap_and_max   : uge_swap_and_max_before  ⊑  uge_swap_and_max_combined := by
  unfold uge_swap_and_max_before uge_swap_and_max_combined
  simp_alive_peephole
  sorry
def uge_swap_and_max_logical_combined := [llvmfunc|
  llvm.func @uge_swap_and_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_swap_and_max_logical   : uge_swap_and_max_logical_before  ⊑  uge_swap_and_max_logical_combined := by
  unfold uge_swap_and_max_logical_before uge_swap_and_max_logical_combined
  simp_alive_peephole
  sorry
def uge_swap_and_max_commute_combined := [llvmfunc|
  llvm.func @uge_swap_and_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_swap_and_max_commute   : uge_swap_and_max_commute_before  ⊑  uge_swap_and_max_commute_combined := by
  unfold uge_swap_and_max_commute_before uge_swap_and_max_commute_combined
  simp_alive_peephole
  sorry
def uge_swap_and_max_commute_logical_combined := [llvmfunc|
  llvm.func @uge_swap_and_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_uge_swap_and_max_commute_logical   : uge_swap_and_max_commute_logical_before  ⊑  uge_swap_and_max_commute_logical_combined := by
  unfold uge_swap_and_max_commute_logical_before uge_swap_and_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sle_and_min_combined := [llvmfunc|
  llvm.func @sle_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_and_min   : sle_and_min_before  ⊑  sle_and_min_combined := by
  unfold sle_and_min_before sle_and_min_combined
  simp_alive_peephole
  sorry
def sle_and_min_logical_combined := [llvmfunc|
  llvm.func @sle_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_and_min_logical   : sle_and_min_logical_before  ⊑  sle_and_min_logical_combined := by
  unfold sle_and_min_logical_before sle_and_min_logical_combined
  simp_alive_peephole
  sorry
def sle_and_min_commute_combined := [llvmfunc|
  llvm.func @sle_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_and_min_commute   : sle_and_min_commute_before  ⊑  sle_and_min_commute_combined := by
  unfold sle_and_min_commute_before sle_and_min_commute_combined
  simp_alive_peephole
  sorry
def sle_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @sle_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_and_min_commute_logical   : sle_and_min_commute_logical_before  ⊑  sle_and_min_commute_logical_combined := by
  unfold sle_and_min_commute_logical_before sle_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sle_swap_and_min_combined := [llvmfunc|
  llvm.func @sle_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_swap_and_min   : sle_swap_and_min_before  ⊑  sle_swap_and_min_combined := by
  unfold sle_swap_and_min_before sle_swap_and_min_combined
  simp_alive_peephole
  sorry
def sle_swap_and_min_logical_combined := [llvmfunc|
  llvm.func @sle_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_swap_and_min_logical   : sle_swap_and_min_logical_before  ⊑  sle_swap_and_min_logical_combined := by
  unfold sle_swap_and_min_logical_before sle_swap_and_min_logical_combined
  simp_alive_peephole
  sorry
def sle_swap_and_min_commute_combined := [llvmfunc|
  llvm.func @sle_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_swap_and_min_commute   : sle_swap_and_min_commute_before  ⊑  sle_swap_and_min_commute_combined := by
  unfold sle_swap_and_min_commute_before sle_swap_and_min_commute_combined
  simp_alive_peephole
  sorry
def sle_swap_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @sle_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sle_swap_and_min_commute_logical   : sle_swap_and_min_commute_logical_before  ⊑  sle_swap_and_min_commute_logical_combined := by
  unfold sle_swap_and_min_commute_logical_before sle_swap_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_and_min_combined := [llvmfunc|
  llvm.func @ule_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min   : ule_and_min_before  ⊑  ule_and_min_combined := by
  unfold ule_and_min_before ule_and_min_combined
  simp_alive_peephole
  sorry
def ule_and_min_logical_combined := [llvmfunc|
  llvm.func @ule_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min_logical   : ule_and_min_logical_before  ⊑  ule_and_min_logical_combined := by
  unfold ule_and_min_logical_before ule_and_min_logical_combined
  simp_alive_peephole
  sorry
def ule_and_min_commute_combined := [llvmfunc|
  llvm.func @ule_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min_commute   : ule_and_min_commute_before  ⊑  ule_and_min_commute_combined := by
  unfold ule_and_min_commute_before ule_and_min_commute_combined
  simp_alive_peephole
  sorry
def ule_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min_commute_logical   : ule_and_min_commute_logical_before  ⊑  ule_and_min_commute_logical_combined := by
  unfold ule_and_min_commute_logical_before ule_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_combined := [llvmfunc|
  llvm.func @ule_swap_and_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min   : ule_swap_and_min_before  ⊑  ule_swap_and_min_combined := by
  unfold ule_swap_and_min_before ule_swap_and_min_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_logical_combined := [llvmfunc|
  llvm.func @ule_swap_and_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min_logical   : ule_swap_and_min_logical_before  ⊑  ule_swap_and_min_logical_combined := by
  unfold ule_swap_and_min_logical_before ule_swap_and_min_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_commute_combined := [llvmfunc|
  llvm.func @ule_swap_and_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min_commute   : ule_swap_and_min_commute_before  ⊑  ule_swap_and_min_commute_combined := by
  unfold ule_swap_and_min_commute_before ule_swap_and_min_commute_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_swap_and_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "eq" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min_commute_logical   : ule_swap_and_min_commute_logical_before  ⊑  ule_swap_and_min_commute_logical_combined := by
  unfold ule_swap_and_min_commute_logical_before ule_swap_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sge_or_max_combined := [llvmfunc|
  llvm.func @sge_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_or_max   : sge_or_max_before  ⊑  sge_or_max_combined := by
  unfold sge_or_max_before sge_or_max_combined
  simp_alive_peephole
  sorry
def sge_or_max_logical_combined := [llvmfunc|
  llvm.func @sge_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_or_max_logical   : sge_or_max_logical_before  ⊑  sge_or_max_logical_combined := by
  unfold sge_or_max_logical_before sge_or_max_logical_combined
  simp_alive_peephole
  sorry
def sge_or_max_commute_combined := [llvmfunc|
  llvm.func @sge_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_or_max_commute   : sge_or_max_commute_before  ⊑  sge_or_max_commute_combined := by
  unfold sge_or_max_commute_before sge_or_max_commute_combined
  simp_alive_peephole
  sorry
def sge_or_max_commute_logical_combined := [llvmfunc|
  llvm.func @sge_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_sge_or_max_commute_logical   : sge_or_max_commute_logical_before  ⊑  sge_or_max_commute_logical_combined := by
  unfold sge_or_max_commute_logical_before sge_or_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sge_swap_or_max_combined := [llvmfunc|
  llvm.func @sge_swap_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_swap_or_max   : sge_swap_or_max_before  ⊑  sge_swap_or_max_combined := by
  unfold sge_swap_or_max_before sge_swap_or_max_combined
  simp_alive_peephole
  sorry
def sge_swap_or_max_logical_combined := [llvmfunc|
  llvm.func @sge_swap_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_swap_or_max_logical   : sge_swap_or_max_logical_before  ⊑  sge_swap_or_max_logical_combined := by
  unfold sge_swap_or_max_logical_before sge_swap_or_max_logical_combined
  simp_alive_peephole
  sorry
def sge_swap_or_max_commute_combined := [llvmfunc|
  llvm.func @sge_swap_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sle" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sge_swap_or_max_commute   : sge_swap_or_max_commute_before  ⊑  sge_swap_or_max_commute_combined := by
  unfold sge_swap_or_max_commute_before sge_swap_or_max_commute_combined
  simp_alive_peephole
  sorry
def sge_swap_or_max_commute_logical_combined := [llvmfunc|
  llvm.func @sge_swap_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_sge_swap_or_max_commute_logical   : sge_swap_or_max_commute_logical_before  ⊑  sge_swap_or_max_commute_logical_combined := by
  unfold sge_swap_or_max_commute_logical_before sge_swap_or_max_commute_logical_combined
  simp_alive_peephole
  sorry
def uge_or_max_combined := [llvmfunc|
  llvm.func @uge_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_or_max   : uge_or_max_before  ⊑  uge_or_max_combined := by
  unfold uge_or_max_before uge_or_max_combined
  simp_alive_peephole
  sorry
def uge_or_max_logical_combined := [llvmfunc|
  llvm.func @uge_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_or_max_logical   : uge_or_max_logical_before  ⊑  uge_or_max_logical_combined := by
  unfold uge_or_max_logical_before uge_or_max_logical_combined
  simp_alive_peephole
  sorry
def uge_or_max_commute_combined := [llvmfunc|
  llvm.func @uge_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "uge" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_or_max_commute   : uge_or_max_commute_before  ⊑  uge_or_max_commute_combined := by
  unfold uge_or_max_commute_before uge_or_max_commute_combined
  simp_alive_peephole
  sorry
def uge_or_max_commute_logical_combined := [llvmfunc|
  llvm.func @uge_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_uge_or_max_commute_logical   : uge_or_max_commute_logical_before  ⊑  uge_or_max_commute_logical_combined := by
  unfold uge_or_max_commute_logical_before uge_or_max_commute_logical_combined
  simp_alive_peephole
  sorry
def uge_swap_or_max_combined := [llvmfunc|
  llvm.func @uge_swap_or_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_swap_or_max   : uge_swap_or_max_before  ⊑  uge_swap_or_max_combined := by
  unfold uge_swap_or_max_before uge_swap_or_max_combined
  simp_alive_peephole
  sorry
def uge_swap_or_max_logical_combined := [llvmfunc|
  llvm.func @uge_swap_or_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_swap_or_max_logical   : uge_swap_or_max_logical_before  ⊑  uge_swap_or_max_logical_combined := by
  unfold uge_swap_or_max_logical_before uge_swap_or_max_logical_combined
  simp_alive_peephole
  sorry
def uge_swap_or_max_commute_combined := [llvmfunc|
  llvm.func @uge_swap_or_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ule" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_uge_swap_or_max_commute   : uge_swap_or_max_commute_before  ⊑  uge_swap_or_max_commute_combined := by
  unfold uge_swap_or_max_commute_before uge_swap_or_max_commute_combined
  simp_alive_peephole
  sorry
def uge_swap_or_max_commute_logical_combined := [llvmfunc|
  llvm.func @uge_swap_or_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_uge_swap_or_max_commute_logical   : uge_swap_or_max_commute_logical_before  ⊑  uge_swap_or_max_commute_logical_combined := by
  unfold uge_swap_or_max_commute_logical_before uge_swap_or_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sle_or_min_combined := [llvmfunc|
  llvm.func @sle_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_or_min   : sle_or_min_before  ⊑  sle_or_min_combined := by
  unfold sle_or_min_before sle_or_min_combined
  simp_alive_peephole
  sorry
def sle_or_min_logical_combined := [llvmfunc|
  llvm.func @sle_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_or_min_logical   : sle_or_min_logical_before  ⊑  sle_or_min_logical_combined := by
  unfold sle_or_min_logical_before sle_or_min_logical_combined
  simp_alive_peephole
  sorry
def sle_or_min_commute_combined := [llvmfunc|
  llvm.func @sle_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sle" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_or_min_commute   : sle_or_min_commute_before  ⊑  sle_or_min_commute_combined := by
  unfold sle_or_min_commute_before sle_or_min_commute_combined
  simp_alive_peephole
  sorry
def sle_or_min_commute_logical_combined := [llvmfunc|
  llvm.func @sle_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_sle_or_min_commute_logical   : sle_or_min_commute_logical_before  ⊑  sle_or_min_commute_logical_combined := by
  unfold sle_or_min_commute_logical_before sle_or_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sle_swap_or_min_combined := [llvmfunc|
  llvm.func @sle_swap_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_swap_or_min   : sle_swap_or_min_before  ⊑  sle_swap_or_min_combined := by
  unfold sle_swap_or_min_before sle_swap_or_min_combined
  simp_alive_peephole
  sorry
def sle_swap_or_min_logical_combined := [llvmfunc|
  llvm.func @sle_swap_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_swap_or_min_logical   : sle_swap_or_min_logical_before  ⊑  sle_swap_or_min_logical_combined := by
  unfold sle_swap_or_min_logical_before sle_swap_or_min_logical_combined
  simp_alive_peephole
  sorry
def sle_swap_or_min_commute_combined := [llvmfunc|
  llvm.func @sle_swap_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sge" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sle_swap_or_min_commute   : sle_swap_or_min_commute_before  ⊑  sle_swap_or_min_commute_combined := by
  unfold sle_swap_or_min_commute_before sle_swap_or_min_commute_combined
  simp_alive_peephole
  sorry
def sle_swap_or_min_commute_logical_combined := [llvmfunc|
  llvm.func @sle_swap_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_sle_swap_or_min_commute_logical   : sle_swap_or_min_commute_logical_before  ⊑  sle_swap_or_min_commute_logical_combined := by
  unfold sle_swap_or_min_commute_logical_before sle_swap_or_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_or_min_combined := [llvmfunc|
  llvm.func @ule_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_min   : ule_or_min_before  ⊑  ule_or_min_combined := by
  unfold ule_or_min_before ule_or_min_combined
  simp_alive_peephole
  sorry
def ule_or_min_logical_combined := [llvmfunc|
  llvm.func @ule_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_min_logical   : ule_or_min_logical_before  ⊑  ule_or_min_logical_combined := by
  unfold ule_or_min_logical_before ule_or_min_logical_combined
  simp_alive_peephole
  sorry
def ule_or_min_commute_combined := [llvmfunc|
  llvm.func @ule_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_min_commute   : ule_or_min_commute_before  ⊑  ule_or_min_commute_combined := by
  unfold ule_or_min_commute_before ule_or_min_commute_combined
  simp_alive_peephole
  sorry
def ule_or_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ule_or_min_commute_logical   : ule_or_min_commute_logical_before  ⊑  ule_or_min_commute_logical_combined := by
  unfold ule_or_min_commute_logical_before ule_or_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_combined := [llvmfunc|
  llvm.func @ule_swap_or_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_min   : ule_swap_or_min_before  ⊑  ule_swap_or_min_combined := by
  unfold ule_swap_or_min_before ule_swap_or_min_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_min_logical   : ule_swap_or_min_logical_before  ⊑  ule_swap_or_min_logical_combined := by
  unfold ule_swap_or_min_logical_before ule_swap_or_min_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_commute_combined := [llvmfunc|
  llvm.func @ule_swap_or_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_min_commute   : ule_swap_or_min_commute_before  ⊑  ule_swap_or_min_commute_combined := by
  unfold ule_swap_or_min_commute_before ule_swap_or_min_commute_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : i8
    %3 = llvm.icmp "eq" %arg0, %0 : i8
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ule_swap_or_min_commute_logical   : ule_swap_or_min_commute_logical_before  ⊑  ule_swap_or_min_commute_logical_combined := by
  unfold ule_swap_or_min_commute_logical_before ule_swap_or_min_commute_logical_combined
  simp_alive_peephole
  sorry
def slt_and_not_max_combined := [llvmfunc|
  llvm.func @slt_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_and_not_max   : slt_and_not_max_before  ⊑  slt_and_not_max_combined := by
  unfold slt_and_not_max_before slt_and_not_max_combined
  simp_alive_peephole
  sorry
def slt_and_not_max_logical_combined := [llvmfunc|
  llvm.func @slt_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_and_not_max_logical   : slt_and_not_max_logical_before  ⊑  slt_and_not_max_logical_combined := by
  unfold slt_and_not_max_logical_before slt_and_not_max_logical_combined
  simp_alive_peephole
  sorry
def slt_and_not_max_commute_combined := [llvmfunc|
  llvm.func @slt_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_and_not_max_commute   : slt_and_not_max_commute_before  ⊑  slt_and_not_max_commute_combined := by
  unfold slt_and_not_max_commute_before slt_and_not_max_commute_combined
  simp_alive_peephole
  sorry
def slt_and_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @slt_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_slt_and_not_max_commute_logical   : slt_and_not_max_commute_logical_before  ⊑  slt_and_not_max_commute_logical_combined := by
  unfold slt_and_not_max_commute_logical_before slt_and_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def slt_swap_and_not_max_combined := [llvmfunc|
  llvm.func @slt_swap_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_swap_and_not_max   : slt_swap_and_not_max_before  ⊑  slt_swap_and_not_max_combined := by
  unfold slt_swap_and_not_max_before slt_swap_and_not_max_combined
  simp_alive_peephole
  sorry
def slt_swap_and_not_max_logical_combined := [llvmfunc|
  llvm.func @slt_swap_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_swap_and_not_max_logical   : slt_swap_and_not_max_logical_before  ⊑  slt_swap_and_not_max_logical_combined := by
  unfold slt_swap_and_not_max_logical_before slt_swap_and_not_max_logical_combined
  simp_alive_peephole
  sorry
def slt_swap_and_not_max_commute_combined := [llvmfunc|
  llvm.func @slt_swap_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_slt_swap_and_not_max_commute   : slt_swap_and_not_max_commute_before  ⊑  slt_swap_and_not_max_commute_combined := by
  unfold slt_swap_and_not_max_commute_before slt_swap_and_not_max_commute_combined
  simp_alive_peephole
  sorry
def slt_swap_and_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @slt_swap_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_slt_swap_and_not_max_commute_logical   : slt_swap_and_not_max_commute_logical_before  ⊑  slt_swap_and_not_max_commute_logical_combined := by
  unfold slt_swap_and_not_max_commute_logical_before slt_swap_and_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def ult_and_not_max_combined := [llvmfunc|
  llvm.func @ult_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_and_not_max   : ult_and_not_max_before  ⊑  ult_and_not_max_combined := by
  unfold ult_and_not_max_before ult_and_not_max_combined
  simp_alive_peephole
  sorry
def ult_and_not_max_logical_combined := [llvmfunc|
  llvm.func @ult_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_and_not_max_logical   : ult_and_not_max_logical_before  ⊑  ult_and_not_max_logical_combined := by
  unfold ult_and_not_max_logical_before ult_and_not_max_logical_combined
  simp_alive_peephole
  sorry
def ult_and_not_max_commute_combined := [llvmfunc|
  llvm.func @ult_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_and_not_max_commute   : ult_and_not_max_commute_before  ⊑  ult_and_not_max_commute_combined := by
  unfold ult_and_not_max_commute_before ult_and_not_max_commute_combined
  simp_alive_peephole
  sorry
def ult_and_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @ult_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ult_and_not_max_commute_logical   : ult_and_not_max_commute_logical_before  ⊑  ult_and_not_max_commute_logical_combined := by
  unfold ult_and_not_max_commute_logical_before ult_and_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def ult_swap_and_not_max_combined := [llvmfunc|
  llvm.func @ult_swap_and_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_swap_and_not_max   : ult_swap_and_not_max_before  ⊑  ult_swap_and_not_max_combined := by
  unfold ult_swap_and_not_max_before ult_swap_and_not_max_combined
  simp_alive_peephole
  sorry
def ult_swap_and_not_max_logical_combined := [llvmfunc|
  llvm.func @ult_swap_and_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_swap_and_not_max_logical   : ult_swap_and_not_max_logical_before  ⊑  ult_swap_and_not_max_logical_combined := by
  unfold ult_swap_and_not_max_logical_before ult_swap_and_not_max_logical_combined
  simp_alive_peephole
  sorry
def ult_swap_and_not_max_commute_combined := [llvmfunc|
  llvm.func @ult_swap_and_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ult_swap_and_not_max_commute   : ult_swap_and_not_max_commute_before  ⊑  ult_swap_and_not_max_commute_combined := by
  unfold ult_swap_and_not_max_commute_before ult_swap_and_not_max_commute_combined
  simp_alive_peephole
  sorry
def ult_swap_and_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @ult_swap_and_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ult_swap_and_not_max_commute_logical   : ult_swap_and_not_max_commute_logical_before  ⊑  ult_swap_and_not_max_commute_logical_combined := by
  unfold ult_swap_and_not_max_commute_logical_before ult_swap_and_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sgt_and_not_min_combined := [llvmfunc|
  llvm.func @sgt_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_and_not_min   : sgt_and_not_min_before  ⊑  sgt_and_not_min_combined := by
  unfold sgt_and_not_min_before sgt_and_not_min_combined
  simp_alive_peephole
  sorry
def sgt_and_not_min_logical_combined := [llvmfunc|
  llvm.func @sgt_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_and_not_min_logical   : sgt_and_not_min_logical_before  ⊑  sgt_and_not_min_logical_combined := by
  unfold sgt_and_not_min_logical_before sgt_and_not_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_and_not_min_commute_combined := [llvmfunc|
  llvm.func @sgt_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "sgt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_and_not_min_commute   : sgt_and_not_min_commute_before  ⊑  sgt_and_not_min_commute_combined := by
  unfold sgt_and_not_min_commute_before sgt_and_not_min_commute_combined
  simp_alive_peephole
  sorry
def sgt_and_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @sgt_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_sgt_and_not_min_commute_logical   : sgt_and_not_min_commute_logical_before  ⊑  sgt_and_not_min_commute_logical_combined := by
  unfold sgt_and_not_min_commute_logical_before sgt_and_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_not_min_combined := [llvmfunc|
  llvm.func @sgt_swap_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_swap_and_not_min   : sgt_swap_and_not_min_before  ⊑  sgt_swap_and_not_min_combined := by
  unfold sgt_swap_and_not_min_before sgt_swap_and_not_min_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_not_min_logical_combined := [llvmfunc|
  llvm.func @sgt_swap_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_swap_and_not_min_logical   : sgt_swap_and_not_min_logical_before  ⊑  sgt_swap_and_not_min_logical_combined := by
  unfold sgt_swap_and_not_min_logical_before sgt_swap_and_not_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_not_min_commute_combined := [llvmfunc|
  llvm.func @sgt_swap_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "slt" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_sgt_swap_and_not_min_commute   : sgt_swap_and_not_min_commute_before  ⊑  sgt_swap_and_not_min_commute_combined := by
  unfold sgt_swap_and_not_min_commute_before sgt_swap_and_not_min_commute_combined
  simp_alive_peephole
  sorry
def sgt_swap_and_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @sgt_swap_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "slt" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_sgt_swap_and_not_min_commute_logical   : sgt_swap_and_not_min_commute_logical_before  ⊑  sgt_swap_and_not_min_commute_logical_combined := by
  unfold sgt_swap_and_not_min_commute_logical_before sgt_swap_and_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_combined := [llvmfunc|
  llvm.func @ugt_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_not_min   : ugt_and_not_min_before  ⊑  ugt_and_not_min_combined := by
  unfold ugt_and_not_min_before ugt_and_not_min_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_not_min_logical   : ugt_and_not_min_logical_before  ⊑  ugt_and_not_min_logical_combined := by
  unfold ugt_and_not_min_logical_before ugt_and_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_not_min_commute   : ugt_and_not_min_commute_before  ⊑  ugt_and_not_min_commute_combined := by
  unfold ugt_and_not_min_commute_before ugt_and_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ugt_and_not_min_commute_logical   : ugt_and_not_min_commute_logical_before  ⊑  ugt_and_not_min_commute_logical_combined := by
  unfold ugt_and_not_min_commute_logical_before ugt_and_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min   : ugt_swap_and_not_min_before  ⊑  ugt_swap_and_not_min_combined := by
  unfold ugt_swap_and_not_min_before ugt_swap_and_not_min_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min_logical   : ugt_swap_and_not_min_logical_before  ⊑  ugt_swap_and_not_min_logical_combined := by
  unfold ugt_swap_and_not_min_logical_before ugt_swap_and_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : i8
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min_commute   : ugt_swap_and_not_min_commute_before  ⊑  ugt_swap_and_not_min_commute_combined := by
  unfold ugt_swap_and_not_min_commute_before ugt_swap_and_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : i8
    %3 = llvm.icmp "ne" %arg0, %0 : i8
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min_commute_logical   : ugt_swap_and_not_min_commute_logical_before  ⊑  ugt_swap_and_not_min_commute_logical_combined := by
  unfold ugt_swap_and_not_min_commute_logical_before ugt_swap_and_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def slt_or_not_max_combined := [llvmfunc|
  llvm.func @slt_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_or_not_max   : slt_or_not_max_before  ⊑  slt_or_not_max_combined := by
  unfold slt_or_not_max_before slt_or_not_max_combined
  simp_alive_peephole
  sorry
def slt_or_not_max_logical_combined := [llvmfunc|
  llvm.func @slt_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_or_not_max_logical   : slt_or_not_max_logical_before  ⊑  slt_or_not_max_logical_combined := by
  unfold slt_or_not_max_logical_before slt_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def slt_or_not_max_commute_combined := [llvmfunc|
  llvm.func @slt_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_or_not_max_commute   : slt_or_not_max_commute_before  ⊑  slt_or_not_max_commute_combined := by
  unfold slt_or_not_max_commute_before slt_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def slt_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @slt_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_or_not_max_commute_logical   : slt_or_not_max_commute_logical_before  ⊑  slt_or_not_max_commute_logical_combined := by
  unfold slt_or_not_max_commute_logical_before slt_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def slt_swap_or_not_max_combined := [llvmfunc|
  llvm.func @slt_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_swap_or_not_max   : slt_swap_or_not_max_before  ⊑  slt_swap_or_not_max_combined := by
  unfold slt_swap_or_not_max_before slt_swap_or_not_max_combined
  simp_alive_peephole
  sorry
def slt_swap_or_not_max_logical_combined := [llvmfunc|
  llvm.func @slt_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_swap_or_not_max_logical   : slt_swap_or_not_max_logical_before  ⊑  slt_swap_or_not_max_logical_combined := by
  unfold slt_swap_or_not_max_logical_before slt_swap_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def slt_swap_or_not_max_commute_combined := [llvmfunc|
  llvm.func @slt_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_swap_or_not_max_commute   : slt_swap_or_not_max_commute_before  ⊑  slt_swap_or_not_max_commute_combined := by
  unfold slt_swap_or_not_max_commute_before slt_swap_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def slt_swap_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @slt_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(127 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_slt_swap_or_not_max_commute_logical   : slt_swap_or_not_max_commute_logical_before  ⊑  slt_swap_or_not_max_commute_logical_combined := by
  unfold slt_swap_or_not_max_commute_logical_before slt_swap_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def ult_or_not_max_combined := [llvmfunc|
  llvm.func @ult_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_or_not_max   : ult_or_not_max_before  ⊑  ult_or_not_max_combined := by
  unfold ult_or_not_max_before ult_or_not_max_combined
  simp_alive_peephole
  sorry
def ult_or_not_max_logical_combined := [llvmfunc|
  llvm.func @ult_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_or_not_max_logical   : ult_or_not_max_logical_before  ⊑  ult_or_not_max_logical_combined := by
  unfold ult_or_not_max_logical_before ult_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def ult_or_not_max_commute_combined := [llvmfunc|
  llvm.func @ult_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_or_not_max_commute   : ult_or_not_max_commute_before  ⊑  ult_or_not_max_commute_combined := by
  unfold ult_or_not_max_commute_before ult_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def ult_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @ult_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_or_not_max_commute_logical   : ult_or_not_max_commute_logical_before  ⊑  ult_or_not_max_commute_logical_combined := by
  unfold ult_or_not_max_commute_logical_before ult_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def ult_swap_or_not_max_combined := [llvmfunc|
  llvm.func @ult_swap_or_not_max(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_swap_or_not_max   : ult_swap_or_not_max_before  ⊑  ult_swap_or_not_max_combined := by
  unfold ult_swap_or_not_max_before ult_swap_or_not_max_combined
  simp_alive_peephole
  sorry
def ult_swap_or_not_max_logical_combined := [llvmfunc|
  llvm.func @ult_swap_or_not_max_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_swap_or_not_max_logical   : ult_swap_or_not_max_logical_before  ⊑  ult_swap_or_not_max_logical_combined := by
  unfold ult_swap_or_not_max_logical_before ult_swap_or_not_max_logical_combined
  simp_alive_peephole
  sorry
def ult_swap_or_not_max_commute_combined := [llvmfunc|
  llvm.func @ult_swap_or_not_max_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_swap_or_not_max_commute   : ult_swap_or_not_max_commute_before  ⊑  ult_swap_or_not_max_commute_combined := by
  unfold ult_swap_or_not_max_commute_before ult_swap_or_not_max_commute_combined
  simp_alive_peephole
  sorry
def ult_swap_or_not_max_commute_logical_combined := [llvmfunc|
  llvm.func @ult_swap_or_not_max_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-1 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ult_swap_or_not_max_commute_logical   : ult_swap_or_not_max_commute_logical_before  ⊑  ult_swap_or_not_max_commute_logical_combined := by
  unfold ult_swap_or_not_max_commute_logical_before ult_swap_or_not_max_commute_logical_combined
  simp_alive_peephole
  sorry
def sgt_or_not_min_combined := [llvmfunc|
  llvm.func @sgt_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_or_not_min   : sgt_or_not_min_before  ⊑  sgt_or_not_min_combined := by
  unfold sgt_or_not_min_before sgt_or_not_min_combined
  simp_alive_peephole
  sorry
def sgt_or_not_min_logical_combined := [llvmfunc|
  llvm.func @sgt_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_or_not_min_logical   : sgt_or_not_min_logical_before  ⊑  sgt_or_not_min_logical_combined := by
  unfold sgt_or_not_min_logical_before sgt_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_or_not_min_commute_combined := [llvmfunc|
  llvm.func @sgt_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_or_not_min_commute   : sgt_or_not_min_commute_before  ⊑  sgt_or_not_min_commute_combined := by
  unfold sgt_or_not_min_commute_before sgt_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def sgt_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @sgt_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_or_not_min_commute_logical   : sgt_or_not_min_commute_logical_before  ⊑  sgt_or_not_min_commute_logical_combined := by
  unfold sgt_or_not_min_commute_logical_before sgt_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sgt_swap_or_not_min_combined := [llvmfunc|
  llvm.func @sgt_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_swap_or_not_min   : sgt_swap_or_not_min_before  ⊑  sgt_swap_or_not_min_combined := by
  unfold sgt_swap_or_not_min_before sgt_swap_or_not_min_combined
  simp_alive_peephole
  sorry
def sgt_swap_or_not_min_logical_combined := [llvmfunc|
  llvm.func @sgt_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_swap_or_not_min_logical   : sgt_swap_or_not_min_logical_before  ⊑  sgt_swap_or_not_min_logical_combined := by
  unfold sgt_swap_or_not_min_logical_before sgt_swap_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_swap_or_not_min_commute_combined := [llvmfunc|
  llvm.func @sgt_swap_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_swap_or_not_min_commute   : sgt_swap_or_not_min_commute_before  ⊑  sgt_swap_or_not_min_commute_combined := by
  unfold sgt_swap_or_not_min_commute_before sgt_swap_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def sgt_swap_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @sgt_swap_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(-128 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_sgt_swap_or_not_min_commute_logical   : sgt_swap_or_not_min_commute_logical_before  ⊑  sgt_swap_or_not_min_commute_logical_combined := by
  unfold sgt_swap_or_not_min_commute_logical_before sgt_swap_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_combined := [llvmfunc|
  llvm.func @ugt_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min   : ugt_or_not_min_before  ⊑  ugt_or_not_min_combined := by
  unfold ugt_or_not_min_before ugt_or_not_min_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min_logical   : ugt_or_not_min_logical_before  ⊑  ugt_or_not_min_logical_combined := by
  unfold ugt_or_not_min_logical_before ugt_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_or_not_min_commute(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min_commute   : ugt_or_not_min_commute_before  ⊑  ugt_or_not_min_commute_combined := by
  unfold ugt_or_not_min_commute_before ugt_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_or_not_min_commute_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min_commute_logical   : ugt_or_not_min_commute_logical_before  ⊑  ugt_or_not_min_commute_logical_combined := by
  unfold ugt_or_not_min_commute_logical_before ugt_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min   : ugt_swap_or_not_min_before  ⊑  ugt_swap_or_not_min_combined := by
  unfold ugt_swap_or_not_min_before ugt_swap_or_not_min_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_logical(%arg0: i8, %arg1: i8) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.icmp "ne" %arg0, %0 : i8
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min_logical   : ugt_swap_or_not_min_logical_before  ⊑  ugt_swap_or_not_min_logical_combined := by
  unfold ugt_swap_or_not_min_logical_before ugt_swap_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute(%arg0: i823, %arg1: i823) -> i1 {
    %0 = llvm.mlir.constant(0 : i823) : i823
    %1 = llvm.icmp "ne" %arg0, %0 : i823
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min_commute   : ugt_swap_or_not_min_commute_before  ⊑  ugt_swap_or_not_min_commute_combined := by
  unfold ugt_swap_or_not_min_commute_before ugt_swap_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute_logical(%arg0: i823, %arg1: i823) -> i1 {
    %0 = llvm.mlir.constant(0 : i823) : i823
    %1 = llvm.icmp "ne" %arg0, %0 : i823
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min_commute_logical   : ugt_swap_or_not_min_commute_logical_before  ⊑  ugt_swap_or_not_min_commute_logical_combined := by
  unfold ugt_swap_or_not_min_commute_logical_before ugt_swap_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
