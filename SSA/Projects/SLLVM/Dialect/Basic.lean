/-
Released under Apache 2.0 license as described in the file LICENSE.
-/

import LeanMLIR.Framework.Macro

import LeanMLIR.Dialects.LLVM.Basic
import SSA.Projects.SLLVM.Dialect.Semantics

namespace LeanMLIR
open InstCombine (LLVM)

/-!
## SLLVM Dialect
SLLVM stands for "Structured LLVM"; eventually this dialect will become a
formalization of the `ptr + arith + scf` MLIR dialects.
This IR is conceptually similar to LLVM IR, except it uses only *structured*
control flow, hence the name.

Note that in the formalization, we assume a 64-bit architecture!
Nothing in the formalization itself should depend on the exact pointer-width,
but this assumption does affect which optimizations are admitted.

For now, though, this dialect just models only arithmetic, just like our
existing LLVM dialect, *but* it refines the semantics to include a proper model
of (side-effecting) UB.
-/

/-! ### Dialect definition -/

inductive SLLVMOp where
  | arith (o : LLVM.Op)
  | ptradd
  | load (w : Nat)
  | store (w : Nat)
  deriving DecidableEq, Lean.ToExpr

inductive SLLVMTy where
  | arith (t : LLVM.Ty)
  | ptr
  deriving DecidableEq, Lean.ToExpr

def SLLVM : Dialect where
  Op := SLLVMOp
  Ty := SLLVMTy
  m := EffectM

namespace SLLVM

instance : TyDenote SLLVM.Ty where
  toType
  | .arith t => ⟦t⟧
  | .ptr => SLLVM.Ptr

instance : DecidableEq SLLVM.Op := by unfold SLLVM; infer_instance
instance : DecidableEq SLLVM.Ty := by unfold SLLVM; infer_instance
instance : Lean.ToExpr SLLVM.Op := by unfold SLLVM; infer_instance
instance : Lean.ToExpr SLLVM.Ty := by unfold SLLVM; infer_instance

-- instance : ToString SLLVM.Op    := by unfold SLLVM; infer_instance
-- instance : ToString SLLVM.Ty    := by unfold SLLVM; infer_instance
-- instance : Repr SLLVM.Op        := by unfold SLLVM; infer_instance
-- instance : Repr SLLVM.Ty        := by unfold SLLVM; infer_instance

instance : Monad SLLVM.m        := by unfold SLLVM; infer_instance
instance : LawfulMonad SLLVM.m  := by unfold SLLVM; infer_instance

open Qq in instance : DialectToExpr SLLVM where
  toExprDialect := q(SLLVM)
  toExprM := q(Id.{0})

@[simp, simp_denote]
theorem m_eq : SLLVM.m α = EffectM α := by rfl

/-! ### Aliasses -/
section Alias
open InstCombine.LLVM SLLVMOp

@[match_pattern] nonrec abbrev Ty.arith : LLVM.Ty → SLLVM.Ty := .arith

@[match_pattern] abbrev Ty.bitvec (w : Nat) : SLLVM.Ty := .arith (.bitvec w)
@[match_pattern] abbrev Ty.ptr : SLLVM.Ty := .ptr

@[match_pattern] nonrec abbrev Op.arith : LLVM.Op → SLLVM.Op := .arith

