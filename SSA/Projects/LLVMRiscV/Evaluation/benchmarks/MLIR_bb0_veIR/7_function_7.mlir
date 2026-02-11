"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64):
	%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%1 = "llvm.urem"(%arg0, %arg0) : (i64, i64) -> i64
	%2 = "llvm.sdiv"(%arg0, %1) : (i64, i64) -> i64
	%3 = "llvm.select"(%0, %2, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%4 = "llvm.trunc"(%3) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%5 = "llvm.select"(%4, %arg1, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%6) : (i32) -> ()
}) : () -> ()
