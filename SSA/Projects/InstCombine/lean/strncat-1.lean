import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  strncat-1
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.constant(dense<0> : tensor<1xi8>) : !llvm.array<1 x i8>
    %6 = llvm.mlir.addressof @null : !llvm.ptr
    %7 = llvm.mlir.constant(42 : i32) : i32
    %8 = llvm.mlir.constant("\00hello\00") : !llvm.array<7 x i8>
    %9 = llvm.mlir.addressof @null_hello : !llvm.ptr
    %10 = llvm.mlir.constant(0 : i32) : i32
    %11 = llvm.alloca %0 x !llvm.array<1024 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

    llvm.store %1, %11 {alignment = 1 : i64} : i8, !llvm.ptr]

    %12 = llvm.call @strncat(%11, %3, %4) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    %13 = llvm.call @strncat(%12, %6, %7) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    %14 = llvm.call @strncat(%13, %9, %7) : (!llvm.ptr, !llvm.ptr, i32) -> !llvm.ptr
    %15 = llvm.call @puts(%14) : (!llvm.ptr) -> i32
    llvm.return %10 : i32
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant("hello\00") : !llvm.array<6 x i8>
    %3 = llvm.mlir.addressof @hello : !llvm.ptr
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.alloca %0 x !llvm.array<1024 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.store %1, %6 {alignment = 1 : i64} : i8, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %7 = llvm.call @strlen(%6) : (!llvm.ptr) -> i32
    %8 = llvm.getelementptr inbounds %6[%7] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    "llvm.intr.memcpy"(%8, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    %9 = llvm.call @puts(%6) : (!llvm.ptr) -> i32
    llvm.return %5 : i32
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
