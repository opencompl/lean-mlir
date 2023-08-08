/-!
  This file was originally intended to showcase a `failed to generate splitter` error.
  In the process of minimization, that error dissapeared.
  Instead, we triggered an infinite loop
-/



inductive Ty
  | nat

def Ctxt : Type :=
  List Ty

def Ctxt.Var.IsValid (Γ : Ctxt) (t : Ty) (i : Nat) : Prop :=
  Γ.get? i = some t

def Ctxt.Var (Γ : Ctxt) (t : Ty) : Type :=
  { i : Nat // Var.IsValid Γ t i }  

def Ctxt.Var.IsValid.ofSucc :
    IsValid (u :: Γ) t (i+1) → IsValid Γ t i := by
  simp[IsValid, List.get?]
  exact id


def matchVar {t : Ty} : {Δ : Ctxt} → Δ.Var t → Option Bool 
  | _::_, ⟨w+1, h⟩ => -- w† = Var.toSnoc w
      matchVar ⟨w, .ofSucc h⟩
  | _, _ =>
      none


example {Δ : Ctxt } {w : Δ.Var t} : 
  matchVar w = none
    := by
        -- uncommenting the `unfold` triggers an infinite loop of sorts, 
        -- consuming 100% CPU without being caught by `maxHeartbeats` timeout
        -- unfold matchVar
        sorry