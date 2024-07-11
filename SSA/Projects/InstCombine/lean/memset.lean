import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  memset
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def test_before := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    "llvm.intr.memset"(%arg0, %0, %2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    "llvm.intr.memset"(%arg0, %0, %3) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    "llvm.intr.memset"(%arg0, %0, %4) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    "llvm.intr.memset"(%arg0, %0, %5) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return %1 : i32
  }]

def memset_to_constant_before := [llvmfunc|
  llvm.func @memset_to_constant() {
    %0 = llvm.mlir.addressof @Unknown : !llvm.ptr
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memset"(%0, %1, %2) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return
  }]

def memset_undef_before := [llvmfunc|
  llvm.func @memset_undef(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return
  }]

def memset_undef_volatile_before := [llvmfunc|
  llvm.func @memset_undef_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return
  }]

def memset_poison_before := [llvmfunc|
  llvm.func @memset_poison(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return
  }]

def memset_poison_volatile_before := [llvmfunc|
  llvm.func @memset_poison_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()]

    llvm.return
  }]

def test_combined := [llvmfunc|
  llvm.func @test(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(257 : i16) : i16
    %2 = llvm.mlir.constant(16843009 : i32) : i32
    %3 = llvm.mlir.constant(72340172838076673 : i64) : i64
    %4 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    llvm.store %1, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr
    llvm.store %2, %arg0 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %3, %arg0 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return %4 : i32
  }]

theorem inst_combine_test   : test_before  ⊑  test_combined := by
  unfold test_before test_combined
  simp_alive_peephole
  sorry
def memset_to_constant_combined := [llvmfunc|
  llvm.func @memset_to_constant() {
    llvm.return
  }]

theorem inst_combine_memset_to_constant   : memset_to_constant_before  ⊑  memset_to_constant_combined := by
  unfold memset_to_constant_before memset_to_constant_combined
  simp_alive_peephole
  sorry
def memset_undef_combined := [llvmfunc|
  llvm.func @memset_undef(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_memset_undef   : memset_undef_before  ⊑  memset_undef_combined := by
  unfold memset_undef_before memset_undef_combined
  simp_alive_peephole
  sorry
def memset_undef_volatile_combined := [llvmfunc|
  llvm.func @memset_undef_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.undef : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }]

theorem inst_combine_memset_undef_volatile   : memset_undef_volatile_before  ⊑  memset_undef_volatile_combined := by
  unfold memset_undef_volatile_before memset_undef_volatile_combined
  simp_alive_peephole
  sorry
def memset_poison_combined := [llvmfunc|
  llvm.func @memset_poison(%arg0: !llvm.ptr) {
    llvm.return
  }]

theorem inst_combine_memset_poison   : memset_poison_before  ⊑  memset_poison_combined := by
  unfold memset_poison_before memset_poison_combined
  simp_alive_peephole
  sorry
def memset_poison_volatile_combined := [llvmfunc|
  llvm.func @memset_poison_volatile(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.poison : i8
    %1 = llvm.mlir.constant(8 : i32) : i32
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = true}> : (!llvm.ptr, i8, i32) -> ()
    llvm.return
  }]

theorem inst_combine_memset_poison_volatile   : memset_poison_volatile_before  ⊑  memset_poison_volatile_combined := by
  unfold memset_poison_volatile_before memset_poison_volatile_combined
  simp_alive_peephole
  sorry
