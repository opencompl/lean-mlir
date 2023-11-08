"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: i65):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = 65 : i65} : () -> i65
    %1 = "llvm.ashr"(%arg0, %0) : (i65, i65) -> i65
    "llvm.return"(%1) : (i65) -> ()
  }) {linkage = 10 : i64, sym_name = "foo", type = !llvm.func<i65 (i65)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
