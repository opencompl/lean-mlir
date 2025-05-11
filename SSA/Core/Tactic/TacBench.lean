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

namespace TacBench

inductive Config.OutputType
| text  -- TACSTART..TACEND
| csv -- CSV
deriving Repr, DecidableEq

structure Config where
  outputType : Config.OutputType := .text
/-- Allow elaboration of `bv_automata_circuit's config` arguments to tactics. -/
declare_config_elab elabTacBenchConfig Config

/--
Run `tac_bench <name> <tacticSeq>` to run a sequence of tactics whose runtime is benchmarked.
This does not affect the current goal state, and thus allow multiple `tac_bench` statements to be run in sequence.
-/
syntax tacBenchItem := str &":" tacticSeq
syntax (name := tacBench) "tac_bench" (Lean.Parser.Tactic.config)? "["(tacBenchItem),*,?"]" : tactic


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


def csvEscapeString (s : String) : String :=
  let s := s.replace "\n" " "
  let s := s.replace "," " "
  let s := s.replace "\t" " "
  s

def Result.errorMessage (r : Result) : MessageData :=
  match r with
  | .ok .. => ""
  | .err (e := e) .. => e.toMessageData

def Result.isOk (r : Result) : Bool :=
  match r with
  | .ok .. => true
  | .err .. => false

def Result.timeElapsed (r : Result) : Float :=
  match r with
  | .ok (time := time) ..  => time
  | .err (time := time) .. => time

def Result.item (r : Result) : Item :=
  match r with
  | .ok item .. => item
  | .err item .. => item


def Result.toMessageData : Result → MessageData
| .ok item timeMs => m!"TACBENCH {item.name} PASS, TIME_ELAPSED {timeMs} ms, "
| .err item timeMs e => m!"TACBENCH {item.name} FAIL, TIME_ELAPSED {timeMs} ms, MSGSTART {indentD e.toMessageData} MSGEND"

instance : ToMessageData Result where
  toMessageData := Result.toMessageData


def hermeticRun (g : MVarId) (item : Item) : TacticM Result := g.withContext do
  let t1 ← IO.monoNanosNow
  try
    -- TODO: think if we need this, I'm just stealing from Henrik at this point.
    -- We can configure more options here to enable/disable tracing as needed.
    withOptions setTraceOptions <| withoutModifyingEnv <| withoutModifyingState <| withFreshTraceState do
      withoutRecover do
        evalTactic item.tac
      let t2 ← IO.monoNanosNow
      return .ok item (Nat.deltaInMs t2 t1)
  catch e =>
    let t2 ← IO.monoNanosNow
    return .err item (Nat.deltaInMs t2 t1) e



def parseTacBenchItem : TSyntax ``tacBenchItem → TacticM Item
| `(tacBenchItem| $name:str : $tac:tacticSeq) =>
     return { name := name.getString, tac := tac : Item }
| _ => throwUnsupportedSyntax

private def toMessageDataToCsvString [ToMessageData α] (a : α) : MetaM String := do
  return csvEscapeString <| ← MessageData.toString <| ← addMessageContextFull <| toMessageData a

@[tactic tacBench]
def evalTacBench : Tactic := fun
| `(tactic| tac_bench $[$cfg]? [$tacBenchItems:tacBenchItem,*]) => do
    let cfg ← elabTacBenchConfig (mkOptionalNode cfg)
    let thmName : String :=
      match (← getLCtx).decls.toArray[0]? with
      | .some (some decl) => decl.userName.toString
      | _ => "unknown-theorem"
    let g ← getMainGoal
    g.withContext do
      let items ← tacBenchItems.getElems.mapM parseTacBenchItem
      let mut msg := m!""
      let mut results : Array Result := #[]
      for item in items do
        let out ← hermeticRun g item
        results := results.push out
        msg := msg ++ m!"\n" ++ out.toMessageData
      -- Produce output.
      if cfg.outputType == Config.OutputType.text then
        logInfo m!"TACSTART NAME {thmName} ENDNAME {.nestD msg}\nTACEND"
      else if cfg.outputType == Config.OutputType.csv then
        let goalStr ← toMessageDataToCsvString g
        for result in results do
          let statusStr := if result.isOk then "ok" else "err"
          let errMsgStr ← if result.isOk then pure "<noerror>" else toMessageDataToCsvString result.errorMessage
          let outStr := m!"TACBENCHCSV| {thmName}, {goalStr}, {result.item.name}, {statusStr}, {errMsgStr}, {result.timeElapsed}"
          logInfo outStr

| _ => throwUnsupportedSyntax
end TacBench


section Examples
/-
theorem eg1 (x : Nat) : 1 = x := by
  tac_bench ["rfl" : rfl, "wrong" : (rw [Nat.add_comm]), "success" : simp, "ring_done" : foo, "sorry" : sorry]
  sorry

theorem eg2 (x y : BitVec 8) : x * y = y * x := by
  tac_bench ["bv_decide" :  bv_decide, "ac_nf" : ac_nf]
  sorry
-/

end Examples
