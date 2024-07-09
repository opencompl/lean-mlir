module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 128 : i64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @oppositesign(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-32768 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.or %arg0, %0  : i16
    %3 = llvm.and %arg1, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @zero_sign_bit(%arg0: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.mlir.constant(512 : i16) : i16
    %2 = llvm.and %arg0, %0  : i16
    %3 = llvm.add %2, %1  : i16
    llvm.return %3 : i16
  }
  llvm.func @zero_sign_bit2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(32767 : i16) : i16
    %1 = llvm.and %arg0, %0  : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.add %1, %2  : i16
    llvm.return %3 : i16
  }
  llvm.func @bounded(i16) -> i16
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @add_bounded_values(%arg0: i16, %arg1: i16) -> i16 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.call @bounded(%arg0) : (i16) -> i16
    %3 = llvm.invoke @bounded(%arg1) to ^bb1 unwind ^bb2 : (i16) -> i16
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    %5 = llvm.landingpad (filter %0 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.return %1 : i16
  }
  llvm.func @add_bounded_values_2(%arg0: i16, %arg1: i16) -> i16 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.undef : !llvm.array<0 x ptr>
    %1 = llvm.mlir.constant(42 : i16) : i16
    %2 = llvm.call @bounded(%arg0) : (i16) -> i16
    %3 = llvm.invoke @bounded(%arg1) to ^bb1 unwind ^bb2 : (i16) -> i16
  ^bb1:  // pred: ^bb0
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  ^bb2:  // pred: ^bb0
    %5 = llvm.landingpad (filter %0 : !llvm.array<0 x ptr>) : !llvm.struct<(ptr, i32)>
    llvm.return %1 : i16
  }
  llvm.func @ripple_nsw1(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-16385 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_nsw2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(-16385 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_nsw3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21843 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_nsw4(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21843 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_nsw5(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_nsw6(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_no_nsw1(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.and %arg1, %0  : i32
    %2 = llvm.add %1, %arg0  : i32
    llvm.return %2 : i32
  }
  llvm.func @ripple_no_nsw2(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(1 : i16) : i16
    %1 = llvm.mlir.constant(32767 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_no_nsw3(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21845 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_no_nsw4(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21845 : i16) : i16
    %1 = llvm.mlir.constant(21845 : i16) : i16
    %2 = llvm.and %arg1, %0  : i16
    %3 = llvm.and %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_no_nsw5(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21847 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %2, %3  : i16
    llvm.return %4 : i16
  }
  llvm.func @ripple_no_nsw6(%arg0: i16, %arg1: i16) -> i16 {
    %0 = llvm.mlir.constant(-21847 : i16) : i16
    %1 = llvm.mlir.constant(-10923 : i16) : i16
    %2 = llvm.or %arg1, %0  : i16
    %3 = llvm.or %arg0, %1  : i16
    %4 = llvm.add %3, %2  : i16
    llvm.return %4 : i16
  }
  llvm.func @PR38021(%arg0: i8) -> i8 {
    %0 = llvm.mlir.constant(3 : i8) : i8
    %1 = llvm.mlir.constant(-63 : i8) : i8
    %2 = llvm.lshr %arg0, %0  : i8
    %3 = llvm.add %2, %1  : i8
    llvm.return %3 : i8
  }
}
