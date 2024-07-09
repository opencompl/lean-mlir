module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @int(0 : i32) {addr_space = 0 : i32} : i32
  llvm.mlir.global external constant @opaque_global() {addr_space = 0 : i32, alignment = 4 : i64} : !llvm.struct<"opaque_type", opaque>
  llvm.func @use(...)
  llvm.func @test() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @int : !llvm.ptr
    %3 = llvm.alloca %0 x !llvm.array<0 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%3) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %4 = llvm.alloca %1 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%4) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %5 = llvm.alloca %0 x !llvm.struct<()> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%5) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    %6 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    %7 = llvm.alloca %6 x !llvm.struct<(struct<()>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%7) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test3() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(123 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.struct<(i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.getelementptr %3[%1, 0] : (!llvm.ptr, i32) -> !llvm.ptr, !llvm.struct<(i32)>
    llvm.store %2, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.return
  }
  llvm.func @test4(%arg0: i32) -> !llvm.ptr {
    %0 = llvm.alloca %arg0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.return %0 : !llvm.ptr
  }
  llvm.func @test5() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.constant(3 : i32) : i32
    %4 = llvm.mlir.constant(4 : i32) : i32
    %5 = llvm.alloca %0 x !llvm.struct<(i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x !llvm.ptr {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %1, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %5, %6 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.store %1, %6 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %2, %5 atomic unordered {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %3, %5 atomic release {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.store %4, %5 atomic seq_cst {alignment = 4 : i64} : i32, !llvm.ptr
    %8 = llvm.addrspacecast %7 : !llvm.ptr to !llvm.ptr<1>
    llvm.store %1, %8 {alignment = 4 : i64} : i32, !llvm.ptr<1>
    llvm.return
  }
  llvm.func @f(!llvm.ptr)
  llvm.func @test6() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(123 : i32) : i32
    %2 = llvm.alloca %0 x !llvm.struct<(i32)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store volatile %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.call @f(%3) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test7() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @opaque_global : !llvm.ptr
    %2 = llvm.mlir.constant(8 : i32) : i32
    %3 = llvm.alloca %0 x !llvm.struct<"real_type", (struct<(i32, ptr)>)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %1, %2) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @test8() {
    %0 = llvm.mlir.constant(100 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%1) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test9_aux(!llvm.ptr {llvm.inalloca = !llvm.struct<packed (struct<"struct_type", (i32, i32)>)>})
  llvm.func @test9(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(8 : i32) : i32
    %2 = llvm.intr.stacksave : !llvm.ptr
    %3 = llvm.alloca inalloca %0 x !llvm.struct<packed (struct<"struct_type", (i32, i32)>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%3, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.call @test9_aux(%3) : (!llvm.ptr) -> ()
    llvm.intr.stackrestore %2 : !llvm.ptr
    llvm.return
  }
  llvm.func @test10() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.mlir.constant(1 : i33) : i33
    %3 = llvm.alloca %0 x i1 {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %4 = llvm.alloca %1 x i1 {alignment = 8 : i64} : (i64) -> !llvm.ptr
    %5 = llvm.alloca %2 x i1 {alignment = 8 : i64} : (i33) -> !llvm.ptr
    llvm.call @use(%3, %4, %5) vararg(!llvm.func<void (...)>) : (!llvm.ptr, !llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test11() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.addressof @int : !llvm.ptr
    %3 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%2) vararg(!llvm.func<void (...)>) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test_inalloca_with_element_count(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(10 : i32) : i32
    %1 = llvm.alloca inalloca %0 x !llvm.struct<"struct_type", (i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.call @test9_aux(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
}
