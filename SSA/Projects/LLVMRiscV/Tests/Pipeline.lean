import SSA.Projects.LLVMRiscV.Pipeline.add
import SSA.Projects.LLVMRiscV.Pipeline.and
import SSA.Projects.InstCombine.LLVM.Opt

/--
 info: builtin.module {
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
 info: builtin.module {
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
 info: builtin.module {
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
info: builtin.module {
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
 info: builtin.module {
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
 info: builtin.module {
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
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_8)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_8)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_16)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_16)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_16)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_16)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_32)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_32)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_32)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_32)


/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_no_flags_64)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_flags_64)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nuw_flags_64)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 add_llvm_nsw_nuw_flags_64)

/--
  %lhsr = "builtin.unrealized_conversion_cast" (%lhs) : (i1) -> (!i64)
  %rhsr = "builtin.unrealized_conversion_cast" (%rhs) : (i1) -> (!i64)
  %0 = and %lhsr, %rhsr : !i64
  %1 = "builtin.unrealized_conversion_cast" (%0) : (!i64) -> (i1)
  llvm.return %1 : i1
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_1)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_8)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_16)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_32)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 and_llvm_64)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_8)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_8)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_16)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_16)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_32)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_32)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_no_flag_64)

/--
-/
#guard_msgs in
#eval! String.toFormat <| Com.toPrint (multiRewritePeephole 100 rewritingPatterns0 ashr_llvm_exact_flag_64)
