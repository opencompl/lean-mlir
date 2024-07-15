module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mysqrt(%arg0: f64) -> f64 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %3 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x f64 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.bitcast %1 : i32 to i32
    llvm.store %arg0, %3 {alignment = 4 : i64} : f64, !llvm.ptr
    %7 = llvm.load %3 {alignment = 8 : i64} : !llvm.ptr -> f64
    %8 = llvm.call @fabs(%7) : (f64) -> f64
    %9 = llvm.call @sqrt(%8) : (f64) -> f64
    %10 = llvm.fadd %9, %2  : f64
    llvm.store %10, %5 {alignment = 8 : i64} : f64, !llvm.ptr
    %11 = llvm.load %5 {alignment = 8 : i64} : !llvm.ptr -> f64
    llvm.store %11, %4 {alignment = 8 : i64} : f64, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %12 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f64
    llvm.return %12 : f64
  }
  llvm.func @fabs(f64) -> f64
  llvm.func @sqrt(f64) -> f64 attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind"]}
}
