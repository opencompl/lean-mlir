/-!
  This file was originally intended to showcase a `failed to generate splitter` error.
  In the process of minimization, that error dissapeared.
  Instead, we triggered an infinite loop
-/


inductive Ty
  | nat

def Ctxt : Type :=
  List Ty


def Ctxt.Var (Γ : Ctxt) (t : Ty) : Type :=
  { i : Nat // Γ.get? i = some t }


def matchVar {t : Ty} : {Δ : Ctxt} → Δ.Var t → Option Bool
  | _::Δ, ⟨w+1, h⟩ => -- w† = Var.toSnoc w
      let w : Ctxt.Var Δ t := ⟨w, by simp_all[List.get?]⟩
      matchVar w
  | _, _ =>
      none


example {Δ : Ctxt } {w : Δ.Var t} :
  matchVar w = none
    := by
        -- uncommenting the `unfold` triggers an infinite loop of sorts,
        -- consuming 100% CPU without being caught by `maxHeartbeats` timeout
        -- unfold matchVar
        sorry