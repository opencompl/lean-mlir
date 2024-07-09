module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @mysqrt(%arg0: f32, %arg1: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %arg1, %2 {alignment = 4 : i64} : f32, !llvm.ptr
    %3 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32
    %4 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> f32
    %5 = llvm.fmul %3, %4  {fastmathFlags = #llvm.fastmath<fast>} : f32
    %6 = llvm.intr.sqrt(%5)  : (f32) -> f32
    llvm.return %6 : f32
  }
  llvm.func @fake_sqrt(%arg0: f64, %arg1: f64) -> f64 {
    %0 = llvm.fmul %arg0, %arg0  {fastmathFlags = #llvm.fastmath<fast>} : f64
    %1 = llvm.call @sqrtf(%0) {fastmathFlags = #llvm.fastmath<fast>} : (f64) -> f64
    llvm.return %1 : f64
  }
  llvm.func @sqrtf(f64) -> f64 attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>}
}
