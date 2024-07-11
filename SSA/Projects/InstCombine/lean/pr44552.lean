import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  pr44552
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def main_before := [llvmfunc|
  llvm.func @main() -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @csmith_sink_ : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.addressof @g_313_0 : !llvm.ptr
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.mlir.addressof @g_313_1 : !llvm.ptr
    %6 = llvm.mlir.addressof @g_313_2 : !llvm.ptr
    %7 = llvm.mlir.addressof @g_313_3 : !llvm.ptr
    %8 = llvm.mlir.addressof @g_313_4 : !llvm.ptr
    %9 = llvm.mlir.addressof @g_313_5 : !llvm.ptr
    %10 = llvm.mlir.addressof @g_313_6 : !llvm.ptr
    %11 = llvm.mlir.undef : !llvm.struct<"struct.S3", (i64)>
    %12 = llvm.insertvalue %0, %11[0] : !llvm.struct<"struct.S3", (i64)> 
    %13 = llvm.mlir.addressof @g_316 : !llvm.ptr
    %14 = llvm.mlir.addressof @g_316_1_0 : !llvm.ptr
    llvm.store %0, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %15 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %16 = llvm.sext %15 : i16 to i64
    llvm.store %16, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %17 = llvm.load %5 {alignment = 1 : i64} : !llvm.ptr -> i32]

    %18 = llvm.zext %17 : i32 to i64
    llvm.store %18, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %19 = llvm.load %6 {alignment = 1 : i64} : !llvm.ptr -> i32]

    %20 = llvm.sext %19 : i32 to i64
    llvm.store %20, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %21 = llvm.load %7 {alignment = 1 : i64} : !llvm.ptr -> i32]

    %22 = llvm.zext %21 : i32 to i64
    llvm.store %22, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %23 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %24 = llvm.sext %23 : i16 to i64
    llvm.store %24, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %25 = llvm.load %9 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %26 = llvm.sext %25 : i16 to i64
    llvm.store %26, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %27 = llvm.load %10 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %28 = llvm.sext %27 : i16 to i64
    llvm.store %28, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %29 = llvm.load %13 {alignment = 1 : i64} : !llvm.ptr -> i64]

    llvm.store %29, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    %30 = llvm.load %14 {alignment = 1 : i64} : !llvm.ptr -> i16]

    %31 = llvm.sext %30 : i16 to i64
    llvm.store %31, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    llvm.store %0, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

    llvm.return %2 : i16
  }]

def main_combined := [llvmfunc|
  llvm.func @main() -> i16 {
    %0 = llvm.mlir.constant(0 : i64) : i64
    %1 = llvm.mlir.addressof @csmith_sink_ : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i16) : i16
    llvm.store %0, %1 {alignment = 1 : i64} : i64, !llvm.ptr]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
    llvm.return %2 : i16
  }]

theorem inst_combine_main   : main_before  ⊑  main_combined := by
  unfold main_before main_combined
  simp_alive_peephole
  sorry
