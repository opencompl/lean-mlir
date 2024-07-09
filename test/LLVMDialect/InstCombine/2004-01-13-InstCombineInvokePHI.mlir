module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test() -> !llvm.ptr
  llvm.func @foo() -> i32 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(true) : i1
    %2 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %1, ^bb3(%0 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    %3 = llvm.invoke @test() to ^bb2 unwind ^bb4 : () -> !llvm.ptr
  ^bb2:  // pred: ^bb1
    llvm.br ^bb3(%3 : !llvm.ptr)
  ^bb3(%4: !llvm.ptr):  // 2 preds: ^bb0, ^bb2
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %5 : i32
  ^bb4:  // pred: ^bb1
    %6 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %2 : i32
  }
  llvm.func @__gxx_personality_v0(...) -> i32
}
