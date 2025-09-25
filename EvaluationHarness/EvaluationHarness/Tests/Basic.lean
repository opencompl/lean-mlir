import EvaluationHarness.Basic

namespace EvaluationHarness.Tests

/-! ## getDefLikeName -/

/-- info: some "foo" -/
#guard_msgs in #eval do
  let cmd ← `(command| theorem foo : False := sorry)
  return getDefLikeName? cmd

/-- info: some "foo.bar" -/
#guard_msgs in #eval do
  let cmd ← `(command| theorem foo.bar : False := sorry)
  return getDefLikeName? cmd

/-- info: some "baz" -/
#guard_msgs in #eval do
  let cmd ← `(command| def baz : False := sorry)
  return getDefLikeName? cmd

/-- info: some "privateBaz" -/
#guard_msgs in #eval do
  let cmd ← `(command| private def privateBaz : False := sorry)
  return getDefLikeName? cmd

/-- info: some "protBaz" -/
#guard_msgs in #eval do
  let cmd ← `(command| protected def protBaz : False := sorry)
  return getDefLikeName? cmd

/-! ## `#evaluation`-/
set_option evaluation.outputAsLog true
set_option evaluation.includePosition false

/--
info: {"wallTime": null,
 "strategy": null,
 "name": "foo",
 "messages":
 [{"severity": "warning",
   "pos": {"line": 0, "column": 0},
   "data": "declaration uses 'sorry'",
   "caption": ""}],
 "line": 0,
 "hasErrors": false,
 "filename":
 "/home/alex/Workspace/PhD/lean-mlir-alt/EvaluationHarness/EvaluationHarness/Tests/Basic.lean"}
-/
#guard_msgs in #evaluation in
  def foo : False := sorry

/--
info: {"wallTime": null,
 "strategy": "barStrat",
 "name": "bar",
 "messages":
 [{"severity": "warning",
   "pos": {"line": 0, "column": 0},
   "data": "declaration uses 'sorry'",
   "caption": ""}],
 "line": 0,
 "hasErrors": false,
 "filename":
 "/home/alex/Workspace/PhD/lean-mlir-alt/EvaluationHarness/EvaluationHarness/Tests/Basic.lean"}
-/
#guard_msgs in #evaluation (strategy := "barStrat") in
  def bar : False := sorry

/--
info: {"wallTime": null,
 "strategy": null,
 "name": "shouldError",
 "messages":
 [{"severity": "error",
   "pos": {"line": 0, "column": 0},
   "data": "Failed: `fail` tactic was invoked\n⊢ False",
   "caption": ""}],
 "line": 0,
 "hasErrors": true,
 "filename":
 "/home/alex/Workspace/PhD/lean-mlir-alt/EvaluationHarness/EvaluationHarness/Tests/Basic.lean"}
-/
#guard_msgs in #evaluation in
  def shouldError : False := by
    fail

set_option evaluation.includeMessages false in
/--
info: {"wallTime": null,
 "strategy": null,
 "name": "shouldErrorWithoutMsg",
 "messages": null,
 "line": 0,
 "hasErrors": true,
 "filename":
 "/home/alex/Workspace/PhD/lean-mlir-alt/EvaluationHarness/EvaluationHarness/Tests/Basic.lean"}
-/
#guard_msgs in #evaluation in
  def shouldErrorWithoutMsg : False := by
    fail
