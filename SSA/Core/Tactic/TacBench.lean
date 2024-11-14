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

/--
Run `tac_bench <name> <tacticSeq>` to run a sequence of tactics whose runtime is benchmarked.
This does not affect the current goal state, and thus allow multiple `tac_bench` statements to be run in sequence.
-/
syntax tacBenchItem := str &":" tacticSeq
syntax (name := tacBench) "tac_bench" "["(tacBenchItem),*"]" : tactic


def setTraceOptions (opt : Options) : Options := opt
    |>.setBool `trace.profiler true
    |>.setBool `trace.Meta.Tactic.bv true
    |>.setBool `trace.Meta.Tactic.sat true
    |>.setNat `trace.profiler.threshold 1

def withFreshTraceState {α : Type} (x : TacticM α) : TacticM α := do
    let traces ← getTraceState
    resetTraceState
    try x finally setTraceState traces

def Nat.deltaInMs (now past : Nat) : Float := (Float.ofNat <| now - past) / 1000000.0

structure Item where
 name : String
 tac : Syntax


inductive Result
| ok (item : Item) (time : Float)
| err (item : Item) (time : Float) (e : Exception)


def Result.toMessageData : Result → MessageData
| .ok item timeMs => m!"TACBENCH {item.name} PASS, TIME_ELAPSED {timeMs} ms, "
| .err item timeMs e => m!"TACBENCH {item.name} FAIL, TIME_ELAPSED {timeMs} ms, {indentD e.toMessageData}"

instance : ToMessageData Result where
  toMessageData := Result.toMessageData


def hermeticRun (g : MVarId) (item : Item) : TacticM Result := g.withContext do
  let t1 ← IO.monoNanosNow
  try
    -- TODO: think if we need this, I'm just stealing from Henrik at this point.
    -- We can configure more options here to enable/disable tracing as needed.
    withOptions setTraceOptions <| withoutModifyingEnv <| withoutModifyingState <| withFreshTraceState do
      evalTactic item.tac
      let t2 ← IO.monoNanosNow
      return .ok item (Nat.deltaInMs t2 t1)
  catch e =>
    let t2 ← IO.monoNanosNow
    return .err item (Nat.deltaInMs t2 t1) e



def parseTacBenchItem : TSyntax `tacBenchItem → TacticM Item
| `(tacBenchItem| $name:str : $tac:tacticSeq) => 
     return { name := name.getString, tac := tac : Item }
| _ => throwUnsupportedSyntax


@[tactic tacBench]
def evalTacBench : Tactic := fun
| `(tactic| tac_bench [$tacBenchItems:tacBenchItem,*]) => do
    let g ← getMainGoal
    let items ← tacBenchItems.getElems.mapM parseTacBenchItem
    -- logInfo m!{← hermeticRun g tac}
    let mut msg := m!""
    for item in items do
      let out ← hermeticRun g item
      msg := msg ++ m!"\n" ++ out.toMessageData
    logInfo msg
| _ => throwUnsupportedSyntax


section Examples
theorem eg1 : 1 = 1 := by
  tac_bench ["rfl" : rfl, "wrong" : (rw [Nat.add_comm]), "success" : simp, "done" : done, "sorry" : sorry]
  sorry

theorem eg2 (x y : BitVec 8) : x * y = y * x := by
  tac_bench ["bv_decide" :  bv_decide, "ac_nf" : ac_nf]
  sorry

end Examples


