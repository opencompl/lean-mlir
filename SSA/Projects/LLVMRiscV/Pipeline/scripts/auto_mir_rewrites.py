#!/usr/bin/env python3
"""Translates LLVM GlobalISel MIR patterns to Lean-MLIR rewrite rules."""

import re
import sys
from dataclasses import dataclass, field
from typing import Dict, List, Optional, Tuple

LLVM_OPS = {
    'G_ADD': 'llvm.add', 'G_SUB': 'llvm.sub', 'G_MUL': 'llvm.mul',
    'G_SDIV': 'llvm.sdiv', 'G_UDIV': 'llvm.udiv',
    'G_SREM': 'llvm.srem', 'G_UREM': 'llvm.urem',
    'G_AND': 'llvm.and', 'G_OR': 'llvm.or', 'G_XOR': 'llvm.xor',
    'G_SHL': 'llvm.shl', 'G_LSHR': 'llvm.lshr', 'G_ASHR': 'llvm.ashr',
    'G_ICMP': 'llvm.icmp', 'G_SELECT': 'llvm.select',
    'G_ZEXT': 'llvm.zext', 'G_SEXT': 'llvm.sext', 'G_ANYEXT': 'llvm.zext',
    'G_TRUNC': 'llvm.trunc', 'G_CONSTANT': 'llvm.mlir.constant',
    'G_FREEZE': 'llvm.freeze',
}

BUILTIN_OPS = {'GIReplaceReg', 'GIEraseRoot', 'COPY'}

@dataclass
class Operand:
    name: str                   # e.g. "$dst", "$zero"
    ty: Optional[str] = None    # e.g. "root" from root:$dst
    is_imm: bool = False   # is immediate
    imm_val: Optional[int] = None  # immediate value


@dataclass
class Inst:
    op: str                        # e.g. "G_ADD", "GIReplaceReg"
    operands: List[Operand] = field(default_factory=list)
    name: Optional[str] = None     # optional inst name like :$mi


@dataclass
class PatFrag:
    name: str                          # e.g. "binop_left_to_zero_frags"
    outs: List[Tuple[str, str]]        # (type, name) pairs
    ins: List[Tuple[str, str]]
    alts: List[List[Inst]] = field(default_factory=list)   # possible expansions


@dataclass 
class Rule:
    name: str
    defs: List[str]
    match: List[Inst] = field(default_factory=list)     # pattern to match
    apply: List[Inst] = field(default_factory=list)     # replacement
    has_cpp: bool = False
    has_cpp_match: bool = False
    has_wip_match: bool = False
    has_matchdata: bool = False


