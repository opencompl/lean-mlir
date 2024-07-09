module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %10 : f32
  }
  llvm.func @test2() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %10 : f32
  }
  llvm.func @test3() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %10 : f32
  }
  llvm.func @test4() -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(-1.000000e-01 : f64) : f64
    %3 = llvm.mlir.constant(-1.000000e+00 : f64) : f64
    %4 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.bitcast %1 : i32 to i32
    %7 = llvm.frem %2, %3  : f64
    %8 = llvm.fptrunc %7 : f64 to f32
    llvm.store %8, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.store %9, %4 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    %10 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %10 : f32
  }
}
