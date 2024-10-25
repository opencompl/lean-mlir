
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gpr14365_proof
theorem test0_thm (x : BitVec 32) :
  ((if
            (x.msb && (1431655765#32).msb) = (4294967295#32).msb ∧
              ¬((x &&& 1431655765#32 ^^^ 4294967295#32) + 1#32).msb =
                  (x.msb && (1431655765#32).msb ^^ (4294967295#32).msb) then
          none
        else some ((x &&& 1431655765#32 ^^^ 4294967295#32) + 1#32)).bind
      fun y' => if x.msb = y'.msb ∧ ¬(x + y').msb = x.msb then none else some (x + y')) ⊑
    some (x &&& 2863311530#32) := by bv_compare'

theorem test1_thm (x : BitVec 32) :
  ((if
            (x.msb && (1431655765#32).msb) = (4294967295#32).msb ∧
              ¬((x.sshiftRight 1 &&& 1431655765#32 ^^^ 4294967295#32) + 1#32).msb =
                  (x.msb && (1431655765#32).msb ^^ (4294967295#32).msb) then
          none
        else some ((x.sshiftRight 1 &&& 1431655765#32 ^^^ 4294967295#32) + 1#32)).bind
      fun y' => if x.msb = y'.msb ∧ ¬(x + y').msb = x.msb then none else some (x + y')) ⊑
    if
        (signExtend 33 x - signExtend 33 (x >>> 1 &&& 1431655765#32)).msb =
          (signExtend 33 x - signExtend 33 (x >>> 1 &&& 1431655765#32)).getMsbD 1 then
      some (x - (x >>> 1 &&& 1431655765#32))
    else none := by bv_compare'

