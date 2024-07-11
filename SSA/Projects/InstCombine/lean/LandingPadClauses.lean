import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  LandingPadClauses
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def foo_generic_before := [llvmfunc|
  llvm.func @foo_generic() attributes {personality = @generic_personality} {
    %0 = llvm.mlir.addressof @T1 : !llvm.ptr
    %1 = llvm.mlir.addressof @T2 : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %3 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %4 = llvm.insertvalue %0, %3[0] : !llvm.array<1 x ptr> 
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.array<3 x ptr>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.array<3 x ptr> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.array<3 x ptr> 
    %9 = llvm.insertvalue %5, %8[2] : !llvm.array<3 x ptr> 
    %10 = llvm.mlir.undef : !llvm.array<3 x ptr>
    %11 = llvm.insertvalue %0, %10[0] : !llvm.array<3 x ptr> 
    %12 = llvm.insertvalue %1, %11[1] : !llvm.array<3 x ptr> 
    %13 = llvm.insertvalue %1, %12[2] : !llvm.array<3 x ptr> 
    %14 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %15 = llvm.insertvalue %1, %14[0] : !llvm.array<2 x ptr> 
    %16 = llvm.insertvalue %0, %15[1] : !llvm.array<2 x ptr> 
    %17 = llvm.mlir.addressof @T3 : !llvm.ptr
    %18 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %19 = llvm.insertvalue %0, %18[0] : !llvm.array<2 x ptr> 
    %20 = llvm.insertvalue %5, %19[1] : !llvm.array<2 x ptr> 
    %21 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %22 = llvm.insertvalue %5, %21[0] : !llvm.array<1 x ptr> 
    llvm.invoke @bar() to ^bb1 unwind ^bb10 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb11 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb12 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb13 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.invoke @bar() to ^bb5 unwind ^bb14 : () -> ()
  ^bb5:  // pred: ^bb4
    llvm.invoke @bar() to ^bb6 unwind ^bb15 : () -> ()
  ^bb6:  // pred: ^bb5
    llvm.invoke @bar() to ^bb7 unwind ^bb16 : () -> ()
  ^bb7:  // pred: ^bb6
    llvm.invoke @bar() to ^bb8 unwind ^bb17 : () -> ()
  ^bb8:  // pred: ^bb7
    llvm.invoke @bar() to ^bb9 unwind ^bb18 : () -> ()
  ^bb9:  // pred: ^bb8
    llvm.return
  ^bb10:  // pred: ^bb0
    %23 = llvm.landingpad (catch %0 : !llvm.ptr) (catch %1 : !llvm.ptr) (catch %0 : !llvm.ptr) (catch %1 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb11:  // pred: ^bb1
    %24 = llvm.landingpad (filter %2 : !llvm.array<0 x ptr>) (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb12:  // pred: ^bb2
    %25 = llvm.landingpad (catch %0 : !llvm.ptr) (filter %4 : !llvm.array<1 x ptr>) (catch %1 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb13:  // pred: ^bb3
    %26 = llvm.landingpad (filter %9 : !llvm.array<3 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb14:  // pred: ^bb4
    %27 = llvm.landingpad (catch %0 : !llvm.ptr) (filter %13 : !llvm.array<3 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb15:  // pred: ^bb5
    %28 = llvm.landingpad (filter %16 : !llvm.array<2 x ptr>) (filter %4 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb16:  // pred: ^bb6
    %29 = llvm.landingpad (filter %4 : !llvm.array<1 x ptr>) (catch %17 : !llvm.ptr) (filter %16 : !llvm.array<2 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb17:  // pred: ^bb7
    %30 = llvm.landingpad (filter %20 : !llvm.array<2 x ptr>) (filter %22 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb18:  // pred: ^bb8
    %31 = llvm.landingpad cleanup (filter %2 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

def foo_cxx_before := [llvmfunc|
  llvm.func @foo_cxx() attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.addressof @T1 : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %3 = llvm.insertvalue %0, %2[0] : !llvm.array<1 x ptr> 
    %4 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %5 = llvm.insertvalue %1, %4[0] : !llvm.array<2 x ptr> 
    %6 = llvm.insertvalue %0, %5[1] : !llvm.array<2 x ptr> 
    llvm.invoke @bar() to ^bb1 unwind ^bb5 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb6 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb7 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb8 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.return
  ^bb5:  // pred: ^bb0
    %7 = llvm.landingpad (catch %0 : !llvm.ptr) (catch %1 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb6:  // pred: ^bb1
    %8 = llvm.landingpad (filter %3 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb7:  // pred: ^bb2
    %9 = llvm.landingpad (filter %6 : !llvm.array<2 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb8:  // pred: ^bb3
    %10 = llvm.landingpad cleanup (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

def foo_objc_before := [llvmfunc|
  llvm.func @foo_objc() attributes {personality = @__objc_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.addressof @T1 : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %3 = llvm.insertvalue %0, %2[0] : !llvm.array<1 x ptr> 
    %4 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %5 = llvm.insertvalue %1, %4[0] : !llvm.array<2 x ptr> 
    %6 = llvm.insertvalue %0, %5[1] : !llvm.array<2 x ptr> 
    llvm.invoke @bar() to ^bb1 unwind ^bb5 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb6 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb7 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb8 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.return
  ^bb5:  // pred: ^bb0
    %7 = llvm.landingpad (catch %0 : !llvm.ptr) (catch %1 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb6:  // pred: ^bb1
    %8 = llvm.landingpad (filter %3 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb7:  // pred: ^bb2
    %9 = llvm.landingpad (filter %6 : !llvm.array<2 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb8:  // pred: ^bb3
    %10 = llvm.landingpad cleanup (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

def foo_seh_before := [llvmfunc|
  llvm.func @foo_seh() attributes {personality = @__C_specific_handler} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.addressof @T1 : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %3 = llvm.insertvalue %0, %2[0] : !llvm.array<1 x ptr> 
    %4 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %5 = llvm.insertvalue %1, %4[0] : !llvm.array<2 x ptr> 
    %6 = llvm.insertvalue %0, %5[1] : !llvm.array<2 x ptr> 
    llvm.invoke @bar() to ^bb1 unwind ^bb5 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb6 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb7 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb8 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.return
  ^bb5:  // pred: ^bb0
    %7 = llvm.landingpad (catch %0 : !llvm.ptr) (catch %1 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb6:  // pred: ^bb1
    %8 = llvm.landingpad (filter %3 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb7:  // pred: ^bb2
    %9 = llvm.landingpad (filter %6 : !llvm.array<2 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb8:  // pred: ^bb3
    %10 = llvm.landingpad cleanup (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

def foo_generic_combined := [llvmfunc|
  llvm.func @foo_generic() attributes {personality = @generic_personality} {
    %0 = llvm.mlir.addressof @T1 : !llvm.ptr
    %1 = llvm.mlir.addressof @T2 : !llvm.ptr
    %2 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %3 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %4 = llvm.insertvalue %0, %3[0] : !llvm.array<1 x ptr> 
    %5 = llvm.mlir.zero : !llvm.ptr
    %6 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.array<1 x ptr> 
    %8 = llvm.mlir.undef : !llvm.array<2 x ptr>
    %9 = llvm.insertvalue %0, %8[0] : !llvm.array<2 x ptr> 
    %10 = llvm.insertvalue %1, %9[1] : !llvm.array<2 x ptr> 
    %11 = llvm.mlir.addressof @T3 : !llvm.ptr
    llvm.invoke @bar() to ^bb1 unwind ^bb10 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb11 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb12 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb13 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.invoke @bar() to ^bb5 unwind ^bb14 : () -> ()
  ^bb5:  // pred: ^bb4
    llvm.invoke @bar() to ^bb6 unwind ^bb15 : () -> ()
  ^bb6:  // pred: ^bb5
    llvm.invoke @bar() to ^bb7 unwind ^bb16 : () -> ()
  ^bb7:  // pred: ^bb6
    llvm.invoke @bar() to ^bb8 unwind ^bb17 : () -> ()
  ^bb8:  // pred: ^bb7
    llvm.invoke @bar() to ^bb9 unwind ^bb18 : () -> ()
  ^bb9:  // pred: ^bb8
    llvm.return
  ^bb10:  // pred: ^bb0
    %12 = llvm.landingpad (catch %0 : !llvm.ptr) (catch %1 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb11:  // pred: ^bb1
    %13 = llvm.landingpad (filter %2 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb12:  // pred: ^bb2
    %14 = llvm.landingpad (catch %0 : !llvm.ptr) (filter %4 : !llvm.array<1 x ptr>) (catch %1 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb13:  // pred: ^bb3
    %15 = llvm.landingpad (filter %7 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb14:  // pred: ^bb4
    %16 = llvm.landingpad (catch %0 : !llvm.ptr) (filter %10 : !llvm.array<2 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb15:  // pred: ^bb5
    %17 = llvm.landingpad (filter %4 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb16:  // pred: ^bb6
    %18 = llvm.landingpad (filter %4 : !llvm.array<1 x ptr>) (catch %11 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb17:  // pred: ^bb7
    %19 = llvm.landingpad (filter %7 : !llvm.array<1 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb18:  // pred: ^bb8
    %20 = llvm.landingpad (filter %2 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

theorem inst_combine_foo_generic   : foo_generic_before  ⊑  foo_generic_combined := by
  unfold foo_generic_before foo_generic_combined
  simp_alive_peephole
  sorry
def foo_cxx_combined := [llvmfunc|
  llvm.func @foo_cxx() attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.invoke @bar() to ^bb1 unwind ^bb5 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb6 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb7 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb8 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.return
  ^bb5:  // pred: ^bb0
    %1 = llvm.landingpad (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb6:  // pred: ^bb1
    %2 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb7:  // pred: ^bb2
    %3 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb8:  // pred: ^bb3
    %4 = llvm.landingpad (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

theorem inst_combine_foo_cxx   : foo_cxx_before  ⊑  foo_cxx_combined := by
  unfold foo_cxx_before foo_cxx_combined
  simp_alive_peephole
  sorry
def foo_objc_combined := [llvmfunc|
  llvm.func @foo_objc() attributes {personality = @__objc_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.invoke @bar() to ^bb1 unwind ^bb5 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb6 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb7 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb8 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.return
  ^bb5:  // pred: ^bb0
    %1 = llvm.landingpad (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb6:  // pred: ^bb1
    %2 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb7:  // pred: ^bb2
    %3 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb8:  // pred: ^bb3
    %4 = llvm.landingpad (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

theorem inst_combine_foo_objc   : foo_objc_before  ⊑  foo_objc_combined := by
  unfold foo_objc_before foo_objc_combined
  simp_alive_peephole
  sorry
def foo_seh_combined := [llvmfunc|
  llvm.func @foo_seh() attributes {personality = @__C_specific_handler} {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.invoke @bar() to ^bb1 unwind ^bb5 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.invoke @bar() to ^bb2 unwind ^bb6 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.invoke @bar() to ^bb3 unwind ^bb7 : () -> ()
  ^bb3:  // pred: ^bb2
    llvm.invoke @bar() to ^bb4 unwind ^bb8 : () -> ()
  ^bb4:  // pred: ^bb3
    llvm.return
  ^bb5:  // pred: ^bb0
    %1 = llvm.landingpad (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb6:  // pred: ^bb1
    %2 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb7:  // pred: ^bb2
    %3 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  ^bb8:  // pred: ^bb3
    %4 = llvm.landingpad (catch %0 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

theorem inst_combine_foo_seh   : foo_seh_before  ⊑  foo_seh_combined := by
  unfold foo_seh_before foo_seh_combined
  simp_alive_peephole
  sorry
