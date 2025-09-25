import SSA.Projects.InstCombine.LLVM.Opt
import SSA.Core.Framework.Print

/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.ugt"(%0, %1)ugt : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.sltu"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_ugt_llvm_32)


/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.uge"(%0, %1)uge : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.sltu"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_uge_llvm_32)


/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.ult"(%0, %1)ult : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.sltu"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_ult_llvm_32)


/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.ule"(%0, %1)ule : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.sltu"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_ule_llvm_32)


/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.sgt"(%0, %1)sgt : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.slt"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_sgt_llvm_32)

/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.sge"(%0, %1)sge : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.slt"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_sge_llvm_32)

/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.slt"(%0, %1)slt : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.slt"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_slt_llvm_32)

/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.sle"(%0, %1)sle : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.slt"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_sle_llvm_32)

/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.eq"(%0, %1)eq : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.xor"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.sltiu"(%5){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_eq_llvm_32)

/--
info:
^bb0(%0 : i32, %1 : i32):
  %2 = "llvm.icmp.ne"(%0, %1)ne : (i32, i32) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i32) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i32) -> (!riscv.reg)
  %5 = "riscv.xor"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.li"(){immediate = 0 : i64 } : () -> (!riscv.reg)
  %7 = "riscv.sltu"(%6, %5) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %8 = "builtin.unrealized_conversion_cast"(%7) : (!riscv.reg) -> (i1)
  "llvm.return"(%8) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_neq_llvm_32)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.ugt"(%0, %1)ugt : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.sltu"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_ugt_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.uge"(%0, %1)uge : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.sltu"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_uge_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.ult"(%0, %1)ult : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.sltu"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_ult_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.ule"(%0, %1)ule : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.sltu"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_ule_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.sgt"(%0, %1)sgt : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.slt"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_sgt_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.sge"(%0, %1)sge : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.slt"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_sge_llvm_64)


/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.slt"(%0, %1)slt : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.slt"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "llvm.return"(%6) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_slt_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.sle"(%0, %1)sle : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.slt"(%4, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.xori"(%5){immediate = 1 : si12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_sle_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.eq"(%0, %1)eq : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.xor"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.sltiu"(%5){immediate = 1 : i12 } : (!riscv.reg) -> (!riscv.reg)
  %7 = "builtin.unrealized_conversion_cast"(%6) : (!riscv.reg) -> (i1)
  "llvm.return"(%7) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_eq_llvm_64)

/--
info:
^bb0(%0 : i64, %1 : i64):
  %2 = "llvm.icmp.ne"(%0, %1)ne : (i64, i64) -> (i1)
  %3 = "builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %4 = "builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %5 = "riscv.xor"(%3, %4) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %6 = "riscv.li"(){immediate = 0 : i64 } : () -> (!riscv.reg)
  %7 = "riscv.sltu"(%6, %5) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %8 = "builtin.unrealized_conversion_cast"(%7) : (!riscv.reg) -> (i1)
  "llvm.return"(%8) : (i1) -> ()
-/
#guard_msgs in
#eval! Com.print (multiRewritePeephole 100 rewritingPatterns0 icmp_neq_llvm_64)
