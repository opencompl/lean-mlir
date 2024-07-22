module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @constant_fold_ceil_f32_01() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.intr.ceil(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_ceil_f32_02() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.250000e+00 : f32) : f32
    %1 = llvm.intr.ceil(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_ceil_f32_03() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.250000e+00 : f32) : f32
    %1 = llvm.intr.ceil(%0)  : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @constant_fold_ceil_v4f32_01() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 1.250000e+00, -1.250000e+00, -1.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.intr.ceil(%0)  : (vector<4xf32>) -> vector<4xf32>
    llvm.return %1 : vector<4xf32>
  }
  llvm.func @constant_fold_ceil_f64_01() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @constant_fold_ceil_f64_02() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.300000e+00 : f64) : f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @constant_fold_ceil_f64_03() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-1.750000e+00 : f64) : f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
}
