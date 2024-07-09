module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @t0_noop(%arg0: i32) attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.constant(24 : i32) : i32
    %2 = llvm.call @cond() : () -> i1
    %3 = llvm.add %arg0, %0  : i32
    %4 = llvm.add %arg0, %1  : i32
    llvm.cond_br %2, ^bb1, ^bb4
  ^bb1:  // pred: ^bb0
    llvm.invoke @simple_throw() to ^bb2 unwind ^bb3 : () -> ()
  ^bb2:  // pred: ^bb1
    llvm.unreachable
  ^bb3:  // pred: ^bb1
    %5 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.call @consume(%3) : (i32) -> ()
    llvm.call @destructor() : () -> ()
    llvm.resume %5 : !llvm.struct<(ptr, i32)>
  ^bb4:  // pred: ^bb0
    llvm.call @consume(%4) : (i32) -> ()
    llvm.call @sideeffect() : () -> ()
    llvm.return
  }
  llvm.func @cond() -> i1
  llvm.func @sideeffect()
  llvm.func @simple_throw() attributes {passthrough = ["noreturn"]}
  llvm.func @destructor()
  llvm.func @consume(i32)
  llvm.func @__gxx_personality_v0(...) -> i32
}
