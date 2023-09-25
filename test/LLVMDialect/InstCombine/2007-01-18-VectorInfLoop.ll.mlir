"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xi32>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<-1> : vector<4xi32>} : () -> vector<4xi32>
    %1 = "llvm.xor"(%arg0, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    %2 = "llvm.and"(%1, %0) : (vector<4xi32>, vector<4xi32>) -> vector<4xi32>
    "llvm.return"(%2) : (vector<4xi32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<vector<4xi32> (vector<4xi32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
