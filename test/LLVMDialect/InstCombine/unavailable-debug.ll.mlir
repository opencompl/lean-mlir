#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "char", sizeInBits = 8, encoding = DW_ATE_signed_char>
#di_basic_type1 = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"a.c" in "/Users/davide/llvm/build/bin">
#tbaa_root = #llvm.tbaa_root<id = "Simple C/C++ TBAA">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version 9.0.0 (https://github.com/llvm/llvm-project b306ef12f046353ea5bda4b3b77759e57909a0db)", isOptimized = true, emissionKind = Full>
#di_derived_type = #llvm.di_derived_type<tag = DW_TAG_typedef, name = "a", baseType = #di_basic_type1>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_basic_type, #di_basic_type1>
#di_subroutine_type1 = #llvm.di_subroutine_type<types = #di_basic_type1>
#di_global_variable = #llvm.di_global_variable<scope = #di_compile_unit, name = "e", file = #di_file, line = 3, type = #di_basic_type, isDefined = true>
#di_global_variable1 = #llvm.di_global_variable<scope = #di_compile_unit, name = "c", file = #di_file, line = 2, type = #di_derived_type, isDefined = true>
#di_global_variable2 = #llvm.di_global_variable<scope = #di_compile_unit, name = "d", file = #di_file, line = 2, type = #di_derived_type, isDefined = true>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "b", file = #di_file, line = 4, scopeLine = 4, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type>
#di_subprogram1 = #llvm.di_subprogram<id = distinct[2]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "main", file = #di_file, line = 5, scopeLine = 5, subprogramFlags = "Definition|Optimized", type = #di_subroutine_type1>
#tbaa_type_desc = #llvm.tbaa_type_desc<id = "omnipotent char", members = {<#tbaa_root, 0>}>
#di_global_variable_expression = #llvm.di_global_variable_expression<var = #di_global_variable, expr = <>>
#di_global_variable_expression1 = #llvm.di_global_variable_expression<var = #di_global_variable1, expr = <>>
#di_global_variable_expression2 = #llvm.di_global_variable_expression<var = #di_global_variable2, expr = <>>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "f", file = #di_file, line = 4, arg = 1, type = #di_basic_type1>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram1, name = "l_1499", file = #di_file, line = 7, type = #di_derived_type>
#tbaa_tag = #llvm.tbaa_tag<base_type = #tbaa_type_desc, access_type = #tbaa_type_desc, offset = 0>
#tbaa_type_desc1 = #llvm.tbaa_type_desc<id = "int", members = {<#tbaa_type_desc, 0>}>
#tbaa_tag1 = #llvm.tbaa_tag<base_type = #tbaa_type_desc1, access_type = #tbaa_type_desc1, offset = 0>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common local_unnamed_addr @e(0 : i8) {addr_space = 0 : i32, alignment = 1 : i64, dbg_expr = #di_global_variable_expression} : i8
  llvm.mlir.global common local_unnamed_addr @c(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64, dbg_expr = #di_global_variable_expression1} : i32
  llvm.mlir.global common local_unnamed_addr @d(0 : i32) {addr_space = 0 : i32, alignment = 4 : i64, dbg_expr = #di_global_variable_expression2} : i32
  llvm.func local_unnamed_addr @b(%arg0: i32) -> (i8 {llvm.signext}) {
    llvm.intr.dbg.value #di_local_variable = %arg0 : i32
    %0 = llvm.trunc %arg0 : i32 to i8
    llvm.return %0 : i8
  }
  llvm.func local_unnamed_addr @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @e : !llvm.ptr
    %2 = llvm.mlir.constant(0 : i32) : i32
    %3 = llvm.mlir.addressof @c : !llvm.ptr
    %4 = llvm.mlir.constant(6 : i32) : i32
    %5 = llvm.mlir.addressof @d : !llvm.ptr
    %6 = llvm.mlir.constant(-1372423381 : i32) : i32
    llvm.intr.dbg.value #di_local_variable1 = %6 : i32
    %7 = llvm.load %1 {alignment = 1 : i64, tbaa = [#tbaa_tag]} : !llvm.ptr -> i8
    %8 = llvm.sext %7 : i8 to i32
    llvm.store %8, %3 {alignment = 4 : i64, tbaa = [#tbaa_tag1]} : i32, !llvm.ptr
    %9 = llvm.call @b(%4) : (i32) -> i8
    %10 = llvm.sext %9 : i8 to i32
    llvm.intr.dbg.value #di_local_variable1 = %10 : i32
    %11 = llvm.load %5 {alignment = 4 : i64, tbaa = [#tbaa_tag1]} : !llvm.ptr -> i32
    %12 = llvm.call @optimize_me_not() vararg(!llvm.func<i32 (...)>) : () -> i32
    llvm.return %2 : i32
  }
  llvm.func local_unnamed_addr @optimize_me_not(...) -> i32
}
