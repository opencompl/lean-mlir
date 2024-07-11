import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  all-bits-shift
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main() -> _before := [llvmfunc|
  llvm.func @main() -> (i32 {llvm.signext}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.mlir.addressof @a : !llvm.ptr
    %5 = llvm.mlir.constant(2072 : i32) : i32
    %6 = llvm.mlir.constant(7 : i32) : i32
    %7 = llvm.mlir.constant(1 : i32) : i32
    %8 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %9 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %10 = llvm.icmp "eq" %9, %3 : i32
    %11 = llvm.zext %10 : i1 to i32
    %12 = llvm.lshr %5, %11  : i32
    %13 = llvm.lshr %12, %6  : i32
    %14 = llvm.and %13, %7  : i32
    %15 = llvm.load %8 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %16 = llvm.or %14, %15  : i32
    llvm.store %16, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    %17 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32]

    %18 = llvm.icmp "eq" %17, %3 : i32
    %19 = llvm.zext %18 : i1 to i32
    %20 = llvm.lshr %5, %19  : i32
    %21 = llvm.lshr %20, %6  : i32
    %22 = llvm.and %21, %7  : i32
    %23 = llvm.or %22, %16  : i32
    llvm.store %23, %8 {alignment = 4 : i64} : i32, !llvm.ptr]

    llvm.return %23 : i32
  }]

def main() -> _combined := [llvmfunc|
  llvm.func @main() -> (i32 {llvm.signext}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(15 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr
    %2 = llvm.mlir.addressof @b : !llvm.ptr
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }]

theorem inst_combine_main() ->    : main() -> _before  ⊑  main() -> _combined := by
  unfold main() -> _before main() -> _combined
  simp_alive_peephole
  sorry
