import SSA.Projects.InstCombine.LLVM.PrettyEDSL

/-!
# Print Tests
-/
namespace Tests

/-!
## General print tests

First, we assert that variables in a basic block are printed in the correct
order.
-/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i1):
    "llvm.return"(%0) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%0: i64, %1: i1):
    "llvm.return"(%0) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i1):
  "return"(%0) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%0: i64, %1: i1):
    "llvm.return"(%0) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i1):
    return %0 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%0: i64, %1: i1):
    "llvm.return"(%0) : (i64) -> ()
}]

/-!
## Per-operation tests

Note: for each operation we have a test without flags for each of the three
printing methods. If the operation takes flags, we additionally have flagged
test-cases *only* for `Com.print`, as it's the only printing method that handles
flags well.

The goal for these tests is that the output is parse-able, and the result of parsing
it matches *exactly* with the input:
* Where the input is not standard MLIR syntax, that is a parser-bug
* Where the output otherwise (meaningfully) differs from the input, that is
  a printing bug.

Do note: if, e.g., the input does not pass a value for an optional flag, but the
output does print the flag with the default value explicitly set, that is *not*
a bug, as the result of parsing this output will match the parsed input.

Finally, the below test-cases expose many cases where these invariants are broken.
Those are bugs! The tests should not be seen as prescriptive, they merely
expose the current behaviour for easier diagnosis.
-/

/-! #### add -/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.add"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.BinaryOp.add)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### add (flags) -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) {overflowFlags = #llvm.overflow<none>} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) {overflowFlags = #llvm.overflow<"nsw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) {overflowFlags = #llvm.overflow<"nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.add"(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.add"(%x, %y) {overflowFlags = #llvm.overflow<"nsw","nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### sub -/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sub"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sub"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.sub"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sub"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.BinaryOp.sub)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sub"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### sub (flags) -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sub"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sub"(%x, %y) {overflowFlags = #llvm.overflow<"none">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/-! #### sub (flags) -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sub"(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sub"(%x, %y) {overflowFlags = #llvm.overflow<"nsw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sub"(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sub"(%x, %y) {overflowFlags = #llvm.overflow<"nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sub"(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sub"(%x, %y) {overflowFlags = #llvm.overflow<"nsw","nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### mul -/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mul"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.mul"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.mul"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.mul"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.BinaryOp.mul)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.mul"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### mul (flags) -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mul"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.mul"(%x, %y) {overflowFlags = #llvm.overflow<"none">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mul"(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.mul"(%x, %y) {overflowFlags = #llvm.overflow<"nsw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mul"(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.mul"(%x, %y) {overflowFlags = #llvm.overflow<"nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.mul"(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.mul"(%x, %y) {overflowFlags = #llvm.overflow<"nsw","nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### udiv -/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.udiv"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.udiv"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.udiv"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.udiv"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.BinaryOp.udiv)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.udiv"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### udiv (exact) -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.udiv"(%0, %1)<{isExact}>  : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.udiv"(%x, %y) {isExact} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### sdiv -/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sdiv"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sdiv"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.sdiv"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sdiv"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.BinaryOp.sdiv)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sdiv"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### sdiv (exact) -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.sdiv"(%0, %1)<{isExact}>  : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.sdiv"(%x, %y) {isExact} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### urem -/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.urem"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.urem"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.urem"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.urem"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.BinaryOp.urem)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.urem"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### srem -/

/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.srem"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.srem"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.srem"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.srem"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.BinaryOp.srem)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.srem"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### and -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.and"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.and"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.and"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.BinaryOp.and)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.and"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### or -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.or"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.or"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.or"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.BinaryOp.or)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.or"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### xor -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.xor"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.xor"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.xor"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.BinaryOp.xor)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.xor"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### not -/
/--
info: builtin.module {
  ^bb0(%0 : i64):
    %1 = "llvm.not"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.not"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64):
  %1 = "InstCombine.MOp.UnaryOp.not"(%0) : (i64) -> (i64)
  "return"(%1) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.not"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64):
    %1 = InstCombine.MOp.unary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.UnaryOp.not)(%0) : (i64) → (i64)
    return %1 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.not"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### neg -/
/--
info: builtin.module {
  ^bb0(%0 : i64):
    %1 = "llvm.neg"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.neg"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64):
  %1 = "InstCombine.MOp.UnaryOp.neg"(%0) : (i64) -> (i64)
  "return"(%1) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.neg"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64):
    %1 = InstCombine.MOp.unary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.UnaryOp.neg)(%0) : (i64) → (i64)
    return %1 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.neg"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### copy -/
