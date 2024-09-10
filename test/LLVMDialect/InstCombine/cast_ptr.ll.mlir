module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<!llvm.ptr, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<16> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global external @global(0 : i8) {addr_space = 0 : i32} : i8
  llvm.mlir.global internal constant @Array() {addr_space = 0 : i32, dso_local} : !llvm.array<1 x ptr> {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.array<1 x ptr> 
    llvm.return %2 : !llvm.array<1 x ptr>
  }
  llvm.func @test1(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.constant(32 : i32) : i32
    %1 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %2 = llvm.add %1, %0  : i32
    %3 = llvm.inttoptr %2 : i32 to !llvm.ptr
    llvm.return %3 : !llvm.ptr
  }
  llvm.func @test2(%arg0: !llvm.ptr, %arg1: !llvm.ptr) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @test2_as2_same_int(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr<2>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i16
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<2> to i16
    %2 = llvm.icmp "eq" %0, %1 : i16
    llvm.return %2 : i1
  }
  llvm.func @test2_as2_larger(%arg0: !llvm.ptr<2>, %arg1: !llvm.ptr<2>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr<2> to i32
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<2> to i32
    %2 = llvm.icmp "eq" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @test2_diff_as(%arg0: !llvm.ptr, %arg1: !llvm.ptr<1>) -> i1 {
    %0 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %1 = llvm.ptrtoint %arg1 : !llvm.ptr<1> to i32
    %2 = llvm.icmp "sge" %0, %1 : i32
    llvm.return %2 : i1
  }
  llvm.func @test2_diff_as_global(%arg0: !llvm.ptr<1>) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i32
    %4 = llvm.icmp "sge" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @test3(%arg0: !llvm.ptr) -> i1 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @global : !llvm.ptr
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    %3 = llvm.ptrtoint %arg0 : !llvm.ptr to i32
    %4 = llvm.icmp "eq" %3, %2 : i32
    llvm.return %4 : i1
  }
  llvm.func @test4(%arg0: i32) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr
    llvm.return %2 : i1
  }
  llvm.func @test4_as2(%arg0: i16) -> i1 {
    %0 = llvm.mlir.zero : !llvm.ptr<2>
    %1 = llvm.inttoptr %arg0 : i16 to !llvm.ptr<2>
    %2 = llvm.icmp "eq" %1, %0 : !llvm.ptr<2>
    llvm.return %2 : i1
  }
  llvm.func @foo(!llvm.ptr) -> !llvm.ptr
  llvm.func @test5(%arg0: !llvm.ptr) -> !llvm.ptr {
    %0 = llvm.mlir.addressof @foo : !llvm.ptr
    %1 = llvm.mlir.undef : !llvm.array<1 x ptr>
    %2 = llvm.insertvalue %0, %1[0] : !llvm.array<1 x ptr> 
    %3 = llvm.mlir.addressof @Array : !llvm.ptr
    %4 = llvm.load %3 {alignment = 4 : i64} : !llvm.ptr -> !llvm.ptr
    %5 = llvm.call %4(%arg0) : !llvm.ptr, (!llvm.ptr) -> !llvm.ptr
    llvm.return %5 : !llvm.ptr
  }
  llvm.func @test6(%arg0: !llvm.ptr<1>) -> i8 {
    %0 = llvm.addrspacecast %arg0 : !llvm.ptr<1> to !llvm.ptr
    %1 = llvm.load %0 {alignment = 1 : i64} : !llvm.ptr -> i8
    llvm.return %1 : i8
  }
  llvm.func @insertelt(%arg0: vector<2xi32>, %arg1: !llvm.ptr, %arg2: i133) -> vector<2xi32> {
    %0 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    %1 = llvm.insertelement %arg1, %0[%arg2 : i133] : !llvm.vec<2 x ptr>
    %2 = llvm.ptrtoint %1 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %2 : vector<2xi32>
  }
  llvm.func @insertelt_intptr_trunc(%arg0: vector<2xi64>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi64> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @insertelt_intptr_zext(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi8> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @insertelt_intptr_zext_zext(%arg0: vector<2xi8>, %arg1: !llvm.ptr) -> vector<2xi64> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi8> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi64>
    llvm.return %3 : vector<2xi64>
  }
  llvm.func @use(!llvm.vec<2 x ptr>)
  llvm.func @insertelt_extra_use1(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    llvm.call @use(%1) : (!llvm.vec<2 x ptr>) -> ()
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @insertelt_extra_use2(%arg0: vector<2xi32>, %arg1: !llvm.ptr) -> vector<2xi32> {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.inttoptr %arg0 : vector<2xi32> to !llvm.vec<2 x ptr>
    %2 = llvm.insertelement %arg1, %1[%0 : i32] : !llvm.vec<2 x ptr>
    llvm.call @use(%2) : (!llvm.vec<2 x ptr>) -> ()
    %3 = llvm.ptrtoint %2 : !llvm.vec<2 x ptr> to vector<2xi32>
    llvm.return %3 : vector<2xi32>
  }
  llvm.func @ptr_add_in_int(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }
  llvm.func @ptr_add_in_int_2(%arg0: i32, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr inbounds %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i32
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }
  llvm.func @ptr_add_in_int_nneg(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i32) -> i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }
  llvm.func @ptr_add_in_int_different_type_1(%arg0: i32, %arg1: i32) -> i64 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i64
    llvm.return %2 : i64
  }
  llvm.func @ptr_add_in_int_different_type_2(%arg0: i32, %arg1: i32) -> i16 {
    %0 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i16
    llvm.return %2 : i16
  }
  llvm.func @ptr_add_in_int_different_type_3(%arg0: i16, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i16 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }
  llvm.func @ptr_add_in_int_different_type_4(%arg0: i64, %arg1: i32) -> i32 {
    %0 = llvm.inttoptr %arg0 : i64 to !llvm.ptr
    %1 = llvm.getelementptr %0[%arg1] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %2 = llvm.ptrtoint %1 : !llvm.ptr to i32
    llvm.return %2 : i32
  }
  llvm.func @ptr_add_in_int_not_inbounds(%arg0: i32, %arg1: i32) -> i32 {
    %0 = "llvm.intr.abs"(%arg1) <{is_int_min_poison = true}> : (i32) -> i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }
  llvm.func @ptr_add_in_int_const(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }
  llvm.func @ptr_add_in_int_const_negative(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(-4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }
  llvm.func @use_ptr(!llvm.ptr)
  llvm.func @ptr_add_in_int_extra_use1(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    llvm.call @use_ptr(%1) : (!llvm.ptr) -> ()
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }
  llvm.func @ptr_add_in_int_extra_use2(%arg0: i32) -> i32 {
    %0 = llvm.mlir.constant(4096 : i32) : i32
    %1 = llvm.inttoptr %arg0 : i32 to !llvm.ptr
    %2 = llvm.getelementptr inbounds %1[%0] : (!llvm.ptr, i32) -> !llvm.ptr, i8
    llvm.call @use_ptr(%2) : (!llvm.ptr) -> ()
    %3 = llvm.ptrtoint %2 : !llvm.ptr to i32
    llvm.return %3 : i32
  }
}
