"builtin.module"() ({
  "llvm.func"() <{CConv = #llvm.cconv<ccc>, function_type = !llvm.func<i1 (i64, i64, i64, i1)>, linkage = #llvm.linkage<external>, sym_name = "main", visibility_ = 0 : i64}> ({
  ^bb0(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i1):
    %0 = "llvm.ashr"(%arg1, %arg1) : (i64, i64) -> i64
    %1 = "llvm.srem"(%arg0, %0) : (i64, i64) -> i64
    %2 = "llvm.ashr"(%arg2, %arg2) : (i64, i64) -> i64
    %3 = "llvm.sub"(%2, %2) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %4 = "llvm.lshr"(%1, %3) : (i64, i64) -> i64
    %5 = "llvm.add"(%4, %arg1) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %6 = "llvm.and"(%4, %5) : (i64, i64) -> i64
    %7 = "llvm.zext"(%arg3) : (i1) -> i64
    %8 = "llvm.sub"(%6, %7) <{overflowFlags = #llvm.overflow<nuw>}> : (i64, i64) -> i64
    %9 = "llvm.icmp"(%5, %8) <{predicate = 6 : i64}> : (i64, i64) -> i1
    "llvm.return"(%9) : (i1) -> ()
  }) : () -> ()
}) : () -> ()

