module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @__cxa_call_unexpected(!llvm.ptr)
  llvm.func @foo(!llvm.ptr)
  llvm.func @test_call() {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.call @foo(%0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_invoke() attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.array<0 x ptr>
    llvm.invoke @foo(%0) to ^bb1 unwind ^bb2 : (!llvm.ptr) -> ()
  ^bb1:  // pred: ^bb0
    llvm.return
  ^bb2:  // pred: ^bb0
    %2 = llvm.landingpad (filter %1 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    %3 = llvm.extractvalue %2[0] : !llvm.struct<(ptr, i32)> 
    llvm.call @__cxa_call_unexpected(%3) : (!llvm.ptr) -> ()
    llvm.unreachable
  }
}