class Parser:
    def __init__(self, src: str):
        self.src = src
        self.frags: Dict[str, PatFrag] = {}
        self.rules: Dict[str, Rule] = {}
    
    def parse(self):
        self._parse_frags()  # parse GICombinePatFrags
        self._parse_rules()  # parse GICombineRules
    
    def _extract_body(self, start: int, open_ch: str, close_ch: str) -> Optional[str]:
        depth, i = 1, start
        while i < len(self.src) and depth > 0:
            if self.src[i] == open_ch: depth += 1
            elif self.src[i] == close_ch: depth -= 1
            i += 1
        return self.src[start:i-1] if depth == 0 else None
    
    def _parse_frags(self):
        for m in re.finditer(r'def\s+(\w+)\s*:\s*GICombinePatFrag\s*<', self.src):
            body = self._extract_body(m.end(), '<', '>')
            if not body:
                continue
            
            outs_m = re.search(r'\(outs\s+([^)]+)\)', body)
            ins_m = re.search(r'\(ins\s*([^)]*)\)', body)
            outs = self._parse_params(outs_m.group(1)) if outs_m else []
            ins = self._parse_params(ins_m.group(1)) if ins_m else []
            
            frag = PatFrag(name=m.group(1), outs=outs, ins=ins)
            
            foreach_m = re.search(r'!\s*foreach\s*\(\s*(\w+)\s*,\s*\[([^\]]+)\]\s*,\s*\(pattern\s+', body, re.DOTALL)
            if foreach_m:
                var = foreach_m.group(1)
                ops = [o.strip() for o in foreach_m.group(2).split(',')]
                pat_start = foreach_m.end()
                pat = self._extract_balanced(body, pat_start)
                if pat:
                    for op in ops:
                        insts = self._parse_insts(pat.replace(var, op))
                        if insts:
                            frag.alts.append(insts)
            else:
                # Try pattern list in brackets - find each (pattern ...) with balanced parens
                for pm in re.finditer(r'\(pattern\s+', body):
                    pat = self._extract_balanced(body, pm.end())
                    if pat:
                        insts = self._parse_insts(pat)
                        if insts:
                            frag.alts.append(insts)
            
            if frag.alts:
                self.frags[frag.name] = frag
    
    def _extract_balanced(self, s: str, start: int) -> Optional[str]:
        """Extract content until parens are balanced (one more close than open)."""
        depth, i = 0, start
        while i < len(s):
            if s[i] == '(':
                depth += 1
            elif s[i] == ')':
                if depth == 0:
                    return s[start:i]
                depth -= 1
            i += 1
        return None
    
    def _parse_rules(self):
        for m in re.finditer(r'def\s+(\w+)\s*:\s*GICombineRule\s*<', self.src):
            body = self._extract_body(m.end(), '<', '>')
            if not body:
                continue
            
            rule = Rule(name=m.group(1), defs=[])
            rule.has_cpp = '[{' in body or '${' in body
            rule.has_wip_match = 'wip_match_opcode' in body
            rule.has_matchdata = '_matchinfo' in body or '_matchdata' in body
            
            defs_m = re.search(r'\(defs\s+([^)]+)\)', body)
            if defs_m:
                for item in defs_m.group(1).split(','):
                    item = item.strip()
                    rule.defs.append(item.split(':')[1].strip() if ':' in item else item)
            
            match_m = re.search(r'\(match\s+(.+?)\)\s*,\s*\(apply', body, re.DOTALL)
            if match_m:
                content = match_m.group(1)
                rule.has_cpp_match = '[{' in content
                rule.match = self._parse_insts(re.sub(r'\[\{.*?\}\]', '', content, flags=re.DOTALL))
            
            apply_m = re.search(r'\(apply\s+(.+?)\)\s*(?:>|$)', body, re.DOTALL)
            if apply_m:
                content = apply_m.group(1)
                if '[{' in content:
                    rule.has_cpp = True
                rule.apply = self._parse_insts(re.sub(r'\[\{.*?\}\]', '', content, flags=re.DOTALL))
            
            self.rules[rule.name] = rule
    
    def _parse_params(self, s: str) -> List[Tuple[str, str]]:
        params = []
        for p in s.split(','):
            p = p.strip()
            if ':' in p:
                ty, name = p.split(':', 1)
                params.append((ty.strip(), name.strip()))
            elif p.startswith('$'):
                params.append(('', p))
        return params
    
    def _parse_insts(self, s: str) -> List[Inst]:
        insts, depth, cur = [], 0, ""
        for c in s:
            if c == '(':
                if depth == 0: cur = ""
                depth += 1
                cur += c
            elif c == ')':
                depth -= 1
                cur += c
                if depth == 0:
                    inst = self._parse_inst(cur.strip())
                    if inst:
                        insts.append(inst)
                    cur = ""
            elif depth > 0:
                cur += c
        return insts
    
    def _parse_inst(self, s: str) -> Optional[Inst]:
        name_m = re.search(r'\)\s*:\s*\$(\w+)\s*$', s)
        name = f"${name_m.group(1)}" if name_m else None
        if name_m:
            s = s[:name_m.start()] + ')'
        
        if not (s.startswith('(') and s.endswith(')')):
            return None
        
        tokens = self._tokenize(s[1:-1].strip())
        if not tokens:
            return None
        
        inst = Inst(op=tokens[0], name=name)
        for t in tokens[1:]:
            op = self._parse_operand(t)
            if op:
                inst.operands.append(op)
        return inst
    
    def _tokenize(self, s: str) -> List[str]:
        tokens, cur, depth = [], "", 0
        for c in s:
            if c == '(': depth += 1; cur += c
            elif c == ')': depth -= 1; cur += c
            elif (c == ',' or c.isspace()) and depth == 0:
                if cur.strip(): tokens.append(cur.strip())
                cur = ""
            else: cur += c
        if cur.strip():
            tokens.append(cur.strip())
        return tokens
    
    def _parse_operand(self, t: str) -> Optional[Operand]:
        t = t.strip()
        
        if m := re.match(r'\((\w+)\s+(-?\d+)\)', t):
            return Operand(name="", ty=m.group(1), is_imm=True, imm_val=int(m.group(2)))
        if re.match(r'^-?\d+$', t):
            return Operand(name="", is_imm=True, imm_val=int(t))
        if m := re.match(r'(-?\d+):\$(\w+)', t):
            return Operand(name=f"${m.group(2)}", is_imm=True, imm_val=int(m.group(1)))
        if m := re.match(r'(\w+):\$(\w+)', t):
            return Operand(name=f"${m.group(2)}", ty=m.group(1))
        if t.startswith('$'):
            return Operand(name=t)
        if m := re.match(r'GITypeOf<"\$\w+">:(\$\w+)', t):
            return Operand(name=m.group(1))
        return None


