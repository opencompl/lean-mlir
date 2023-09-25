"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.array<2 x f64>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @cabs, fastmathFlags = #llvm.fastmath<>} : (!llvm.array<2 x f64>) -> f64
    "llvm.return"(%0) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "std_cabs", type = !llvm.func<f64 (array<2 x f64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.array<2 x f32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @cabsf, fastmathFlags = #llvm.fastmath<>} : (!llvm.array<2 x f32>) -> f32
    "llvm.return"(%0) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "std_cabsf", type = !llvm.func<f32 (array<2 x f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.array<2 x f128>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @cabsl, fastmathFlags = #llvm.fastmath<>} : (!llvm.array<2 x f128>) -> f128
    "llvm.return"(%0) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "std_cabsl", type = !llvm.func<f128 (array<2 x f128>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.array<2 x f64>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @cabs, fastmathFlags = #llvm.fastmath<>} : (!llvm.array<2 x f64>) -> f64
    "llvm.return"(%0) : (f64) -> ()
  }) {linkage = 10 : i64, sym_name = "fast_cabs", type = !llvm.func<f64 (array<2 x f64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.array<2 x f32>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @cabsf, fastmathFlags = #llvm.fastmath<>} : (!llvm.array<2 x f32>) -> f32
    "llvm.return"(%0) : (f32) -> ()
  }) {linkage = 10 : i64, sym_name = "fast_cabsf", type = !llvm.func<f32 (array<2 x f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.array<2 x f128>):  // no predecessors
    %0 = "llvm.call"(%arg0) {callee = @cabsl, fastmathFlags = #llvm.fastmath<>} : (!llvm.array<2 x f128>) -> f128
    "llvm.return"(%0) : (f128) -> ()
  }) {linkage = 10 : i64, sym_name = "fast_cabsl", type = !llvm.func<f128 (array<2 x f128>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cabs", type = !llvm.func<f64 (array<2 x f64>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cabsf", type = !llvm.func<f32 (array<2 x f32>)>} : () -> ()
  "llvm.func"() ( {
  }) {linkage = 10 : i64, sym_name = "cabsl", type = !llvm.func<f128 (array<2 x f128>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
