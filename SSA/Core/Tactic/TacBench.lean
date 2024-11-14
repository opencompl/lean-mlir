/-
Released under Apache 2.0 license as described in the file LICENSE.

This file adds a new tactic, `tac_bench name:str T` which will log the success or failure of the tactic
on the goal, leaving the goal unchanged.

References:

- `bv_compare` from Leanwuzla for running tactics: https://github.com/hargoniX/Leanwuzla/blob/4df0b4721bedcf0d3adad9818640773eef777ea7/Leanwuzla.lean#L437

Authors: Siddharth Bhat
-/
import Lean
open Lean.Parser.Tactic
open Lean Meta Elab Tactic
open Lean.Meta

syntax (name := tacBench) "tac_bench" str tacticSeq : tactic

def setTraceOptions (opt : Options) : Options := opt
    |>.setBool `trace.profiler true
    |>.setBool `trace.Meta.Tactic.bv true
    |>.setBool `trace.Meta.Tactic.sat true
    |>.setNat `trace.profiler.threshold 1

def withFreshTraceState {α : Type} (x : TacticM α) : TacticM α := do
    let traces ← getTraceState
    resetTraceState
    try x finally setTraceState traces

inductive Result
| ok (time : Float)
| err (time : Float) (e : Exception)

def Nat.deltaInMs (now past : Nat) : Float := (Float.ofNat <| now - past) / 1000000.0

def hermeticRun (g : MVarId) (tac : Syntax) : TacticM Result := g.withContext do
  let t1 ← IO.monoNanosNow
  try
    -- TODO: think if we need this, I'm just stealing from Henrik at this point.
    -- We can configure more options here to enable/disable tracing as needed.
    withOptions setTraceOptions <| withoutModifyingEnv <| withoutModifyingState <| withFreshTraceState do
      evalTactic tac
      let t2 ← IO.monoNanosNow
      return .ok (Nat.deltaInMs t2 t1)
  catch e =>
    let t2 ← IO.monoNanosNow
    return .err (Nat.deltaInMs t2 t1) e



@[tactic tacBench]
def evalTacBench : Tactic := fun
| `(tactic| tac_bench $name:str $tac:tactic) => do
    let g ← getMainGoal
    match ← hermeticRun g tac with
    | .ok tms =>
      logInfo m!"TACBENCH {name} PASS, TIME_ELAPSED {tms} ms, "
    | .err tms e =>
      logInfo m!"TACBENCH {name} FAIL, TIME_ELAPSED {tms} ms, {indentD e.toMessageData}"

| _ => throwUnsupportedSyntax


section Examples
theorem eg1 : 1 = 1 := by
  tac_bench "rfl" rfl
  tac_bench "wrong" (rw [Nat.add_comm])
  tac_bench "success" simp
  tac_bench "done" done
  tac_bench "sorry" sorry
  sorry
theorem eg2 (x y : BitVec 8) : x * y = y * x := by
  tac_bench "bv_decide" bv_decide
  tac_bench "ac_nf" ac_nf
  sorry

end Examples


