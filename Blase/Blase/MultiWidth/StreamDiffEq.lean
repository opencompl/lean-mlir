import Blase.Fast.Circuit
import Blase.Fast.FiniteStateMachine



inductive StreamVar (ι : Type) (npast : Nat) where
| input (i : ι) (kpast : Fin npast) 
| output (kpast : Fin npast) (h : 0 < kpast.val)
deriving DecidableEq, Repr, Hashable

instance [DecidableEq ι] : FinEnum (StreamVar ι npast) where
  card := sorry
  equiv := sorry

-- out[0] = ...
-- a stream equation, that says that out[n] is a function of the inputs ι, and the previous outputs out[0], ..., out[n-1]
-- stream differential equation with 'ι' inputs, and 
structure StreamDiffEq (ι : Type) (npast : Nat) where
  -- | Assumed values of the output for the horizon.
  outInit : (kpast : Fin npast) → (h : 0 < kpast.val) → Bool
  -- | compute output as a function of past outputs and inputs
  outCircuit : Circuit (StreamVar ι npast)


def StreamDiffEq.toStream [DecidableEq ι] (s : StreamDiffEq ι npast) (input : ι → BitStream) : BitStream := 
  let rec go (n : Nat) : Bool :=
    if n < npast then
      s.outInit (Fin.mk n (by omega)) (by omega)
    else
      let circInput : FinEnumVal (StreamVar ι npast) → Bool := 
        fun v => match v with
        | .input i kpast => input.get (n - kpast.val - 1)
        | .output kpast h => go (n - kpast.val - 1)
      s.outCircuit.eval circInput
  ⟨go⟩

def StreamDiffEq.toFSM [DecidableEq ι] [Hashable ι] (s : StreamDiffEq ι npast) : FSM ι where
  α := StreamVar ι npast
  initCarry 
    | .input i kpast => false
    | .output kpast h => s.outInit kpast (by omega)
  outputCirc := sorry
  nextStateCirc := sorry


    


