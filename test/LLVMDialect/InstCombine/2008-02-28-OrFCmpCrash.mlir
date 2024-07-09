module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: f32, %arg1: f80) -> f32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.fcmp "uno" %arg1, %0 : f80
    %3 = llvm.fcmp "uno" %arg0, %1 : f32
    %4 = llvm.or %2, %3  : i1
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : f32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : f32
  }
  llvm.func @test_logical(%arg0: f32, %arg1: f80) -> f32 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f80) : f80
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(true) : i1
    %3 = llvm.fcmp "uno" %arg1, %0 : f80
    %4 = llvm.fcmp "uno" %arg0, %1 : f32
    %5 = llvm.select %3, %2, %4 : i1, i1
    llvm.cond_br %5, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %1 : f32
  ^bb2:  // pred: ^bb0
    llvm.return %1 : f32
  }
}
