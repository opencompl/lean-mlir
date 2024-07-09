module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "big">>} {
  llvm.mlir.global internal constant @C.0.1248(dense<"0x000080BF000080BF000080BF00000000000080BF000080BF00000000000080BF000080BF000080BF000000000000803F000080BF000080BF0000803F00000000000080BF00000000000080BF000080BF000080BF00000000000080BF0000803F000080BF000000000000803F000080BF000080BF000000000000803F0000803F000080BF0000803F000080BF00000000000080BF0000803F00000000000080BF000080BF0000803F000000000000803F000080BF0000803F0000803F0000000000000000000080BF000080BF000080BF00000000000080BF000080BF0000803F00000000000080BF0000803F000080BF00000000000080BF0000803F0000803F0000803F000080BF000080BF000000000000803F000080BF00000000000080BF0000803F000080BF000000000000803F0000803F000080BF0000803F000000000000803F00000000000080BF000080BF0000803F00000000000080BF0000803F0000803F000000000000803F000080BF0000803F000000000000803F0000803F0000803F0000803F000080BF000000000000803F0000803F00000000000080BF0000803F0000803F000000000000803F0000803F0000803F0000803F00000000000000000000803F000080BF000080BF000000000000803F000080BF0000803F000000000000803F0000803F000080BF000000000000803F0000803F0000803F"> : tensor<128xf32>) {addr_space = 0 : i32, alignment = 32 : i64, dso_local} : !llvm.array<128 x f32>
  llvm.mlir.global external constant @G() {addr_space = 0 : i32} : !llvm.struct<"T", (i8, array<123 x i8>)> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %5 = llvm.insertvalue %1, %4[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    llvm.return %5 : !llvm.struct<"T", (i8, array<123 x i8>)>
  }
  llvm.mlir.global external constant @H() {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %3 = llvm.insertvalue %0, %2[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %0, %3[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %0, %4[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %0, %5[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    llvm.return %9 : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
  }
  llvm.mlir.global internal constant @I(dense<0.000000e+00> : tensor<4xf32>) {addr_space = 1 : i32, alignment = 4 : i64, dso_local} : !llvm.array<4 x f32>
  llvm.mlir.global external local_unnamed_addr @bbb(dense<0> : tensor<1000000xi8>) {addr_space = 0 : i32, alignment = 16 : i64} : !llvm.array<1000000 x i8>
  llvm.mlir.global internal unnamed_addr constant @_ZL3KKK("\01\01\02") {addr_space = 0 : i32, alignment = 1 : i64, dso_local}
  llvm.func @test1(%arg0: i32, %arg1: f32, %arg2: f32, %arg3: f32, %arg4: f32) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(dense<"0x000080BF000080BF000080BF00000000000080BF000080BF00000000000080BF000080BF000080BF000000000000803F000080BF000080BF0000803F00000000000080BF00000000000080BF000080BF000080BF00000000000080BF0000803F000080BF000000000000803F000080BF000080BF000000000000803F0000803F000080BF0000803F000080BF00000000000080BF0000803F00000000000080BF000080BF0000803F000000000000803F000080BF0000803F0000803F0000000000000000000080BF000080BF000080BF00000000000080BF000080BF0000803F00000000000080BF0000803F000080BF00000000000080BF0000803F0000803F0000803F000080BF000080BF000000000000803F000080BF00000000000080BF0000803F000080BF000000000000803F0000803F000080BF0000803F000000000000803F00000000000080BF000080BF0000803F00000000000080BF0000803F0000803F000000000000803F000080BF0000803F000000000000803F0000803F0000803F0000803F000080BF000000000000803F0000803F00000000000080BF0000803F0000803F000000000000803F0000803F0000803F0000803F00000000000000000000803F000080BF000080BF000000000000803F000080BF0000803F000000000000803F0000803F000080BF000000000000803F0000803F0000803F"> : tensor<128xf32>) : !llvm.array<128 x f32>
    %2 = llvm.mlir.addressof @C.0.1248 : !llvm.ptr
    %3 = llvm.mlir.constant(512 : i64) : i64
    %4 = llvm.mlir.constant(2 : i32) : i32
    %5 = llvm.mlir.constant(124 : i32) : i32
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.alloca %0 x !llvm.array<128 x f32> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%9, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    %10 = llvm.shl %arg0, %4  : i32
    %11 = llvm.and %10, %5  : i32
    %12 = llvm.getelementptr %9[%6, %11] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> f32
    %14 = llvm.fmul %13, %arg1  : f32
    %15 = llvm.fadd %14, %7  : f32
    %16 = llvm.or %11, %0  : i32
    %17 = llvm.getelementptr %9[%6, %16] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %18 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> f32
    %19 = llvm.fmul %18, %arg2  : f32
    %20 = llvm.fadd %19, %15  : f32
    %21 = llvm.or %11, %4  : i32
    %22 = llvm.getelementptr %9[%6, %21] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %23 = llvm.load %22 {alignment = 4 : i64} : !llvm.ptr -> f32
    %24 = llvm.fmul %23, %arg3  : f32
    %25 = llvm.fadd %24, %20  : f32
    %26 = llvm.or %11, %8  : i32
    %27 = llvm.getelementptr %9[%6, %26] : (!llvm.ptr, i32, i32) -> !llvm.ptr, !llvm.array<128 x f32>
    %28 = llvm.load %27 {alignment = 4 : i64} : !llvm.ptr -> f32
    %29 = llvm.fmul %28, %arg4  : f32
    %30 = llvm.fadd %29, %25  : f32
    llvm.return %30 : f32
  }
  llvm.func @test2() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%10, %9, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test2_no_null_opt() attributes {passthrough = ["null_pointer_is_valid"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%10, %9, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test2_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    %11 = llvm.addrspacecast %9 : !llvm.ptr to !llvm.ptr<1>
    %12 = llvm.addrspacecast %10 : !llvm.ptr to !llvm.ptr<1>
    "llvm.intr.memcpy"(%11, %7, %8) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%12, %11, %8) <{isVolatile = false}> : (!llvm.ptr<1>, !llvm.ptr<1>, i64) -> ()
    llvm.call @bar_as1(%12) : (!llvm.ptr<1>) -> ()
    llvm.return
  }
  llvm.func @bar(!llvm.ptr)
  llvm.func @bar_as1(!llvm.ptr<1>)
  llvm.func @test3() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%9) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test3_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.addrspacecast %7 : !llvm.ptr to !llvm.ptr<1>
    %9 = llvm.mlir.constant(124 : i64) : i64
    %10 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%10, %8, %9) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.call @bar(%10) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test4() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @baz(%9) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test5() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i8) : i8
    %2 = llvm.mlir.constant(dense<0> : tensor<123xi8>) : !llvm.array<123 x i8>
    %3 = llvm.mlir.constant(1 : i8) : i8
    %4 = llvm.mlir.undef : !llvm.struct<"T", (i8, array<123 x i8>)>
    %5 = llvm.insertvalue %3, %4[0] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %6 = llvm.insertvalue %2, %5[1] : !llvm.struct<"T", (i8, array<123 x i8>)> 
    %7 = llvm.mlir.addressof @G : !llvm.ptr
    %8 = llvm.mlir.constant(124 : i64) : i64
    %9 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start -1, %9 : !llvm.ptr
    "llvm.intr.memcpy"(%9, %7, %8) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @baz(%9) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @baz(!llvm.ptr {llvm.byval = i8})
  llvm.func @test6() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test7() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test8() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.mlir.constant(20 : i64) : i64
    %15 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%15, %13, %14) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%15) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test8_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.addrspacecast %13 : !llvm.ptr to !llvm.ptr<1>
    %15 = llvm.mlir.constant(20 : i64) : i64
    %16 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%16, %14, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.call @bar(%16) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test9() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.mlir.constant(20 : i64) : i64
    %15 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%15, %13, %14) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%15) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test9_addrspacecast() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %4 = llvm.insertvalue %2, %3[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %2, %4[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %2, %5[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %2, %6[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.insertvalue %2, %7[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %9 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %10 = llvm.insertvalue %8, %9[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.insertvalue %8, %10[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %12 = llvm.mlir.addressof @H : !llvm.ptr
    %13 = llvm.getelementptr inbounds %12[%1, %0] : (!llvm.ptr, i64, i32) -> !llvm.ptr, !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %14 = llvm.addrspacecast %13 : !llvm.ptr to !llvm.ptr<1>
    %15 = llvm.mlir.constant(20 : i64) : i64
    %16 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%16, %14, %15) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    llvm.call @bar(%16) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @test9_small_global() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("\01\01\02") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @_ZL3KKK : !llvm.ptr
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(dense<0> : tensor<1000000xi8>) : !llvm.array<1000000 x i8>
    %6 = llvm.mlir.addressof @bbb : !llvm.ptr
    %7 = llvm.mlir.constant(1000000 : i64) : i64
    %8 = llvm.alloca %0 x !llvm.array<1000000 x i8> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%8, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%6, %8, %7) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test10_same_global() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant("\01\01\02") : !llvm.array<3 x i8>
    %2 = llvm.mlir.addressof @_ZL3KKK : !llvm.ptr
    %3 = llvm.mlir.constant(3 : i64) : i64
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(dense<0> : tensor<1000000xi8>) : !llvm.array<1000000 x i8>
    %6 = llvm.mlir.addressof @bbb : !llvm.ptr
    %7 = llvm.alloca %0 x !llvm.array<3 x i8> {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%7, %2, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    "llvm.intr.memcpy"(%6, %7, %3) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.return
  }
  llvm.func @test11(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(dense<0.000000e+00> : tensor<4xf32>) : !llvm.array<4 x f32>
    %3 = llvm.mlir.addressof @I : !llvm.ptr<1>
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<4 x f32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 16, %6 : !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    %7 = llvm.getelementptr inbounds %6[%5, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x f32>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %8 : f32
  }
  llvm.func @test11_volatile(%arg0: i64) -> f32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %2 = llvm.mlir.constant(dense<0.000000e+00> : tensor<4xf32>) : !llvm.array<4 x f32>
    %3 = llvm.mlir.addressof @I : !llvm.ptr<1>
    %4 = llvm.mlir.constant(16 : i64) : i64
    %5 = llvm.mlir.constant(0 : i64) : i64
    %6 = llvm.alloca %0 x !llvm.array<4 x f32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.lifetime.start 16, %6 : !llvm.ptr
    "llvm.intr.memcpy"(%6, %3, %4) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr<1>, i64) -> ()
    %7 = llvm.getelementptr inbounds %6[%5, %arg0] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<4 x f32>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %8 : f32
  }
  llvm.func @memcpy_from_readonly_noalias(%arg0: !llvm.ptr {llvm.align = 8 : i64, llvm.dereferenceable = 124 : i64, llvm.noalias, llvm.readonly}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(124 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%2, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%2) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @memcpy_from_just_readonly(%arg0: !llvm.ptr {llvm.align = 8 : i64, llvm.dereferenceable = 124 : i64, llvm.readonly}) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(124 : i64) : i64
    %2 = llvm.alloca %0 x !llvm.struct<"T", (i8, array<123 x i8>)> {alignment = 8 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%2, %arg0, %1) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%2) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @volatile_memcpy() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = true}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @memcpy_to_nocapture_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @memcpy_to_capturing_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @bar(%13) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @memcpy_to_aliased_nocapture_readonly() {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.undef : !llvm.struct<"U", (i32, i32, i32, i32, i32)>
    %3 = llvm.insertvalue %1, %2[0] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %4 = llvm.insertvalue %1, %3[1] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %5 = llvm.insertvalue %1, %4[2] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %6 = llvm.insertvalue %1, %5[3] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %7 = llvm.insertvalue %1, %6[4] : !llvm.struct<"U", (i32, i32, i32, i32, i32)> 
    %8 = llvm.mlir.undef : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.array<2 x struct<"U", (i32, i32, i32, i32, i32)>> 
    %11 = llvm.mlir.addressof @H : !llvm.ptr
    %12 = llvm.mlir.constant(20 : i64) : i64
    %13 = llvm.alloca %0 x !llvm.struct<"U", (i32, i32, i32, i32, i32)> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%13, %11, %12) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr, i64) -> ()
    llvm.call @two_params(%13, %13) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @two_params(!llvm.ptr {llvm.nocapture, llvm.readonly}, !llvm.ptr {llvm.nocapture})
}
