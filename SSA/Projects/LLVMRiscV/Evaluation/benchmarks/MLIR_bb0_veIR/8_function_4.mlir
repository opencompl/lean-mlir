"builtin.module"() ({
	^bb0(%arg0: i1, %arg1: i64, %arg2: i64, %arg3: i32):
	%0 = "llvm.select"(%arg0, %arg1, %arg2) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%1 = "llvm.sext"(%arg3) : (i32) -> i64
	%2 = "llvm.select"(%arg0, %arg1, %1) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%3 = "llvm.lshr"(%1, %2) : (i64, i64) -> i64
	%4 = "llvm.lshr"(%0, %3) : (i64, i64) -> i64
	%5 = "llvm.select"(%arg0, %arg1, %4) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%6 = "llvm.urem"(%4, %5) : (i64, i64) -> i64
	%7 = "llvm.icmp"(%4, %6) <{predicate = 4 : i64}> : (i64, i64) -> i1
	"llvm.return"(%7) : (i1) -> ()
}) : () -> ()
