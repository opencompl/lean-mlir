"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>, %arg1: vector<4xf32>):  // no predecessors
    %0 = "llvm.fadd"(%arg0, %arg1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    %1 = "llvm.fsub"(%0, %arg1) : (vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    "llvm.return"(%1) : (vector<4xf32>) -> ()
  }) {linkage = 10 : i64, sym_name = "test", type = !llvm.func<vector<4xf32> (vector<4xf32>, vector<4xf32>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
