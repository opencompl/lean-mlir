module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @__isnan(%arg0: f32) -> i32 attributes {passthrough = ["alwaysinline", "nounwind", "optsize"]} {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.mlir.constant(-16777216 : i32) : i32
    %2 = llvm.alloca %0 x f32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.store %arg0, %2 {alignment = 4 : i64} : f32, !llvm.ptr
    %3 = llvm.load %2 {alignment = 4 : i64} : !llvm.ptr -> f32
    %4 = llvm.bitcast %3 : f32 to i32
    %5 = llvm.shl %4, %0  : i32
    %6 = llvm.icmp "ugt" %5, %1 : i32
    %7 = llvm.zext %6 : i1 to i32
    llvm.return %7 : i32
  }
  llvm.func @icmp_shl7(%arg0: i32) -> i1 {
    %0 = llvm.mlir.constant(7 : i32) : i32
    %1 = llvm.mlir.constant(4608 : i32) : i32
    %2 = llvm.shl %arg0, %0  : i32
    %3 = llvm.icmp "slt" %2, %1 : i32
    llvm.return %3 : i1
  }
}
