module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(false) : i1
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.or %0, %0  : i1
    llvm.cond_br %2, ^bb1, ^bb2(%arg0 : i32)
  ^bb1:  // pred: ^bb0
    %3 = llvm.add %arg0, %1  : i32
    llvm.br ^bb2(%3 : i32)
  ^bb2(%4: i32):  // 2 preds: ^bb0, ^bb1
    llvm.return %4 : i32
  }
  llvm.func @test2(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.intr.stacksave : !llvm.ptr
    %1 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test3() {
    %0 = llvm.mlir.undef : !llvm.ptr
    llvm.intr.lifetime.start -1, %0 : !llvm.ptr
    llvm.intr.lifetime.end -1, %0 : !llvm.ptr
    llvm.return
  }
}
