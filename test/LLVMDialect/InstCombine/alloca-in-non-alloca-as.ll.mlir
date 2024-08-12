module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<6>, dense<32> : vector<4xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<7>, dense<[160, 256, 256, 32]> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<8>, dense<128> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<2>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<1>, dense<64> : vector<4xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<4>, dense<64> : vector<4xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr<3>, dense<32> : vector<4xi64>>, #dlti.dl_entry<!llvm.ptr<5>, dense<32> : vector<4xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.stack_alignment", 32 : i64>, #dlti.dl_entry<"dlti.alloca_memory_space", 5 : ui64>, #dlti.dl_entry<"dlti.global_memory_space", 1 : ui64>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @use(!llvm.ptr)
  llvm.func @use2(!llvm.ptr, !llvm.ptr)
  llvm.func weak amdgpu_kernelcc @__omp_offloading_802_ea0109_main_l8(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(8 : i64) : i64
    %1 = llvm.mlir.undef : !llvm.ptr
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i64) -> !llvm.ptr
    llvm.store %1, %2 {alignment = 8 : i64} : !llvm.ptr, !llvm.ptr
    llvm.call @use2(%2, %2) : (!llvm.ptr, !llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @spam(%arg0: !llvm.ptr) {
    %0 = llvm.mlir.constant(0 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<30 x struct<"struct.widget", (array<8 x i8>)>> {alignment = 16 : i64} : (i32) -> !llvm.ptr
    llvm.call @zot(%1) : (!llvm.ptr) -> ()
    llvm.return
  }
  llvm.func @alloca_addrspace_0_nonnull() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.zero : !llvm.ptr
    %2 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr
    llvm.call @use(%2) : (!llvm.ptr) -> ()
    %3 = llvm.icmp "ne" %2, %1 : !llvm.ptr
    llvm.return %3 : i1
  }
  llvm.func @alloca_addrspace_5_nonnull() -> i1 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.addressof @use : !llvm.ptr
    %2 = llvm.mlir.zero : !llvm.ptr<5>
    %3 = llvm.alloca %0 x i8 {alignment = 1 : i64} : (i32) -> !llvm.ptr<5>
    llvm.call %1(%3) : !llvm.ptr, (!llvm.ptr<5>) -> ()
    %4 = llvm.icmp "ne" %3, %2 : !llvm.ptr<5>
    llvm.return %4 : i1
  }
  llvm.func hidden @zot(!llvm.ptr)
}
