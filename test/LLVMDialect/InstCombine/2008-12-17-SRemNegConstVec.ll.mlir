"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi8>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[2, -2]> : vector<2xi8>} : () -> vector<2xi8>
    %1 = "llvm.srem"(%arg0, %0) : (vector<2xi8>, vector<2xi8>) -> vector<2xi8>
    "llvm.return"(%1) : (vector<2xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<vector<2xi8> (vector<2xi8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