@[match_pattern] nonrec abbrev Op.neg (w : Nat) : SLLVM.Op := arith <| Op.neg w
@[match_pattern] nonrec abbrev Op.not (w : Nat) : SLLVM.Op := arith <| Op.not w
@[match_pattern] nonrec abbrev Op.copy (w : Nat) : SLLVM.Op := arith <| Op.copy w
@[match_pattern] nonrec abbrev Op.sext (w w' : Nat) : SLLVM.Op := arith <| Op.sext w w'
@[match_pattern] nonrec abbrev Op.zext (w w' : Nat) (flag : LLVM.NonNegFlag := { }) : SLLVM.Op := arith <| Op.zext w w' flag
@[match_pattern] nonrec abbrev Op.trunc (w w' : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.trunc w w' flags

@[match_pattern] nonrec abbrev Op.and (w : Nat) : SLLVM.Op := arith <| Op.and w
@[match_pattern] nonrec abbrev Op.or (w : Nat) (flag : LLVM.DisjointFlag := { }) : SLLVM.Op := arith <| Op.or w flag
@[match_pattern] nonrec abbrev Op.xor (w : Nat) : SLLVM.Op := arith <| Op.xor w
@[match_pattern] nonrec abbrev Op.shl (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.shl w flags
@[match_pattern] nonrec abbrev Op.lshr (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.lshr w flag
@[match_pattern] nonrec abbrev Op.ashr (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.ashr w flag
@[match_pattern] nonrec abbrev Op.add (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.add w flags
@[match_pattern] nonrec abbrev Op.mul (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.mul w flags
@[match_pattern] nonrec abbrev Op.sub (w : Nat) (flags : LLVM.NoWrapFlags := { }) : SLLVM.Op := arith <| Op.sub w flags

@[match_pattern] nonrec abbrev Op.icmp (c : LLVM.IntPred) (w : Nat) : SLLVM.Op := arith <| Op.icmp c w
@[match_pattern] nonrec abbrev Op.const (w : Nat) (val : Int) : SLLVM.Op := arith <| Op.const w val
@[match_pattern] nonrec abbrev Op.select (w : Nat) : SLLVM.Op := arith <| Op.select w

@[match_pattern] nonrec abbrev Op.udiv (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.udiv w flag
@[match_pattern] nonrec abbrev Op.sdiv (w : Nat) (flag : LLVM.ExactFlag := { }) : SLLVM.Op := arith <| Op.sdiv w flag
@[match_pattern] nonrec abbrev Op.urem : Nat → SLLVM.Op := arith ∘ Op.urem
@[match_pattern] nonrec abbrev Op.srem : Nat → SLLVM.Op := arith ∘ Op.srem


@[simp, simp_denote] theorem toType_arith : toType (Ty.arith t) = toType t := rfl
@[simp, simp_denote] theorem toType_bitvec : toType (Ty.bitvec w) = LLVM.IntW w := rfl

end Alias

/-! ### Signature -/

open Ty in
/- The signature of each operation is the same as in LLVM. -/
def_signature for SLLVM
  -- New operations
  | .ptradd          => (ptr, bitvec 64) -> ptr
  | .load w          => (ptr) -[.impure]-> bitvec w
  | .store w         => (ptr, bitvec w) -[.impure]-> []
  -- LLVM operations with modified effect signature
  | Op.urem w        => (bitvec w, bitvec w) -[.impure]-> bitvec w
  | Op.srem w        => (bitvec w, bitvec w) -[.impure]-> bitvec w
  | Op.sdiv w _flag  => (bitvec w, bitvec w) -[.impure]-> bitvec w
  | Op.udiv w _flag  => (bitvec w, bitvec w) -[.impure]-> bitvec w
  -- Other LLVM operations
  | Op.neg w         => (bitvec w) -> bitvec w
  | Op.not w         => (bitvec w) -> bitvec w
  | Op.copy w        => (bitvec w) -> bitvec w
  | Op.sext w w'     => (bitvec w) -> bitvec w'
  | Op.zext w w' _flag   => (bitvec w) -> bitvec w'
  | Op.trunc w w' _flags => (bitvec w) -> bitvec w'
  | Op.and w         => (bitvec w, bitvec w) -> bitvec w
  | Op.xor w         => (bitvec w, bitvec w) -> bitvec w
  | Op.or w _flag    => (bitvec w, bitvec w) -> bitvec w
  | Op.shl w _flags  => (bitvec w, bitvec w) -> bitvec w
  | Op.add w _flags  => (bitvec w, bitvec w) -> bitvec w
  | Op.mul w _flags  => (bitvec w, bitvec w) -> bitvec w
  | Op.sub w _flags  => (bitvec w, bitvec w) -> bitvec w
  | Op.lshr w _flag  => (bitvec w, bitvec w) -> bitvec w
  | Op.ashr w _flag  => (bitvec w, bitvec w) -> bitvec w
  | Op.icmp _c w     => (bitvec w, bitvec w) -> bitvec 1
  | Op.select w      => (bitvec 1, bitvec w, bitvec w) -> bitvec w
  | Op.const w _val  => () -> bitvec w

attribute [local irreducible] EffectM
-- ^^ This is needed so that `EffectM` doesn't get unfolded in the `def_denote` macro

def_denote for SLLVM
  -- New operations
  | .ptradd   => fun p x => [SLLVM.ptradd p x]ₕ
  | .load w   => fun p   => ([·]ₕ) <$> SLLVM.load p w
  | .store _  => fun p x => (fun _ => []ₕ) <$> SLLVM.store p x
  -- LLVM operations with modified effect signature
  | Op.udiv _w flag => fun x y => ([·]ₕ) <$> SLLVM.udiv x y flag
  | Op.sdiv _w flag => fun x y => ([·]ₕ) <$> SLLVM.sdiv x y flag
  | Op.urem _w      => fun x y => ([·]ₕ) <$> SLLVM.urem x y
  | Op.srem _w      => fun x y => ([·]ₕ) <$> SLLVM.srem x y
  -- Other LLVM operations
  | Op.neg _w       => fun x => [LLVM.neg x]ₕ
  | Op.not _w       => fun x => [LLVM.not x]ₕ
  | Op.copy _w      => fun x => [x]ₕ
  | Op.sext _w w'   => fun x => [LLVM.sext w' x]ₕ
  | Op.zext _w w' flag   => fun x => [LLVM.zext w' x flag]ₕ
  | Op.trunc _w w' flags => fun x => [LLVM.trunc w' x flags]ₕ
  | Op.and _w       => fun x y => [LLVM.and x y]ₕ
  | Op.xor _w       => fun x y => [LLVM.xor x y]ₕ
  | Op.or _w flag   => fun x y => [LLVM.or x y flag]ₕ
  | Op.shl _w flags => fun x y => [LLVM.shl x y flags]ₕ
  | Op.add _w flags => fun x y => [LLVM.add x y flags]ₕ
  | Op.mul _w flags => fun x y => [LLVM.mul x y flags]ₕ
  | Op.sub _w flags => fun x y => [LLVM.sub x y flags]ₕ
  | Op.lshr _w flag => fun x y => [LLVM.lshr x y flag]ₕ
  | Op.ashr _w flag => fun x y => [LLVM.ashr x y flag]ₕ
  | Op.icmp c _w    => fun x y => [LLVM.icmp c x y]ₕ
  | Op.select _w    => fun c x y => [LLVM.select c x y]ₕ
  | Op.const _w val => [LLVM.const? _ val]ₕ

/-! ### Printing -/
section Print
open DialectPrint

instance : DialectPrint SLLVM where
  printOpName
    | .arith llvmOp => printOpName llvmOp
    | .store _ => "ptr.store"
    | .load _ => "ptr.load"
    | .ptradd => "ptr.add"
  printAttributes
    | .arith llvmOp => printAttributes llvmOp
    | _ => ""
  printTy
    | .arith llvmTy => printTy llvmTy
    | .ptr => "ptr"
  dialectName := "sllvm"
  printReturn _ := "llvm.return"
  printFunc _ := "^entry"

end Print
