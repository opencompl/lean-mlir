module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fadd %1, %0  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test2(%arg0: f32, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fmul %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test3(%arg0: f32, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test4(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(-0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f32 to f64
    %2 = llvm.fsub %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test4_unary_fneg(%arg0: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fneg %0  : f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test5(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<2xf64>) : vector<2xf64>
    %2 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %3 = llvm.fadd %2, %1  : vector<2xf64>
    %4 = llvm.fptrunc %3 : vector<2xf64> to vector<2xf32>
    llvm.return %4 : vector<2xf32>
  }
  llvm.func @test6(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, -0.000000e+00]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fadd %1, %0  : vector<2xf64>
    %3 = llvm.fptrunc %2 : vector<2xf64> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @test6_undef(%arg0: vector<2xf32>) -> vector<2xf32> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.undef : f64
    %1 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %2 = llvm.mlir.undef : vector<2xf64>
    %3 = llvm.mlir.constant(0 : i32) : i32
    %4 = llvm.insertelement %1, %2[%3 : i32] : vector<2xf64>
    %5 = llvm.mlir.constant(1 : i32) : i32
    %6 = llvm.insertelement %0, %4[%5 : i32] : vector<2xf64>
    %7 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %8 = llvm.fadd %7, %6  : vector<2xf64>
    %9 = llvm.fptrunc %8 : vector<2xf64> to vector<2xf32>
    llvm.return %9 : vector<2xf32>
  }
  llvm.func @not_half_shrinkable(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.mlir.constant(dense<[0.000000e+00, 2.049000e+03]> : vector<2xf64>) : vector<2xf64>
    %1 = llvm.fpext %arg0 : vector<2xf32> to vector<2xf64>
    %2 = llvm.fadd %1, %0  : vector<2xf64>
    %3 = llvm.fptrunc %2 : vector<2xf64> to vector<2xf32>
    llvm.return %3 : vector<2xf32>
  }
  llvm.func @test7(%arg0: f32) -> f16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fptrunc %0 : f64 to f16
    llvm.return %1 : f16
  }
  llvm.func @test8(%arg0: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fptrunc %0 : f64 to f32
    llvm.return %1 : f32
  }
  llvm.func @test9(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fmul %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test10(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fmul %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test11(%arg0: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(0.000000e+00 : f64) : f64
    %1 = llvm.fpext %arg0 : f16 to f64
    %2 = llvm.fadd %1, %0  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test12(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fadd %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test13(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test14(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test15(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.fdiv %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test16(%arg0: f16, %arg1: f32) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f32 to f64
    %2 = llvm.frem %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test17(%arg0: f32, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.frem %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @test18(%arg0: f16, %arg1: f16) -> f32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : f16 to f64
    %1 = llvm.fpext %arg1 : f16 to f64
    %2 = llvm.frem %0, %1  : f64
    %3 = llvm.fptrunc %2 : f64 to f32
    llvm.return %3 : f32
  }
  llvm.func @ItoFtoF_s25_f32_f64(%arg0: i25) -> f64 {
    %0 = llvm.sitofp %arg0 : i25 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }
  llvm.func @ItoFtoF_u24_f32_f128(%arg0: i24) -> f128 {
    %0 = llvm.uitofp %arg0 : i24 to f32
    %1 = llvm.fpext %0 : f32 to f128
    llvm.return %1 : f128
  }
  llvm.func @ItoFtoF_s26_f32_f64(%arg0: i26) -> f64 {
    %0 = llvm.sitofp %arg0 : i26 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }
  llvm.func @ItoFtoF_u25_f32_f64(%arg0: i25) -> f64 {
    %0 = llvm.uitofp %arg0 : i25 to f32
    %1 = llvm.fpext %0 : f32 to f64
    llvm.return %1 : f64
  }
  llvm.func @FtoItoFtoF_f32_s32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.sitofp %0 : i32 to f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @use_i32(i32)
  llvm.func @use_f32(f32)
  llvm.func @FtoItoFtoF_f32_u32_f32_f64_extra_uses(%arg0: f32) -> f64 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    llvm.call @use_i32(%0) : (i32) -> ()
    %1 = llvm.uitofp %0 : i32 to f32
    llvm.call @use_f32(%1) : (f32) -> ()
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @FtoItoFtoF_v3f16_v3s32_v3f32_v3f64(%arg0: vector<3xf16>) -> vector<3xf64> {
    %0 = llvm.fptosi %arg0 : vector<3xf16> to vector<3xi32>
    %1 = llvm.sitofp %0 : vector<3xi32> to vector<3xf32>
    %2 = llvm.fpext %1 : vector<3xf32> to vector<3xf64>
    llvm.return %2 : vector<3xf64>
  }
  llvm.func @FtoItoFtoF_f32_s64_f64_f128(%arg0: f32) -> f128 {
    %0 = llvm.fptosi %arg0 : f32 to i64
    %1 = llvm.sitofp %0 : i64 to f64
    %2 = llvm.fpext %1 : f64 to f128
    llvm.return %2 : f128
  }
  llvm.func @FtoItoFtoF_f64_u54_f64_f80(%arg0: f64) -> f80 {
    %0 = llvm.fptoui %arg0 : f64 to i54
    %1 = llvm.uitofp %0 : i54 to f64
    %2 = llvm.fpext %1 : f64 to f80
    llvm.return %2 : f80
  }
  llvm.func @FtoItoFtoF_f64_u54_f64_p128(%arg0: f64) -> !llvm.ppc_fp128 {
    %0 = llvm.fptoui %arg0 : f64 to i54
    %1 = llvm.uitofp %0 : i54 to f64
    %2 = llvm.fpext %1 : f64 to !llvm.ppc_fp128
    llvm.return %2 : !llvm.ppc_fp128
  }
  llvm.func @FtoItoFtoF_f32_us32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptoui %arg0 : f32 to i32
    %1 = llvm.sitofp %0 : i32 to f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @FtoItoFtoF_f32_su32_f32_f64(%arg0: f32) -> f64 {
    %0 = llvm.fptosi %arg0 : f32 to i32
    %1 = llvm.uitofp %0 : i32 to f32
    %2 = llvm.fpext %1 : f32 to f64
    llvm.return %2 : f64
  }
  llvm.func @bf16_to_f32_to_f16(%arg0: bf16) -> f16 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.fpext %arg0 : bf16 to f32
    %1 = llvm.fptrunc %0 : f32 to f16
    llvm.return %1 : f16
  }
  llvm.func @bf16_frem(%arg0: bf16) -> bf16 {
    %0 = llvm.mlir.constant(6.281250e+00 : f32) : f32
    %1 = llvm.fpext %arg0 : bf16 to f32
    %2 = llvm.frem %1, %0  : f32
    %3 = llvm.fptrunc %2 : f32 to bf16
    llvm.return %3 : bf16
  }
}
