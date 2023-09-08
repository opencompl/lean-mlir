"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi1>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.vector.reduce.or.v4i1, fastmathFlags = #llvm.fastmath<>} : (vector<4xi1>) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "reduction_logical_or", type = !llvm.func<i1 (vector<4xi1>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi1>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @llvm.vector.reduce.and.v4i1, fastmathFlags = #llvm.fastmath<>} : (vector<4xi1>) -> i1
    "llvm.return"(%0) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "reduction_logical_and", type = !llvm.func<i1 (vector<4xi1>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.reduce.or.v4i1", type = !llvm.func<i1 (vector<4xi1>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "llvm.vector.reduce.and.v4i1", type = !llvm.func<i1 (vector<4xi1>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
