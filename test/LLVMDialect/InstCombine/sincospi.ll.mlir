module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @var32(0.000000e+00 : f32) {addr_space = 0 : i32} : f32
  llvm.mlir.global external @var64(0.000000e+00 : f64) {addr_space = 0 : i32} : f64
  llvm.func @__sinpif(f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @__cospif(f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @__sinpi(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @__cospi(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @test_instbased_f32() -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var32 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32
    %3 = llvm.call @__sinpif(%2) : (f32) -> f32
    %4 = llvm.call @__cospif(%2) : (f32) -> f32
    %5 = llvm.fadd %3, %4  : f32
    llvm.return %5 : f32
  }
  llvm.func @test_instbased_f32_other_user(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @var32 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.store %2, %arg0 {alignment = 4 : i64} : f32, !llvm.ptr
    %3 = llvm.call @__sinpif(%2) : (f32) -> f32
    %4 = llvm.call @__cospif(%2) : (f32) -> f32
    %5 = llvm.fadd %3, %4  : f32
    llvm.return %5 : f32
  }
  llvm.func @test_constant_f32() -> f32 {
    %0 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %1 = llvm.call @__sinpif(%0) : (f32) -> f32
    %2 = llvm.call @__cospif(%0) : (f32) -> f32
    %3 = llvm.fadd %1, %2  : f32
    llvm.return %3 : f32
  }
  llvm.func @test_instbased_f64() -> f64 {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.addressof @var64 : !llvm.ptr
    %2 = llvm.load %1 {alignment = 8 : i64} : !llvm.ptr -> f64
    %3 = llvm.call @__sinpi(%2) : (f64) -> f64
    %4 = llvm.call @__cospi(%2) : (f64) -> f64
    %5 = llvm.fadd %3, %4  : f64
    llvm.return %5 : f64
  }
  llvm.func @test_constant_f64() -> f64 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.call @__sinpi(%0) : (f64) -> f64
    %2 = llvm.call @__cospi(%0) : (f64) -> f64
    %3 = llvm.fadd %1, %2  : f64
    llvm.return %3 : f64
  }
  llvm.func @test_fptr(%arg0: !llvm.ptr, %arg1: f64) -> f64 {
    %0 = llvm.call @__sinpi(%arg1) : (f64) -> f64
    %1 = llvm.call %arg0(%arg1) : !llvm.ptr, (f64) -> f64
    %2 = llvm.fadd %0, %1  : f64
    llvm.return %2 : f64
  }
  llvm.func @test_cospif_used_in_branch_cond() -> i1 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(false) : i1
    %3 = llvm.call @__cospif(%0) : (f32) -> f32
    %4 = llvm.fcmp "uno" %3, %0 : f32
    llvm.cond_br %4, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.return %2 : i1
  ^bb2:  // pred: ^bb0
    llvm.return %1 : i1
  }
}
