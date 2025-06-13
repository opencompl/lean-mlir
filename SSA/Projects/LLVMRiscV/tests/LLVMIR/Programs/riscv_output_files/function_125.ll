; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

define i64 @main(i64 %0) {
  %2 = icmp sgt i64 %0, 0
  %3 = select i1 %2, i64 -1, i64 1
  %4 = add i64 %3, 4587139437073004161
  %5 = sdiv i64 %4, %0
  %6 = add i64 %5, 1
  %7 = sdiv i64 -4587139437073004161, %0
  %8 = sub i64 0, %7
  %9 = icmp slt i64 %0, 0
  %10 = icmp sgt i64 %0, 0
  %11 = and i1 false, %9
  %12 = and i1 true, %10
  %13 = or i1 %11, %12
  %14 = select i1 %13, i64 %6, i64 %8
  %15 = urem i64 -861827906971256433, %14
  ret i64 %15
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
