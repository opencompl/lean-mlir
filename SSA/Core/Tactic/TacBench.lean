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
| jsonl -- JSONL
deriving Repr, DecidableEq

structure Config where
  outputType : Config.OutputType := .text
  outputPath : Option System.FilePath := .none
  /-- Number of samples to run each tactic. -/
  nSamples : Nat := 1

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


/-- TODO: convert to a structure with a field. -/
inductive Result
| ok (item : Item) (time : Float) (nSamples : Nat) (iSample: Nat) (trace : String)
| err (item : Item) (time : Float) (e : Exception) (nSamples : Nat) (iSample: Nat) (trace : String)


def csvEscapeString (s : String) : String :=
  let s := s.replace "\n" " "
  let s := s.replace "," " "
  let s := s.replace "\t" " "
  s


def Result.nSamples (r : Result) : Nat :=
  match r with
  | .ok (nSamples := nSamples) .. => nSamples
  | .err (nSamples := nSamples) .. => nSamples

def Result.iSample (r : Result) : Nat :=
  match r with
  | .ok (iSample := iSample) .. => iSample
  | .err (iSample := iSample) .. => iSample

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

def Result.trace (r : Result) : String :=
  match r with
  | .ok (trace := trace) ..  => trace
  | .err (trace := trace) .. => trace

def Result.item (r : Result) : Item :=
  match r with
  | .ok item .. => item
  | .err item .. => item


def Result.toMessageData : Result → MessageData
| .ok item timeMs .. => m!"TACBENCH {item.name} PASS, TIME_ELAPSED {timeMs} ms, "
| .err item timeMs e .. => m!"TACBENCH {item.name} FAIL, TIME_ELAPSED {timeMs} ms, MSGSTART {indentD e.toMessageData} MSGEND"

instance : ToMessageData Result where
  toMessageData := Result.toMessageData

/-- format the messages emitted by a tactic. -/
def formatTraces : TacticM String := do
  Lean.addTraceAsMessages
  -- let traceState ← getTraceState
  let msgs ← Core.getMessageLog
  let mut traces := #[]
  for msg in msgs.toArray do
    traces := traces.push <| ← msg.toString
  let trace := Format.joinSep traces.toList Format.line
  return trace.pretty (width := 80)

def hermeticRun (g : MVarId) (item : Item) (nSamples : Nat) (iSample : Nat) : TacticM Result := g.withContext do
  let t1 ← IO.monoNanosNow
  -- TODO: think if we need this, I'm just stealing from Henrik at this point.
  -- We can configure more options here to enable/disable tracing as needed.
  withOptions setTraceOptions <| withoutModifyingEnv <| withoutModifyingState <| withFreshTraceState do
    try
      withoutRecover <| evalTactic item.tac
      let t2 ← IO.monoNanosNow
      return .ok item (Nat.deltaInMs t2 t1) nSamples iSample (← formatTraces)
    catch e =>
      let t2 ← IO.monoNanosNow
      return .err item (Nat.deltaInMs t2 t1) e nSamples iSample (← formatTraces)

def parseTacBenchItem : TSyntax ``tacBenchItem → TacticM Item
| `(tacBenchItem| $name:str : $tac:tacticSeq) =>
     return { name := name.getString, tac := tac : Item }
| _ => throwUnsupportedSyntax

private def toMessageDataToString [ToMessageData α] (a : α) : MetaM String := do
  return ← MessageData.toString <| ← addMessageContextFull <| toMessageData a

private def toMessageDataToCsvString [ToMessageData α] (a : α) : MetaM String := do
  return csvEscapeString <| ← toMessageDataToString a

structure RecordRow where
  /-- The name of the theorem being benchmarked. -/
  fileName : String
  /-- Name of theorem being benchmarked. -/
  thmName : String
  /-- Goal state. -/
  goal : String
  /-- name of tactic that was run. -/
  tacName : String
  /-- Whether tactic succeeded. -/
  isOk : Bool
  /-- Error message string. -/
  errorMessage : String
  /-- Total time elapsed in running. -/
  timeElapsed : Float
  /-- Total #of samples. -/
  nSamples : Nat
  /-- Index of sample. -/
  iSample : Nat
  /-- Trace string. -/
  trace : String
deriving Repr, Inhabited, ToJson

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
        for iSample in [0:cfg.nSamples] do
          let out ← hermeticRun g item cfg.nSamples iSample
          results := results.push out
          msg := msg ++ m!"\n" ++ out.toMessageData
      -- Produce output.
      match cfg.outputType with
      | Config.OutputType.text =>
        logInfo m!"TACSTART NAME {thmName} ENDNAME {.nestD msg}\nTACEND"
      | Config.OutputType.csv =>
        let goalStr ← toMessageDataToCsvString g
        for result in results do
          let statusStr := if result.isOk then "ok" else "err"
          let errMsgStr ← if result.isOk then pure "<noerror>" else toMessageDataToCsvString result.errorMessage
          let outStr := m!"TACBENCHCSV| {thmName}, {goalStr}, {result.item.name}, {statusStr}, {errMsgStr}, {result.timeElapsed}"
          logInfo outStr
      | Config.OutputType.jsonl =>
        let goalStr ← toMessageDataToString g
        for result in results do
          let errMsgStr ← if result.isOk then pure "<noerror>" else (toMessageDataToString result.errorMessage)
          let record : RecordRow := {
            fileName := (← getFileName)
            thmName := thmName
            goal := goalStr
            tacName := result.item.name
            isOk := result.isOk
            errorMessage := errMsgStr
            timeElapsed := result.timeElapsed
            nSamples := result.nSamples
            iSample := result.iSample
            trace := result.trace
          }
          let outStr := record |> toJson |>.compress
          logInfo <| outStr
          if let some path := cfg.outputPath then
            IO.FS.writeFile path outStr
| _ => throwUnsupportedSyntax
end TacBench


section Examples
/-
theorem eg1 (x : Nat) : 1 = x := by
  tac_bench ["rfl" : rfl, "wrong" : (rw [Nat.add_comm]), "success" : simp, "ring_done" : foo, "sorry" : sorry]
  sorry
-/

/-
theorem eg2 (x y : BitVec 8) : x * y = y * x := by
  tac_bench (config := { outputType := .jsonl }) ["bv_decide" :  bv_decide, "ac_nf" : ac_nf]
  sorry
-/
end Examples
