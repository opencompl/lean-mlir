"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i1):
    %0 = "llvm.lshr"(%arg0, %arg0) : (i64, i64) -> i64
    %1 = "llvm.sdiv"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.mul"(%arg0, %1) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %3 = "llvm.icmp"(%0, %arg0) <{predicate = 6 : i64}> : (i64, i64) -> i1
    %4 = "llvm.sext"(%3) : (i1) -> i64
    %5 = "llvm.or"(%2, %4) : (i64, i64) -> i64
    %6 = "llvm.zext"(%arg1) : (i1) -> i64
    %7 = "llvm.and"(%1, %6) : (i64, i64) -> i64
    %8 = "llvm.sub"(%arg0, %7) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %9 = "llvm.icmp"(%5, %8) <{predicate = 4 : i64}> : (i64, i64) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

