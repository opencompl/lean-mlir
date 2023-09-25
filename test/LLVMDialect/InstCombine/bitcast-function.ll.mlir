"module"() ( {
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi32>):  // no predecessors
    "llvm.return"(%arg0) : (vector<2xi32>) -> ()
  }) {linkage = 1 : i64, sym_name = "func_v2i32", type = !llvm.func<vector<2xi32> (vector<2xi32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xf32>):  // no predecessors
    "llvm.return"(%arg0) : (vector<2xf32>) -> ()
  }) {linkage = 1 : i64, sym_name = "func_v2f32", type = !llvm.func<vector<2xf32> (vector<2xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<4xf32>):  // no predecessors
    "llvm.return"(%arg0) : (vector<4xf32>) -> ()
  }) {linkage = 1 : i64, sym_name = "func_v4f32", type = !llvm.func<vector<4xf32> (vector<4xf32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i32):  // no predecessors
    "llvm.return"(%arg0) : (i32) -> ()
  }) {linkage = 1 : i64, sym_name = "func_i32", type = !llvm.func<i32 (i32)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: i64):  // no predecessors
    "llvm.return"(%arg0) : (i64) -> ()
  }) {linkage = 1 : i64, sym_name = "func_i64", type = !llvm.func<i64 (i64)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: vector<2xi64>):  // no predecessors
    "llvm.return"(%arg0) : (vector<2xi64>) -> ()
  }) {linkage = 1 : i64, sym_name = "func_v2i64", type = !llvm.func<vector<2xi64> (vector<2xi64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.vec<2 x ptr<i32>>):  // no predecessors
    "llvm.return"(%arg0) : (!llvm.vec<2 x ptr<i32>>) -> ()
  }) {linkage = 1 : i64, sym_name = "func_v2i32p", type = !llvm.func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_i32} : () -> !llvm.ptr<func<i32 (i32)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i32 (i32)>>) -> !llvm.ptr<func<f32 (f32)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<f32 (f32)>>, f32) -> f32
    "llvm.store"(%3, %arg1) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_scalar", type = !llvm.func<void (ptr<f32>, ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<2xf32>>, %arg1: !llvm.ptr<vector<2xf32>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_v2i32} : () -> !llvm.ptr<func<vector<2xi32> (vector<2xi32>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vector<2xi32> (vector<2xi32>)>>) -> !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<vector<2xf32>>) -> vector<2xf32>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>, vector<2xf32>) -> vector<2xf32>
    "llvm.store"(%3, %arg1) : (vector<2xf32>, !llvm.ptr<vector<2xf32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_vector", type = !llvm.func<void (ptr<vector<2xf32>>, ptr<vector<2xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<2xf32>>, %arg1: !llvm.ptr<vector<2xf32>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_i64} : () -> !llvm.ptr<func<i64 (i64)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i64 (i64)>>) -> !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<vector<2xf32>>) -> vector<2xf32>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>, vector<2xf32>) -> vector<2xf32>
    "llvm.store"(%3, %arg1) : (vector<2xf32>, !llvm.ptr<vector<2xf32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_vector_scalar_same_size", type = !llvm.func<void (ptr<vector<2xf32>>, ptr<vector<2xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_v2f32} : () -> !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>) -> !llvm.ptr<func<i64 (i64)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<i64 (i64)>>, i64) -> i64
    "llvm.store"(%3, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_scalar_vector_same_size", type = !llvm.func<void (ptr<i64>, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vec<2 x ptr<i64>>>, %arg1: !llvm.ptr<vec<2 x ptr<i64>>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_v2i32p} : () -> !llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>>) -> !llvm.ptr<func<vec<2 x ptr<i64>> (vec<2 x ptr<i64>>)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<vec<2 x ptr<i64>>>) -> !llvm.vec<2 x ptr<i64>>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<vec<2 x ptr<i64>> (vec<2 x ptr<i64>>)>>, !llvm.vec<2 x ptr<i64>>) -> !llvm.vec<2 x ptr<i64>>
    "llvm.store"(%3, %arg1) : (!llvm.vec<2 x ptr<i64>>, !llvm.ptr<vec<2 x ptr<i64>>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_vector_ptrs_same_size", type = !llvm.func<void (ptr<vec<2 x ptr<i64>>>, ptr<vec<2 x ptr<i64>>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<f32>, %arg1: !llvm.ptr<f32>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_i64} : () -> !llvm.ptr<func<i64 (i64)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i64 (i64)>>) -> !llvm.ptr<func<f32 (f32)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<f32>) -> f32
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<f32 (f32)>>, f32) -> f32
    "llvm.store"(%3, %arg1) : (f32, !llvm.ptr<f32>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_mismatch_scalar_size", type = !llvm.func<void (ptr<f32>, ptr<f32>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<2xf32>>, %arg1: !llvm.ptr<vector<2xf32>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_v2i64} : () -> !llvm.ptr<func<vector<2xi64> (vector<2xi64>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vector<2xi64> (vector<2xi64>)>>) -> !llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<vector<2xf32>>) -> vector<2xf32>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<vector<2xf32> (vector<2xf32>)>>, vector<2xf32>) -> vector<2xf32>
    "llvm.store"(%3, %arg1) : (vector<2xf32>, !llvm.ptr<vector<2xf32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_mismatch_vector_element_and_bit_size", type = !llvm.func<void (ptr<vector<2xf32>>, ptr<vector<2xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>, %arg1: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_v2i32} : () -> !llvm.ptr<func<vector<2xi32> (vector<2xi32>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vector<2xi32> (vector<2xi32>)>>) -> !llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> vector<4xf32>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>, vector<4xf32>) -> vector<4xf32>
    "llvm.store"(%3, %arg1) : (vector<4xf32>, !llvm.ptr<vector<4xf32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_vector_mismatched_number_elements", type = !llvm.func<void (ptr<vector<4xf32>>, ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vector<4xf32>>, %arg1: !llvm.ptr<vector<4xf32>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_i64} : () -> !llvm.ptr<func<i64 (i64)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i64 (i64)>>) -> !llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<vector<4xf32>>) -> vector<4xf32>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>, vector<4xf32>) -> vector<4xf32>
    "llvm.store"(%3, %arg1) : (vector<4xf32>, !llvm.ptr<vector<4xf32>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_vector_scalar_mismatched_bit_size", type = !llvm.func<void (ptr<vector<4xf32>>, ptr<vector<4xf32>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<vec<4 x ptr<i32>>>, %arg1: !llvm.ptr<vec<4 x ptr<i32>>>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_i64} : () -> !llvm.ptr<func<i64 (i64)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<i64 (i64)>>) -> !llvm.ptr<func<vec<4 x ptr<i32>> (vec<4 x ptr<i32>>)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<vec<4 x ptr<i32>>>) -> !llvm.vec<4 x ptr<i32>>
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<vec<4 x ptr<i32>> (vec<4 x ptr<i32>>)>>, !llvm.vec<4 x ptr<i32>>) -> !llvm.vec<4 x ptr<i32>>
    "llvm.store"(%3, %arg1) : (!llvm.vec<4 x ptr<i32>>, !llvm.ptr<vec<4 x ptr<i32>>>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_vector_ptrs_scalar_mismatched_bit_size", type = !llvm.func<void (ptr<vec<4 x ptr<i32>>>, ptr<vec<4 x ptr<i32>>>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_v2i32p} : () -> !llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vec<2 x ptr<i32>> (vec<2 x ptr<i32>>)>>) -> !llvm.ptr<func<i64 (i64)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<i64 (i64)>>, i64) -> i64
    "llvm.store"(%3, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_scalar_vector_ptrs_same_size", type = !llvm.func<void (ptr<i64>, ptr<i64>)>} : () -> ()
  "llvm.func"() ( {
  ^bb0(%arg0: !llvm.ptr<i64>, %arg1: !llvm.ptr<i64>):  // no predecessors
    %0 = "llvm.mlir.addressof"() {global_name = @func_v4f32} : () -> !llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>
    %1 = "llvm.bitcast"(%0) : (!llvm.ptr<func<vector<4xf32> (vector<4xf32>)>>) -> !llvm.ptr<func<i64 (i64)>>
    %2 = "llvm.load"(%arg0) : (!llvm.ptr<i64>) -> i64
    %3 = "llvm.call"(%1, %2) : (!llvm.ptr<func<i64 (i64)>>, i64) -> i64
    "llvm.store"(%3, %arg1) : (i64, !llvm.ptr<i64>) -> ()
    "llvm.return"() : () -> ()
  }) {linkage = 10 : i64, sym_name = "bitcast_scalar_vector_mismatched_bit_size", type = !llvm.func<void (ptr<i64>, ptr<i64>)>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
