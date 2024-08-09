module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr<4>, dense<16> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<8> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<3>, dense<16> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<64> : vector<4xi64>>, #dlti.dl_entry<i64, dense<32> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @g(89 : i32) {addr_space = 3 : i32} : i32
  llvm.mlir.global external constant @const_zero_i8_as1(0 : i8) {addr_space = 1 : i32} : i8
  llvm.mlir.global external constant @const_zero_i32_as1(0 : i32) {addr_space = 1 : i32} : i32
  llvm.mlir.global external constant @const_zero_i8_as2(0 : i8) {addr_space = 2 : i32} : i8
  llvm.mlir.global external constant @const_zero_i32_as2(0 : i32) {addr_space = 2 : i32} : i32
  llvm.mlir.global external constant @const_zero_i8_as3(0 : i8) {addr_space = 3 : i32} : i8
  llvm.mlir.global external constant @const_zero_i32_as3(0 : i32) {addr_space = 3 : i32} : i32
  llvm.mlir.global external @g_float_as3(0.000000e+00 : f32) {addr_space = 3 : i32} : f32
  llvm.mlir.global external @g_v4f_as3(dense<0.000000e+00> : vector<4xf32>) {addr_space = 3 : i32} : vector<4xf32>
  llvm.mlir.global external @i32_array_as3(dense<0> : tensor<10xi32>) {addr_space = 3 : i32} : !llvm.array<10 x i32>
  llvm.mlir.global external @constant_fold_global_ptr() {addr_space = 3 : i32} : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<10xi32>) : !llvm.array<10 x i32>
    %2 = llvm.mlir.addressof @i32_array_as3 : !llvm.ptr<3>
    %3 = llvm.mlir.constant(dense<0> : tensor<4xi32>) : !llvm.array<4 x i32>
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.undef : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    %8 = llvm.insertvalue %3, %7[2] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    %9 = llvm.insertvalue %2, %8[3] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    llvm.return %9 : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)>
  }
  llvm.mlir.global external constant @constant_data_as3(dense<[1, 2, 3, 4, 5]> : tensor<5xi32>) {addr_space = 3 : i32} : !llvm.array<5 x i32>
  llvm.mlir.global external constant @a(9 : i32) {addr_space = 1 : i32} : i32
  llvm.mlir.global external constant @b(23 : i32) {addr_space = 1 : i32} : i32
  llvm.mlir.global external constant @c(34 : i32) {addr_space = 1 : i32} : i32
  llvm.mlir.global external constant @d(99 : i32) {addr_space = 1 : i32} : i32
  llvm.mlir.global external constant @ptr_array() {addr_space = 2 : i32} : !llvm.array<4 x ptr<1>> {
    %0 = llvm.mlir.constant(99 : i32) : i32
    %1 = llvm.mlir.addressof @d : !llvm.ptr<1>
    %2 = llvm.mlir.constant(34 : i32) : i32
    %3 = llvm.mlir.addressof @c : !llvm.ptr<1>
    %4 = llvm.mlir.constant(23 : i32) : i32
    %5 = llvm.mlir.addressof @b : !llvm.ptr<1>
    %6 = llvm.mlir.constant(9 : i32) : i32
    %7 = llvm.mlir.addressof @a : !llvm.ptr<1>
    %8 = llvm.mlir.undef : !llvm.array<4 x ptr<1>>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.array<4 x ptr<1>> 
    %10 = llvm.insertvalue %5, %9[1] : !llvm.array<4 x ptr<1>> 
    %11 = llvm.insertvalue %3, %10[2] : !llvm.array<4 x ptr<1>> 
    %12 = llvm.insertvalue %1, %11[3] : !llvm.array<4 x ptr<1>> 
    llvm.return %12 : !llvm.array<4 x ptr<1>>
  }
  llvm.mlir.global external constant @indirect() {addr_space = 0 : i32} : !llvm.ptr<2> {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(99 : i32) : i32
    %3 = llvm.mlir.addressof @d : !llvm.ptr<1>
    %4 = llvm.mlir.constant(34 : i32) : i32
    %5 = llvm.mlir.addressof @c : !llvm.ptr<1>
    %6 = llvm.mlir.constant(23 : i32) : i32
    %7 = llvm.mlir.addressof @b : !llvm.ptr<1>
    %8 = llvm.mlir.constant(9 : i32) : i32
    %9 = llvm.mlir.addressof @a : !llvm.ptr<1>
    %10 = llvm.mlir.undef : !llvm.array<4 x ptr<1>>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.array<4 x ptr<1>> 
    %12 = llvm.insertvalue %7, %11[1] : !llvm.array<4 x ptr<1>> 
    %13 = llvm.insertvalue %5, %12[2] : !llvm.array<4 x ptr<1>> 
    %14 = llvm.insertvalue %3, %13[3] : !llvm.array<4 x ptr<1>> 
    %15 = llvm.mlir.addressof @ptr_array : !llvm.ptr<2>
    %16 = llvm.getelementptr inbounds %15[%1, %0] : (!llvm.ptr<2>, i1, i32) -> !llvm.ptr<2>, !llvm.array<4 x ptr<1>>
    llvm.return %16 : !llvm.ptr<2>
  }
  llvm.mlir.global external @shared_mem() {addr_space = 3 : i32} : !llvm.array<0 x i8>
  llvm.func @test_constant_fold_inttoptr_as_pointer_same_size() -> !llvm.ptr<3> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @const_zero_i32_as3 : !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr<3>
    llvm.return %3 : !llvm.ptr<3>
  }
  llvm.func @test_constant_fold_inttoptr_as_pointer_smaller() -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @const_zero_i32_as2 : !llvm.ptr<2>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<2> to i16
    %3 = llvm.inttoptr %2 : i16 to !llvm.ptr<2>
    llvm.return %3 : !llvm.ptr<2>
  }
  llvm.func @test_constant_fold_inttoptr_as_pointer_smaller_different_as() -> !llvm.ptr<4> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @const_zero_i32_as3 : !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i16
    %3 = llvm.inttoptr %2 : i16 to !llvm.ptr<4>
    llvm.return %3 : !llvm.ptr<4>
  }
  llvm.func @test_constant_fold_inttoptr_as_pointer_smaller_different_size_as() -> !llvm.ptr<2> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @const_zero_i32_as3 : !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr<2>
    llvm.return %3 : !llvm.ptr<2>
  }
  llvm.func @test_constant_fold_inttoptr_as_pointer_larger() -> !llvm.ptr<3> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.addressof @const_zero_i32_as3 : !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i8
    %3 = llvm.inttoptr %2 : i8 to !llvm.ptr<3>
    llvm.return %3 : !llvm.ptr<3>
  }
  llvm.func @const_fold_ptrtoint() -> i8 {
    %0 = llvm.mlir.constant(4 : i4) : i4
    %1 = llvm.inttoptr %0 : i4 to !llvm.ptr<2>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<2> to i8
    llvm.return %2 : i8
  }
  llvm.func @const_fold_ptrtoint_mask() -> i8 {
    %0 = llvm.mlir.constant(257 : i32) : i32
    %1 = llvm.inttoptr %0 : i32 to !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i8
    llvm.return %2 : i8
  }
  llvm.func @const_fold_ptrtoint_mask_small_as0() -> i64 {
    %0 = llvm.mlir.constant(-1 : i128) : i128
    %1 = llvm.inttoptr %0 : i128 to !llvm.ptr<1>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<1> to i64
    llvm.return %2 : i64
  }
  llvm.func @const_inttoptr() -> !llvm.ptr<3> {
    %0 = llvm.mlir.constant(4 : i16) : i16
    %1 = llvm.inttoptr %0 : i16 to !llvm.ptr<3>
    llvm.return %1 : !llvm.ptr<3>
  }
  llvm.func @const_ptrtoint() -> i16 {
    %0 = llvm.mlir.constant(89 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i16
    llvm.return %2 : i16
  }
  llvm.func @const_inttoptr_ptrtoint() -> i16 {
    %0 = llvm.mlir.constant(9 : i16) : i16
    llvm.return %0 : i16
  }
  llvm.func @constant_fold_cmp_constantexpr_inttoptr() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr<3>
    %1 = llvm.icmp "eq" %0, %0 : !llvm.ptr<3>
    llvm.return %1 : i1
  }
  llvm.func @constant_fold_inttoptr_null(%arg0: i16) -> i1 {
    %0 = llvm.mlir.constant(99 : i16) : i16
    %1 = llvm.inttoptr %0 : i16 to !llvm.ptr<3>
    %2 = llvm.mlir.zero : !llvm.ptr<3>
    %3 = llvm.icmp "eq" %1, %2 : !llvm.ptr<3>
    llvm.return %3 : i1
  }
  llvm.func @constant_fold_ptrtoint_null() -> i1 {
    %0 = llvm.mlir.constant(89 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i16
    %3 = llvm.mlir.constant(0 : i16) : i16
    %4 = llvm.icmp "eq" %2, %3 : i16
    llvm.return %4 : i1
  }
  llvm.func @constant_fold_ptrtoint_null_2() -> i1 {
    %0 = llvm.mlir.constant(0 : i16) : i16
    %1 = llvm.mlir.constant(89 : i32) : i32
    %2 = llvm.mlir.addressof @g : !llvm.ptr<3>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<3> to i16
    %4 = llvm.icmp "eq" %0, %3 : i16
    llvm.return %4 : i1
  }
  llvm.func @constant_fold_ptrtoint() -> i1 {
    %0 = llvm.mlir.constant(89 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr<3>
    %2 = llvm.ptrtoint %1 : !llvm.ptr<3> to i16
    %3 = llvm.icmp "eq" %2, %2 : i16
    llvm.return %3 : i1
  }
  llvm.func @constant_fold_inttoptr() -> i1 {
    %0 = llvm.mlir.constant(99 : i16) : i16
    %1 = llvm.inttoptr %0 : i16 to !llvm.ptr<3>
    %2 = llvm.mlir.constant(27 : i16) : i16
    %3 = llvm.inttoptr %2 : i16 to !llvm.ptr<3>
    %4 = llvm.icmp "eq" %1, %3 : !llvm.ptr<3>
    llvm.return %4 : i1
  }
  llvm.func @constant_fold_bitcast_ftoi_load() -> f32 {
    %0 = llvm.mlir.constant(89 : i32) : i32
    %1 = llvm.mlir.addressof @g : !llvm.ptr<3>
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<3> -> f32
    llvm.return %2 : f32
  }
  llvm.func @constant_fold_bitcast_itof_load() -> i32 {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.addressof @g_float_as3 : !llvm.ptr<3>
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    llvm.return %2 : i32
  }
  llvm.func @constant_fold_bitcast_vector_as() -> vector<4xf32> {
    %0 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %1 = llvm.mlir.constant(dense<0.000000e+00> : vector<4xf32>) : vector<4xf32>
    %2 = llvm.mlir.addressof @g_v4f_as3 : !llvm.ptr<3>
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr<3> -> vector<4xf32>
    llvm.return %3 : vector<4xf32>
  }
  llvm.func @test_cast_gep_small_indices_as() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<10xi32>) : !llvm.array<10 x i32>
    %2 = llvm.mlir.addressof @i32_array_as3 : !llvm.ptr<3>
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_cast_gep_large_indices_as() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<10xi32>) : !llvm.array<10 x i32>
    %2 = llvm.mlir.addressof @i32_array_as3 : !llvm.ptr<3>
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    llvm.return %3 : i32
  }
  llvm.func @test_constant_cast_gep_struct_indices_as() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.mlir.constant(dense<0> : tensor<10xi32>) : !llvm.array<10 x i32>
    %2 = llvm.mlir.addressof @i32_array_as3 : !llvm.ptr<3>
    %3 = llvm.mlir.constant(dense<0> : tensor<4xi32>) : !llvm.array<4 x i32>
    %4 = llvm.mlir.constant(0.000000e+00 : f32) : f32
    %5 = llvm.mlir.undef : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    %8 = llvm.insertvalue %3, %7[2] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    %9 = llvm.insertvalue %2, %8[3] : !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)> 
    %10 = llvm.mlir.addressof @constant_fold_global_ptr : !llvm.ptr<3>
    %11 = llvm.mlir.constant(0 : i18) : i18
    %12 = llvm.mlir.constant(2 : i32) : i32
    %13 = llvm.mlir.constant(2 : i12) : i12
    %14 = llvm.getelementptr %10[%11, 2, %13] : (!llvm.ptr<3>, i18, i12) -> !llvm.ptr<3>, !llvm.struct<"struct.foo", (f32, f32, array<4 x i32>, ptr<3>)>
    %15 = llvm.load %14 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    llvm.return %15 : i32
  }
  llvm.func @test_read_data_from_global_as3() -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2, 3, 4, 5]> : tensor<5xi32>) : !llvm.array<5 x i32>
    %1 = llvm.mlir.addressof @constant_data_as3 : !llvm.ptr<3>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.constant(1 : i32) : i32
    %4 = llvm.getelementptr %1[%2, %3] : (!llvm.ptr<3>, i32, i32) -> !llvm.ptr<3>, !llvm.array<5 x i32>
    %5 = llvm.load %4 {alignment = 4 : i64} : !llvm.ptr<3> -> i32
    llvm.return %5 : i32
  }
  llvm.func @constant_through_array_as_ptrs() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    %1 = llvm.mlir.constant(false) : i1
    %2 = llvm.mlir.constant(99 : i32) : i32
    %3 = llvm.mlir.addressof @d : !llvm.ptr<1>
    %4 = llvm.mlir.constant(34 : i32) : i32
    %5 = llvm.mlir.addressof @c : !llvm.ptr<1>
    %6 = llvm.mlir.constant(23 : i32) : i32
    %7 = llvm.mlir.addressof @b : !llvm.ptr<1>
    %8 = llvm.mlir.constant(9 : i32) : i32
    %9 = llvm.mlir.addressof @a : !llvm.ptr<1>
    %10 = llvm.mlir.undef : !llvm.array<4 x ptr<1>>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.array<4 x ptr<1>> 
    %12 = llvm.insertvalue %7, %11[1] : !llvm.array<4 x ptr<1>> 
    %13 = llvm.insertvalue %5, %12[2] : !llvm.array<4 x ptr<1>> 
    %14 = llvm.insertvalue %3, %13[3] : !llvm.array<4 x ptr<1>> 
    %15 = llvm.mlir.addressof @ptr_array : !llvm.ptr<2>
    %16 = llvm.getelementptr inbounds %15[%1, %0] : (!llvm.ptr<2>, i1, i32) -> !llvm.ptr<2>, !llvm.array<4 x ptr<1>>
    %17 = llvm.mlir.addressof @indirect : !llvm.ptr
    %18 = llvm.load %17 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr<2>
    %19 = llvm.load %18 {alignment = 4 : i64} : !llvm.ptr<2> -> !llvm.ptr<1>
    %20 = llvm.load %19 {alignment = 4 : i64} : !llvm.ptr<1> -> i32
    llvm.return %20 : i32
  }
  llvm.func @canonicalize_addrspacecast(%arg0: i32) -> f32 {
    %0 = llvm.mlir.addressof @shared_mem : !llvm.ptr<3>
    %1 = llvm.addrspacecast %0 : !llvm.ptr<3> to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%arg0] : (!llvm.ptr, i32) -> !llvm.ptr, f32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %3 : f32
  }
}
