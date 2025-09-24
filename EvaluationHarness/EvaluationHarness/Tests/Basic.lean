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
