define i64 @icmp_predicate(i64 %a,i64 %b ) {
entry:
  %0 = icmp ugt i64 %a, %b; 
  %1 = icmp uge i64 %a, %b; 
  %2 = icmp ule i64 %a, %b; 
  %3 = icmp ult i64 %a, %b; 
  %4 = icmp sgt i64 %a, %b; 
  %5 = icmp sge i64 %a, %b; 
  %6 = icmp sle i64 %a, %b; 
  %7 = icmp slt i64 %a, %b; 
  ret i64 %4
}

 define i64 @main(i64 %arg0, i64 %arg1)  {
  %out = call i64 @icmp_predicate(i64 %arg0,i64 %arg1 )
  ret i64 %out
}
 ; for return %0
 builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.sltu"(%3, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i1)
  "riscv.ret"(%5) : (i1) -> ()
 }
  ; for return %1
  builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.sltu"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.xori"(%4){immediate = 1 : !riscv.reg } : (!riscv.reg) -> (!riscv.reg)
  %6 = "riscv.builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "riscv.ret"(%6) : (i1) -> ()
 }
  ; for return %2
  builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.sltu"(%3, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.xori"(%4){immediate = 1 : !riscv.reg } : (!riscv.reg) -> (!riscv.reg)
  %6 = "riscv.builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "riscv.ret"(%6) : (i1) -> ()
 }
  ; for return %3
  builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.sltu"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i1)
  "riscv.ret"(%5) : (i1) -> ()
 }

  ; for return %4
  builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.slt"(%3, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i1)
  "riscv.ret"(%5) : (i1) -> ()
 }
  ; for return %5
  builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.slt"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.xori"(%4){immediate = 1 : !riscv.reg } : (!riscv.reg) -> (!riscv.reg)
  %6 = "riscv.builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "riscv.ret"(%6) : (i1) -> ()
 }
  ; for return %6
  builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.slt"(%3, %2) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.xori"(%4){immediate = 1 : !riscv.reg } : (!riscv.reg) -> (!riscv.reg)
  %6 = "riscv.builtin.unrealized_conversion_cast"(%5) : (!riscv.reg) -> (i1)
  "riscv.ret"(%6) : (i1) -> ()
 }

  ; for return %7
  builtin.module { 
^bb0(%0 : i64, %1 : i64):
  %2 = "riscv.builtin.unrealized_conversion_cast"(%0) : (i64) -> (!riscv.reg)
  %3 = "riscv.builtin.unrealized_conversion_cast"(%1) : (i64) -> (!riscv.reg)
  %4 = "riscv.slt"(%2, %3) : (!riscv.reg, !riscv.reg) -> (!riscv.reg)
  %5 = "riscv.builtin.unrealized_conversion_cast"(%4) : (!riscv.reg) -> (i1)
  "riscv.ret"(%5) : (i1) -> ()
 }