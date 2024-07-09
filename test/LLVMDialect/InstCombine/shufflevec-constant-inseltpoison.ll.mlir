module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @__inff4() -> vector<4xf32> attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<0x7F800000> : vector<2xf32>) : vector<2xf32>
    %1 = llvm.bitcast %0 : vector<2xf32> to vector<1xf64>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.poison : vector<2xf32>
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %6 = llvm.extractelement %1[%2 : i32] : vector<1xf64>
    %7 = llvm.bitcast %6 : f64 to i64
    %8 = llvm.bitcast %7 : i64 to vector<2xf32>
    %9 = llvm.shufflevector %8, %3 [0, 1, -1, -1] : vector<2xf32> 
    %10 = llvm.shufflevector %5, %9 [0, 1, 4, 5] : vector<4xf32> 
    llvm.return %10 : vector<4xf32>
  }
}
