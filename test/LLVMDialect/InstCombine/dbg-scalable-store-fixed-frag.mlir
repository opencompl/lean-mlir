#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"u.cpp" in "/path/to/test">
#di_null_type = #llvm.di_null_type
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C_plus_plus_14, file = #di_file, producer = "clang version 17.0.0 (git@github.com:llvm/llvm-project.git a489e11439e36c7e0ec83b28a6fb1596a5c21faa)", isOptimized = true, emissionKind = Full>
#di_composite_type = #llvm.di_composite_type<tag = DW_TAG_array_type, baseType = #di_basic_type, sizeInBits = 128>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_null_type>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "foo", linkageName = "foo", file = #di_file, line = 2, scopeLine = 2, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_subprogram1 = #llvm.di_subprogram<id = distinct[2]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "foo2", linkageName = "foo2", file = #di_file, line = 5, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "arr", file = #di_file, line = 3, type = #di_composite_type>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram1, name = "arr", file = #di_file, line = 6, type = #di_composite_type>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.func @foo(%arg0: !llvm.vec<? x 2 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x i32 {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable = %1 : !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.vec<? x 2 x  i32>, !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
  llvm.func @foo2(%arg0: !llvm.vec<? x 2 x  i32>) -> i32 {
    %0 = llvm.mlir.constant(1 : i32) : i32
    %1 = llvm.alloca %0 x !llvm.array<4 x i32> {alignment = 4 : i64} : (i32) -> !llvm.ptr
    llvm.intr.dbg.declare #di_local_variable1 = %1 : !llvm.ptr
    llvm.store %arg0, %1 {alignment = 4 : i64} : !llvm.vec<? x 2 x  i32>, !llvm.ptr
    %2 = llvm.load %1 {alignment = 4 : i64} : !llvm.ptr -> i32
    llvm.return %2 : i32
  }
}
