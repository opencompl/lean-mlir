import SSA.Projects.InstCombine.LLVM.PrettyEDSL
import SSA.Projects.InstCombine.AliveStatements
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic
open MLIR AST
open Std (BitVec)
open Ctxt (Var)
namespace  2008-05-09-SinkOfInvoke
set_option pp.proofs false
set_option pp.proofs.withType false
set_option linter.deprecated false
def _ZNSt5ctypeIcEC2EPiPKtbm_before := [llvmfunc|
  llvm.func @_ZNSt5ctypeIcEC2EPiPKtbm(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: !llvm.ptr, %arg3: i8 {llvm.zeroext}, %arg4: i64) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(4 : i32) : i32
    %2 = llvm.invoke @_ZNSt6locale5facet15_S_get_c_localeEv() to ^bb1 unwind ^bb4 : () -> !llvm.ptr
  ^bb1:  // pred: ^bb0
    %3 = llvm.invoke @__ctype_toupper_loc() to ^bb2 unwind ^bb4 : () -> !llvm.ptr
  ^bb2:  // pred: ^bb1
    %4 = llvm.invoke @__ctype_tolower_loc() to ^bb3 unwind ^bb4 : () -> !llvm.ptr
  ^bb3:  // pred: ^bb2
    %5 = llvm.load %4 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr]

    %6 = llvm.getelementptr %arg0[%0, 4] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<"struct.std::ctype<char>", (struct<"struct.std::locale::facet", (ptr, i32)>, ptr, i8, ptr, ptr, ptr, i8, array<256 x i8>, array<256 x i8>, i8)>
    llvm.store %5, %6 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr]

    llvm.return
  ^bb4:  // 3 preds: ^bb0, ^bb1, ^bb2
    %7 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.unreachable
  }]

