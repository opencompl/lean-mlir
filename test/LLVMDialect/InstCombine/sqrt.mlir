module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test1(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test2(%arg0: f32) -> f32 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "ssp"]} {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    %2 = llvm.fptrunc %1 : f64 to f32
    llvm.return %2 : f32
  }
  llvm.func @test3(%arg0: !llvm.ptr) -> f32 attributes {passthrough = ["nounwind", "ssp", ["uwtable", "2"]]} {
    %0 = llvm.mlir.constant(2 : i64) : i64
    %1 = llvm.mlir.undef : f32
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, f32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> f32
    %4 = llvm.fmul %3, %3  : f32
    %5 = llvm.fadd %1, %4  : f32
    %6 = llvm.fpext %5 : f32 to f64
    %7 = llvm.call @sqrt(%6) : (f64) -> f64
    %8 = llvm.call @foo(%7) : (f64) -> i32
    %9 = llvm.fptrunc %7 : f64 to f32
    llvm.return %9 : f32
  }
  llvm.func @<<INVALID EMPTY SYMBOL>>(%arg0: f32) {
    %0 = llvm.fpext %arg0 : f32 to f64
    %1 = llvm.call @sqrt(%0) : (f64) -> f64
    llvm.return
  }
  llvm.func @sqrt_call_nnan_f32(%arg0: f32) -> f32 {
    %0 = llvm.call @sqrtf(%arg0) {fastmathFlags = #llvm.fastmath<nnan>} : (f32) -> f32
    llvm.return %0 : f32
  }
  llvm.func @sqrt_call_nnan_f64(%arg0: f64) -> f64 {
    %0 = llvm.call @sqrt(%arg0) {fastmathFlags = #llvm.fastmath<nnan, ninf>} : (f64) -> f64
    llvm.return %0 : f64
  }
  llvm.func @sqrt_call_fabs_f32(%arg0: f32) -> f32 {
    %0 = llvm.intr.fabs(%arg0)  : (f32) -> f32
    %1 = llvm.call @sqrtf(%0) : (f32) -> f32
    llvm.return %1 : f32
  }
  llvm.func @sqrt_exp(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp_2(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp2(%arg0: f64) -> f64 {
    %0 = llvm.call @exp2(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp10(%arg0: f64) -> f64 {
    %0 = llvm.call @exp10(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp_nofast_1(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp_nofast_2(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp_merge_constant(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.mlir.constant(1.000000e+01 : f64) : f64
    %1 = llvm.fmul %arg0, %0  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : f64
    %2 = llvm.intr.exp(%1)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %3 = llvm.intr.sqrt(%2)  {fastmathFlags = #llvm.fastmath<nsz, reassoc>} : (f64) -> f64
    llvm.return %3 : f64
  }
  llvm.func @sqrt_exp_intr_and_libcall(%arg0: f64) -> f64 {
    %0 = llvm.call @exp(%arg0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp_intr_and_libcall_2(%arg0: f64) -> f64 {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    %1 = llvm.call @sqrt(%0) {fastmathFlags = #llvm.fastmath<reassoc>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrt_exp_vec(%arg0: vector<2xf32>) -> vector<2xf32> {
    %0 = llvm.intr.exp(%arg0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>) -> vector<2xf32>
    %1 = llvm.intr.sqrt(%0)  {fastmathFlags = #llvm.fastmath<reassoc>} : (vector<2xf32>) -> vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @foo(f64) -> i32
  llvm.func @sqrt(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>}
  llvm.func @sqrtf(f32) -> f32
  llvm.func @exp(f64) -> f64
  llvm.func @exp2(f64) -> f64
  llvm.func @exp10(f64) -> f64
}
