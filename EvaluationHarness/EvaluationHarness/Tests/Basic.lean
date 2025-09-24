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

/-
NOTE: `#guard_msgs` doesn't work, presumably because we output the data
with `IO.println` instead of `logInfo` or the like.
-/

#evaluation in
  def foo : False := sorry

#evaluation (strategy := "barStrat") in
  def bar : False := sorry

#evaluation in
  def shouldError : False := by
    fail