class Emitter:
    def __init__(self, bw=64):
        self.bw = bw        # bitwidth
        self.idx = 0        # next variable number
        self.vars = {}      # map from TableGen names ("$zero") to SSA names ("%1")
        self.lines = []     # accumulated output lines
    
    def reset(self, inputs: List[str]):
        self.idx, self.vars, self.lines = 0, {}, []
        for name in inputs:
            self.vars[name] = self._next()
    
    def _next(self) -> str:
        v = f"%{self.idx}"
        self.idx += 1
        return v
    
    def const(self, val: int) -> str:
        v = self._next()
        self.lines.append(f"      {v} = llvm.mlir.constant ({val}) : i{self.bw}")
        return v
    
    def emit(self, inst: Inst, consts: Dict[str, int]) -> Optional[str]:
        llvm_op = LLVM_OPS.get(inst.op)
        if not llvm_op or not inst.operands:
            return None
        
        # Handle G_CONSTANT specially: just create the constant directly
        # instead of emitting a redundant intermediate instruction
        if inst.op == 'G_CONSTANT' and len(inst.operands) > 1 and inst.operands[1].is_imm:
            result = self.const(inst.operands[1].imm_val)
            self.vars[inst.operands[0].name] = result
            return result
        
        # Process arguments FIRST to ensure sequential variable numbering.
        # Any const() calls here allocate %N before the result gets %N+1.
        args = []
        for op in inst.operands[1:]:
            if op.is_imm and not op.name:
                args.append(self.const(op.imm_val))
            elif op.name in consts and op.name not in self.vars:
                self.vars[op.name] = self.const(consts[op.name])
                args.append(self.vars[op.name])
            elif op.name in self.vars:
                args.append(self.vars[op.name])
            else:
                args.append(f"%{op.name[1:]}")
        
        # Allocate result AFTER operands so numbering is sequential
        result = self._next()
        self.vars[inst.operands[0].name] = result
        
        self.lines.append(f"      {result} = {llvm_op} {', '.join(args)} : i{self.bw}")
        return result
    
    def entry(self, inputs: List[str]) -> str:
        if not inputs:
            return "    ^entry:"
        params = ", ".join(f"{self.vars[n]}: i{self.bw}" for n in inputs)
        return f"    ^entry ({params}):"


