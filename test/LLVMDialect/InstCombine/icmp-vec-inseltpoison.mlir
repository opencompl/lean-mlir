module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @someglobal(0 : i32) {addr_space = 0 : i32} : i32
  llvm.func @sge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-127, 127]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sge" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @uge(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "uge" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @sle(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[126, -128]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "sle" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @ule(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<[-2, 0]> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ule" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @ult_min_signed_value(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(dense<-128> : vector<2xi8>) : vector<2xi8>
    %1 = llvm.icmp "ult" %arg0, %0 : vector<2xi8>
    llvm.return %1 : vector<2xi1>
  }
  llvm.func @sge_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "sge" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @uge_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "uge" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @sle_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "sle" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @ule_zero(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(dense<0> : vector<2xi8>) : vector<2xi8>
    %2 = llvm.icmp "ule" %arg0, %1 : vector<2xi8>
    llvm.return %2 : vector<2xi1>
  }
  llvm.func @sge_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(3 : i3) : i3
    %2 = llvm.mlir.constant(-3 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-3, 3, 0]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "sge" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }
  llvm.func @uge_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(2 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(-1 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-1, 1, 2]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "uge" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }
  llvm.func @sle_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(-4 : i3) : i3
    %2 = llvm.mlir.constant(2 : i3) : i3
    %3 = llvm.mlir.constant(dense<[2, -4, 0]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "sle" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }
  llvm.func @ule_weird(%arg0: vector<3xi3>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(0 : i3) : i3
    %2 = llvm.mlir.constant(-2 : i3) : i3
    %3 = llvm.mlir.constant(dense<[-2, 0, 1]> : vector<3xi3>) : vector<3xi3>
    %4 = llvm.icmp "ule" %arg0, %3 : vector<3xi3>
    llvm.return %4 : vector<3xi1>
  }
  llvm.func @sge_min(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(-4 : i3) : i3
    %2 = llvm.mlir.constant(dense<[-4, 1]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "sge" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @uge_min(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[1, 0]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "uge" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @sle_max(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(3 : i3) : i3
    %1 = llvm.mlir.constant(1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[1, 3]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "sle" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @ule_max(%arg0: vector<2xi3>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(1 : i3) : i3
    %1 = llvm.mlir.constant(-1 : i3) : i3
    %2 = llvm.mlir.constant(dense<[-1, 1]> : vector<2xi3>) : vector<2xi3>
    %3 = llvm.icmp "ule" %arg0, %2 : vector<2xi3>
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @PR27756_1(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(2 : i4) : i4
    %2 = llvm.mlir.constant(1 : i4) : i4
    %3 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi4>) : vector<2xi4>
    %4 = llvm.bitcast %3 : vector<2xi4> to i8
    %5 = llvm.mlir.undef : vector<2xi8>
    %6 = llvm.mlir.constant(0 : i32) : i32
    %7 = llvm.insertelement %4, %5[%6 : i32] : vector<2xi8>
    %8 = llvm.mlir.constant(1 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<2xi8>
    %10 = llvm.icmp "sle" %arg0, %9 : vector<2xi8>
    llvm.return %10 : vector<2xi1>
  }
  llvm.func @PR27756_2(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.poison : i8
    %2 = llvm.mlir.constant(42 : i8) : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.icmp "sle" %arg0, %9 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }
  llvm.func @PR27756_3(%arg0: vector<3xi8>) -> vector<3xi1> {
    %0 = llvm.mlir.constant(42 : i8) : i8
    %1 = llvm.mlir.constant(1 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<3xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<3xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<3xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %0, %7[%8 : i32] : vector<3xi8>
    %10 = llvm.icmp "sge" %arg0, %9 : vector<3xi8>
    llvm.return %10 : vector<3xi1>
  }
  llvm.func @PR27786(%arg0: vector<2xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @someglobal : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i16
    %3 = llvm.bitcast %2 : i16 to vector<2xi8>
    %4 = llvm.icmp "sle" %arg0, %3 : vector<2xi8>
    llvm.return %4 : vector<2xi1>
  }
  llvm.func @same_shuffle_inputs_icmp(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 3, 2, 0] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [3, 3, 2, 0] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %1, %2 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }
  llvm.func @same_shuffle_inputs_fcmp(%arg0: vector<4xf32>, %arg1: vector<4xf32>) -> vector<5xi1> {
    %0 = llvm.mlir.poison : vector<4xf32>
    %1 = llvm.shufflevector %arg0, %0 [0, 1, 3, 2, 0] : vector<4xf32> 
    %2 = llvm.shufflevector %arg1, %0 [0, 1, 3, 2, 0] : vector<4xf32> 
    %3 = llvm.fcmp "oeq" %1, %2 : vector<5xf32>
    llvm.return %3 : vector<5xi1>
  }
  llvm.func @use_v4i8(vector<4xi8>)
  llvm.func @same_shuffle_inputs_icmp_extra_use1(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [3, 3, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "ugt" %1, %2 : vector<4xi8>
    llvm.call @use_v4i8(%1) : (vector<4xi8>) -> ()
    llvm.return %3 : vector<4xi1>
  }
  llvm.func @use_v2i8(vector<2xi8>)
  llvm.func @same_shuffle_inputs_icmp_extra_use2(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [3, 2] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [3, 2] : vector<4xi8> 
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi8>
    llvm.call @use_v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @same_shuffle_inputs_icmp_extra_use3(%arg0: vector<4xi8>, %arg1: vector<4xi8>) -> vector<2xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.shufflevector %arg0, %0 [0, 0] : vector<4xi8> 
    %2 = llvm.shufflevector %arg1, %0 [0, 0] : vector<4xi8> 
    %3 = llvm.icmp "eq" %1, %2 : vector<2xi8>
    llvm.call @use_v2i8(%1) : (vector<2xi8>) -> ()
    llvm.call @use_v2i8(%2) : (vector<2xi8>) -> ()
    llvm.return %3 : vector<2xi1>
  }
  llvm.func @splat_icmp(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }
  llvm.func @splat_icmp_poison(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<4xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %2, %3[%4 : i32] : vector<4xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi8>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi8>
    %12 = llvm.shufflevector %arg0, %0 [2, -1, -1, 2] : vector<4xi8> 
    %13 = llvm.icmp "ult" %12, %11 : vector<4xi8>
    llvm.return %13 : vector<4xi1>
  }
  llvm.func @splat_icmp_larger_size(%arg0: vector<2xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<2xi8>
    %1 = llvm.mlir.constant(42 : i8) : i8
    %2 = llvm.mlir.poison : i8
    %3 = llvm.mlir.undef : vector<4xi8>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xi8>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xi8>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xi8>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xi8>
    %12 = llvm.shufflevector %arg0, %0 [1, -1, 1, -1] : vector<2xi8> 
    %13 = llvm.icmp "eq" %12, %11 : vector<4xi8>
    llvm.return %13 : vector<4xi1>
  }
  llvm.func @splat_fcmp_smaller_size(%arg0: vector<5xf32>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<5xf32>
    %1 = llvm.mlir.constant(4.200000e+01 : f32) : f32
    %2 = llvm.mlir.poison : f32
    %3 = llvm.mlir.undef : vector<4xf32>
    %4 = llvm.mlir.constant(0 : i32) : i32
    %5 = llvm.insertelement %1, %3[%4 : i32] : vector<4xf32>
    %6 = llvm.mlir.constant(1 : i32) : i32
    %7 = llvm.insertelement %1, %5[%6 : i32] : vector<4xf32>
    %8 = llvm.mlir.constant(2 : i32) : i32
    %9 = llvm.insertelement %2, %7[%8 : i32] : vector<4xf32>
    %10 = llvm.mlir.constant(3 : i32) : i32
    %11 = llvm.insertelement %1, %9[%10 : i32] : vector<4xf32>
    %12 = llvm.shufflevector %arg0, %0 [1, -1, 1, -1] : vector<5xf32> 
    %13 = llvm.fcmp "oeq" %12, %11 : vector<4xf32>
    llvm.return %13 : vector<4xi1>
  }
  llvm.func @splat_icmp_extra_use(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 3, 3, 3] : vector<4xi8> 
    llvm.call @use_v4i8(%2) : (vector<4xi8>) -> ()
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }
  llvm.func @not_splat_icmp(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<42> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [3, 2, 3, 3] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }
  llvm.func @not_splat_icmp2(%arg0: vector<4xi8>) -> vector<4xi1> {
    %0 = llvm.mlir.poison : vector<4xi8>
    %1 = llvm.mlir.constant(dense<[43, 42, 42, 42]> : vector<4xi8>) : vector<4xi8>
    %2 = llvm.shufflevector %arg0, %0 [2, 2, 2, 2] : vector<4xi8> 
    %3 = llvm.icmp "sgt" %2, %1 : vector<4xi8>
    llvm.return %3 : vector<4xi1>
  }
}
