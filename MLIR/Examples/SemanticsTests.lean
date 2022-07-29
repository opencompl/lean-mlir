import MLIR.EDSL
import MLIR.AST
import MLIR.Dialects.ArithSemantics
import MLIR.Dialects.FuncSemantics
import MLIR.Dialects.ControlFlowSemantics
import MLIR.Dialects.ScfSemantics
open MLIR.AST

namespace SemanticsTests

inductive Test :=
  | mk {α σ ε} (δ: Dialect α σ ε) [S: Semantics δ]:
      String → Region (δ + cf) → Test

def Test.name: Test → String
  | @Test.mk _ _ _ δ _ str r => str

def Test.run (t: Test): String :=
  let (@Test.mk α σ ε δ S _ r) := t
  let t := semanticsRegion 99 r []
  let t := interpSSA' t SSAEnv.empty
  let t: Fitree (Semantics.E cf +' UBE) _ :=
    t.interp (Fitree.case (Fitree.case
      (fun _ e => Fitree.translate Member.inject (S.handle _ e))
      (fun _ e => Fitree.trigger e))
    (fun _ e => Fitree.trigger e))
  let t: Fitree UBE _ :=
    t.interp (Fitree.case ControlFlowE.handleLogged Fitree.liftHandler)
  let t := interpUB t
  match Fitree.run t with
  | .error msg => "error: " ++ msg
  | .ok ((r, env), assertLog) => assertLog

def trueval := Test.mk (func_ + arith) "trueval.mlir" [mlir_region| {
  %true = "arith.constant" () {value = 1: i1}: () -> i1
  "cf.assert" (%true) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def add := Test.mk (func_ + arith) "add.mlir" [mlir_region| {
  %r1 = "arith.constant" () {value = 17: i5}: () -> i5
  %r2 = "arith.constant" () {value = 25: i5}: () -> i5
  %r = "arith.addi" (%r1, %r2): (i5, i5) -> i5
  %e = "arith.constant" () {value = 10: i5}: () -> i5
  %b = "arith.cmpi" (%r, %e) {predicate = 0 /- eq -/}: (i5, i5) -> i1
  "cf.assert" (%b) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def sub := Test.mk (func_ + arith) "sub.mlir" [mlir_region| {
  %_1 = "arith.constant" () {value = 8374: i16}: () -> i16
  %_2 = "arith.constant" () {value = 12404: i16}: () -> i16

  %r1 = "arith.subi" (%_2, %_1): (i16, i16) -> i16
  %e1 = "arith.constant" () {value = 4030: i16}: () -> i16
  %b1 = "arith.cmpi" (%r1, %e1) {predicate = 0 /- eq -/}: (i16, i16) -> i1
  "cf.assert" (%b1) {msg="<FAILED>"}: (i1) -> ()

  %r2 = "arith.subi" (%r1, %_1): (i16, i16) -> i16
  %e2 = "arith.constant" () {value = 61192: i16}: () -> i16
  %b2 = "arith.cmpi" (%r1, %e1) {predicate = 0 /- eq -/}: (i16, i16) -> i1
  "cf.assert" (%b2) {msg="<FAILED>"}: (i1) -> ()


  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def xor := Test.mk (func_ + arith) "xor.mlir" [mlir_region| {
  %r1 = "arith.constant" () {value = 17: i8}: () -> i8
  %r2 = "arith.constant" () {value = 25: i8}: () -> i8
  %r = "arith.xori" (%r1, %r2): (i8, i8) -> i8
  %e = "arith.constant" () {value = 8: i8}: () -> i8
  %b = "arith.cmpi" (%r, %e) {predicate = 0 /- eq -/}: (i8, i8) -> i1
  "cf.assert" (%b) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def rw1 := Test.mk (func_ + arith) "rw1.mlir" [mlir_region| {
  %_1 = "arith.constant"() {value = 84: i8}: () -> i8
  %_2 = "arith.constant"() {value = 28: i8}: () -> i8

  %r1 = "arith.xori"(%_1, %_2): (i8, i8) -> i8
  %e1 = "arith.constant"() {value = 72: i8}: () -> i8
  %b1 = "arith.cmpi" (%r1, %e1) {predicate = 0 /- eq -/}: (i8, i8) -> i1
  "cf.assert" (%b1) {msg="<FAILED>"}: (i1) -> ()

  %r2 = "arith.andi"(%_1, %_2): (i8, i8) -> i8
  %e2 = "arith.constant"() {value = 20: i8}: () -> i8
  %b2 = "arith.cmpi" (%r2, %e2) {predicate = 0 /- eq -/}: (i8, i8) -> i1
  "cf.assert" (%b2) {msg="<FAILED>"}: (i1) -> ()

  %r3 = "arith.ori"(%_1, %_2): (i8, i8) -> i8
  %e3 = "arith.constant"() {value = 92: i8}: () -> i8
  %b3 = "arith.cmpi" (%r3, %e3) {predicate = 0 /- eq -/}: (i8, i8) -> i1
  "cf.assert" (%b3) {msg="<FAILED>"}: (i1) -> ()

  %r4 = "arith.addi"(%r1, %r2): (i8, i8) -> i8
  %b4 = "arith.cmpi" (%r4, %r3) {predicate = 0 /- eq -/}: (i8, i8) -> i1
  "cf.assert" (%b4) {msg="<FAILED>"}: (i1) -> ()

  %r5 = "arith.addi"(%_1, %_2): (i8, i8) -> i8
  %e5 = "arith.constant"() {value = 112: i8}: () -> i8
  %b5 = "arith.cmpi" (%r5, %e5) {predicate = 0 /- eq -/}: (i8, i8) -> i1
  "cf.assert" (%b5) {msg="<FAILED>"}: (i1) -> ()

  %r6 = "arith.addi"(%r2, %r3): (i8, i8) -> i8
  %b6 = "arith.cmpi" (%r6, %e5) {predicate = 0 /- eq -/}: (i8, i8) -> i1
  "cf.assert" (%b6) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def if_true := Test.mk (func_ + scf + arith) "if_true.mlir" [mlir_region| {
  %b = "arith.constant" () {value = 1: i1}: () -> i1
  %y = "scf.if"(%b) ({
    %x1 = "arith.constant"() {value = 3: i16}: () -> i16
    "scf.yield"(%x1): (i16) -> ()
  }, {
    %x2 = "arith.constant"() {value = 4: i16}: () -> i16
    "scf.yield"(%x2): (i16) -> ()
  }): (i1) -> i16

  %e = "arith.constant"() {value = 3: i16}: () -> i16
  %b1 = "arith.cmpi" (%y, %e) {predicate = 0 /- eq -/}: (i16, i16) -> i1
  "cf.assert"(%b1) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def if_false := Test.mk (func_ + scf + arith) "if_false.mlir" [mlir_region| {
  %b = "arith.constant" () {value = 0: i1}: () -> i1
  %y = "scf.if"(%b) ({
    %x1 = "arith.constant"() {value = 3: i16}: () -> i16
    "scf.yield"(%x1): (i16) -> ()
  }, {
    %x2 = "arith.constant"() {value = 4: i16}: () -> i16
    "scf.yield"(%x2): (i16) -> ()
  }): (i1) -> i16

  %e = "arith.constant"() {value = 4: i16}: () -> i16
  %b1 = "arith.cmpi" (%y, %e) {predicate = 0 /- eq -/}: (i16, i16) -> i1
  "cf.assert"(%b1) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def if_select := Test.mk (func_ + scf + arith) "if_select.mlir" [mlir_region| {
  %b = "arith.constant" () {value = 1: i1}: () -> i1
  %x1 = "arith.constant"() {value = 12: i16}: () -> i16
  %x2 = "arith.constant"() {value = 16: i16}: () -> i16

  %y1 = "scf.if"(%b) ({
    "scf.yield"(%x1): (i16) -> ()
  }, {
    "scf.yield"(%x2): (i16) -> ()
  }): (i1) -> i16
  %y2 = "arith.select"(%b, %x1, %x2): (i1, i16, i16) -> i16

  %b1 = "arith.cmpi" (%y1, %y2) {predicate = 0 /- eq -/}: (i16, i16) -> i1
  "cf.assert"(%b1) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

-- We only check the return value of the last instruction because we don't
-- yet implement the folding behavior of the loop, and we have no side effects
def for_trivial := Test.mk (func_ + scf + arith) "for_trivial.mlir" [mlir_region| {
  %lower = "arith.constant"() {value =  8: i32}: () -> i32
  %upper = "arith.constant"() {value = 18: i32}: () -> i32
  %step  = "arith.constant"() {value =  1: i32}: () -> i32

  %r = "scf.for"(%lower, %upper, %step) ({
    "scf.yield"(%step): (i32) -> ()
  }): (i32, i32, i32) -> ()

  %e = "arith.constant"() {value = 1: i32}: () -> i32
  %b = "arith.cmpi"(%e, %r) {predicate = 0 /- eq -/}: (i32, i32) -> i1
  "cf.assert"(%b) {msg="<FAILED>"}: (i1) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def for_bound := Test.mk (func_ + scf + arith) "for_bound.mlir" [mlir_region| {
  %lower = "arith.constant"() {value =  0: i32}: () -> i32
  %upper = "arith.constant"() {value = 18: i32}: () -> i32
  %step  = "arith.constant"() {value =  1: i32}: () -> i32

  "scf.for"(%lower, %upper, %step) ({
    ^bb(%i: i32):
      %b1 = "arith.cmpi"(%i, %lower) {predicate = 5 /- sge -/}: (i32, i32) -> i1
      "cf.assert"(%b1) {msg="<FAILED>"}: (i1) -> ()

      %b2 = "arith.cmpi"(%i, %upper) {predicate = 3 /- sle -/}: (i32, i32) -> i1
      "cf.assert"(%b2) {msg="<FAILED>"}: (i1) -> ()

      "scf.yield"(%step): (i32) -> ()
  }): (i32, i32, i32) -> ()

  %z = "arith.constant" () {value = 0: i32}: () -> i32
  "func.return" (%z): (i32) -> ()
}]

def allTests: Array Test := #[
  trueval,
  add,
  sub,
  xor,
  rw1,
  if_true,
  if_false,
  if_select,
--  for_trivial,
  for_bound
]

def runAllTests: IO Bool :=
  allTests.allM (fun t => do
    let b := t.run = ""
    IO.println s!"{t.name}: {if b then "ok" else "FAIL"}"
    return b)

#eval runAllTests

end SemanticsTests
