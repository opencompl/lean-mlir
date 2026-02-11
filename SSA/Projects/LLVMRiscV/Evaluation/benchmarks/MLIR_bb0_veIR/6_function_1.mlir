"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.ashr"(%arg1, %arg0) : (i64, i64) -> i64
	%1 = "llvm.sdiv"(%0, %arg2) : (i64, i64) -> i64
	%2 = "llvm.sdiv"(%arg2, %arg1) : (i64, i64) -> i64
	%3 = "llvm.sdiv"(%1, %2) : (i64, i64) -> i64
	%4 = "llvm.icmp"(%arg0, %3) <{predicate = 2 : i64}> : (i64, i64) -> i1
	%5 = "llvm.sext"(%4) : (i1) -> i64
	"llvm.return"(%5) : (i64) -> ()
}) : () -> ()
