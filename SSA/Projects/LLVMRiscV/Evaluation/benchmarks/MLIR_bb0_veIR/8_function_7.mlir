"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i1, %arg2: i64, %arg3: i32):
	%0 = "llvm.sext"(%arg3) : (i32) -> i64
	%1 = "llvm.lshr"(%arg2, %0) : (i64, i64) -> i64
	%2 = "llvm.icmp"(%1, %arg0) <{predicate = 5 : i64}> : (i64, i64) -> i1
	%3 = "llvm.sext"(%2) : (i1) -> i64
	%4 = "llvm.select"(%arg1, %1, %3) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%5 = "llvm.and"(%4, %4) : (i64, i64) -> i64
	%6 = "llvm.udiv"(%arg0, %5) : (i64, i64) -> i64
	%7 = "llvm.trunc"(%6) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%7) : (i32) -> ()
}) : () -> ()
