
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthand_proof
theorem test2_thm (x : BitVec 15) : x &&& 32767#15 = x := sorry

theorem test3_thm (x : BitVec 23) : x &&& 127#23 &&& 128#23 = 0#23 := sorry

theorem test7_thm (x : BitVec 47) : x.sshiftRight 39 &&& 255#47 = x >>> 39 := sorry

theorem test9_thm (x : BitVec 1005) :
  x &&&
      342882754299605542703496015699200579379649539745770754382000124278512336359979559197823481221022674600830295333617006984059886491421540493951506482390354393725906168794375391533474387361995876540094533828897487199474622120556760561893297406274466013266278287285969349365133754612883980378790581378220031#1005 =
    x := sorry

theorem test10_thm (x : BitVec 123) : x &&& 127#123 &&& 128#123 = 0#123 := sorry

theorem test13_thm (x : BitVec 1024) :
  (Option.bind (if 1024 % 2 ^ 1024 ≤ 1016 % 2 ^ 1024 then none else some (x.sshiftRight (1016 % 2 ^ 1024))) fun a =>
      some (a &&& 255#1024)) ⊑
    if 1024 % 2 ^ 1024 ≤ 1016 % 2 ^ 1024 then none else some (x >>> (1016 % 2 ^ 1024)) := sorry

