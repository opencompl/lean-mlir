import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  and-or-icmp-nullptr
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def ugt_and_min_before := [llvmfunc|
  llvm.func @ugt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_and_min_logical_before := [llvmfunc|
  llvm.func @ugt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_min_commute_before := [llvmfunc|
  llvm.func @ugt_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_min_before := [llvmfunc|
  llvm.func @ugt_swap_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_min_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_min_commute_before := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_not_min_before := [llvmfunc|
  llvm.func @ule_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_or_not_min_logical_before := [llvmfunc|
  llvm.func @ule_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_not_min_commute_before := [llvmfunc|
  llvm.func @ule_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_not_min_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_not_min_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_not_min_commute_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ule_and_min_before := [llvmfunc|
  llvm.func @ule_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_and_min_logical_before := [llvmfunc|
  llvm.func @ule_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_and_min_commute_before := [llvmfunc|
  llvm.func @ule_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_and_min_before := [llvmfunc|
  llvm.func @ule_swap_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_swap_and_min_logical_before := [llvmfunc|
  llvm.func @ule_swap_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_and_min_commute_before := [llvmfunc|
  llvm.func @ule_swap_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_swap_and_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_swap_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_min_before := [llvmfunc|
  llvm.func @ule_or_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_or_min_logical_before := [llvmfunc|
  llvm.func @ule_or_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_or_min_commute_before := [llvmfunc|
  llvm.func @ule_or_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_or_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_or_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_min_before := [llvmfunc|
  llvm.func @ule_swap_or_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_min_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ule_swap_or_min_commute_before := [llvmfunc|
  llvm.func @ule_swap_or_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ule_swap_or_min_commute_logical_before := [llvmfunc|
  llvm.func @ule_swap_or_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_not_min_before := [llvmfunc|
  llvm.func @ugt_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_and_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_and_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_and_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_and_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_not_min_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_and_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_and_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_or_not_min_before := [llvmfunc|
  llvm.func @ugt_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_or_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_or_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_or_not_min_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_or_not_min_logical_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_swap_or_not_min_commute_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %2, %1  : i1
    llvm.return %3 : i1
  }]

def ugt_swap_or_not_min_commute_logical_before := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_and_min_before := [llvmfunc|
  llvm.func @sgt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_and_min_logical_before := [llvmfunc|
  llvm.func @sgt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sle_or_not_min_before := [llvmfunc|
  llvm.func @sle_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_or_not_min_logical_before := [llvmfunc|
  llvm.func @sle_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def sle_and_min_before := [llvmfunc|
  llvm.func @sle_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sle_and_min_logical_before := [llvmfunc|
  llvm.func @sle_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sle" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_and_not_min_before := [llvmfunc|
  llvm.func @sgt_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_and_not_min_logical_before := [llvmfunc|
  llvm.func @sgt_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def sgt_or_not_min_before := [llvmfunc|
  llvm.func @sgt_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

def sgt_or_not_min_logical_before := [llvmfunc|
  llvm.func @sgt_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %2, %1, %3 : i1, i1
    llvm.return %4 : i1
  }]

def slt_and_min_before := [llvmfunc|
  llvm.func @slt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

def slt_and_min_logical_before := [llvmfunc|
  llvm.func @slt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.icmp "slt" %arg0, %arg1 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

def ugt_and_min_combined := [llvmfunc|
  llvm.func @ugt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min   : ugt_and_min_before  ⊑  ugt_and_min_combined := by
  unfold ugt_and_min_before ugt_and_min_combined
  simp_alive_peephole
  sorry
def ugt_and_min_logical_combined := [llvmfunc|
  llvm.func @ugt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min_logical   : ugt_and_min_logical_before  ⊑  ugt_and_min_logical_combined := by
  unfold ugt_and_min_logical_before ugt_and_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_and_min_commute_combined := [llvmfunc|
  llvm.func @ugt_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min_commute   : ugt_and_min_commute_before  ⊑  ugt_and_min_commute_combined := by
  unfold ugt_and_min_commute_before ugt_and_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_min_commute_logical   : ugt_and_min_commute_logical_before  ⊑  ugt_and_min_commute_logical_combined := by
  unfold ugt_and_min_commute_logical_before ugt_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min   : ugt_swap_and_min_before  ⊑  ugt_swap_and_min_combined := by
  unfold ugt_swap_and_min_before ugt_swap_and_min_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min_logical   : ugt_swap_and_min_logical_before  ⊑  ugt_swap_and_min_logical_combined := by
  unfold ugt_swap_and_min_logical_before ugt_swap_and_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_commute_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min_commute   : ugt_swap_and_min_commute_before  ⊑  ugt_swap_and_min_commute_combined := by
  unfold ugt_swap_and_min_commute_before ugt_swap_and_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(false) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_min_commute_logical   : ugt_swap_and_min_commute_logical_before  ⊑  ugt_swap_and_min_commute_logical_combined := by
  unfold ugt_swap_and_min_commute_logical_before ugt_swap_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_combined := [llvmfunc|
  llvm.func @ule_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min   : ule_or_not_min_before  ⊑  ule_or_not_min_combined := by
  unfold ule_or_not_min_before ule_or_not_min_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ule_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min_logical   : ule_or_not_min_logical_before  ⊑  ule_or_not_min_logical_combined := by
  unfold ule_or_not_min_logical_before ule_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ule_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min_commute   : ule_or_not_min_commute_before  ⊑  ule_or_not_min_commute_combined := by
  unfold ule_or_not_min_commute_before ule_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ule_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_not_min_commute_logical   : ule_or_not_min_commute_logical_before  ⊑  ule_or_not_min_commute_logical_combined := by
  unfold ule_or_not_min_commute_logical_before ule_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min   : ule_swap_or_not_min_before  ⊑  ule_swap_or_not_min_combined := by
  unfold ule_swap_or_not_min_before ule_swap_or_not_min_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min_logical   : ule_swap_or_not_min_logical_before  ⊑  ule_swap_or_not_min_logical_combined := by
  unfold ule_swap_or_not_min_logical_before ule_swap_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min_commute   : ule_swap_or_not_min_commute_before  ⊑  ule_swap_or_not_min_commute_combined := by
  unfold ule_swap_or_not_min_commute_before ule_swap_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ule_swap_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_not_min_commute_logical   : ule_swap_or_not_min_commute_logical_before  ⊑  ule_swap_or_not_min_commute_logical_combined := by
  unfold ule_swap_or_not_min_commute_logical_before ule_swap_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_and_min_combined := [llvmfunc|
  llvm.func @ule_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min   : ule_and_min_before  ⊑  ule_and_min_combined := by
  unfold ule_and_min_before ule_and_min_combined
  simp_alive_peephole
  sorry
def ule_and_min_logical_combined := [llvmfunc|
  llvm.func @ule_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min_logical   : ule_and_min_logical_before  ⊑  ule_and_min_logical_combined := by
  unfold ule_and_min_logical_before ule_and_min_logical_combined
  simp_alive_peephole
  sorry
def ule_and_min_commute_combined := [llvmfunc|
  llvm.func @ule_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min_commute   : ule_and_min_commute_before  ⊑  ule_and_min_commute_combined := by
  unfold ule_and_min_commute_before ule_and_min_commute_combined
  simp_alive_peephole
  sorry
def ule_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_and_min_commute_logical   : ule_and_min_commute_logical_before  ⊑  ule_and_min_commute_logical_combined := by
  unfold ule_and_min_commute_logical_before ule_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_combined := [llvmfunc|
  llvm.func @ule_swap_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min   : ule_swap_and_min_before  ⊑  ule_swap_and_min_combined := by
  unfold ule_swap_and_min_before ule_swap_and_min_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_logical_combined := [llvmfunc|
  llvm.func @ule_swap_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min_logical   : ule_swap_and_min_logical_before  ⊑  ule_swap_and_min_logical_combined := by
  unfold ule_swap_and_min_logical_before ule_swap_and_min_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_commute_combined := [llvmfunc|
  llvm.func @ule_swap_and_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min_commute   : ule_swap_and_min_commute_before  ⊑  ule_swap_and_min_commute_combined := by
  unfold ule_swap_and_min_commute_before ule_swap_and_min_commute_combined
  simp_alive_peephole
  sorry
def ule_swap_and_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_swap_and_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ule_swap_and_min_commute_logical   : ule_swap_and_min_commute_logical_before  ⊑  ule_swap_and_min_commute_logical_combined := by
  unfold ule_swap_and_min_commute_logical_before ule_swap_and_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_or_min_combined := [llvmfunc|
  llvm.func @ule_or_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_min   : ule_or_min_before  ⊑  ule_or_min_combined := by
  unfold ule_or_min_before ule_or_min_combined
  simp_alive_peephole
  sorry
def ule_or_min_logical_combined := [llvmfunc|
  llvm.func @ule_or_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_min_logical   : ule_or_min_logical_before  ⊑  ule_or_min_logical_combined := by
  unfold ule_or_min_logical_before ule_or_min_logical_combined
  simp_alive_peephole
  sorry
def ule_or_min_commute_combined := [llvmfunc|
  llvm.func @ule_or_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_or_min_commute   : ule_or_min_commute_before  ⊑  ule_or_min_commute_combined := by
  unfold ule_or_min_commute_before ule_or_min_commute_combined
  simp_alive_peephole
  sorry
def ule_or_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_or_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "ule" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ule_or_min_commute_logical   : ule_or_min_commute_logical_before  ⊑  ule_or_min_commute_logical_combined := by
  unfold ule_or_min_commute_logical_before ule_or_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_combined := [llvmfunc|
  llvm.func @ule_swap_or_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_min   : ule_swap_or_min_before  ⊑  ule_swap_or_min_combined := by
  unfold ule_swap_or_min_before ule_swap_or_min_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_min_logical   : ule_swap_or_min_logical_before  ⊑  ule_swap_or_min_logical_combined := by
  unfold ule_swap_or_min_logical_before ule_swap_or_min_logical_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_commute_combined := [llvmfunc|
  llvm.func @ule_swap_or_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ule_swap_or_min_commute   : ule_swap_or_min_commute_before  ⊑  ule_swap_or_min_commute_combined := by
  unfold ule_swap_or_min_commute_before ule_swap_or_min_commute_combined
  simp_alive_peephole
  sorry
def ule_swap_or_min_commute_logical_combined := [llvmfunc|
  llvm.func @ule_swap_or_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.icmp "uge" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %1, %2 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ule_swap_or_min_commute_logical   : ule_swap_or_min_commute_logical_before  ⊑  ule_swap_or_min_commute_logical_combined := by
  unfold ule_swap_or_min_commute_logical_before ule_swap_or_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_combined := [llvmfunc|
  llvm.func @ugt_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_not_min   : ugt_and_not_min_before  ⊑  ugt_and_not_min_combined := by
  unfold ugt_and_not_min_before ugt_and_not_min_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_not_min_logical   : ugt_and_not_min_logical_before  ⊑  ugt_and_not_min_logical_combined := by
  unfold ugt_and_not_min_logical_before ugt_and_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_and_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_and_not_min_commute   : ugt_and_not_min_commute_before  ⊑  ugt_and_not_min_commute_combined := by
  unfold ugt_and_not_min_commute_before ugt_and_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_and_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_and_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ugt" %arg0, %arg1 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ugt_and_not_min_commute_logical   : ugt_and_not_min_commute_logical_before  ⊑  ugt_and_not_min_commute_logical_combined := by
  unfold ugt_and_not_min_commute_logical_before ugt_and_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min   : ugt_swap_and_not_min_before  ⊑  ugt_swap_and_not_min_combined := by
  unfold ugt_swap_and_not_min_before ugt_swap_and_not_min_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min_logical   : ugt_swap_and_not_min_logical_before  ⊑  ugt_swap_and_not_min_logical_combined := by
  unfold ugt_swap_and_not_min_logical_before ugt_swap_and_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    llvm.return %0 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min_commute   : ugt_swap_and_not_min_commute_before  ⊑  ugt_swap_and_not_min_commute_combined := by
  unfold ugt_swap_and_not_min_commute_before ugt_swap_and_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_swap_and_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_and_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "ult" %arg1, %arg0 : !llvm.ptr
    %3 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %4 = llvm.select %3, %2, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_ugt_swap_and_not_min_commute_logical   : ugt_swap_and_not_min_commute_logical_before  ⊑  ugt_swap_and_not_min_commute_logical_combined := by
  unfold ugt_swap_and_not_min_commute_logical_before ugt_swap_and_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_combined := [llvmfunc|
  llvm.func @ugt_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min   : ugt_or_not_min_before  ⊑  ugt_or_not_min_combined := by
  unfold ugt_or_not_min_before ugt_or_not_min_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min_logical   : ugt_or_not_min_logical_before  ⊑  ugt_or_not_min_logical_combined := by
  unfold ugt_or_not_min_logical_before ugt_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min_commute   : ugt_or_not_min_commute_before  ⊑  ugt_or_not_min_commute_combined := by
  unfold ugt_or_not_min_commute_before ugt_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_or_not_min_commute_logical   : ugt_or_not_min_commute_logical_before  ⊑  ugt_or_not_min_commute_logical_combined := by
  unfold ugt_or_not_min_commute_logical_before ugt_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min   : ugt_swap_or_not_min_before  ⊑  ugt_swap_or_not_min_combined := by
  unfold ugt_swap_or_not_min_before ugt_swap_or_not_min_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min_logical   : ugt_swap_or_not_min_logical_before  ⊑  ugt_swap_or_not_min_logical_combined := by
  unfold ugt_swap_or_not_min_logical_before ugt_swap_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_commute_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min_commute   : ugt_swap_or_not_min_commute_before  ⊑  ugt_swap_or_not_min_commute_combined := by
  unfold ugt_swap_or_not_min_commute_before ugt_swap_or_not_min_commute_combined
  simp_alive_peephole
  sorry
def ugt_swap_or_not_min_commute_logical_combined := [llvmfunc|
  llvm.func @ugt_swap_or_not_min_commute_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }]

theorem inst_combine_ugt_swap_or_not_min_commute_logical   : ugt_swap_or_not_min_commute_logical_before  ⊑  ugt_swap_or_not_min_commute_logical_combined := by
  unfold ugt_swap_or_not_min_commute_logical_before ugt_swap_or_not_min_commute_logical_combined
  simp_alive_peephole
  sorry
def sgt_and_min_combined := [llvmfunc|
  llvm.func @sgt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg1, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_and_min   : sgt_and_min_before  ⊑  sgt_and_min_combined := by
  unfold sgt_and_min_before sgt_and_min_combined
  simp_alive_peephole
  sorry
def sgt_and_min_logical_combined := [llvmfunc|
  llvm.func @sgt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg1, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_and_min_logical   : sgt_and_min_logical_before  ⊑  sgt_and_min_logical_combined := by
  unfold sgt_and_min_logical_before sgt_and_min_logical_combined
  simp_alive_peephole
  sorry
def sle_or_not_min_combined := [llvmfunc|
  llvm.func @sle_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "sge" %arg1, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sle_or_not_min   : sle_or_not_min_before  ⊑  sle_or_not_min_combined := by
  unfold sle_or_not_min_before sle_or_not_min_combined
  simp_alive_peephole
  sorry
def sle_or_not_min_logical_combined := [llvmfunc|
  llvm.func @sle_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "sge" %arg1, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sle_or_not_min_logical   : sle_or_not_min_logical_before  ⊑  sle_or_not_min_logical_combined := by
  unfold sle_or_not_min_logical_before sle_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def sle_and_min_combined := [llvmfunc|
  llvm.func @sle_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "sge" %arg1, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sle_and_min   : sle_and_min_before  ⊑  sle_and_min_combined := by
  unfold sle_and_min_before sle_and_min_combined
  simp_alive_peephole
  sorry
def sle_and_min_logical_combined := [llvmfunc|
  llvm.func @sle_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "sge" %arg1, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sle_and_min_logical   : sle_and_min_logical_before  ⊑  sle_and_min_logical_combined := by
  unfold sle_and_min_logical_before sle_and_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_and_not_min_combined := [llvmfunc|
  llvm.func @sgt_and_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_and_not_min   : sgt_and_not_min_before  ⊑  sgt_and_not_min_combined := by
  unfold sgt_and_not_min_before sgt_and_not_min_combined
  simp_alive_peephole
  sorry
def sgt_and_not_min_logical_combined := [llvmfunc|
  llvm.func @sgt_and_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "sgt" %arg0, %arg1 : !llvm.ptr
    %2 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_and_not_min_logical   : sgt_and_not_min_logical_before  ⊑  sgt_and_not_min_logical_combined := by
  unfold sgt_and_not_min_logical_before sgt_and_not_min_logical_combined
  simp_alive_peephole
  sorry
def sgt_or_not_min_combined := [llvmfunc|
  llvm.func @sgt_or_not_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg1, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_or_not_min   : sgt_or_not_min_before  ⊑  sgt_or_not_min_combined := by
  unfold sgt_or_not_min_before sgt_or_not_min_combined
  simp_alive_peephole
  sorry
def sgt_or_not_min_logical_combined := [llvmfunc|
  llvm.func @sgt_or_not_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "slt" %arg1, %0 : !llvm.ptr
    %3 = llvm.or %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_sgt_or_not_min_logical   : sgt_or_not_min_logical_before  ⊑  sgt_or_not_min_logical_combined := by
  unfold sgt_or_not_min_logical_before sgt_or_not_min_logical_combined
  simp_alive_peephole
  sorry
def slt_and_min_combined := [llvmfunc|
  llvm.func @slt_and_min(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %2 = llvm.icmp "sgt" %arg1, %0 : !llvm.ptr
    %3 = llvm.and %1, %2  : i1
    llvm.return %3 : i1
  }]

theorem inst_combine_slt_and_min   : slt_and_min_before  ⊑  slt_and_min_combined := by
  unfold slt_and_min_before slt_and_min_combined
  simp_alive_peephole
  sorry
def slt_and_min_logical_combined := [llvmfunc|
  llvm.func @slt_and_min_logical(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.icmp "eq" %arg0, %0 : !llvm.ptr
    %3 = llvm.icmp "sgt" %arg1, %0 : !llvm.ptr
    %4 = llvm.select %2, %3, %1 : i1, i1
    llvm.return %4 : i1
  }]

theorem inst_combine_slt_and_min_logical   : slt_and_min_logical_before  ⊑  slt_and_min_logical_combined := by
  unfold slt_and_min_logical_before slt_and_min_logical_combined
  simp_alive_peephole
  sorry
