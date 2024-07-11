import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  select-obo-peo-ops
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_shl_nuw_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nuw__all_are_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_shl_nsw__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl__all_are_safe_before := [llvmfunc|
  llvm.func @test_shl__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nuw_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1073741822 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nuw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1073741822 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_shl_nsw__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1073741822 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_shl__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(1073741822 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nuw_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(-335544316 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %4, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    %8 = llvm.mul %7, %4  : i32
    %9 = llvm.mul %8, %6  : i32
    llvm.return %9 : i32
  }]

def test_shl_nuw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(-335544316 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %4, %2 overflow<nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    %8 = llvm.mul %7, %4  : i32
    %9 = llvm.mul %8, %6  : i32
    llvm.return %9 : i32
  }]

def test_shl_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_shl_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(-335544316 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %4, %2 overflow<nsw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    %8 = llvm.mul %7, %4  : i32
    %9 = llvm.mul %8, %6  : i32
    llvm.return %9 : i32
  }]

def test_shl__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_shl__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(-335544316 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.shl %4, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    %8 = llvm.mul %7, %4  : i32
    %9 = llvm.mul %8, %6  : i32
    llvm.return %9 : i32
  }]

def test_shl_nuw_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nuw__none_are_safe_before := [llvmfunc|
  llvm.func @test_shl_nuw__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nuw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_shl_nsw__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1 overflow<nsw>  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_shl__none_are_safe_before := [llvmfunc|
  llvm.func @test_shl__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.shl %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_lshr_exact__exact_is_safe_before := [llvmfunc|
  llvm.func @test_lshr_exact__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(60 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_lshr__exact_is_safe_before := [llvmfunc|
  llvm.func @test_lshr__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(60 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_lshr_exact__exact_is_unsafe_before := [llvmfunc|
  llvm.func @test_lshr_exact__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_lshr__exact_is_unsafe_before := [llvmfunc|
  llvm.func @test_lshr__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(63 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.lshr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_ashr_exact__exact_is_safe_before := [llvmfunc|
  llvm.func @test_ashr_exact__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483588 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_ashr__exact_is_safe_before := [llvmfunc|
  llvm.func @test_ashr__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483588 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_ashr_exact__exact_is_unsafe_before := [llvmfunc|
  llvm.func @test_ashr_exact__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483585 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_ashr__exact_is_unsafe_before := [llvmfunc|
  llvm.func @test_ashr__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(-2147483585 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.ashr %3, %1  : i32
    %5 = llvm.zext %4 : i32 to i64
    %6 = llvm.icmp "eq" %3, %2 : i32
    %7 = llvm.ashr %arg1, %5  : i64
    %8 = llvm.select %6, %arg1, %7 : i1, i64
    llvm.return %8 : i64
  }]

def test_add_nuw_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_add_nuw_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add_nuw__all_are_safe_before := [llvmfunc|
  llvm.func @test_add_nuw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2 overflow<nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_add_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2 overflow<nsw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add__all_are_safe_before := [llvmfunc|
  llvm.func @test_add__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(3 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add_nuw_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_add_nuw_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.add %3, %1 overflow<nsw, nuw>  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_add_nuw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_add_nuw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.add %3, %1 overflow<nuw>  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_add_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_add_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.add %3, %1 overflow<nsw>  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_add__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_add__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %0 : i32
    %5 = llvm.add %3, %1  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_add_nuw_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_add_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add_nuw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_add_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2 overflow<nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_add_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2 overflow<nsw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_add__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-1 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.add %4, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_add_nuw_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_add_nuw_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_add_nuw__none_are_safe_before := [llvmfunc|
  llvm.func @test_add_nuw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1 overflow<nuw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_add_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_add_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1 overflow<nsw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_add__none_are_safe_before := [llvmfunc|
  llvm.func @test_add__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(4 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.add %arg0, %1  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_sub_nuw_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(-254 : i32) : i32
    %3 = llvm.mlir.constant(-260 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.sub %2, %4 overflow<nsw, nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_sub_nuw__all_are_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(-254 : i32) : i32
    %3 = llvm.mlir.constant(-260 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.sub %2, %4 overflow<nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_sub_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_sub_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(-254 : i32) : i32
    %3 = llvm.mlir.constant(-260 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.sub %2, %4 overflow<nsw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_sub__all_are_safe_before := [llvmfunc|
  llvm.func @test_sub__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(6 : i32) : i32
    %2 = llvm.mlir.constant(-254 : i32) : i32
    %3 = llvm.mlir.constant(-260 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.sub %2, %4  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_sub_nuw_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1073741824 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %2, %3 overflow<nsw, nuw>  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub_nuw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1073741824 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %2, %3 overflow<nuw>  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_sub_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1073741824 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %2, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_sub__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1073741824 : i32) : i32
    %2 = llvm.mlir.constant(-2147483648 : i32) : i32
    %3 = llvm.and %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %2, %3  : i32
    %6 = llvm.select %4, %1, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub_nuw_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483647 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %0, %3 overflow<nsw, nuw>  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub_nuw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483647 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %0, %3 overflow<nuw>  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_sub_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483647 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %0, %3 overflow<nsw>  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_sub__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(-2147483647 : i32) : i32
    %2 = llvm.mlir.constant(-1 : i32) : i32
    %3 = llvm.or %arg0, %0  : i32
    %4 = llvm.icmp "eq" %3, %1 : i32
    %5 = llvm.sub %0, %3  : i32
    %6 = llvm.select %4, %2, %5 : i1, i32
    llvm.return %6 : i32
  }]

def test_sub_nuw_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw, nuw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_sub_nuw__none_are_safe_before := [llvmfunc|
  llvm.func @test_sub_nuw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nuw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_sub_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_sub_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0 overflow<nsw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_sub__none_are_safe_before := [llvmfunc|
  llvm.func @test_sub__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.mlir.constant(2147483647 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.sub %1, %arg0  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_mul_nuw_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(153 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nuw__all_are_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(153 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nsw__all_are_safe_before := [llvmfunc|
  llvm.func @test_mul_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(153 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nsw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul__all_are_safe_before := [llvmfunc|
  llvm.func @test_mul__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(17 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(153 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nuw_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-1879048192 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nuw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-1879048192 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nsw__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_mul_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-1879048192 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nsw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul__nuw_is_safe_before := [llvmfunc|
  llvm.func @test_mul__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(268435456 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-1879048192 : i32) : i32
    %4 = llvm.and %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nuw_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-754974711 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nsw, nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nuw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-754974711 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nuw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nsw__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_mul_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-754974711 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2 overflow<nsw>  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul__nsw_is_safe_before := [llvmfunc|
  llvm.func @test_mul__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(-83886079 : i32) : i32
    %2 = llvm.mlir.constant(9 : i32) : i32
    %3 = llvm.mlir.constant(-754974711 : i32) : i32
    %4 = llvm.or %arg0, %0  : i32
    %5 = llvm.icmp "eq" %4, %1 : i32
    %6 = llvm.mul %4, %2  : i32
    %7 = llvm.select %5, %3, %6 : i1, i32
    llvm.return %7 : i32
  }]

def test_mul_nuw_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(805306368 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(-1342177280 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.mul %arg0, %1 overflow<nsw, nuw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_mul_nuw__none_are_safe_before := [llvmfunc|
  llvm.func @test_mul_nuw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(805306368 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(-1342177280 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.mul %arg0, %1 overflow<nuw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_mul_nsw__none_are_safe_before := [llvmfunc|
  llvm.func @test_mul_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(805306368 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(-1342177280 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.mul %arg0, %1 overflow<nsw>  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_mul__none_are_safe_before := [llvmfunc|
  llvm.func @test_mul__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(805306368 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.mlir.constant(-1342177280 : i32) : i32
    %3 = llvm.icmp "eq" %arg0, %0 : i32
    %4 = llvm.mul %arg0, %1  : i32
    %5 = llvm.select %3, %2, %4 : i1, i32
    llvm.return %5 : i32
  }]

def test_shl_nuw_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nuw_nsw__all_are_safe   : test_shl_nuw_nsw__all_are_safe_before  ⊑  test_shl_nuw_nsw__all_are_safe_combined := by
  unfold test_shl_nuw_nsw__all_are_safe_before test_shl_nuw_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nuw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nuw__all_are_safe   : test_shl_nuw__all_are_safe_before  ⊑  test_shl_nuw__all_are_safe_combined := by
  unfold test_shl_nuw__all_are_safe_before test_shl_nuw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_shl_nsw__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nsw__all_are_safe   : test_shl_nsw__all_are_safe_before  ⊑  test_shl_nsw__all_are_safe_combined := by
  unfold test_shl_nsw__all_are_safe_before test_shl_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_shl__all_are_safe_combined := [llvmfunc|
  llvm.func @test_shl__all_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(60 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl__all_are_safe   : test_shl__all_are_safe_before  ⊑  test_shl__all_are_safe_combined := by
  unfold test_shl__all_are_safe_before test_shl__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nuw_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nuw_nsw__nuw_is_safe   : test_shl_nuw_nsw__nuw_is_safe_before  ⊑  test_shl_nuw_nsw__nuw_is_safe_combined := by
  unfold test_shl_nuw_nsw__nuw_is_safe_before test_shl_nuw_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nuw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nuw__nuw_is_safe   : test_shl_nuw__nuw_is_safe_before  ⊑  test_shl_nuw__nuw_is_safe_combined := by
  unfold test_shl_nuw__nuw_is_safe_before test_shl_nuw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl_nsw__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nsw__nuw_is_safe   : test_shl_nsw__nuw_is_safe_before  ⊑  test_shl_nsw__nuw_is_safe_combined := by
  unfold test_shl_nsw__nuw_is_safe_before test_shl_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl__nuw_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl__nuw_is_safe   : test_shl__nuw_is_safe_before  ⊑  test_shl__nuw_is_safe_combined := by
  unfold test_shl__nuw_is_safe_before test_shl__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nuw_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_shl_nuw_nsw__nsw_is_safe   : test_shl_nuw_nsw__nsw_is_safe_before  ⊑  test_shl_nuw_nsw__nsw_is_safe_combined := by
  unfold test_shl_nuw_nsw__nsw_is_safe_before test_shl_nuw_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nuw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }]

theorem inst_combine_test_shl_nuw__nsw_is_safe   : test_shl_nuw__nsw_is_safe_before  ⊑  test_shl_nuw__nsw_is_safe_combined := by
  unfold test_shl_nuw__nsw_is_safe_before test_shl_nuw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.shl %2, %1 overflow<nsw>  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.mul %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_shl_nsw__nsw_is_safe   : test_shl_nsw__nsw_is_safe_before  ⊑  test_shl_nsw__nsw_is_safe_combined := by
  unfold test_shl_nsw__nsw_is_safe_before test_shl_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_shl__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.shl %2, %1 overflow<nsw>  : i32
    %4 = llvm.mul %3, %2  : i32
    %5 = llvm.mul %4, %3  : i32
    llvm.return %5 : i32
  }]

theorem inst_combine_test_shl__nsw_is_safe   : test_shl__nsw_is_safe_before  ⊑  test_shl__nsw_is_safe_combined := by
  unfold test_shl__nsw_is_safe_before test_shl__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nuw_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw_nsw__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nuw_nsw__none_are_safe   : test_shl_nuw_nsw__none_are_safe_before  ⊑  test_shl_nuw_nsw__none_are_safe_combined := by
  unfold test_shl_nuw_nsw__none_are_safe_before test_shl_nuw_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nuw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_shl_nuw__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nuw__none_are_safe   : test_shl_nuw__none_are_safe_before  ⊑  test_shl_nuw__none_are_safe_combined := by
  unfold test_shl_nuw__none_are_safe_before test_shl_nuw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_shl_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_shl_nsw__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl_nsw__none_are_safe   : test_shl_nsw__none_are_safe_before  ⊑  test_shl_nsw__none_are_safe_combined := by
  unfold test_shl_nsw__none_are_safe_before test_shl_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_shl__none_are_safe_combined := [llvmfunc|
  llvm.func @test_shl__none_are_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-8 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_shl__none_are_safe   : test_shl__none_are_safe_before  ⊑  test_shl__none_are_safe_combined := by
  unfold test_shl__none_are_safe_before test_shl__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_lshr_exact__exact_is_safe_combined := [llvmfunc|
  llvm.func @test_lshr_exact__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_lshr_exact__exact_is_safe   : test_lshr_exact__exact_is_safe_before  ⊑  test_lshr_exact__exact_is_safe_combined := by
  unfold test_lshr_exact__exact_is_safe_before test_lshr_exact__exact_is_safe_combined
  simp_alive_peephole
  sorry
def test_lshr__exact_is_safe_combined := [llvmfunc|
  llvm.func @test_lshr__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_lshr__exact_is_safe   : test_lshr__exact_is_safe_before  ⊑  test_lshr__exact_is_safe_combined := by
  unfold test_lshr__exact_is_safe_before test_lshr__exact_is_safe_combined
  simp_alive_peephole
  sorry
def test_lshr_exact__exact_is_unsafe_combined := [llvmfunc|
  llvm.func @test_lshr_exact__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_lshr_exact__exact_is_unsafe   : test_lshr_exact__exact_is_unsafe_before  ⊑  test_lshr_exact__exact_is_unsafe_combined := by
  unfold test_lshr_exact__exact_is_unsafe_before test_lshr_exact__exact_is_unsafe_combined
  simp_alive_peephole
  sorry
def test_lshr__exact_is_unsafe_combined := [llvmfunc|
  llvm.func @test_lshr__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(15 : i32) : i32
    %2 = llvm.lshr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_lshr__exact_is_unsafe   : test_lshr__exact_is_unsafe_before  ⊑  test_lshr__exact_is_unsafe_combined := by
  unfold test_lshr__exact_is_unsafe_before test_lshr__exact_is_unsafe_combined
  simp_alive_peephole
  sorry
def test_ashr_exact__exact_is_safe_combined := [llvmfunc|
  llvm.func @test_ashr_exact__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-536870897 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_ashr_exact__exact_is_safe   : test_ashr_exact__exact_is_safe_before  ⊑  test_ashr_exact__exact_is_safe_combined := by
  unfold test_ashr_exact__exact_is_safe_before test_ashr_exact__exact_is_safe_combined
  simp_alive_peephole
  sorry
def test_ashr__exact_is_safe_combined := [llvmfunc|
  llvm.func @test_ashr__exact_is_safe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-536870897 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_ashr__exact_is_safe   : test_ashr__exact_is_safe_before  ⊑  test_ashr__exact_is_safe_combined := by
  unfold test_ashr__exact_is_safe_before test_ashr__exact_is_safe_combined
  simp_alive_peephole
  sorry
def test_ashr_exact__exact_is_unsafe_combined := [llvmfunc|
  llvm.func @test_ashr_exact__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-536870897 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_ashr_exact__exact_is_unsafe   : test_ashr_exact__exact_is_unsafe_before  ⊑  test_ashr_exact__exact_is_unsafe_combined := by
  unfold test_ashr_exact__exact_is_unsafe_before test_ashr_exact__exact_is_unsafe_combined
  simp_alive_peephole
  sorry
def test_ashr__exact_is_unsafe_combined := [llvmfunc|
  llvm.func @test_ashr__exact_is_unsafe(%arg0: i32, %arg1: i64) -> i64 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(-536870897 : i32) : i32
    %2 = llvm.ashr %arg0, %0  : i32
    %3 = llvm.and %2, %1  : i32
    %4 = llvm.zext %3 : i32 to i64
    %5 = llvm.ashr %arg1, %4  : i64
    llvm.return %5 : i64
  }]

theorem inst_combine_test_ashr__exact_is_unsafe   : test_ashr__exact_is_unsafe_before  ⊑  test_ashr__exact_is_unsafe_combined := by
  unfold test_ashr__exact_is_unsafe_before test_ashr__exact_is_unsafe_combined
  simp_alive_peephole
  sorry
def test_add_nuw_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nuw_nsw__all_are_safe   : test_add_nuw_nsw__all_are_safe_before  ⊑  test_add_nuw_nsw__all_are_safe_combined := by
  unfold test_add_nuw_nsw__all_are_safe_before test_add_nuw_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_add_nuw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nuw__all_are_safe   : test_add_nuw__all_are_safe_before  ⊑  test_add_nuw__all_are_safe_combined := by
  unfold test_add_nuw__all_are_safe_before test_add_nuw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_add_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_add_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nsw__all_are_safe   : test_add_nsw__all_are_safe_before  ⊑  test_add_nsw__all_are_safe_combined := by
  unfold test_add_nsw__all_are_safe_before test_add_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_add__all_are_safe_combined := [llvmfunc|
  llvm.func @test_add__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1073741823 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add__all_are_safe   : test_add__all_are_safe_before  ⊑  test_add__all_are_safe_combined := by
  unfold test_add__all_are_safe_before test_add__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_add_nuw_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nuw_nsw__nuw_is_safe   : test_add_nuw_nsw__nuw_is_safe_before  ⊑  test_add_nuw_nsw__nuw_is_safe_combined := by
  unfold test_add_nuw_nsw__nuw_is_safe_before test_add_nuw_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add_nuw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nuw__nuw_is_safe   : test_add_nuw__nuw_is_safe_before  ⊑  test_add_nuw__nuw_is_safe_combined := by
  unfold test_add_nuw__nuw_is_safe_before test_add_nuw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_add_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nsw__nuw_is_safe   : test_add_nsw__nuw_is_safe_before  ⊑  test_add_nsw__nuw_is_safe_combined := by
  unfold test_add_nsw__nuw_is_safe_before test_add_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_add__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add__nuw_is_safe   : test_add__nuw_is_safe_before  ⊑  test_add__nuw_is_safe_combined := by
  unfold test_add__nuw_is_safe_before test_add__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add_nuw_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nuw_nsw__nsw_is_safe   : test_add_nuw_nsw__nsw_is_safe_before  ⊑  test_add_nuw_nsw__nsw_is_safe_combined := by
  unfold test_add_nuw_nsw__nsw_is_safe_before test_add_nuw_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add_nuw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nuw__nsw_is_safe   : test_add_nuw__nsw_is_safe_before  ⊑  test_add_nuw__nsw_is_safe_combined := by
  unfold test_add_nuw__nsw_is_safe_before test_add_nuw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_add_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add_nsw__nsw_is_safe   : test_add_nsw__nsw_is_safe_before  ⊑  test_add_nsw__nsw_is_safe_combined := by
  unfold test_add_nsw__nsw_is_safe_before test_add_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_add__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.add %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_add__nsw_is_safe   : test_add__nsw_is_safe_before  ⊑  test_add__nsw_is_safe_combined := by
  unfold test_add__nsw_is_safe_before test_add__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_add_nuw_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_add_nuw_nsw__none_are_safe   : test_add_nuw_nsw__none_are_safe_before  ⊑  test_add_nuw_nsw__none_are_safe_combined := by
  unfold test_add_nuw_nsw__none_are_safe_before test_add_nuw_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_add_nuw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_add_nuw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_add_nuw__none_are_safe   : test_add_nuw__none_are_safe_before  ⊑  test_add_nuw__none_are_safe_combined := by
  unfold test_add_nuw__none_are_safe_before test_add_nuw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_add_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_add_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_add_nsw__none_are_safe   : test_add_nsw__none_are_safe_before  ⊑  test_add_nsw__none_are_safe_combined := by
  unfold test_add_nsw__none_are_safe_before test_add_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_add__none_are_safe_combined := [llvmfunc|
  llvm.func @test_add__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.add %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_add__none_are_safe   : test_add__none_are_safe_before  ⊑  test_add__none_are_safe_combined := by
  unfold test_add__none_are_safe_before test_add__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(-254 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub_nuw_nsw__all_are_safe   : test_sub_nuw_nsw__all_are_safe_before  ⊑  test_sub_nuw_nsw__all_are_safe_combined := by
  unfold test_sub_nuw_nsw__all_are_safe_before test_sub_nuw_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(-254 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub_nuw__all_are_safe   : test_sub_nuw__all_are_safe_before  ⊑  test_sub_nuw__all_are_safe_combined := by
  unfold test_sub_nuw__all_are_safe_before test_sub_nuw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_sub_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(-254 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub_nsw__all_are_safe   : test_sub_nsw__all_are_safe_before  ⊑  test_sub_nsw__all_are_safe_combined := by
  unfold test_sub_nsw__all_are_safe_before test_sub_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub__all_are_safe_combined := [llvmfunc|
  llvm.func @test_sub__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(-254 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub__all_are_safe   : test_sub__all_are_safe_before  ⊑  test_sub__all_are_safe_combined := by
  unfold test_sub__all_are_safe_before test_sub__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub_nuw_nsw__nuw_is_safe   : test_sub_nuw_nsw__nuw_is_safe_before  ⊑  test_sub_nuw_nsw__nuw_is_safe_combined := by
  unfold test_sub_nuw_nsw__nuw_is_safe_before test_sub_nuw_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub_nuw__nuw_is_safe   : test_sub_nuw__nuw_is_safe_before  ⊑  test_sub_nuw__nuw_is_safe_combined := by
  unfold test_sub_nuw__nuw_is_safe_before test_sub_nuw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub_nsw__nuw_is_safe   : test_sub_nsw__nuw_is_safe_before  ⊑  test_sub_nsw__nuw_is_safe_combined := by
  unfold test_sub_nsw__nuw_is_safe_before test_sub_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(2147483647 : i32) : i32
    %1 = llvm.mlir.constant(-2147483648 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.sub %1, %2 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_sub__nuw_is_safe   : test_sub__nuw_is_safe_before  ⊑  test_sub__nuw_is_safe_combined := by
  unfold test_sub__nuw_is_safe_before test_sub__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sub_nuw_nsw__nsw_is_safe   : test_sub_nuw_nsw__nsw_is_safe_before  ⊑  test_sub_nuw_nsw__nsw_is_safe_combined := by
  unfold test_sub_nuw_nsw__nsw_is_safe_before test_sub_nuw_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sub_nuw__nsw_is_safe   : test_sub_nuw__nsw_is_safe_before  ⊑  test_sub_nuw__nsw_is_safe_combined := by
  unfold test_sub_nuw__nsw_is_safe_before test_sub_nuw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sub_nsw__nsw_is_safe   : test_sub_nsw__nsw_is_safe_before  ⊑  test_sub_nsw__nsw_is_safe_combined := by
  unfold test_sub_nsw__nsw_is_safe_before test_sub_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_sub__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.or %arg0, %0  : i32
    %2 = llvm.sub %0, %1 overflow<nsw>  : i32
    llvm.return %2 : i32
  }]

theorem inst_combine_test_sub__nsw_is_safe   : test_sub__nsw_is_safe_before  ⊑  test_sub__nsw_is_safe_combined := by
  unfold test_sub__nsw_is_safe_before test_sub__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_sub_nuw_nsw__none_are_safe   : test_sub_nuw_nsw__none_are_safe_before  ⊑  test_sub_nuw_nsw__none_are_safe_combined := by
  unfold test_sub_nuw_nsw__none_are_safe_before test_sub_nuw_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nuw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_sub_nuw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_sub_nuw__none_are_safe   : test_sub_nuw__none_are_safe_before  ⊑  test_sub_nuw__none_are_safe_combined := by
  unfold test_sub_nuw__none_are_safe_before test_sub_nuw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_sub_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_sub_nsw__none_are_safe   : test_sub_nsw__none_are_safe_before  ⊑  test_sub_nsw__none_are_safe_combined := by
  unfold test_sub_nsw__none_are_safe_before test_sub_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_sub__none_are_safe_combined := [llvmfunc|
  llvm.func @test_sub__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-2147483648 : i32) : i32
    %1 = llvm.sub %0, %arg0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_sub__none_are_safe   : test_sub__none_are_safe_before  ⊑  test_sub__none_are_safe_combined := by
  unfold test_sub__none_are_safe_before test_sub__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nuw_nsw__all_are_safe   : test_mul_nuw_nsw__all_are_safe_before  ⊑  test_mul_nuw_nsw__all_are_safe_combined := by
  unfold test_mul_nuw_nsw__all_are_safe_before test_mul_nuw_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nuw__all_are_safe   : test_mul_nuw__all_are_safe_before  ⊑  test_mul_nuw__all_are_safe_combined := by
  unfold test_mul_nuw__all_are_safe_before test_mul_nuw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nsw__all_are_safe_combined := [llvmfunc|
  llvm.func @test_mul_nsw__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nsw__all_are_safe   : test_mul_nsw__all_are_safe_before  ⊑  test_mul_nsw__all_are_safe_combined := by
  unfold test_mul_nsw__all_are_safe_before test_mul_nsw__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul__all_are_safe_combined := [llvmfunc|
  llvm.func @test_mul__all_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(255 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw, nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul__all_are_safe   : test_mul__all_are_safe_before  ⊑  test_mul__all_are_safe_combined := by
  unfold test_mul__all_are_safe_before test_mul__all_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nuw_nsw__nuw_is_safe   : test_mul_nuw_nsw__nuw_is_safe_before  ⊑  test_mul_nuw_nsw__nuw_is_safe_combined := by
  unfold test_mul_nuw_nsw__nuw_is_safe_before test_mul_nuw_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nuw__nuw_is_safe   : test_mul_nuw__nuw_is_safe_before  ⊑  test_mul_nuw__nuw_is_safe_combined := by
  unfold test_mul_nuw__nuw_is_safe_before test_mul_nuw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nsw__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul_nsw__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nsw__nuw_is_safe   : test_mul_nsw__nuw_is_safe_before  ⊑  test_mul_nsw__nuw_is_safe_combined := by
  unfold test_mul_nsw__nuw_is_safe_before test_mul_nsw__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul__nuw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul__nuw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(268435457 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.and %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nuw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul__nuw_is_safe   : test_mul__nuw_is_safe_before  ⊑  test_mul__nuw_is_safe_combined := by
  unfold test_mul__nuw_is_safe_before test_mul__nuw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nuw_nsw__nsw_is_safe   : test_mul_nuw_nsw__nsw_is_safe_before  ⊑  test_mul_nuw_nsw__nsw_is_safe_combined := by
  unfold test_mul_nuw_nsw__nsw_is_safe_before test_mul_nuw_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nuw__nsw_is_safe   : test_mul_nuw__nsw_is_safe_before  ⊑  test_mul_nuw__nsw_is_safe_combined := by
  unfold test_mul_nuw__nsw_is_safe_before test_mul_nuw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nsw__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul_nsw__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul_nsw__nsw_is_safe   : test_mul_nsw__nsw_is_safe_before  ⊑  test_mul_nsw__nsw_is_safe_combined := by
  unfold test_mul_nsw__nsw_is_safe_before test_mul_nsw__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul__nsw_is_safe_combined := [llvmfunc|
  llvm.func @test_mul__nsw_is_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-83886080 : i32) : i32
    %1 = llvm.mlir.constant(9 : i32) : i32
    %2 = llvm.or %arg0, %0  : i32
    %3 = llvm.mul %2, %1 overflow<nsw>  : i32
    llvm.return %3 : i32
  }]

theorem inst_combine_test_mul__nsw_is_safe   : test_mul__nsw_is_safe_before  ⊑  test_mul__nsw_is_safe_combined := by
  unfold test_mul__nsw_is_safe_before test_mul__nsw_is_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_mul_nuw_nsw__none_are_safe   : test_mul_nuw_nsw__none_are_safe_before  ⊑  test_mul_nuw_nsw__none_are_safe_combined := by
  unfold test_mul_nuw_nsw__none_are_safe_before test_mul_nuw_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nuw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_mul_nuw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_mul_nuw__none_are_safe   : test_mul_nuw__none_are_safe_before  ⊑  test_mul_nuw__none_are_safe_combined := by
  unfold test_mul_nuw__none_are_safe_before test_mul_nuw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul_nsw__none_are_safe_combined := [llvmfunc|
  llvm.func @test_mul_nsw__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_mul_nsw__none_are_safe   : test_mul_nsw__none_are_safe_before  ⊑  test_mul_nsw__none_are_safe_combined := by
  unfold test_mul_nsw__none_are_safe_before test_mul_nsw__none_are_safe_combined
  simp_alive_peephole
  sorry
def test_mul__none_are_safe_combined := [llvmfunc|
  llvm.func @test_mul__none_are_safe(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(9 : i32) : i32
    %1 = llvm.mul %arg0, %0  : i32
    llvm.return %1 : i32
  }]

theorem inst_combine_test_mul__none_are_safe   : test_mul__none_are_safe_before  ⊑  test_mul__none_are_safe_combined := by
  unfold test_mul__none_are_safe_before test_mul__none_are_safe_combined
  simp_alive_peephole
  sorry
