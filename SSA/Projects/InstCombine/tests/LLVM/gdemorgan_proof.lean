
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gdemorgan_proof
theorem demorgan_or_apint1_thm (x x_1 : BitVec 43) :
  x_1 ^^^ 8796093022207#43 ||| x ^^^ 8796093022207#43 = x_1 &&& x ^^^ 8796093022207#43 := sorry

theorem demorgan_or_apint2_thm (x x_1 : BitVec 129) :
  x_1 ^^^ 680564733841876926926749214863536422911#129 ||| x ^^^ 680564733841876926926749214863536422911#129 =
    x_1 &&& x ^^^ 680564733841876926926749214863536422911#129 := sorry

theorem demorgan_and_apint1_thm (x x_1 : BitVec 477) :
  (x_1 ^^^
        390218568789499028922699653724145788218574767833121393857394619953171467352470702515038262882936496394978366390175827861930996959911035663286271#477) &&&
      (x ^^^
        390218568789499028922699653724145788218574767833121393857394619953171467352470702515038262882936496394978366390175827861930996959911035663286271#477) =
    (x_1 ||| x) ^^^
      390218568789499028922699653724145788218574767833121393857394619953171467352470702515038262882936496394978366390175827861930996959911035663286271#477 := sorry

theorem demorgan_and_apint2_thm (x x_1 : BitVec 129) :
  (x_1 ^^^ 680564733841876926926749214863536422911#129) &&& (x ^^^ 680564733841876926926749214863536422911#129) =
    (x_1 ||| x) ^^^ 680564733841876926926749214863536422911#129 := sorry

theorem demorgan_and_apint3_thm (x x_1 : BitVec 65) :
  (x_1 ^^^ 36893488147419103231#65) &&& (36893488147419103231#65 ^^^ x) =
    (x_1 ||| x) ^^^ 36893488147419103231#65 := sorry

theorem demorgan_and_apint4_thm (x x_1 : BitVec 66) :
  (x_1 ^^^ 73786976294838206463#66) &&& (x ^^^ 73786976294838206463#66) =
    (x_1 ||| x) ^^^ 73786976294838206463#66 := sorry

theorem demorgan_and_apint5_thm (x x_1 : BitVec 47) :
  (x_1 ^^^ 140737488355327#47) &&& (x ^^^ 140737488355327#47) = (x_1 ||| x) ^^^ 140737488355327#47 := sorry

theorem test3_thm (x x_1 : BitVec 32) :
  (x_1 ^^^ 4294967295#32) &&& (x ^^^ 4294967295#32) ^^^ 4294967295#32 = x_1 ||| x := sorry

theorem test4_thm (x : BitVec 32) : (x ^^^ 4294967295#32) &&& 5#32 ^^^ 4294967295#32 = x ||| 4294967290#32 := sorry

theorem test5_thm (x x_1 : BitVec 32) :
  (x_1 ^^^ 4294967295#32 ||| x ^^^ 4294967295#32) ^^^ 4294967295#32 = x_1 &&& x := sorry

theorem test3_apint_thm (x x_1 : BitVec 47) :
  (x_1 ^^^ 140737488355327#47) &&& (x ^^^ 140737488355327#47) ^^^ 140737488355327#47 = x_1 ||| x := sorry

theorem test4_apint_thm (x : BitVec 61) : (x ^^^ 2305843009213693951#61) &&& 5#61 = x &&& 5#61 ^^^ 5#61 := sorry

theorem test5_apint_thm (x x_1 : BitVec 71) :
  (x_1 ^^^ 2361183241434822606847#71 ||| x ^^^ 2361183241434822606847#71) ^^^ 2361183241434822606847#71 =
    x_1 &&& x := sorry

theorem demorgan_nand_thm (x x_1 : BitVec 8) : (x_1 ^^^ 255#8) &&& x ^^^ 255#8 = x ^^^ 255#8 ||| x_1 := sorry

theorem demorgan_nand_apint1_thm (x x_1 : BitVec 7) : (x_1 ^^^ 127#7) &&& x ^^^ 127#7 = x ^^^ 127#7 ||| x_1 := sorry

theorem demorgan_nand_apint2_thm (x x_1 : BitVec 117) :
  (x_1 ^^^ 166153499473114484112975882535043071#117) &&& x ^^^ 166153499473114484112975882535043071#117 =
    x ^^^ 166153499473114484112975882535043071#117 ||| x_1 := sorry

theorem demorgan_nor_thm (x x_1 : BitVec 8) : (x_1 ^^^ 255#8 ||| x) ^^^ 255#8 = (x ^^^ 255#8) &&& x_1 := sorry

theorem demorgan_nor_use2a_thm (x x_1 : BitVec 8) :
  (if (x_1 ^^^ 255#8) * 23#8 = 0#8 ∨ (x_1 ^^^ 255#8 ||| x) ^^^ 255#8 = intMin 8 ∧ (x_1 ^^^ 255#8) * 23#8 = 255#8 then
      none
    else some (((x_1 ^^^ 255#8 ||| x) ^^^ 255#8).sdiv ((x_1 ^^^ 255#8) * 23#8))) ⊑
    if (x_1 ^^^ 255#8) * 23#8 = 0#8 ∨ (x ^^^ 255#8) &&& x_1 = intMin 8 ∧ (x_1 ^^^ 255#8) * 23#8 = 255#8 then none
    else some (((x ^^^ 255#8) &&& x_1).sdiv ((x_1 ^^^ 255#8) * 23#8)) := sorry

theorem demorgan_nor_use2b_thm (x x_1 : BitVec 8) :
  (if x * 23#8 = 0#8 ∨ (x_1 ^^^ 255#8 ||| x) ^^^ 255#8 = intMin 8 ∧ x * 23#8 = 255#8 then none
    else some (((x_1 ^^^ 255#8 ||| x) ^^^ 255#8).sdiv (x * 23#8))) ⊑
    if x * 23#8 = 0#8 ∨ (x ^^^ 255#8) &&& x_1 = intMin 8 ∧ x * 23#8 = 255#8 then none
    else some (((x ^^^ 255#8) &&& x_1).sdiv (x * 23#8)) := sorry

theorem demorgan_nor_use2ab_thm (x x_1 : BitVec 8) :
  (Option.bind
      (if x * 23#8 = 0#8 ∨ (x_1 ^^^ 255#8 ||| x) ^^^ 255#8 = intMin 8 ∧ x * 23#8 = 255#8 then none
      else some (((x_1 ^^^ 255#8 ||| x) ^^^ 255#8).sdiv (x * 23#8)))
      fun a =>
      if (x_1 ^^^ 255#8) * 17#8 = 0#8 ∨ a = intMin 8 ∧ (x_1 ^^^ 255#8) * 17#8 = 255#8 then none
      else some (a.sdiv ((x_1 ^^^ 255#8) * 17#8))) ⊑
    Option.bind
      (if x * 23#8 = 0#8 ∨ (x ^^^ 255#8) &&& x_1 = intMin 8 ∧ x * 23#8 = 255#8 then none
      else some (((x ^^^ 255#8) &&& x_1).sdiv (x * 23#8)))
      fun a =>
      if (x_1 ^^^ 255#8) * 17#8 = 0#8 ∨ a = intMin 8 ∧ (x_1 ^^^ 255#8) * 17#8 = 255#8 then none
      else some (a.sdiv ((x_1 ^^^ 255#8) * 17#8)) := sorry

theorem demorganize_constant2_thm (x : BitVec 32) : (x ||| 15#32) ^^^ 4294967295#32 = x &&& 4294967280#32 ^^^ 4294967280#32 := sorry

theorem demorgan_plus_and_to_xor_thm (x x_1 : BitVec 32) :
  (x_1 &&& x ||| (x_1 ||| x) ^^^ 4294967295#32) ^^^ 4294967295#32 = x_1 ^^^ x := sorry

theorem PR45984_thm (x x_1 : BitVec 32) :
  x_1 ^^^ x ||| (x_1 ||| x) ^^^ 4294967295#32 = x_1 &&& x ^^^ 4294967295#32 := sorry

