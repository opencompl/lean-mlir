module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @a() {addr_space = 0 : i32} : i32
  llvm.mlir.global external @b() {addr_space = 0 : i32} : i32
  llvm.mlir.global external constant @c(42 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global external @g(42 : i32) {addr_space = 0 : i32} : i32
  llvm.func @test1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test2(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load volatile %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test4(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test5(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test6(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test7(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test8(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    %1 = llvm.load %arg0 atomic acquire {alignment = 4 : i64} : !llvm.ptr -> i32
    %2 = llvm.add %0, %1  : i32
    llvm.return %2 : i32
  }
  llvm.func @test9() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @test9_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @test10() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @test10_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @test11() -> i32 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @test11_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.load %0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @test12() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test12_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test13() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test13_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test14() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test14_no_null_opt() -> i32 attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    llvm.store %0, %1 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test15(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
  llvm.func @test16(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic monotonic {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
  llvm.func @test17(%arg0: i1) -> i32 {
    %0 = llvm.mlir.addressof @a : !llvm.ptr
    %1 = llvm.mlir.addressof @b : !llvm.ptr
    %2 = llvm.select %arg0, %0, %1 : i1, !llvm.ptr
    %3 = llvm.load %2 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
  llvm.func @test22(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %1 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i32
  }
  llvm.func @test23(%arg0: i1) -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(0 : i32) : i32
    llvm.cond_br %arg0, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    llvm.store %2, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb2:  // pred: ^bb0
    llvm.store %0, %1 atomic monotonic {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    llvm.return %3 : i32
  }
  llvm.func @clobber()
  llvm.func @test18(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.call @clobber() : () -> ()
    llvm.store %1, %arg0 atomic unordered {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test19(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.call @clobber() : () -> ()
    llvm.store %1, %arg0 atomic seq_cst {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test20(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %arg1, %arg0 atomic unordered {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @test21(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.store %arg1, %arg0 atomic monotonic {alignment = 4 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return %0 : i32
  }
  llvm.func @pr27490a(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store volatile %0, %arg1 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @pr27490b(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.store %0, %arg1 atomic seq_cst {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.return
  }
  llvm.func @no_atomic_vector_load(%arg0: !llvm.ptr) -> vector<2xf32> {
    %0 = llvm.load %arg0 atomic unordered {alignment = 8 : i64} : !llvm.ptr -> i64
    %1 = llvm.bitcast %0 : i64 to vector<2xf32>
    llvm.return %1 : vector<2xf32>
  }
  llvm.func @no_atomic_vector_store(%arg0: vector<2xf32>, %arg1: !llvm.ptr) {
    %0 = llvm.bitcast %arg0 : vector<2xf32> to i64
    llvm.store %0, %arg1 atomic unordered {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @atomic_load_from_constant_global() -> i32 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.load %1 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @atomic_load_from_constant_global_bitcast() -> i8 {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.load %1 atomic seq_cst {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %2 : i8
  }
  llvm.func @atomic_load_from_non_constant_global() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr
    %2 = llvm.load %1 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return
  }
  llvm.func @volatile_load_from_constant_global() {
    %0 = llvm.mlir.constant(42 : i32) : i32
    %1 = llvm.mlir.addressof @c : !llvm.ptr
    %2 = llvm.load volatile %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return
  }
}
