/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Qq
import SSA.Projects.SLLVM.Meta.OfExpr
import SSA.Projects.SLLVM.Dialect.Semantics

namespace StructuredLLVM

def NatOrFVar.toExpr : NatOrFVar → Lean.Expr
  | .inl n      => Lean.mkNatLit n
  | .inr fvarId => Lean.Expr.fvar fvarId

namespace Meta
open Lean Elab Tactic
open Qq

#check Com.denote

structure MetaIntW where
  isPoisonExpr : Expr
  valueExpr : Expr

structure MetaDenoteResult where
  value : MetaIntW
  -- TODO: we also ought to construct some proof that `value` is indeed equal
  --       to whatever we're denoting.

structure MetaValuation (Γ : Ctxt MetaSLLVM.Ty) where
  values : Vector MetaIntW Γ.length

instance : GetElem (MetaValuation Γ) (Γ.Var t) MetaIntW (fun _ _ => True) where
  getElem V x _ := V.values[x.1]'(by sorry)

def MetaValuation.push {Γ : Ctxt MetaSLLVM.Ty}
    (V : MetaValuation Γ) (w : NatOrFVar) (x : MetaIntW) :
    MetaValuation (Γ.snoc <| .bitvec w) :=
  ⟨V.1.push x⟩

def metaDenoteExpr {Γ : Ctxt MetaSLLVM.Ty} {eff} {t}
    (V : MetaValuation Γ) :
    Expr MetaSLLVM Γ eff t → Option MetaDenoteResult
  | ⟨.bv_add w, _ty_eq, _eff_le, x₁ ::ₕ (x₂ ::ₕ .nil), .nil⟩ =>
      let isPoison₁ : Q(Bool) := V[x₁].isPoisonExpr
      let isPoison₂ : Q(Bool) := V[x₂].isPoisonExpr
      have w : Q(Nat) := w.toExpr
      let value₁ : Q(BitVec $w) := V[x₁].valueExpr
      let value₂ : Q(BitVec $w) := V[x₂].valueExpr

      let isPoisonExpr := q($isPoison₁ || $isPoison₂)
      let valueExpr := q($value₁ + $value₂)
      some ⟨{ isPoisonExpr, valueExpr }⟩
  | ⟨op, _, _, _, _⟩ => none

def metaDenoteCom {Γ : Ctxt MetaSLLVM.Ty} {eff} {t}
    (V : MetaValuation Γ) :
    Com MetaSLLVM Γ eff t → Option MetaDenoteResult
  | .ret x => some ⟨V[x]⟩
  | .var (α := SLLVM.PreTy.bitvec w) e body => do
      let ⟨eVal⟩ ← metaDenoteExpr V e
      let V := V.push w eVal
      metaDenoteCom V body
  | _ => none

simproc reduceComDenote (Com.denote (d := SLLVM) _) := fun e => do
  let_expr Com.denote _d _sig _tyDen _den _mon _Γ _eff _t com := e
    | return .continue

  logInfo "Bla!"
  return .continue

-- elab "print_com" : tactic => withMainContext <| do
--   let goal ← getMainTarget
--   let some ⟨_α, lhs, rhs⟩ := goal.eq?
--     | return ()
--   let mut lhs := lhs
--   if lhs.isAppOf ``Com.denote then
--     match lhs.getAppArgs[9]? with
--       | some x => lhs := x
--       | none => return ()
--   else
--     return ()

--   let ⟨Γ , eff, ty, lhsCom⟩ ← Meta.comOfExpr lhs
--   logInfo m!"{repr lhsCom}"
--   return ()
