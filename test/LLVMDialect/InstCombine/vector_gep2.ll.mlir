"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<2 x ptr<i8>>):  // no predecessors
    %0 = "llvm.mlir.constant"() {value = dense<[0, 1]> : vector<2xi32>} : () -> vector<2xi32>
    %1 = "llvm.getelementptr"(%arg0, %0) : (!llvm.vec<2 x ptr<i8>>, vector<2xi32>) -> !llvm.vec<2 x ptr<i8>>
    "llvm.return"(%1) : (!llvm.vec<2 x ptr<i8>>) -> ()
  }) {linkage = 10 : i64, sym_name = "testa", type = !llvm.func<vec<2 x ptr<i8>> (vec<2 x ptr<i8>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f64>, %arg1: vector<8xi64>):  // no predecessors
    %0 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<f64>, vector<8xi64>) -> !llvm.vec<8 x ptr<f64>>
    "llvm.return"(%0) : (!llvm.vec<8 x ptr<f64>>) -> ()
  }) {linkage = 10 : i64, sym_name = "vgep_s_v8i64", type = !llvm.func<vec<8 x ptr<f64>> (ptr<f64>, vector<8xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f64>, %arg1: vector<8xi32>):  // no predecessors
    %0 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.ptr<f64>, vector<8xi32>) -> !llvm.vec<8 x ptr<f64>>
    "llvm.return"(%0) : (!llvm.vec<8 x ptr<f64>>) -> ()
  }) {linkage = 10 : i64, sym_name = "vgep_s_v8i32", type = !llvm.func<vec<8 x ptr<f64>> (ptr<f64>, vector<8xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<8 x ptr<i8>>, %arg1: i32):  // no predecessors
    %0 = "llvm.getelementptr"(%arg0, %arg1) : (!llvm.vec<8 x ptr<i8>>, i32) -> !llvm.vec<8 x ptr<i8>>
    "llvm.return"(%0) : (!llvm.vec<8 x ptr<i8>>) -> ()
  }) {linkage = 10 : i64, sym_name = "vgep_v8iPtr_i32", type = !llvm.func<vec<8 x ptr<i8>> (vec<8 x ptr<i8>>, i32)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
