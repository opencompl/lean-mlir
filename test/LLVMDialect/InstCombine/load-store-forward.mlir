module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @load_smaller_int(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(258 : i16) : i16
    llvm.store %0, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %1 : i8
  }
  llvm.func @load_larger_int(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(258 : i16) : i16
    llvm.store %0, %arg0 {alignment = 2 : i64} : i16, !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @vec_store_load_first(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @vec_store_load_first_odd_size(%arg0: !llvm.ptr) -> i17 {
    %0 = llvm.mlir.constant(2 : i17) : i17
    %1 = llvm.mlir.constant(1 : i17) : i17
    %2 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi17>) : vector<2xi17>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi17>, !llvm.ptr
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i17
    llvm.return %3 : i17
  }
  llvm.func @vec_store_load_first_constexpr(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.addressof @vec_store_load_first : !llvm.ptr
    %1 = llvm.ptrtoint %0 : !llvm.ptr to i64
    %2 = llvm.bitcast %1 : i64 to vector<2xi32>
    llvm.store %2, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
  llvm.func @vec_store_load_second(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(1 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i32
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
  llvm.func @vec_store_load_whole(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i64
    llvm.return %1 : i64
  }
  llvm.func @vec_store_load_overlap(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(dense<[1, 2]> : vector<2xi32>) : vector<2xi32>
    %1 = llvm.mlir.constant(2 : i64) : i64
    llvm.store %0, %arg0 {alignment = 8 : i64} : vector<2xi32>, !llvm.ptr
    %2 = llvm.getelementptr %arg0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.load %2 {alignment = 2 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
  llvm.func @load_i32_store_nxv4i32(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
  llvm.func @load_i64_store_nxv8i8(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 8 x  i8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 8 x  i8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0, 0, 0, 0, 0] : !llvm.vec<? x 8 x  i8> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[8]xi8>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.return %5 : i64
  }
  llvm.func @load_i64_store_nxv4i32(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.return %5 : i64
  }
  llvm.func @load_i8_store_nxv4i32(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %5 : i8
  }
  llvm.func @load_f32_store_nxv4f32(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  f32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xf32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %5 : f32
  }
  llvm.func @load_i32_store_nxv4f32(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  f32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1.000000e+00 : f32) : f32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  f32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  f32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xf32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %5 : i32
  }
  llvm.func @load_v4i32_store_nxv4i32(%arg0: !llvm.ptr) -> vector<4xi32> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi32>
    llvm.return %5 : vector<4xi32>
  }
  llvm.func @load_v4i16_store_nxv4i32(%arg0: !llvm.ptr) -> vector<4xi16> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> vector<4xi16>
    llvm.return %5 : vector<4xi16>
  }
  llvm.func @load_i64_store_nxv4i8(%arg0: !llvm.ptr) -> i64 {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i8>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i8>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i8> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi8>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 8 : i64} : !llvm.ptr -> i64
    llvm.return %5 : i64
  }
  llvm.func @load_nxv4i8_store_nxv4i32(%arg0: !llvm.ptr) -> !llvm.vec<? x 4 x  i8> {
    %0 = llvm.mlir.poison : !llvm.vec<? x 4 x  i32>
    %1 = llvm.mlir.constant(0 : i64) : i64
    %2 = llvm.mlir.constant(1 : i32) : i32
    %3 = llvm.insertelement %2, %0[%1 : i64] : !llvm.vec<? x 4 x  i32>
    %4 = llvm.shufflevector %3, %0 [0, 0, 0, 0] : !llvm.vec<? x 4 x  i32> 
    llvm.store %4, %arg0 {alignment = 16 : i64} : vector<[4]xi32>, !llvm.ptr
    %5 = llvm.load %arg0 {alignment = 16 : i64} : !llvm.ptr -> !llvm.vec<? x 4 x  i8>
    llvm.return %5 : !llvm.vec<? x 4 x  i8>
  }
  llvm.func @load_i8_store_i1(%arg0: !llvm.ptr) -> i8 {
    %0 = llvm.mlir.constant(true) : i1
    llvm.store %0, %arg0 {alignment = 1 : i64} : i1, !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %1 : i8
  }
  llvm.func @load_i1_store_i8(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    llvm.store %0, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %1 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i1
    llvm.return %1 : i1
  }
  llvm.func @load_after_memset_0(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @load_after_memset_0_float(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %2 : f32
  }
  llvm.func @load_after_memset_0_non_byte_sized(%arg0: !llvm.ptr) -> i27 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i27
    llvm.return %2 : i27
  }
  llvm.func @load_after_memset_0_i1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i1
    llvm.return %2 : i1
  }
  llvm.func @load_after_memset_0_vec(%arg0: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @load_after_memset_1(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @load_after_memset_1_float(%arg0: !llvm.ptr) -> f32 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> f32
    llvm.return %2 : f32
  }
  llvm.func @load_after_memset_1_non_byte_sized(%arg0: !llvm.ptr) -> i27 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i27
    llvm.return %2 : i27
  }
  llvm.func @load_after_memset_1_i1(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 1 : i64} : !llvm.ptr -> i1
    llvm.return %2 : i1
  }
  llvm.func @load_after_memset_1_vec(%arg0: !llvm.ptr) -> vector<4xi8> {
    %0 = llvm.mlir.constant(1 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> vector<4xi8>
    llvm.return %2 : vector<4xi8>
  }
  llvm.func @load_after_memset_unknown(%arg0: !llvm.ptr, %arg1: i8) -> i32 {
    %0 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %arg1, %0) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @load_after_memset_0_offset(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(4 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
  llvm.func @load_after_memset_0_offset_too_large(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(13 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
  llvm.func @load_after_memset_0_offset_negative(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(-1 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %3 = llvm.getelementptr %arg0[%2] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %4 : i32
  }
  llvm.func @load_after_memset_0_clobber(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    %2 = llvm.mlir.constant(1 : i8) : i8
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    llvm.store %2, %arg0 {alignment = 1 : i64} : i8, !llvm.ptr
    %3 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %3 : i32
  }
  llvm.func @load_after_memset_0_too_small(%arg0: !llvm.ptr) -> i256 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i256
    llvm.return %2 : i256
  }
  llvm.func @load_after_memset_0_too_small_by_one_bit(%arg0: !llvm.ptr) -> i129 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i129
    llvm.return %2 : i129
  }
  llvm.func @load_after_memset_0_unknown_length(%arg0: !llvm.ptr, %arg1: i64) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    "llvm.intr.memset"(%arg0, %0, %arg1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %1 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %1 : i32
  }
  llvm.func @load_after_memset_0_atomic(%arg0: !llvm.ptr) -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 atomic seq_cst {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @load_after_memset_0_scalable(%arg0: !llvm.ptr) -> !llvm.vec<? x 1 x  i32> {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.constant(16 : i64) : i64
    "llvm.intr.memset"(%arg0, %0, %1) <{isVolatile = false}> : (!llvm.ptr, i8, i64) -> ()
    %2 = llvm.load %arg0 {alignment = 4 : i64} : !llvm.ptr -> !llvm.vec<? x 1 x  i32>
    llvm.return %2 : !llvm.vec<? x 1 x  i32>
  }
}
