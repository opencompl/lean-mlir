module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<16> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.func @test1a(!llvm.ptr)
  llvm.func @test1(%arg0: !llvm.ptr) {
    llvm.call @test1a(%arg0) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test1_as1_illegal(%arg0: !llvm.ptr<1>) {
    %0 = llvm.mlir.addressof @test1a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.ptr<1>) -> ()
    llvm.return
  }
  llvm.func @test1a_as1(!llvm.ptr<1>)
  llvm.func @test1_as1(%arg0: !llvm.ptr<1>) {
    llvm.call @test1a_as1(%arg0) : (!llvm.ptr<1>) -> ()
    llvm.return
  }
  llvm.func @test2a(%arg0: i8) {
    llvm.return
  }
  llvm.func @test2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.addressof @test2a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (i32) -> ()
    llvm.return %arg0 : i32
  }
  llvm.func @test3a(%arg0: i8, ...) {
    llvm.unreachable
  }
  llvm.func @test3(%arg0: i8, %arg1: i8) {
    %0 = llvm.mlir.addressof @test3a : !llvm.ptr
    llvm.call %0(%arg0, %arg1) : !llvm.ptr, (i8, i8) -> ()
    llvm.return
  }
  llvm.func @test4a() -> i8 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    llvm.return %0 : i8
  }
  llvm.func @test4() -> i32 {
    %0 = llvm.mlir.addressof @test4a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }
  llvm.func @test5a() -> i32
  llvm.func @test5() -> i32 {
    %0 = llvm.call @test5a() : () -> i32
    llvm.return %0 : i32
  }
  llvm.func @test6a(i32) -> i32
  llvm.func @test6() -> i32 {
    %0 = llvm.mlir.addressof @test6a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }
  llvm.func @test7a() {
    llvm.return
  }
  llvm.func @test7() {
    %0 = llvm.mlir.addressof @test7a : !llvm.ptr
    %1 = llvm.mlir.constant(5 : i32) : i32
    llvm.call %0(%1) : !llvm.ptr, (i32) -> ()
    llvm.return
  }
  llvm.func @test8a()
  llvm.func @test8() -> !llvm.ptr attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.invoke @test8a() to ^bb1 unwind ^bb2 : () -> ()
  ^bb1:  // pred: ^bb0
    llvm.unreachable
  ^bb2:  // pred: ^bb0
    %1 = llvm.landingpad cleanup : !llvm.struct<(ptr, i32)>
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @test9x(!llvm.ptr, !llvm.ptr, ...) -> !llvm.ptr attributes {passthrough = ["noredzone"]}
  llvm.func @test9(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> !llvm.ptr attributes {passthrough = ["noredzone", "nounwind", "ssp"]} {
    %0 = llvm.mlir.addressof @test9x : !llvm.ptr
    %1 = llvm.call %0(%arg0, %arg1) : !llvm.ptr, (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test10a(!llvm.vec<2 x ptr>)
  llvm.func @test10(%arg0: !llvm.vec<2 x ptr>) {
    llvm.call @test10a(%arg0) : (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }
  llvm.func @test10a_mixed_as(!llvm.vec<2 x ptr<1>>)
  llvm.func @test10_mixed_as(%arg0: !llvm.vec<2 x ptr>) {
    %0 = llvm.mlir.addressof @test10a_mixed_as : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }
  llvm.func @test11a() -> !llvm.ptr {
    %0 = llvm.mlir.zero : !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test11() -> !llvm.ptr {
    %0 = llvm.call @test11a() : () -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test11a_mixed_as() -> !llvm.ptr<1> {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    llvm.return %0 : !llvm.ptr<1>
  }
  llvm.func @test11_mixed_as() -> !llvm.ptr {
    %0 = llvm.mlir.addressof @test11a_mixed_as : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @test12a() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    llvm.return %5 : !llvm.vec<2 x ptr>
  }
  llvm.func @test12() -> !llvm.vec<2 x ptr> {
    %0 = llvm.call @test12a() : () -> !llvm.vec<2 x ptr>
    llvm.return %0 : !llvm.vec<2 x ptr>
  }
  llvm.func @test12a_mixed_as() -> !llvm.vec<2 x ptr<1>> {
    %0 = llvm.mlir.zero : !llvm.ptr<1>
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr<1>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr<1>>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr<1>>
    llvm.return %5 : !llvm.vec<2 x ptr<1>>
  }
  llvm.func @test12_mixed_as() -> !llvm.vec<2 x ptr> {
    %0 = llvm.mlir.addressof @test12a_mixed_as : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> !llvm.vec<2 x ptr>
    llvm.return %1 : !llvm.vec<2 x ptr>
  }
  llvm.func @test13a(vector<2xi64>)
  llvm.func @test13(%arg0: !llvm.vec<2 x ptr>) {
    %0 = llvm.mlir.addressof @test13a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (!llvm.vec<2 x ptr>) -> ()
    llvm.return
  }
  llvm.func @test14a(!llvm.vec<2 x ptr>)
  llvm.func @test14(%arg0: vector<2xi64>) {
    %0 = llvm.mlir.addressof @test14a : !llvm.ptr
    llvm.call %0(%arg0) : !llvm.ptr, (vector<2xi64>) -> ()
    llvm.return
  }
  llvm.func @test15a() -> vector<2xi16> {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(dense<0> : vector<2xi16>) : vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }
  llvm.func @test15() -> i32 {
    %0 = llvm.mlir.addressof @test15a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> i32
    llvm.return %1 : i32
  }
  llvm.func @test16a() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %0 : i32
  }
  llvm.func @test16() -> vector<2xi16> {
    %0 = llvm.mlir.addressof @test16a : !llvm.ptr
    %1 = llvm.call %0() : !llvm.ptr, () -> vector<2xi16>
    llvm.return %1 : vector<2xi16>
  }
  llvm.func @pr28655(i32 {llvm.returned}) -> i32
  llvm.func @test17() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.call @pr28655(%0) : (i32) -> i32
    llvm.return %1 : i32
  }
  llvm.func @non_vararg(%arg0: !llvm.ptr, %arg1: i32) {
    llvm.return
  }
  llvm.func @test_cast_to_vararg(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @non_vararg : !llvm.ptr
    %1 = llvm.mlir.constant(42 : i32) : i32
    llvm.call %0(%arg0, %1) vararg(!llvm.func<void (ptr, ...)>) : !llvm.ptr, (!llvm.ptr, i32) -> ()
    llvm.return
  }
}