/--
info: builtin.module {
  ^bb0(%0 : i64):
    %1 = "llvm.copy"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.copy"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64):
  %1 = "InstCombine.MOp.UnaryOp.copy"(%0) : (i64) -> (i64)
  "return"(%1) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.copy"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64):
    %1 = InstCombine.MOp.unary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.UnaryOp.copy)(%0) : (i64) → (i64)
    return %1 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.copy"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### shl -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.shl"(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.shl"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.shl"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.shl"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary (ConcreteOrMVar.concrete 64) (InstCombine.MOp.BinaryOp.shl)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.shl"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### shl (flags) -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.shl"(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.shl"(%x, %y) {overflowFlags = #llvm.overflow<"nsw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.shl"(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.shl"(%x, %y) {overflowFlags = #llvm.overflow<"nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.shl"(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.shl"(%x, %y) {overflowFlags = #llvm.overflow<"nsw","nuw">} : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### lshr -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.lshr"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.lshr"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.lshr"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.lshr"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.BinaryOp.lshr)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.lshr"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### ashr -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.ashr"(%0, %1) : (i64, i64) -> (i64)
    "llvm.return"(%2) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.ashr"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = "llvm.ashr"(%0, %1) : (i64, i64) -> (i64)
  "return"(%2) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.ashr"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.binary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.BinaryOp.ashr)(%0, %1) : (i64, i64) → (i64)
    return %2 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.ashr"(%x, %y) : (i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### trunc -/
/--
info: builtin.module {
  ^bb0(%0 : i64):
    %1 = "llvm.trunc"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.trunc"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64):
  %1 = "InstCombine.MOp.UnaryOp.trunc (ConcreteOrMVar.concrete 64) { nsw := false, nuw := false }"(%0) : (i64) -> (i64)
  "return"(%1) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.trunc"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64):
    %1 = InstCombine.MOp.unary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.UnaryOp.trunc (ConcreteOrMVar.concrete 64) { nsw := false, nuw := false })(%0) : (i64) → (i64)
    return %1 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.trunc"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### zext -/
/--
info: builtin.module {
  ^bb0(%0 : i64):
    %1 = "llvm.zext"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.zext"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64):
  %1 = "InstCombine.MOp.UnaryOp.zext (ConcreteOrMVar.concrete 64) { nneg := false }"(%0) : (i64) -> (i64)
  "return"(%1) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.zext"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64):
    %1 = InstCombine.MOp.unary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.UnaryOp.zext (ConcreteOrMVar.concrete 64) { nneg := false })(%0) : (i64) → (i64)
    return %1 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.zext"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### sext -/
/--
info: builtin.module {
  ^bb0(%0 : i64):
    %1 = "llvm.sext"(%0) : (i64) -> (i64)
    "llvm.return"(%1) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.sext"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64):
  %1 = "InstCombine.MOp.UnaryOp.sext (ConcreteOrMVar.concrete 64)"(%0) : (i64) -> (i64)
  "return"(%1) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.sext"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i64):
    %1 = InstCombine.MOp.unary
      (ConcreteOrMVar.concrete 64)
      (InstCombine.MOp.UnaryOp.sext (ConcreteOrMVar.concrete 64))(%0) : (i64) → (i64)
    return %1 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64):
    %z = "llvm.sext"(%x) : (i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### select -/
/--
info: builtin.module {
  ^bb0(%0 : i1, %1 : i64, %2 : i64):
    %3 = "llvm.select"(%0, %1, %2) : (i1, i64, i64) -> (i64)
    "llvm.return"(%3) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%cond: i1, %x: i64, %y: i64):
    %z = "llvm.select"(%cond, %x, %y) : (i1, i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry(%0 : i1, %1 : i64, %2 : i64):
  %3 = select(%0, %1, %2) : (i1, i64, i64) -> (i64)
  "return"(%3) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%cond: i1, %x: i64, %y: i64):
    %z = "llvm.select"(%cond, %x, %y) : (i1, i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry(%0 : i1, %1 : i64, %2 : i64):
    %3 = InstCombine.MOp.select (ConcreteOrMVar.concrete 64)(%0, %1, %2) : (i1, i64, i64) → (i64)
    return %3 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%cond: i1, %x: i64, %y: i64):
    %z = "llvm.select"(%cond, %x, %y) : (i1, i64, i64) -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]

/-! #### icmp -/
/--
info: builtin.module {
  ^bb0(%0 : i64, %1 : i64):
    %2 = "llvm.icmp.eq"(%0, %1)eq : (i64, i64) -> (i1)
    "llvm.return"(%2) : (i1) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.icmp.eq"(%x, %y) : (i64, i64) -> (i1)
    "llvm.return"(%z) : (i1) -> ()
}]
/--
info: { ⏎
^entry(%0 : i64, %1 : i64):
  %2 = icmp(%0, %1) : (i64, i64) -> (i1)
  "return"(%2) : (i1) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.icmp.eq"(%x, %y) : (i64, i64) -> (i1)
    "llvm.return"(%z) : (i1) -> ()
}]
/--
info: {
  ^entry(%0 : i64, %1 : i64):
    %2 = InstCombine.MOp.icmp (LLVM.IntPred.eq) (ConcreteOrMVar.concrete 64)(%0, %1) : (i64, i64) → (i1)
    return %2 : (i1) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0(%x: i64, %y: i64):
    %z = "llvm.icmp.eq"(%x, %y) : (i64, i64) -> (i1)
    "llvm.return"(%z) : (i1) -> ()
}]

/-! #### const -/
/--
info: builtin.module {
  ^bb0():
    %0 = "llvm.const"(){value = 42 : i64} : () -> (i64)
    "llvm.return"(%0) : (i64) -> ()
}
-/
#guard_msgs in #eval Com.printModule [llvm| {
  ^bb0():
    %z = "llvm.mlir.constant"() {value = 42 : i64} : () -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: { ⏎
^entry():
  %0 = "llvm.mlir.constant"() {value = 42 : i64} : () -> (i64)
  "return"(%0) : (i64) -> ()
 }
-/
#guard_msgs in #eval String.toFormat <| Com.toString [llvm| {
  ^bb0():
    %z = "llvm.mlir.constant"() {value = 42 : i64} : () -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
/--
info: {
  ^entry():
    %0 = InstCombine.MOp.const (ConcreteOrMVar.concrete 64) 42 : () → (i64)
    return %0 : (i64) → ()
}
-/
#guard_msgs in #eval [llvm| {
  ^bb0():
    %z = "llvm.mlir.constant"() {value = 42 : i64} : () -> (i64)
    "llvm.return"(%z) : (i64) -> ()
}]
