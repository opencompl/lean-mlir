module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f80, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global internal constant @"\01LC"("%f\0A\00") {addr_space = 0 : i32, dso_local}
  llvm.func @foo1() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @printf(!llvm.ptr, ...) -> i32 attributes {passthrough = ["nounwind"]}
  llvm.func @foo2() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo3() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo4() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo5() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo6() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo7() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo8() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo9() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo10() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo11() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo12() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %3 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo13() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7FC00000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo14() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0x7F800000 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo15() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %4 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %5 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %8 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %7 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %3, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    %9 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %10 = llvm.fpext %9 : f32 to f64
    %11 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> f32
    %12 = llvm.fpext %11 : f32 to f64
    %13 = llvm.frem %12, %10  : f64
    %14 = llvm.call @printf(%5, %13) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
  llvm.func @foo16() attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i32) : i32
    %2 = llvm.mlir.constant(3.500000e+00 : f32) : f32
    %3 = llvm.mlir.constant("%f\0A\00") : !llvm.array<4 x i8>
    %4 = llvm.mlir.addressof @"\01LC" : !llvm.ptr
    %5 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %6 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    %7 = llvm.bitcast %1 : i32 to i32
    llvm.store %2, %6 {alignment = 4 : i64} : f32, !llvm.ptr
    llvm.store %2, %5 {alignment = 4 : i64} : f32, !llvm.ptr
    %8 = llvm.load %5 {alignment = 4 : i64} : !llvm.ptr -> f32
    %9 = llvm.fpext %8 : f32 to f64
    %10 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> f32
    %11 = llvm.fpext %10 : f32 to f64
    %12 = llvm.frem %11, %9  : f64
    %13 = llvm.call @printf(%4, %12) vararg(!llvm.func<i32 (ptr, ...)>) : (!llvm.ptr, f64) -> i32
    llvm.br ^bb1
  ^bb1:  // pred: ^bb0
    llvm.return
  }
}
