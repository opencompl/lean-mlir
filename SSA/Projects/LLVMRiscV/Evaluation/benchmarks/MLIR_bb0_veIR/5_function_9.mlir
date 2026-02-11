"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1, %arg2: i1):
	%0 = "llvm.sext"(%arg1) : (i1) -> i64
	%1 = "llvm.select"(%arg2, %arg0, %0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%2 = "llvm.urem"(%0, %1) : (i64, i64) -> i64
	%3 = "llvm.udiv"(%arg0, %2) : (i64, i64) -> i64
	%4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i1
	"llvm.return"(%4) : (i1) -> ()
}) : () -> ()
