module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @v4float_user(vector<4xf32>) attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]}
  llvm.func @extract_one_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "ne" %arg2, %0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, vector<4xf32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xf32>
    llvm.return %4 : f32
  }
  llvm.func @extract_two_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> vector<2xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(1 : i32) : i32
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.mlir.poison : vector<2xf32>
    %4 = llvm.icmp "ne" %arg2, %0 : i32
    %5 = llvm.select %4, %arg0, %arg1 : i1, vector<4xf32>
    %6 = llvm.extractelement %5[%1 : i32] : vector<4xf32>
    %7 = llvm.extractelement %5[%2 : i32] : vector<4xf32>
    %8 = llvm.insertelement %6, %3[%0 : i32] : vector<2xf32>
    %9 = llvm.insertelement %7, %8[%1 : i32] : vector<2xf32>
    llvm.return %9 : vector<2xf32>
  }
  llvm.func @extract_one_select_user(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: i32) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(2 : i32) : i32
    %2 = llvm.icmp "ne" %arg2, %0 : i32
    %3 = llvm.select %2, %arg0, %arg1 : i1, vector<4xf32>
    %4 = llvm.extractelement %3[%1 : i32] : vector<4xf32>
    llvm.call @v4float_user(%3) : (vector<4xf32>) -> ()
    llvm.return %4 : f32
  }
  llvm.func @extract_one_vselect_user(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(2 : i32) : i32
    %3 = llvm.icmp "ne" %arg2, %1 : vector<4xi32>
    %4 = llvm.select %3, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %5 = llvm.extractelement %4[%2 : i32] : vector<4xf32>
    llvm.call @v4float_user(%4) : (vector<4xf32>) -> ()
    llvm.return %5 : f32
  }
  llvm.func @extract_one_vselect(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> f32 attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.icmp "ne" %arg2, %1 : vector<4xi32>
    %3 = llvm.select %2, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %4 = llvm.extractelement %3[%0 : i32] : vector<4xf32>
    llvm.return %4 : f32
  }
  llvm.func @extract_two_vselect(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> vector<2xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : vector<4xi32>) : vector<4xi32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.poison : vector<2xf32>
    %5 = llvm.icmp "ne" %arg2, %1 : vector<4xi32>
    %6 = llvm.select %5, %arg0, %arg1 : vector<4xi1>, vector<4xf32>
    %7 = llvm.extractelement %6[%2 : i32] : vector<4xf32>
    %8 = llvm.extractelement %6[%3 : i32] : vector<4xf32>
    %9 = llvm.insertelement %7, %4[%0 : i32] : vector<2xf32>
    %10 = llvm.insertelement %8, %9[%2 : i32] : vector<2xf32>
    llvm.return %10 : vector<2xf32>
  }
  llvm.func @simple_vector_select(%arg0: vector<4xf32>, %arg1: vector<4xf32>, %arg2: vector<4xi32>) -> vector<4xf32> attributes {frame_pointer = #llvm.framePointerKind<all>, passthrough = ["nounwind", "ssp", ["uwtable", "2"], ["less-precise-fpmad", "false"], ["no-infs-fp-math", "false"], ["no-nans-fp-math", "false"], ["stack-protector-buffer-size", "8"], ["unsafe-fp-math", "false"], ["use-soft-float", "false"]]} {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.poison : vector<4xf32>
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.mlir.constant(2 : i32) : i32
    %4 = llvm.mlir.constant(3 : i32) : i32
    %5 = llvm.extractelement %arg2[%0 : i32] : vector<4xi32>
    %6 = llvm.icmp "ne" %5, %0 : i32
    %7 = llvm.select %6, %arg0, %arg1 : i1, vector<4xf32>
    %8 = llvm.extractelement %7[%0 : i32] : vector<4xf32>
    %9 = llvm.insertelement %8, %1[%0 : i32] : vector<4xf32>
    %10 = llvm.extractelement %arg2[%2 : i32] : vector<4xi32>
    %11 = llvm.icmp "ne" %10, %0 : i32
    %12 = llvm.select %11, %arg0, %arg1 : i1, vector<4xf32>
    %13 = llvm.extractelement %12[%2 : i32] : vector<4xf32>
    %14 = llvm.insertelement %13, %9[%2 : i32] : vector<4xf32>
    %15 = llvm.extractelement %arg2[%3 : i32] : vector<4xi32>
    %16 = llvm.icmp "ne" %15, %0 : i32
    %17 = llvm.select %16, %arg0, %arg1 : i1, vector<4xf32>
    %18 = llvm.extractelement %17[%3 : i32] : vector<4xf32>
    %19 = llvm.insertelement %18, %14[%3 : i32] : vector<4xf32>
    %20 = llvm.extractelement %arg2[%4 : i32] : vector<4xi32>
    %21 = llvm.icmp "ne" %20, %0 : i32
    %22 = llvm.select %21, %arg0, %arg1 : i1, vector<4xf32>
    %23 = llvm.extractelement %22[%4 : i32] : vector<4xf32>
    %24 = llvm.insertelement %23, %19[%4 : i32] : vector<4xf32>
    llvm.return %24 : vector<4xf32>
  }
  llvm.func @extract_cond(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.extractelement %arg2[%0 : i32] : vector<4xi1>
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @splat_cond(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.poison : vector<4xi1>
    %1 = llvm.shufflevector %arg2, %0 [3, 3, 3, 3] : vector<4xi1> 
    %2 = llvm.select %1, %arg0, %arg1 : vector<4xi1>, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @extra_use(i1)
  llvm.func @extract_cond_extra_use(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(3 : i32) : i32
    %1 = llvm.extractelement %arg2[%0 : i32] : vector<4xi1>
    llvm.call @extra_use(%1) : (i1) -> ()
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
  llvm.func @extract_cond_variable_index(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<4xi1>, %arg3: i32) -> vector<4xi32> {
    %0 = llvm.extractelement %arg2[%arg3 : i32] : vector<4xi1>
    %1 = llvm.select %0, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %1 : vector<4xi32>
  }
  llvm.func @extract_cond_type_mismatch(%arg0: vector<4xi32>, %arg1: vector<4xi32>, %arg2: vector<5xi1>) -> vector<4xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.extractelement %arg2[%0 : i32] : vector<5xi1>
    %2 = llvm.select %1, %arg0, %arg1 : i1, vector<4xi32>
    llvm.return %2 : vector<4xi32>
  }
}
