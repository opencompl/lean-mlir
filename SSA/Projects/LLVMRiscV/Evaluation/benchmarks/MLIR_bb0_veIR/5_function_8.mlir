"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.icmp"(%arg0, %arg1) <{predicate = 1 : i64}> : (i64, i64) -> i1
	%1 = "llvm.select"(%0, %arg0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%2 = "llvm.sdiv"(%arg0, %1) : (i64, i64) -> i64
	%3 = "llvm.udiv"(%arg0, %arg2) : (i64, i64) -> i64
	%4 = "llvm.icmp"(%2, %3) <{predicate = 1 : i64}> : (i64, i64) -> i1
	"llvm.return"(%4) : (i1) -> ()
}) : () -> ()
