module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func fastcc @gimp_operation_color_balance_map(%arg0: f32, %arg1: f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["inlinehint", "nounwind"]} {
    %0 = llvm.mlir.constant(1.600000e+01 : f64) : f64
    %1 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %2 = llvm.mlir.constant(1.075000e+00 : f64) : f64
    %3 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %4 = llvm.fpext %arg0 : f32 to f64
    %5 = llvm.fdiv %4, %0  : f64
    %6 = llvm.fadd %5, %1  : f64
    %7 = llvm.fdiv %1, %6  : f64
    %8 = llvm.fsub %2, %7  : f64
    %9 = llvm.fsub %1, %8  : f64
    %10 = llvm.fadd %8, %1  : f64
    %11 = llvm.fcmp "ogt" %arg1, %3 : f64
    %12 = llvm.select %11, %9, %10 : i1, f64
    %13 = llvm.fmul %arg1, %12  : f64
    %14 = llvm.fadd %13, %13  : f64
    llvm.return %14 : f64
  }
  llvm.func @foo(%arg0: i1, %arg1: vector<4xf32>, %arg2: vector<4xf32>, %arg3: vector<4xf32>) -> vector<4xf32> {
    %0 = llvm.fadd %arg1, %arg2  : vector<4xf32>
    %1 = llvm.fsub %arg1, %arg3  : vector<4xf32>
    %2 = llvm.select %arg0, %0, %1 : i1, vector<4xf32>
    llvm.return %2 : vector<4xf32>
  }
}
