module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @bar() -> !llvm.ptr
  llvm.func @foo() -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.invoke @bar() to ^bb1 unwind ^bb2 : () -> !llvm.ptr
  ^bb1:  // pred: ^bb0
    llvm.return %1 : !llvm.ptr
  ^bb2:  // pred: ^bb0
    %2 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @__gxx_personality_v0(...) -> i32
}
