module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @unknown()
  llvm.func @f(!llvm.ptr)
  llvm.func @f2(!llvm.ptr, !llvm.ptr)
  llvm.func @f3(!llvm.ptr, !llvm.ptr) -> !llvm.ptr
  llvm.func @test_dead() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_lifetime() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %1 : !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.intr.lifetime.end 4, %1 : !llvm.ptr
    llvm.return
  }
  llvm.func @test_lifetime2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 4, %1 : !llvm.ptr
    llvm.call @unknown() : () -> ()
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.call @unknown() : () -> ()
    llvm.intr.lifetime.end 4, %1 : !llvm.ptr
    llvm.return
  }
  llvm.func @test_dead_readwrite() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_neg_read_after() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @test_neg_infinite_loop() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_neg_throw() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_neg_extra_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_neg_unmodeled_write() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_neg_captured_by_call() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_neg_captured_before() -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x !llvm.ptr {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.call @f(%1) : (!llvm.ptr) -> ()
    %3 = llvm.load %2 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
  llvm.func @test_unreleated_read() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f2(%1, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_unrelated_capture() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @f3(%1, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    llvm.return
  }
  llvm.func @test_neg_unrelated_capture_used_via_return() -> i8 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.call @f3(%1, %2) : (!llvm.ptr, !llvm.ptr) -> !llvm.ptr
    %4 = llvm.load %3 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %4 : i8
  }
  llvm.func @test_self_read() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @f2(%1, %1) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @removable_readnone() attributes {memory = #llvm.memory_effects<other = none, argMem = none, inaccessibleMem = none>, passthrough = ["nounwind", "willreturn"]}
  llvm.func @removable_ro() attributes {memory = #llvm.memory_effects<other = read, argMem = read, inaccessibleMem = read>, passthrough = ["nounwind", "willreturn"]}
  llvm.func @test_readnone() {
    llvm.call @removable_readnone() : () -> ()
    llvm.return
  }
  llvm.func @test_readnone_with_deopt() {
    llvm.call @removable_readnone() : () -> ()
    llvm.return
  }
  llvm.func @test_readonly() {
    llvm.call @removable_ro() : () -> ()
    llvm.return
  }
  llvm.func @test_readonly_with_deopt() {
    llvm.call @removable_ro() : () -> ()
    llvm.return
  }
}
