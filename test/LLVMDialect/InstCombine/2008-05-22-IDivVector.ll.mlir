"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<3xi8>):  // no predecessors
    %0 = "llvm.sdiv"(%arg0, %arg0) : (vector<3xi8>, vector<3xi8>) -> vector<3xi8>
    "llvm.return"(%0) : (vector<3xi8>) -> ()
  }) {linkage = 10 : i64, sym_name = "f", type = !llvm.func<vector<3xi8> (vector<3xi8>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
