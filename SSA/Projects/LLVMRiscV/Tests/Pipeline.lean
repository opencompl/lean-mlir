import SSA.Projects.LLVMRiscV.Pipeline.add
import SSA.Projects.LLVMRiscV.Pipeline.and
import SSA.Projects.InstCombine.LLVM.Opt

/--
info: builtin.module { ⏎
^bb0(%0 : i1, %1 : i1):
  %2 = "llvm."llvm.add""(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i1, i1) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_1)


/--
info: builtin.module { ⏎
^bb0(%0 : i1, %1 : i1):
  %2 = "llvm."llvm.add true false""(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i1, i1) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_1)


/--
info: builtin.module { ⏎
^bb0(%0 : i1, %1 : i1):
  %2 = "llvm."llvm.add false true""(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i1, i1) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_1)


/--
info: builtin.module { ⏎
^bb0(%0 : i1, %1 : i1):
  %2 = "llvm."llvm.add true true""(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i1, i1) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_1)


/--
info: builtin.module { ⏎
^bb0(%0 : i8, %1 : i8):
  %2 = "llvm."llvm.add""(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i8, i8) -> (i8)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i8) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i8) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i8)
  "llvm.return"(%6) : (i8) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_8)

/--
info: builtin.module { ⏎
^bb0(%0 : i8, %1 : i8):
  %2 = "llvm."llvm.add true false""(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i8, i8) -> (i8)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i8) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i8) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i8)
  "llvm.return"(%6) : (i8) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_8)

/--
info: builtin.module { ⏎
^bb0(%0 : i8, %1 : i8):
  %2 = "llvm."llvm.add false true""(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i8, i8) -> (i8)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i8) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i8) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i8)
  "llvm.return"(%6) : (i8) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_8)

/--
info: builtin.module { ⏎
^bb0(%0 : i8, %1 : i8):
  %2 = "llvm."llvm.add true true""(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i8, i8) -> (i8)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i8) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i8) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i8)
  "llvm.return"(%6) : (i8) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_8)

/--
info: builtin.module { ⏎
^bb0(%0 : i16, %1 : i16):
  %2 = "llvm."llvm.add""(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i16, i16) -> (i16)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i16) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i16)
  "llvm.return"(%6) : (i16) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_16)

/--
info: builtin.module { ⏎
^bb0(%0 : i16, %1 : i16):
  %2 = "llvm."llvm.add true false""(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i16, i16) -> (i16)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i16) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i16)
  "llvm.return"(%6) : (i16) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_16)

/--
info: builtin.module { ⏎
^bb0(%0 : i16, %1 : i16):
  %2 = "llvm."llvm.add false true""(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i16, i16) -> (i16)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i16) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i16)
  "llvm.return"(%6) : (i16) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_16)

/--
info: builtin.module { ⏎
^bb0(%0 : i16, %1 : i16):
  %2 = "llvm."llvm.add true true""(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i16, i16) -> (i16)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i16) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i16)
  "llvm.return"(%6) : (i16) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_16)

/--
info: builtin.module { ⏎
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm."llvm.add""(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i32, i32) -> (i32)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i32)
  "llvm.return"(%6) : (i32) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_32)

/--
info: builtin.module { ⏎
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm."llvm.add true false""(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i32, i32) -> (i32)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i32)
  "llvm.return"(%6) : (i32) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_32)

/--
info: builtin.module { ⏎
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm."llvm.add false true""(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i32, i32) -> (i32)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i32)
  "llvm.return"(%6) : (i32) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_32)

/--
info: builtin.module { ⏎
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm."llvm.add true true""(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i32, i32) -> (i32)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i32)
  "llvm.return"(%6) : (i32) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_32)


/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.add""(%0, %1)<{overflowFlags = #llvm.overflow<none>}> : (i64, i64) -> (i64)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_64)

/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.add true false""(%0, %1)<{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> (i64)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_64)

/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.add false true""(%0, %1)<{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> (i64)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_64)

/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.add true true""(%0, %1)<{overflowFlags = #llvm.overflow<nsw,nuw>}> : (i64, i64) -> (i64)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.add"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_64)

/--
info: builtin.module { ⏎
^bb0(%0 : i1, %1 : i1):
  %2 = "llvm."llvm.and""(%0, %1) : (i1, i1) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i1) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i1) -> (!riscv.reg)
  %5 = "riscv.and"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_1)

/--
info: builtin.module { ⏎
^bb0(%0 : i8, %1 : i8):
  %2 = "llvm."llvm.and""(%0, %1) : (i8, i8) -> (i8)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i8) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i8) -> (!riscv.reg)
  %5 = "riscv.and"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i8)
  "llvm.return"(%6) : (i8) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_8)

/--
info: builtin.module { ⏎
^bb0(%0 : i16, %1 : i16):
  %2 = "llvm."llvm.and""(%0, %1) : (i16, i16) -> (i16)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i16) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> (!riscv.reg)
  %5 = "riscv.and"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i16)
  "llvm.return"(%6) : (i16) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_16)

/--
info: builtin.module { ⏎
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm."llvm.and""(%0, %1) : (i32, i32) -> (i32)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.and"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i32)
  "llvm.return"(%6) : (i32) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_32)

/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.and""(%0, %1) : (i64, i64) -> (i64)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.and"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_64)

/--
info: builtin.module { ⏎
^bb0(%0 : i8, %1 : i8):
  %2 = "llvm."llvm.ashr""(%0, %1) : (i8, i8) -> (i8)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i8) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i8) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i8)
  "llvm.return"(%6) : (i8) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_8)

/--
info: builtin.module { ⏎
^bb0(%0 : i8, %1 : i8):
  %2 = "llvm."llvm.ashr exact""(%0, %1) : (i8, i8) -> (i8)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i8) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i8) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i8)
  "llvm.return"(%6) : (i8) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_8)

/--
info: builtin.module { ⏎
^bb0(%0 : i16, %1 : i16):
  %2 = "llvm."llvm.ashr""(%0, %1) : (i16, i16) -> (i16)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i16) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i16)
  "llvm.return"(%6) : (i16) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_16)

/--
info: builtin.module { ⏎
^bb0(%0 : i16, %1 : i16):
  %2 = "llvm."llvm.ashr exact""(%0, %1) : (i16, i16) -> (i16)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i16) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i16) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i16)
  "llvm.return"(%6) : (i16) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_16)

/--
info: builtin.module { ⏎
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm."llvm.ashr""(%0, %1) : (i32, i32) -> (i32)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i32)
  "llvm.return"(%6) : (i32) -> ()
 }

-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_32)

/--
info: builtin.module { ⏎
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm."llvm.ashr exact""(%0, %1) : (i32, i32) -> (i32)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i32)
  "llvm.return"(%6) : (i32) -> ()
 }

-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_32)

/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.ashr""(%0, %1) : (i64, i64) -> (i64)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_64)

/--
info: builtin.module { ⏎
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm."llvm.ashr exact""(%0, %1) : (i64, i64) -> (i64)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.sra"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i64)
  "llvm.return"(%6) : (i64) -> ()
 }
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_64)
