module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<f32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func internal @func_v2i32(%arg0: vector<2xi32>) -> vector<2xi32> attributes {dso_local, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg0 : vector<2xi32>
  }
  llvm.func internal @func_v2f32(%arg0: vector<2xf32>) -> vector<2xf32> attributes {dso_local, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg0 : vector<2xf32>
  }
  llvm.func internal @func_v4f32(%arg0: vector<4xf32>) -> vector<4xf32> attributes {dso_local, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg0 : vector<4xf32>
  }
  llvm.func internal @func_i32(%arg0: i32) -> i32 attributes {dso_local, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg0 : i32
  }
  llvm.func internal @func_i64(%arg0: i64) -> i64 attributes {dso_local, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg0 : i64
  }
  llvm.func internal @func_v2i64(%arg0: vector<2xi64>) -> vector<2xi64> attributes {dso_local, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg0 : vector<2xi64>
  }
  llvm.func internal @func_v2i32p(%arg0: !llvm.vec<2 x ptr>) -> !llvm.vec<2 x ptr> attributes {dso_local, passthrough = ["noinline", "nounwind"]} {
    llvm.return %arg0 : !llvm.vec<2 x ptr>
  }
  llvm.func @bitcast_scalar(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> f32
    %2 = llvm.call %0(%1) : !llvm.ptr, (f32) -> f32
    llvm.store %2, %arg1 {alignment = 8 : i64} : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_vector(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<2xf32>) -> vector<2xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_vector_scalar_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<2xf32>) -> vector<2xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_scalar_vector_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2f32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_vector_ptrs_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<2 x ptr>
    %1 = llvm.call @func_v2i32p(%0) : (!llvm.vec<2 x ptr>) -> !llvm.vec<2 x ptr>
    llvm.store %1, %arg1 {alignment = 8 : i64} : !llvm.vec<2 x ptr>, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_mismatch_scalar_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> f32
    %2 = llvm.call %0(%1) : !llvm.ptr, (f32) -> f32
    llvm.store %2, %arg1 {alignment = 8 : i64} : f32, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_mismatch_vector_element_and_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<2xf32>
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<2xf32>) -> vector<2xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<2xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_vector_mismatched_number_elements(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<4xf32>
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<4xf32>) -> vector<4xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_vector_scalar_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> vector<4xf32>
    %2 = llvm.call %0(%1) : !llvm.ptr, (vector<4xf32>) -> vector<4xf32>
    llvm.store %2, %arg1 {alignment = 8 : i64} : vector<4xf32>, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_vector_ptrs_scalar_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_i64 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> !llvm.vec<4 x ptr>
    %2 = llvm.call %0(%1) : !llvm.ptr, (!llvm.vec<4 x ptr>) -> !llvm.vec<4 x ptr>
    llvm.store %2, %arg1 {alignment = 8 : i64} : !llvm.vec<4 x ptr>, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_scalar_vector_ptrs_same_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v2i32p : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }
  llvm.func @bitcast_scalar_vector_mismatched_bit_size(%arg0: !llvm.ptr {llvm.noalias}, %arg1: !llvm.ptr {llvm.noalias}) attributes {passthrough = ["nounwind"]} {
    %0 = llvm.mlir.addressof @func_v4f32 : !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    %2 = llvm.call %0(%1) : !llvm.ptr, (i64) -> i64
    llvm.store %2, %arg1 {alignment = 8 : i64} : i64, !llvm.ptr
    llvm.return
  }
}
