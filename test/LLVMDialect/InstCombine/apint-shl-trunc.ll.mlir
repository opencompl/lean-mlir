"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i39, %arg1: i39):  // no predecessors
    %0 = "llvm.lshr"(%arg0, %arg1) : (i39, i39) -> i39
    %1 = "llvm.trunc"(%0) : (i39) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test0", type = !llvm.func<i1 (i39, i39)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i799, %arg1: i799):  // no predecessors
    %0 = "llvm.lshr"(%arg0, %arg1) : (i799, i799) -> i799
    %1 = "llvm.trunc"(%0) : (i799) -> i1
    "llvm.return"(%1) : (i1) -> ()
  }) {linkage = 10 : i64, sym_name = "test1", type = !llvm.func<i1 (i799, i799)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi39>, %arg1: vector<2xi39>):  // no predecessors
    %0 = "llvm.lshr"(%arg0, %arg1) : (vector<2xi39>, vector<2xi39>) -> vector<2xi39>
    %1 = "llvm.trunc"(%0) : (vector<2xi39>) -> vector<2xi1>
    "llvm.return"(%1) : (vector<2xi1>) -> ()
  }) {linkage = 10 : i64, sym_name = "test0vec", type = !llvm.func<vector<2xi1> (vector<2xi39>, vector<2xi39>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
