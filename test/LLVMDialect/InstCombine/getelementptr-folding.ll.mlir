"module"() ( {
  "llvm.mlir.global"() ( {
  }) {linkage = 10 : i64, sym_name = "matrix_identity_float3x3", type = !llvm.struct<"struct.matrix_float3x3", (array<3 x vector<3xf32>>)>} : () -> ()
  "llvm.mlir.global"() ( {
    %0 = "llvm.mlir.constant"() {value = 3 : i64} : () -> i64
    %1 = "llvm.mlir.constant"() {value = 1 : i64} : () -> i64
    %2 = "llvm.mlir.constant"() {value = 0 : i32} : () -> i32
    %3 = "llvm.mlir.constant"() {value = 0 : i64} : () -> i64
    %4 = "llvm.mlir.addressof"() {global_name = @matrix_identity_float3x3} : () -> !llvm.ptr<struct<"struct.matrix_float3x3", (array<3 x vector<3xf32>>)>>
    %5 = "llvm.getelementptr"(%4, %3, %2, %1, %0) : (!llvm.ptr<struct<"struct.matrix_float3x3", (array<3 x vector<3xf32>>)>>, i64, i32, i64, i64) -> !llvm.ptr<f32>
    "llvm.return"(%5) : (!llvm.ptr<f32>) -> ()
  }) {linkage = 10 : i64, sym_name = "bbb", type = !llvm.ptr<f32>} : () -> ()
  "module_terminator"() : () -> ()
}) : () -> ()
