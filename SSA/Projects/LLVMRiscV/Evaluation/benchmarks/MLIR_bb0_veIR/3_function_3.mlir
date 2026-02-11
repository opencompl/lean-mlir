"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.or"(%arg2, %arg2) : (i64, i64) -> i64
	%1 = "llvm.or"(%arg1, %0) : (i64, i64) -> i64
	%2 = "llvm.icmp"(%arg0, %1) <{predicate = 8 : i64}> : (i64, i64) -> i1
	"llvm.return"(%2) : (i1) -> ()
}) : () -> ()
