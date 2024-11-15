import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import os 
import re

paper_directory = '../../paper-lean-bitvectors/'
benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
res_dir = "results/InstCombineSymbolic/"
raw_data_dir = paper_directory + 'raw-data/InstCombineSymbolic/'
reps = 1


col = [
"#a6cee3",
"#1f78b4",
"#b2df8a",
"#33a02c",
"#fb9a99",
"#e31a1c"]



def parse_tacbenches(file_name, raw):
    # Regular expression to match TACBENCH entries
    tac_bench_pattern = re.compile(
        r"TACBENCH\s+(\w+)\s+(PASS|FAIL),\s+TIME_ELAPSED\s+([\d.]+)\s+ms,(?:\s*MSGSTART(.*?)MSGEND)?",
        re.DOTALL
    )
    tac_block_pattern = re.compile(r"(TACSTART.*?TACEND)", re.DOTALL)
    # Parsing the TACBENCH entries
    guid = 0
    out = []
    for blk in tac_block_pattern.findall(raw):
        guid += 1
        new = []
        for match in tac_bench_pattern.finditer(blk):
            tactic_name = match.group(1)
            status = match.group(2)
            time_elapsed = float(match.group(3))
            error_message = match.group(4).strip() if match.group(4) else None  # Only if MSGSTART-MSGEND present
            new.append({
                "filename" : file_name,
                "guid":guid,
                "name": tactic_name,
                "status": status,
                "time_elapsed": time_elapsed,
                "error_message": error_message
            })
        print("==")
        print(blk)
        print("--")
        for r in new: print(r)
        out.extend(new)
        print("==")
    return out


def run():
    out = None
    for file in os.listdir(benchmark_dir):
        if ('proof' in file):
            with open(res_dir+file.split(".")[0]+"_r"+str("0")+".txt") as res_file:
                    results = parse_tacbenches(file.split(".")[0], res_file.read())

            df = pd.DataFrame(results)
            print(df)
            if out is None:
                out = df
            else:
                out = pd.concat([out, df])

    print(out)
    out.to_csv(raw_data_dir + 'instcombineSymbolic.csv')

if __name__ == "__main__":
    run()
    pass
