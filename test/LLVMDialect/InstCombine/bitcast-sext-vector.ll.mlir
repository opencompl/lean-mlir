"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi8>, %arg1: vector<4xi8>):  // no predecessors
    %0 = "llvm.icmp"(%arg0, %arg1) {predicate = 0 : i64} : (vector<4xi8>, vector<4xi8>) -> i1
    %1 = "llvm.sext"(%0) : (i1) -> vector<4xi8>
    %2 = "llvm.bitcast"(%1) : (vector<4xi8>) -> i32
    "llvm.return"(%2) : (i32) -> ()
  }) {linkage = 10 : i64, sym_name = "t", type = !llvm.func<i32 (vector<4xi8>, vector<4xi8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
