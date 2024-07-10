module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<16> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external constant @const_array("\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16") {addr_space = 2 : i32}
  llvm.func @combine_redundant_addrspacecast(%arg0: !llvm.ptr<1>) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<3>
    %1 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @combine_redundant_addrspacecast_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr<3>>
    %1 = llvm.addrspacecast %0 : !llvm.vec<4 x ptr<3>> to !llvm.vec<4 x ptr>
    llvm.return %1 : !llvm.vec<4 x ptr>
  }
  llvm.func @combine_redundant_addrspacecast_types(%arg0: !llvm.ptr<1>) -> !llvm.ptr attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<3>
    %1 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr
    llvm.return %1 : !llvm.ptr
  }
  llvm.func @combine_redundant_addrspacecast_types_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr<3>>
    %1 = llvm.addrspacecast %0 : !llvm.vec<4 x ptr<3>> to !llvm.vec<4 x ptr>
    llvm.return %1 : !llvm.vec<4 x ptr>
  }
  llvm.func @combine_addrspacecast_bitcast_1(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }
  llvm.func @combine_addrspacecast_bitcast_2(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }
  llvm.func @combine_bitcast_addrspacecast_1(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }
  llvm.func @combine_bitcast_addrspacecast_2(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }
  llvm.func @combine_addrspacecast_types(%arg0: !llvm.ptr<1>) -> !llvm.ptr<2> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr<2>
    llvm.return %0 : !llvm.ptr<2>
  }
  llvm.func @combine_addrspacecast_types_vector(%arg0: !llvm.vec<4 x ptr<1>>) -> !llvm.vec<4 x ptr<2>> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<4 x ptr<1>> to !llvm.vec<4 x ptr<2>>
    llvm.return %0 : !llvm.vec<4 x ptr<2>>
  }
  llvm.func @combine_addrspacecast_types_scalevector(%arg0: !llvm.vec<? x 4 x  ptr<1>>) -> !llvm.vec<? x 4 x  ptr<2>> attributes {passthrough = ["nounwind"]} {
    %0 = llvm.addrspacecast %arg0 : !llvm.vec<? x 4 x  ptr<1>> to !llvm.vec<? x 4 x  ptr<2>>
    llvm.return %0 : !llvm.vec<? x 4 x  ptr<2>>
  }
  llvm.func @canonicalize_addrspacecast(%arg0: !llvm.ptr<1>) -> i32 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    %1 = llvm.load %0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @foo(!llvm.ptr) attributes {passthrough = ["nounwind"]}
  llvm.func @memcpy_addrspacecast() -> i32 attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.constant(48 : i32) : i32
    %1 = llvm.mlir.constant(4 : i16) : i16
    %2 = llvm.mlir.constant(0 : i16) : i16
    %3 = llvm.mlir.constant("\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16\02\09\04\16") : !llvm.array<60 x i8>
    %4 = llvm.mlir.addressof @const_array : !llvm.ptr<2>
    %5 = llvm.getelementptr inbounds %4[%2, %1] : (!llvm.ptr<2>, i16, i16) -> !llvm.ptr<2>, !llvm.array<60 x i8>
    %6 = llvm.addrspacecast %5 : !llvm.ptr<2> to !llvm.ptr<1>
    %7 = llvm.mlir.constant(0 : i32) : i32
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    "llvm.intr.memcpy"(%9, %6, %0) <{isVolatile = false}> : (!llvm.ptr, !llvm.ptr<1>, i32) -> ()
    llvm.br ^bb1(%7, %7 : i32, i32)
  ^bb1(%10: i32, %11: i32):  // 2 preds: ^bb0, ^bb1
    %12 = llvm.getelementptr %9[%10] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %13 = llvm.load %12 {alignment = 1 : i64} : !llvm.ptr -> i8
    %14 = llvm.zext %13 : i8 to i32
    %15 = llvm.add %11, %14  : i32
    %16 = llvm.add %10, %8  : i32
    %17 = llvm.icmp "ne" %10, %0 : i32
    llvm.cond_br %17, ^bb1(%16, %15 : i32, i32), ^bb2
  ^bb2:  // pred: ^bb1
    llvm.return %15 : i32
  }
  llvm.func @constant_fold_null() {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.mlir.constant(7 : i32) : i32
    %2 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %1, %2 {alignment = 4 : i64} : i32, !llvm.ptr<4>
    llvm.return
  }
  llvm.func @constant_fold_undef() -> !llvm.ptr<4> {
    %0 = llvm.mlir.undef : !llvm.ptr<3>
    %1 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.return %1 : !llvm.ptr<4>
  }
  llvm.func @constant_fold_null_vector() -> !llvm.vec<4 x ptr<4>> {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.mlir.undef : !llvm.vec<4 x ptr<3>>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<4 x ptr<3>>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<4 x ptr<3>>
    %6 = llvm.mlir.constant(2 : i32) : i32
    %7 = llvm.insertelement %0, %5[%6 : i32] : !llvm.vec<4 x ptr<3>>
    %8 = llvm.mlir.constant(3 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : !llvm.vec<4 x ptr<3>>
    %10 = llvm.addrspacecast %9 : !llvm.vec<4 x ptr<3>> to !llvm.vec<4 x ptr<4>>
    llvm.return %10 : !llvm.vec<4 x ptr<4>>
  }
  llvm.func @constant_fold_inttoptr() {
    %0 = llvm.mlir.constant(-1 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr<3>
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.addrspacecast %1 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %2, %3 {alignment = 4 : i64} : i32, !llvm.ptr<4>
    llvm.return
  }
  llvm.func @constant_fold_gep_inttoptr() {
    %0 = llvm.mlir.constant(1234 : i32) : i32
    %1 = llvm.mlir.constant(10 : i32) : i32
    %2 = llvm.mlir.constant(7 : i32) : i32
    %3 = llvm.inttoptr %0 : i32 to !llvm.ptr<3>
    %4 = llvm.getelementptr %3[%1] : (!llvm.ptr<3>, i32) -> !llvm.ptr<3>, i32
    %5 = llvm.addrspacecast %4 : !llvm.ptr<3> to !llvm.ptr<4>
    llvm.store %2, %5 {alignment = 4 : i64} : i32, !llvm.ptr<4>
    llvm.return
  }
}
