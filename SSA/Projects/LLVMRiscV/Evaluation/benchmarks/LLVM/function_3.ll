"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i64 (i64, i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i1):
    %0 = "llvm.sub"(%arg1, %arg1) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    %1 = "llvm.and"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.lshr"(%arg0, %1) : (i64, i64) -> i64
    %3 = "llvm.select"(%arg2, %arg1, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
    %4 = "llvm.sdiv"(%2, %3) : (i64, i64) -> i64
    %5 = "llvm.ashr"(%3, %1) : (i64, i64) -> i64
    %6 = "llvm.add"(%3, %5) <{overflowFlags = #llvm.overflow<nsw>}> : (i64, i64) -> i64
    %7 = "llvm.icmp"(%4, %6) <{predicate = 3 : i64}> : (i64, i64) -> i1
    %8 = "llvm.trunc"(%7) <{overflowFlags = #llvm.overflow<none>}> : (i1) -> i64
    %9 = "llvm.shl"(%2, %8) <{overflowFlags = #llvm.overflow<nsw, nuw>}> : (i64, i64) -> i64
    "llvm.return"(%9) : (i64) -> ()
  }) : () -> ()
}) : () -> ()

