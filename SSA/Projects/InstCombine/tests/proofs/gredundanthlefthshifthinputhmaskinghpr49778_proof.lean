
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gredundanthlefthshifthinputhmaskinghpr49778_proof
theorem src_thm (x : BitVec 1) :
  (Option.bind (if 32#32 ≤ setWidth 32 x then none else some (4294967295#32 <<< (x.toNat % 4294967296))) fun a =>
      if 32#32 ≤ setWidth 32 x then none
      else some (((a ^^^ 4294967295#32) &&& setWidth 32 x) <<< (x.toNat % 4294967296))) ⊑
    (if (4294967295#32 <<< (x.toNat % 4294967296)).sshiftRight (x.toNat % 4294967296) = 4294967295#32 then none
        else if 32#32 ≤ setWidth 32 x then none else some (4294967295#32 <<< (x.toNat % 4294967296))).bind
      fun a =>
      if
          (((a ^^^ 4294967295#32) &&& setWidth 32 x) <<< (x.toNat % 4294967296)).sshiftRight (x.toNat % 4294967296) =
            (a ^^^ 4294967295#32) &&& setWidth 32 x then
        none
      else
        if
            ((a ^^^ 4294967295#32) &&& setWidth 32 x) <<< (x.toNat % 4294967296) >>> (x.toNat % 4294967296) =
              (a ^^^ 4294967295#32) &&& setWidth 32 x then
          none
        else
          if 32#32 ≤ setWidth 32 x then none
          else some (((a ^^^ 4294967295#32) &&& setWidth 32 x) <<< (x.toNat % 4294967296)) := sorry

