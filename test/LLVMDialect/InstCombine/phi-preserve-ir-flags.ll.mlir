module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">, #dlti.dl_entry<"dlti.stack_alignment", 64 : i64>>} {
  llvm.func @func1(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.br ^bb3(%0 : f32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %arg2  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.br ^bb3(%1 : f32)
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : f32
  }
  llvm.func @func2(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %0 = llvm.fsub %arg0, %arg1  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.br ^bb3(%0 : f32)
  ^bb2:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %arg2  : f32
    llvm.br ^bb3(%1 : f32)
  ^bb3(%2: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %2 : f32
  }
  llvm.func @func3(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    %2 = llvm.fsub %arg1, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.br ^bb3(%2 : f32)
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : f32
  }
  llvm.func @func4(%arg0: f32, %arg1: f32, %arg2: f32, %arg3: i1) -> f32 {
    %0 = llvm.mlir.constant(2.000000e+00 : f32) : f32
    llvm.cond_br %arg3, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %1 = llvm.fsub %arg0, %0  {fastmathFlags = #llvm.fastmath<fast>} : f32
    llvm.br ^bb3(%1 : f32)
  ^bb2:  // pred: ^bb0
    %2 = llvm.fsub %arg1, %0  : f32
    llvm.br ^bb3(%2 : f32)
  ^bb3(%3: f32):  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : f32
  }
}
