"builtin.module"() ({
	^bb0(%arg0: i64, %arg1: i64, %arg2: i64, %arg3: i32):
	%0 = "llvm.xor"(%arg0, %arg1) : (i64, i64) -> i64
	%1 = "llvm.icmp"(%arg1, %arg2) <{predicate = 9 : i64}> : (i64, i64) -> i1
	%2 = "llvm.sext"(%arg3) : (i32) -> i64
	%3 = "llvm.select"(%1, %0, %2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%4 = "llvm.and"(%0, %3) : (i64, i64) -> i64
	%5 = "llvm.xor"(%arg0, %4) : (i64, i64) -> i64
	%6 = "llvm.trunc"(%5) <{overflowFlags = 0 : i32}> : (i64) -> i32
	"llvm.return"(%6) : (i32) -> ()
}) : () -> ()
