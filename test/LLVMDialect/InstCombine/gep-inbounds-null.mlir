module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @test_ne_constants_null() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "ne" %0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }
  llvm.func @test_ne_constants_nonnull() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "ne" %2, %0 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @test_eq_constants_null() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.icmp "eq" %0, %0 : !llvm.ptr
    llvm.return %1 : i1
  }
  llvm.func @test_eq_constants_nonnull() -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.constant(1 : i64) : i64
    %2 = llvm.getelementptr inbounds %0[%1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %2, %0 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @test_ne(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @test_eq(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @test_vector_base(%arg0: !llvm.vec<2 x ptr>, %arg1: i64) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.vec<2 x ptr>, i64) -> !llvm.vec<2 x ptr>, i8
    %7 = llvm.icmp "eq" %6, %5 : !llvm.vec<2 x ptr>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @test_vector_index(%arg0: !llvm.ptr, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %7 = llvm.icmp "eq" %6, %5 : !llvm.vec<2 x ptr>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @test_vector_both(%arg0: !llvm.vec<2 x ptr>, %arg1: vector<2xi64>) -> vector<2xi1> {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.vec<2 x ptr>
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.insertelement %0, %1[%2 : i32] : !llvm.vec<2 x ptr>
    %4 = llvm.mlir.constant(1 : i32) : i32
    %5 = llvm.insertelement %0, %3[%4 : i32] : !llvm.vec<2 x ptr>
    %6 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.vec<2 x ptr>, vector<2xi64>) -> !llvm.vec<2 x ptr>, i8
    %7 = llvm.icmp "eq" %6, %5 : !llvm.vec<2 x ptr>
    llvm.return %7 : vector<2xi1>
  }
  llvm.func @test_eq_pos_idx(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @test_eq_neg_idx(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(-1 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @test_size0(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<()>
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @test_size0_nonzero_offset(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(15 : i64) : i64
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr, i64) -> !llvm.ptr, !llvm.struct<()>
    %3 = llvm.icmp "ne" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @test_index_type(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr inbounds %arg0[%arg1, %arg1] : (!llvm.ptr, i64, i64) -> !llvm.ptr, !llvm.array<10 x i8>
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @neq_noinbounds(%arg0: !llvm.ptr, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.getelementptr %arg0[%arg1] : (!llvm.ptr, i64) -> !llvm.ptr, i8
    %2 = llvm.icmp "ne" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @neg_objectatnull(%arg0: !llvm.ptr<2>, %arg1: i64) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<2>, i64) -> !llvm.ptr<2>, i8
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr<2>
    llvm.return %2 : i1
  }
  llvm.func @invalid_bitcast_icmp_addrspacecast_as0_null(%arg0: !llvm.ptr<5>) -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.addrspacecast %1 : !llvm.ptr to !llvm.ptr<5>
    %3 = llvm.getelementptr inbounds %arg0[%0] : (!llvm.ptr<5>, i32) -> !llvm.ptr<5>, i32
    %4 = llvm.icmp "eq" %3, %2 : !llvm.ptr<5>
    llvm.return %4 : i1
  }
  llvm.func @invalid_bitcast_icmp_addrspacecast_as0_null_var(%arg0: !llvm.ptr<5>, %arg1: i32) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.addrspacecast %0 : !llvm.ptr to !llvm.ptr<5>
    %2 = llvm.getelementptr inbounds %arg0[%arg1] : (!llvm.ptr<5>, i32) -> !llvm.ptr<5>, i32
    %3 = llvm.icmp "eq" %2, %1 : !llvm.ptr<5>
    llvm.return %3 : i1
  }
}
