import re
#so far supports all instructions until &with rorw 

def parse_riscv_to_mlir(riscv_code, example_number):
    lines = riscv_code.strip().split("\n")
    instructions = []
    reg_map = {}  # Track register mappings
    temp_counter = 0  # Unique counter for MLIR registers
    source_registers_for_entry = set()
    written_registers = set()
    
    for line in lines:
        line = line.strip()
        if not line or line.startswith("#"):  #comments
            continue
        
        if line.count(',') == 2:
            #op_string = f'{op}'
            #if op_string in ['slliw', 'srliw', 'sraiw', 'slli', 'srli', 'srai','bclri', 'bexti', 'binvi', 'bseti', 'addi','slti', 'sltiu', 'andi', 'ori','xori', 'bclri', 'bexti', 'binvi', 'bseti']:
            match = re.match(r"(\w+)\s+(x\d+),\s*(x\d+),\s*(\d+)", line)
            if match is None:
                match = re.match(r"(\w+)\s+(x\d+),\s*(x\d+),\s*(x\d+)", line)
        else:
            match = re.match(r"(\w+)\s+(x\d+),\s*(\d+)", line)
        
        if match:
            op, dest, *operands = match.groups()
            op = f'RV64.{op}'  # Convert to MLIR-style op
            
            # Resolve operands
            resolved_operands = []
            for operand in operands:
                if operand in reg_map:
                    resolved_operands.append(reg_map[operand])  # Use computed value
                else:
                    if operand.startswith('x'):
                        resolved_operands.append(f"%{operand}") 
                        source_registers_for_entry.add(f"%{operand}: !i64")
                    else:
                        resolved_operands.append(f"{operand}")  
            
            # Track written registers
            written_registers.add(dest)
            
            # Assign new MLIR temp register
                        
            if len(resolved_operands) == 2: # addw, subw, sllw, srlw, sraw, add, slt, sltu, and, or, xor, sll, srl, sub, sra, remw, rem, mul, mulu, mulw, mulh, mulhu, mulhsu, divu, remwu, remw, divw, div
                if dest not in reg_map:
                    reg_map[dest] = f"%{temp_counter}"
                if op not in ['RV64.slliw', 'RV64.srliw', 'RV64.sraiw', 'RV64.slli', 'RV64.srli', 'RV64.srai','RV64.bclri', 'RV64.bexti', 'RV64.binvi', 'RV64.bseti', 'RV64.addi','RV64.slti', 'RV64.sltiu', 'RV64.andi', 'RV64.ori','RV64.xori']:
                    instructions.append(
                        f'    %{temp_counter} = "{op}" ({resolved_operands[0]}, {resolved_operands[1]}) : (!i64, !i64) -> (!i64)'
                    )
                else:
                    imm = resolved_operands[1]
                    if op not in ['RV64.slliw', 'RV64.srliw', 'RV64.sraiw', 'RV64.slli', 'RV64.srli', 'RV64.srai','RV64.bclri', 'RV64.bexti', 'RV64.binvi', 'RV64.bseti']:
                        instructions.append(f'    %{temp_counter} = "{op}" ({resolved_operands[0]}) {{ imm = {imm} : !i64 }} : (!i64) -> (!i64)')
                    else:
                        instructions.append(f'    %{temp_counter} = "{op}" ({resolved_operands[0]}) {{ shamt= {imm} : !i64 }} : (!i64) -> (!i64)')    

            else:
                imm = resolved_operands[0]
                if dest not in reg_map:
                    d = f'%{dest}'
                    reg_map[dest] = f"%{temp_counter}"
                else:
                    d = reg_map[dest]
                if op in ['RV64.addiw', 'RV64.lui', 'RV64.auipc','RV64.addi', 'RV64.slti', 'RV64.slti','RV64.sltiu','RV64.andi','RV64.ori','RV64.xori']:
                    instructions.append(f'    %{temp_counter} = "{op}" ({d}) {{ imm = {imm} : !i64 }} : (!i64) -> (!i64)')
                elif op in ['RV64.slliw', 'RV64.srliw', 'RV64.sraiw', 'RV64.slli', 'RV64.srli', 'RV64.srai','RV64.bclri', 'RV64.bexti', 'RV64.binvi', 'RV64.bseti' ]: 
                    instructions.append(f'    %{temp_counter} = "{op}" ({d}) {{ shamt = {imm} : !i64 }} : (!i64) -> (!i64)')
                elif op in ['RV64.const']:
                    instructions.append(f'    %{temp_counter} = "{op}" ({d}) {{ val = {imm} : !i64 }} : (!i64) -> (!i64)')

            temp_counter += 1  # Increment counter for unique MLIR register
    
    # Remove written registers from entry list
    #source_registers_for_entry -= {f"{reg}: !i64" for reg in written_registers}
    entry_stuff = ", ".join(sorted(source_registers_for_entry))
    arguments = ('!i64, ' * len(source_registers_for_entry))[:-2]

    
    mlir_output = f"""def RISCVEg{example_number} := [RV64_com| {{
  ^entry ({entry_stuff}):
{chr(10).join(instructions)}
    "return" (%{temp_counter - 1}) : ({arguments}) -> ()
}}].denote"""
    return mlir_output

# Example usage
if __name__ == "__main__":
    riscv_code1 = """
    add x1, x9, x10
    const x2, 10
    add x1, x2, x2
    const x3, 10
    slli x3, x3, 1
    """
    mlir_dialect = parse_riscv_to_mlir(riscv_code1, 1)
    print(mlir_dialect)
#sdiv 1, %X
#subw x30, x15, x5
#lui x30, $19
#slliw x1, $5
#sraiw x10, $19
'''
    add x1, x1, x1 
    subw x30, x15, x5
    mulu x12, x1, x2
    const x12, 3
'''