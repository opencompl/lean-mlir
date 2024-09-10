module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>>} {
  llvm.func @test1(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @ceil(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test1_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.ceil(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test2(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test2_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.fabs(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @fmf_test2(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @fabs(%0) {fastmathFlags = #llvm.fastmath<nnan>} : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test3(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @floor(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test3_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.floor(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test4(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @nearbyint(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @shrink_nearbyint_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.nearbyint(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test5(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @rint(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test6(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @round(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test6_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.round(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test6a(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @roundeven(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test6a_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.roundeven(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test7(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @trunc(%0) : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test7_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.intr.trunc(%0)  : (f64) -> f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test8(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @ceil(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test8_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.ceil(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test9(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fabs(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test9_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.fabs(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test10(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @floor(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @test10_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.floor(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @test11(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @nearbyint(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @test11_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.nearbyint(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %2, %1 : f64
    llvm.return %3 : i1
  }
  llvm.func @test12(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @rint(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test13(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @round(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test13_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.round(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test13a(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @roundeven(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test13a_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.roundeven(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test14(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @trunc(%0) : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test14_intrin(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.intr.trunc(%0)  : (f64) -> f64
    %3 = llvm.fcmp "oeq" %1, %2 : f64
    llvm.return %3 : i1
  }
  llvm.func @test15(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmin(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fpext %arg2 : f32 to f64
    %4 = llvm.fcmp "oeq" %2, %3 : f64
    llvm.return %4 : i1
  }
  llvm.func @test16(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg2 : f32 to f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.call @fmin(%1, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %0, %3 : f64
    llvm.return %4 : i1
  }
  llvm.func @test17(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @fmax(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fpext %arg2 : f32 to f64
    %4 = llvm.fcmp "oeq" %2, %3 : f64
    llvm.return %4 : i1
  }
  llvm.func @test18(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg2 : f32 to f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fpext %arg1 : f32 to f64
    %3 = llvm.call @fmax(%1, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %0, %3 : f64
    llvm.return %4 : i1
  }
  llvm.func @test19(%arg0: f32, %arg1: f32, %arg2: f32) -> i1 {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.call @copysign(%0, %1) : (f64, f64) -> f64
    %3 = llvm.fpext %arg2 : f32 to f64
    %4 = llvm.fcmp "oeq" %2, %3 : f64
    llvm.return %4 : i1
  }
  llvm.func @test20(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.call @fmin(%0, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %1, %3 : f64
    llvm.return %4 : i1
  }
  llvm.func @test21(%arg0: f32, %arg1: f32) -> i1 {
    %0 = llvm.mlir.constant(1.300000e+00 : f64) : f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fpext %arg0 : f32 to f64
    %3 = llvm.call @fmin(%0, %2) : (f64, f64) -> f64
    %4 = llvm.fcmp "oeq" %1, %3 : f64
    llvm.return %4 : i1
  }
  llvm.func @fabs(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @ceil(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @copysign(f64, f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @floor(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @nearbyint(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @rint(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @round(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @roundeven(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @trunc(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @fmin(f64, f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
  llvm.func @fmax(f64, f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind"]}
}
