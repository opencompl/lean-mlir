module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @_ZTIi() {addr_space = 0 : i32} : !llvm.ptr
  llvm.mlir.global external unnamed_addr constant @".str.4"() {addr_space = 0 : i32, alignment = 1 : i64} : !llvm.array<100 x i8>
  llvm.func @test1(%arg0: !llvm.ptr, %arg1: i1, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %4 = llvm.getelementptr inbounds %3[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct2", (i32, i32)>
    llvm.store %0, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3(%4 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %3[%arg3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct2", (i32, i32)>
    llvm.store %0, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3(%5 : !llvm.ptr)
  ^bb3(%6: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.getelementptr inbounds %6[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct2", (i32, i32)>
    %8 = llvm.load %7 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %8 : i32
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: i1, %arg2: i64, %arg3: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %4 = llvm.getelementptr inbounds %3[%arg2] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct2", (i32, i32)>
    llvm.store %0, %4 {alignment = 4 : i64} : i32, !llvm.ptr
    %5 = llvm.getelementptr inbounds %3[%arg3] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct2", (i32, i32)>
    llvm.store %0, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    %6 = llvm.getelementptr inbounds %4[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct2", (i32, i32)>
    %7 = llvm.load %6 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %7 : i32
  }
  llvm.func @test3(%arg0: !llvm.ptr, %arg1: i1, %arg2: i64, %arg3: i64, %arg4: i64, %arg5: i64) -> i32 attributes {personality = @__gxx_personality_v0} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(11 : i32) : i32
    %4 = llvm.mlir.addressof @_ZTIi : !llvm.ptr
    llvm.cond_br %arg1, ^bb1, ^bb2
  ^bb1:  // pred: ^bb0
    %5 = llvm.getelementptr inbounds %arg0[%arg3, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3(%5 : !llvm.ptr)
  ^bb2:  // pred: ^bb0
    %6 = llvm.getelementptr inbounds %arg0[%arg4, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct3", (i32, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>, struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>)>
    %7 = llvm.getelementptr inbounds %6[%1, 0, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>
    llvm.store %2, %7 {alignment = 4 : i64} : i32, !llvm.ptr
    llvm.br ^bb3(%6 : !llvm.ptr)
  ^bb3(%8: !llvm.ptr):  // 2 preds: ^bb1, ^bb2
    %9 = llvm.invoke @foo1(%3) to ^bb4 unwind ^bb5 : (i32) -> i32
  ^bb4:  // pred: ^bb3
    llvm.return %2 : i32
  ^bb5:  // pred: ^bb3
    %10 = llvm.landingpad (catch %4 : !llvm.ptr) : !llvm.struct<(ptr, i32)>
    %11 = llvm.getelementptr inbounds %8[%arg5, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct4", (struct<"struct2", (i32, i32)>, struct<"struct2", (i32, i32)>)>
    %12 = llvm.getelementptr inbounds %11[%1, 1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<"struct2", (i32, i32)>
    %13 = llvm.load %12 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %13 : i32
  }
  llvm.func @__gxx_personality_v0(...) -> i32
  llvm.func @foo1(i32) -> i32
  llvm.func @test4(%arg0: i32, %arg1: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(127 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.getelementptr inbounds %arg1[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.icmp "ugt" %arg0, %1 : i32
    llvm.cond_br %4, ^bb1, ^bb4(%3 : !llvm.ptr)
  ^bb1:  // pred: ^bb0
    llvm.br ^bb2(%3, %arg0 : !llvm.ptr, i32)
  ^bb2(%5: !llvm.ptr, %6: i32):  // 2 preds: ^bb1, ^bb2
    %7 = llvm.lshr %6, %2  : i32
    %8 = llvm.getelementptr inbounds %5[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %9 = llvm.icmp "ugt" %7, %1 : i32
    llvm.cond_br %9, ^bb2(%8, %7 : !llvm.ptr, i32), ^bb3(%8 : !llvm.ptr)
  ^bb3(%10: !llvm.ptr):  // pred: ^bb2
    llvm.br ^bb4(%10 : !llvm.ptr)
  ^bb4(%11: !llvm.ptr):  // 2 preds: ^bb0, ^bb3
    %12 = llvm.getelementptr inbounds %11[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    llvm.return %12 : !llvm.ptr
  }
  llvm.func @test5(%arg0: !llvm.ptr, %arg1: !llvm.ptr) {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(54 : i8) : i8
    %2 = llvm.mlir.addressof @".str.4" : !llvm.ptr
    %3 = llvm.mlir.constant(64 : i8) : i8
    %4 = llvm.mlir.constant(0 : i8) : i8
    %5 = llvm.mlir.constant(2048 : i16) : i16
    %6 = llvm.mlir.constant(0 : i16) : i16
    %7 = llvm.load %arg1 {alignment = 8 : i64} : !llvm.ptr -> !llvm.ptr
    %8 = llvm.getelementptr inbounds %7[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %9 = llvm.load %8 {alignment = 1 : i64} : !llvm.ptr -> i8
    %10 = llvm.icmp "eq" %9, %1 : i8
    llvm.cond_br %10, ^bb2(%8 : !llvm.ptr), ^bb1
  ^bb1:  // pred: ^bb0
    llvm.call @g(%2) : (!llvm.ptr) -> ()
    llvm.br ^bb2(%8 : !llvm.ptr)
  ^bb2(%11: !llvm.ptr):  // 3 preds: ^bb0, ^bb1, ^bb3
    %12 = llvm.load %11 {alignment = 1 : i64} : !llvm.ptr -> i8
    %13 = llvm.and %12, %3  : i8
    %14 = llvm.icmp "eq" %13, %4 : i8
    llvm.cond_br %14, ^bb3, ^bb4
  ^bb3:  // pred: ^bb2
    %15 = llvm.getelementptr inbounds %11[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.br ^bb2(%15 : !llvm.ptr)
  ^bb4:  // pred: ^bb2
    %16 = llvm.getelementptr inbounds %11[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.br ^bb5
  ^bb5:  // 2 preds: ^bb4, ^bb5
    %17 = llvm.load %16 {alignment = 1 : i64} : !llvm.ptr -> i8
    %18 = llvm.zext %17 : i8 to i32
    %19 = llvm.getelementptr inbounds %arg0[%18] : (!llvm.ptr, i32) -> !llvm.ptr, i16
    %20 = llvm.load %19 {alignment = 2 : i64} : !llvm.ptr -> i16
    %21 = llvm.and %20, %5  : i16
    %22 = llvm.icmp "eq" %21, %6 : i16
    llvm.cond_br %22, ^bb6, ^bb5
  ^bb6:  // 2 preds: ^bb5, ^bb6
    llvm.br ^bb6
  }
  llvm.func @g(!llvm.ptr)
}
