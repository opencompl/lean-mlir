#di_basic_type = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "char", sizeInBits = 8, encoding = DW_ATE_signed_char>
#di_basic_type1 = #llvm.di_basic_type<tag = DW_TAG_base_type, name = "int", sizeInBits = 32, encoding = DW_ATE_signed>
#di_file = #llvm.di_file<"test" in "n">
#di_compile_unit = #llvm.di_compile_unit<id = distinct[0]<>, sourceLanguage = DW_LANG_C99, file = #di_file, producer = "clang version 10.0.0", isOptimized = false, emissionKind = Full>
#di_subroutine_type = #llvm.di_subroutine_type<types = #di_basic_type1>
#di_global_variable = #llvm.di_global_variable<scope = #di_compile_unit, name = "a", file = #di_file, line = 1, type = #di_basic_type, isDefined = true>
#di_global_variable1 = #llvm.di_global_variable<scope = #di_compile_unit, name = "b", file = #di_file, line = 1, type = #di_basic_type, isDefined = true>
#di_subprogram = #llvm.di_subprogram<id = distinct[1]<>, compileUnit = #di_compile_unit, scope = #di_file, name = "main", file = #di_file, line = 2, scopeLine = 2, subprogramFlags = Definition, type = #di_subroutine_type>
#di_global_variable_expression = #llvm.di_global_variable_expression<var = #di_global_variable, expr = <>>
#di_global_variable_expression1 = #llvm.di_global_variable_expression<var = #di_global_variable1, expr = <>>
#di_local_variable = #llvm.di_local_variable<scope = #di_subprogram, name = "l_1240", file = #di_file, line = 6, type = #di_basic_type1>
#di_local_variable1 = #llvm.di_local_variable<scope = #di_subprogram, name = "c", file = #di_file, line = 4, type = #di_basic_type1>
module attributes {dlti.dl_spec = #dlti.dl_spec<#dlti.dl_entry<f128, dense<128> : vector<2xi64>>, #dlti.dl_entry<f16, dense<16> : vector<2xi64>>, #dlti.dl_entry<f64, dense<64> : vector<2xi64>>, #dlti.dl_entry<i64, dense<[32, 64]> : vector<2xi64>>, #dlti.dl_entry<i32, dense<32> : vector<2xi64>>, #dlti.dl_entry<i8, dense<8> : vector<2xi64>>, #dlti.dl_entry<i16, dense<16> : vector<2xi64>>, #dlti.dl_entry<i1, dense<8> : vector<2xi64>>, #dlti.dl_entry<!llvm.ptr, dense<64> : vector<4xi64>>, #dlti.dl_entry<"dlti.endianness", "little">>} {
  llvm.mlir.global common @a(0 : i8) {addr_space = 0 : i32, alignment = 1 : i64, dbg_expr = #di_global_variable_expression, dso_local} : i8
  llvm.mlir.global common @b(0 : i8) {addr_space = 0 : i32, alignment = 1 : i64, dbg_expr = #di_global_variable_expression1, dso_local} : i8
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i8) : i8
    %1 = llvm.mlir.addressof @a : !llvm.ptr
    %2 = llvm.mlir.constant(-1 : i8) : i8
    %3 = llvm.mlir.constant(4 : i32) : i32
    %4 = llvm.mlir.addressof @b : !llvm.ptr
    %5 = llvm.mlir.constant(0 : i32) : i32
    %6 = llvm.mlir.constant(-8 : i32) : i32
    llvm.intr.dbg.value #di_local_variable = %6 : i32
    %7 = llvm.load %1 {alignment = 1 : i64} : !llvm.ptr -> i8
    %8 = llvm.add %7, %2  : i8
    llvm.store %8, %1 {alignment = 1 : i64} : i8, !llvm.ptr
    %9 = llvm.sext %8 : i8 to i32
    %10 = llvm.udiv %9, %3  : i32
    llvm.intr.dbg.value #di_local_variable = %10 : i32
    llvm.intr.dbg.value #di_local_variable1 = %10 : i32
    llvm.store %0, %4 {alignment = 1 : i64} : i8, !llvm.ptr
    %11 = llvm.icmp "sgt" %9, %5 : i32
    %12 = llvm.zext %11 : i1 to i32
    llvm.return %5 : i32
  }
}
