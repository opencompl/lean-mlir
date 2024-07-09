module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @constant_fold_fma_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %3 = llvm.intr.fma(%0, %1, %2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @constant_fold_fma_v4f32() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[1.000000e+00, 2.000000e+00, 3.000000e+00, 4.000000e+00]> : vector<4xf32>) : vector<4xf32>
    %1 = llvm.mlir.constant(dense<2.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.constant(dense<1.000000e+01> : vector<4xf32>) : vector<4xf32>
    %3 = llvm.intr.fma(%0, %1, %2)  : (vector<4xf32>, vector<4xf32>, vector<4xf32>) -> vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @constant_fold_fmuladd_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(4.000000e+00 : f32) : f32
    %3 = llvm.intr.fmuladd(%0, %1, %2)  : (f32, f32, f32) -> f32
    llvm.return %3 : f32
  }
  llvm.func @constant_fold_fma_f64() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %3 = llvm.intr.fma(%0, %1, %2)  : (f64, f64, f64) -> f64
    llvm.return %3 : f64
  }
  llvm.func @constant_fold_fmuladd_f64() -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(2.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(4.000000e+00 : f64) : f64
    %3 = llvm.intr.fmuladd(%0, %1, %2)  : (f64, f64, f64) -> f64
    llvm.return %3 : f64
  }
  llvm.func @constant_fold_frem_f32() -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(4.03345148E+18 : f32) : f32
    %1 = llvm.mlir.constant(-2.50991821E+9 : f32) : f32
    %2 = llvm.frem %0, %1  : f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_frem_f64() -> f64 {
    %0 = llvm.mlir.constant(9.2233720368547758E+18 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.frem %0, %1  : f64
    llvm.return %2 : f64
  }
}
