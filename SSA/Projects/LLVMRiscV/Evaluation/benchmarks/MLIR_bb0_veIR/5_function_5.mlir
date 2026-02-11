"builtin.module"() ({
	^bb0(%arg0: i64):
	%0 = "llvm.trunc"(%arg0) <{overflowFlags = 0 : i32}> : (i64) -> i1
	%1 = "llvm.select"(%0, %arg0, %arg0) <{fastmathFlags = #llvm.fastmath<none>}> : (i1, i64, i64) -> i64
	%2 = "llvm.trunc"(%1) <{overflowFlags = 0 : i32}> : (i64) -> i32
	%3 = "llvm.zext"(%2) : (i32) -> i64
	%4 = "llvm.icmp"(%3, %arg0) <{predicate = 0 : i64}> : (i64, i64) -> i1
	"llvm.return"(%4) : (i1) -> ()
}) : () -> ()
