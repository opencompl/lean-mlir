module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal constant @S("panic: restorelist inconsistency\00") {addr_space = 0 : i32, dso_local}
  llvm.mlir.global external constant @h("h\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hel("hel\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @hello_u("hello_u\00") {addr_space = 0 : i32}
  llvm.mlir.global external constant @UnknownConstant() {addr_space = 0 : i32} : i128
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: !llvm.ptr, %arg2: i32) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    "llvm.intr.memmove"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i32) {
    %0 = llvm.mlir.constant("panic: restorelist inconsistency\00") : !llvm.array<33 x i8>
    %1 = llvm.mlir.addressof @S : !llvm.ptr
    "llvm.intr.memmove"(%arg0, %1, %arg1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @test3(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant("h\00") : !llvm.array<2 x i8>
    %1 = llvm.mlir.addressof @h : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant("hel\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @hel : !llvm.ptr
    %5 = llvm.mlir.constant("hello_u\00") : !llvm.array<8 x i8>
    %6 = llvm.mlir.addressof @hello_u : !llvm.ptr
    %7 = llvm.mlir.constant(2 : i32) : i32
    %8 = llvm.mlir.constant(4 : i32) : i32
    %9 = llvm.mlir.constant(8 : i32) : i32
    %10 = llvm.getelementptr %1[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<2 x i8>
    %11 = llvm.getelementptr %4[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<4 x i8>
    %12 = llvm.getelementptr %6[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<8 x i8>
    %13 = llvm.getelementptr %arg0[%2, %2] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<1024 x i8>
    "llvm.intr.memmove"(%13, %10, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    "llvm.intr.memmove"(%13, %11, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    "llvm.intr.memmove"(%13, %12, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return %2 : i32
  }
  llvm.func @test4(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(100 : i32) : i32
    "llvm.intr.memmove"(%arg0, %arg0, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
  llvm.func @memmove_to_constant(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.addressof @UnknownConstant : !llvm.ptr
    %1 = llvm.mlir.constant(16 : i32) : i32
    "llvm.intr.memmove"(%0, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i32) -> ()
    llvm.return
  }
}