class Generator:
    def __init__(self, parser: Parser):
        self.parser = parser
        self.emitter = Emitter()
        self.generated: List[str] = []
        self.skipped: Dict[str, str] = {}
    
    def generate(self) -> str:
        lines = [
            "-- AUTOGENERATED Lean file: Automated GlobalISel pattern translation from llvm/include/llvm/Target/GlobalISel/Combine.td",
            "import SSA.Projects.LLVMRiscV.PeepholeRefine",
            "import SSA.Projects.LLVMRiscV.Simpproc", 
            "import SSA.Projects.RISCV64.Tactic.SimpRiscV",
            "import SSA.Projects.LLVMRiscV.Pipeline.mkRewrite",
            "import SSA.Projects.LLVMRiscV.Pipeline.ConstantMatching",
            "", "open LLVMRiscV", ""
        ]
        
        for name, rule in self.parser.rules.items():
            if result := self._gen_rule(name, rule):
                lines.append(result)
        
        lines.append(self._gen_list())
        return "\n".join(lines)
    
    def _gen_rule(self, name: str, rule: Rule) -> Optional[str]:
        if rule.has_wip_match:
            self.skipped[name] = "uses wip_match_opcode"; return None
        if rule.has_cpp_match:
            self.skipped[name] = "contains C++ in match"; return None
        if rule.has_cpp and not all(i.op in BUILTIN_OPS or i.op in LLVM_OPS for i in rule.apply):
            self.skipped[name] = "contains C++ in apply"; return None
        if rule.has_matchdata:
            self.skipped[name] = "uses matchdata"; return None
        if not rule.match or not rule.apply:
            self.skipped[name] = "no match/apply"; return None
        
        expanded = self._expand_frags(rule.match)
        if not expanded:
            self.skipped[name] = "PatFrag expansion failed"; return None
        
        for alt in expanded:
            for inst in alt:
                if inst.op not in LLVM_OPS and inst.op not in BUILTIN_OPS and inst.op not in self.parser.frags:
                    self.skipped[name] = f"unsupported: {inst.op}"; return None
        
        results = []
        for i, match in enumerate(expanded):
            suffix = f"_{i}" if len(expanded) > 1 else ""
            if r := self._gen_single(name + suffix, match, rule.apply):
                results.append(r)
                self.generated.append(name + suffix)
        
        return "\n".join(results) if results else None
    
    def _expand_frags(self, insts: List[Inst]) -> Optional[List[List[Inst]]]:
        if not any(i.op in self.parser.frags for i in insts):
            return [insts]
        
        alts = [[]]
        for inst in insts:
            if inst.op not in self.parser.frags:
                for a in alts: a.append(inst)
                continue
            
            frag = self.parser.frags[inst.op]
            new_alts = []
            for frag_alt in frag.alts:
                if any(i.op not in LLVM_OPS and i.op not in BUILTIN_OPS for i in frag_alt):
                    continue
                expanded = self._subst_frag(frag, inst, frag_alt)
                if expanded:
                    for existing in alts:
                        new_alts.append(existing + expanded)
            if not new_alts:
                return None
            alts = new_alts
        
        return alts if alts and alts[0] else None
    
    def _subst_frag(self, frag: PatFrag, call: Inst, alt: List[Inst]) -> List[Inst]:
        param_map = {}
        for i, (_, param) in enumerate(frag.outs + frag.ins):
            if i < len(call.operands):
                param_map[param] = call.operands[i].name
        
        result = []
        for inst in alt:
            new_ops = [
                Operand(name=param_map.get(op.name, op.name), ty=op.ty, is_imm=op.is_imm, imm_val=op.imm_val)
                for op in inst.operands
            ]
            result.append(Inst(op=inst.op, operands=new_ops, name=inst.name))
        return result
    
    def _gen_single(self, name: str, match: List[Inst], apply: List[Inst]) -> Optional[str]:
        consts = {op.name: op.imm_val for inst in match for op in inst.operands if op.is_imm and op.name}
        defined = {inst.operands[0].name for inst in match if inst.operands}
        
        inputs = []
        seen = set()
        for inst in match + apply:
            for op in inst.operands:
                if op.name and op.name not in defined and op.name not in consts and not op.is_imm and op.name not in seen:
                    inputs.append(op.name)
                    seen.add(op.name)
        inputs.sort()
        
        match = self._topo_sort(match)
        bw = self.emitter.bw
        
        lines = [f"/-- ### {name} -/"]
        ty_list = ", ".join(f"Ty.llvm (.bitvec {bw})" for _ in inputs)
        lines.append(f"def {name} : LLVMPeepholeRewriteRefine {bw} [{ty_list}] where")
        
        # LHS
        self.emitter.reset(inputs)
        for c, v in consts.items():
            self.emitter.vars[c] = self.emitter.const(v)
        root = None
        for inst in match:
            root = self.emitter.emit(inst, consts)
        
        lines.append("  lhs := [LV| {")
        lines.append(self.emitter.entry(inputs))
        lines.extend(self.emitter.lines)
        lines.append(f"      llvm.return {root} : i{bw}")
        lines.append("  }]")
        
        # RHS
        self.emitter.reset(inputs)
        is_replace = len(apply) == 1 and apply[0].op == 'GIReplaceReg'
        
        if is_replace and len(apply[0].operands) >= 2:
            rep = apply[0].operands[1]
            if rep.name in consts:
                rhs_var = self.emitter.const(consts[rep.name])
            elif rep.name in self.emitter.vars:
                rhs_var = self.emitter.vars[rep.name]
            else:
                for c, v in consts.items():
                    self.emitter.vars[c] = self.emitter.const(v)
                for inst in self._find_deps(match, rep.name):
                    rhs_var = self.emitter.emit(inst, consts)
        else:
            for c, v in consts.items():
                self.emitter.vars[c] = self.emitter.const(v)
            rhs_var = None
            for inst in self._topo_sort(apply):
                if inst.op == 'GIReplaceReg' and len(inst.operands) >= 2:
                    op = inst.operands[1]
                    rhs_var = self.emitter.vars.get(op.name)
                elif inst.op not in BUILTIN_OPS:
                    rhs_var = self.emitter.emit(inst, consts)
        
        lines.append("  rhs := [LV| {")
        lines.append(self.emitter.entry(inputs))
        lines.extend(self.emitter.lines)
        if rhs_var:
            lines.append(f"      llvm.return {rhs_var} : i{bw}")
        lines.append("  }]")
        lines.append("")
        
        return "\n".join(lines)
    
    
    def _topo_sort(self, insts: List[Inst]) -> List[Inst]:
        if not insts:
            return insts
        
        defines = {inst.operands[0].name: i for i, inst in enumerate(insts) if inst.operands}
        deps = {i: set() for i in range(len(insts))}
        
        for i, inst in enumerate(insts):
            for op in inst.operands[1:]:
                if not op.is_imm and op.name in defines and defines[op.name] != i:
                    deps[i].add(defines[op.name])
        
        in_deg = {i: len(deps[i]) for i in range(len(insts))}
        queue = [i for i in range(len(insts)) if in_deg[i] == 0]
        order = []
        
        while queue:
            i = queue.pop(0)
            order.append(i)
            for j in range(len(insts)):
                if i in deps[j]:
                    deps[j].remove(i)
                    in_deg[j] -= 1
                    if in_deg[j] == 0:
                        queue.append(j)
        
        return [insts[i] for i in order] if len(order) == len(insts) else insts
    
    def _find_deps(self, insts: List[Inst], target: str) -> List[Inst]:
        defines = {inst.operands[0].name: i for i, inst in enumerate(insts) if inst.operands}
        needed, queue = set(), [target]
        
        while queue:
            op = queue.pop(0)
            if op in defines and defines[op] not in needed:
                needed.add(defines[op])
                for operand in insts[defines[op]].operands[1:]:
                    if operand.name and not operand.is_imm:
                        queue.append(operand.name)
        
        return self._topo_sort([insts[i] for i in needed])
    
    def _gen_list(self) -> str:
        if not self.generated:
            return "def mir_pattern_combines : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) := []"
        
        lines = ["", "def mir_pattern_combines : List (Σ Γ, LLVMPeepholeRewriteRefine 64 Γ) :="]
        entries = [f"⟨_, {n}⟩" for n in self.generated]
        lines.append(f"  [{entries[0]},")
        for e in entries[1:-1]:
            lines.append(f"   {e},")
        if len(entries) > 1:
            lines.append(f"   {entries[-1]}]")
        else:
            lines[-1] = f"  [{entries[0]}]"
        lines.append("")
        return "\n".join(lines)


def main():
    if len(sys.argv) < 2:
        print("Usage: auto_mir_rewrites.py <Combine.td> [--verbose]")
        sys.exit(1)
    
    verbose = "--verbose" in sys.argv
    
    with open(sys.argv[1]) as f:
        src = f.read()
    
    parser = Parser(src)
    parser.parse()
    print(f"Found {len(parser.rules)} rules")
    
    gen = Generator(parser)
    output = gen.generate()
    
    with open("../mir_combines.lean", 'w') as f:
        f.write(output)
    
    print(f"Translated: {len(gen.generated)} | Skipped: {len(gen.skipped)}")
    
    if verbose:
        by_reason = {}
        for name, reason in gen.skipped.items():
            by_reason.setdefault(reason, []).append(name)
        for reason, names in sorted(by_reason.items(), key=lambda x: -len(x[1])):
            print(f"  [{reason}] {len(names)}")


if __name__ == "__main__":
    main()