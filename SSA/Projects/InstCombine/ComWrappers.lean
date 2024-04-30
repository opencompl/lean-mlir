/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.Base

/- Wrapper around Com, Expr constructors to easily hand-write IR -/
namespace ComWrappers

macro_rules
| `(tactic| get_elem_tactic_trivial) => `(tactic| simp [Ctxt.snoc])

def const {Γ : Ctxt _} (w : ℕ) (n : ℤ) : Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.const w n)
    (ty_eq := rfl)
    (args := .nil)
    (regArgs := .nil)

def not {Γ : Ctxt _} (w : ℕ) (l : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic):
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.not w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ .nil)
    (regArgs := .nil)

def neg {Γ : Ctxt _} (w : ℕ) (l : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic):
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.neg w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ .nil)
    (regArgs := .nil)

def and {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.and w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def or {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.or w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def xor {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.xor w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def shl {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.shl w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def lshr {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.lshr w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def ashr {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.ashr w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def sub {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.sub w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def add {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.add w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def mul {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.mul w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def sdiv {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.sdiv w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def udiv {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.udiv w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def srem {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.srem w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def urem {Γ : Ctxt _} (w : ℕ) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w) :=
  Expr.mk
    (op := InstCombine.MOp.urem w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def icmp {Γ : Ctxt _} (w : ℕ) (pred : LLVM.IntPredicate) (l r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec 1) :=
  Expr.mk
    (op := InstCombine.MOp.icmp pred w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def select {Γ : Ctxt _} (w : ℕ) (l m r : Nat)
    (lp : (Ctxt.get? Γ l = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete 1)))
      := by get_elem_tactic)
    (mp : (Ctxt.get? Γ m = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic)
    (rp : (Ctxt.get? Γ r = some (InstCombine.MTy.bitvec (ConcreteOrMVar.concrete w)))
      := by get_elem_tactic) :
    Expr InstCombine.LLVM Γ (InstCombine.Ty.bitvec w)  :=
  Expr.mk
    (op := InstCombine.MOp.select w)
    (ty_eq := rfl)
    (args := .cons ⟨l, lp⟩ <| .cons ⟨m, mp⟩ <| .cons ⟨r, rp⟩ .nil)
    (regArgs := .nil)

def test (w : ℕ) :
    Com InstCombine.LLVM [InstCombine.Ty.bitvec w] (InstCombine.Ty.bitvec w) :=
  .lete (const  w 0  ) <|
  .lete (not    w 0  ) <|
  .lete (neg    w 0  ) <|
  .lete (and    w 0 0) <|
  .lete (or     w 0 0) <|
  .lete (xor    w 0 0) <|
  .lete (shl    w 0 0) <|
  .lete (lshr   w 0 0) <|
  .lete (ashr   w 0 0) <|
  .lete (sub    w 0 0) <|
  .lete (add    w 0 0) <|
  .lete (mul    w 0 0) <|
  .lete (sdiv   w 0 0) <|
  .lete (udiv   w 0 0) <|
  .lete (srem   w 0 0) <|
  .lete (urem   w 0 0) <|
  .lete (icmp   w .eq 0 0) <|
  .lete (select w 0 1 1) <|
  .ret ⟨0, by simp [Ctxt.snoc]⟩

end ComWrappers
