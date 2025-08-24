import os
import re
import matplotlib.pyplot as plt
import pandas as pd
from pathlib import Path

# this script extracts all the proofs in pipeline folder EXCEPT  the constant proofs and all the files that do not contain a proof. It does iterate over the proof and count the lines per proof.
# we do this the count the number of tactic invocations where a tactic invocation corresponds to a line.
# this script then plots the number of proofs and tactics per file and computes the average number of tactic per fail and gives a "Balkendiagram".

def extract_proof_stats(folder_path, outfolder_path):
    folder_path = Path(folder_path)
    outfolder_path = Path(outfolder_path)
    outfolder_path.mkdir(parents=True, exist_ok=True) 

    stats = []
    excluded_files = {"const.lean", "mkRewrite.lean", "InstructionLowering.lean", "ReconcileCast.lean"}
    globalnum=0
    globaltactics=0
    for filename in sorted(os.listdir(folder_path)):
        if not filename.endswith(".lean") or filename in  excluded_files:
            continue

        file_path = os.path.join(folder_path, filename)
        with open(file_path, 'r') as f:
            lines = f.readlines()

        num_proofs = 0
        total_tactics = 0
        i = 0

        while i < len(lines):
            line = lines[i]
            if "correct := by" in line:
                proof_lines = [line] # I here collect to proof to then print into a file and odulbe check the proof lines.
                num_proofs += 1
                i += 1
                count = 0
                while i < len(lines):
                    next_line = lines[i]
                    if next_line.strip() == "" or next_line.strip() == "}": #we skip empty lines and the final } in the proof block and do not count it.
                        proof_lines.append(next_line)
                        i += 1
                        continue
                    if not next_line.startswith(" "):  # stop if no longer indented bc then not prart of tactic sequence anymore
                        break
                    proof_lines.append(next_line)
                    count += 1
                    i += 1
                total_tactics += count
                base_name = Path(filename).stem #we get the file name without suffix to name the proof files 
                proof_filename = f"{base_name}_{num_proofs}.lean"
                proof_file_path = os.path.join(outfolder_path, proof_filename) #write it into the path we specified for the output file.
                with open(proof_file_path, "w") as pf:
                    pf.writelines(proof_lines)
            else:
                i += 1
        globalnum +=num_proofs
        globaltactics += total_tactics
        avg_tactics = total_tactics / num_proofs if num_proofs > 0 else 0
        stats.append({
            "File": Path(filename).stem,
            "Proofs": num_proofs,
            "Tactics": total_tactics,
            "AvgTactics": avg_tactics
        })
    print(f"path {folder_path}")
    print(f"Extracted {globalnum} proofs")
    print(f"Average number of tactics across all proofs is { round(globaltactics / globalnum, 2)}")
    return pd.DataFrame(stats)


def plot_proof_stats(df_stats):
    plt.figure(figsize=(10, 6))
    bar_width = 0.4
    x = range(len(df_stats))

    plt.bar([i - bar_width/2 for i in x], df_stats["Proofs"], width=bar_width, label="Nr. Of Proofs")
    plt.bar([i + bar_width/2 for i in x], df_stats["AvgTactics"], width=bar_width, label="Avg. Nr. Of Tactics For Operation")

    plt.xticks(ticks=x, labels=df_stats["File"], rotation=45, ha="right")
    plt.ylabel("Count")
    plt.title("Proofs and Avg Tactics per Operation prior/ post automation.")
    plt.legend()
    plt.tight_layout()
    plt.grid(axis="y")
    for i in range(len(df_stats)):
        proof_height = df_stats["Proofs"][i]
        avg_height = df_stats["AvgTactics"][i]

        # label for number of proofs
        plt.text(i - bar_width/2, proof_height + 0.2, f"{proof_height}", 
                ha="center", fontsize=9, color="black")

        # abel for average tactics
        plt.text(i + bar_width/2, avg_height + 0.2, f"{avg_height:.1f}", 
                ha="center", fontsize=9, color="black")

    #plt.axhline(y=2, color='green', linestyle='-', linewidth=1.5, label='2 tactics required after automation, 0 by the user')
    plt.legend()

    plt.show()


current_script = Path(__file__).resolve()
llvmriscv_dir = current_script.parent.parent.parent
proof_folder = llvmriscv_dir / "Pipeline"
output_dir =  current_script.parent / "extracted_proofs"

df = extract_proof_stats(str(proof_folder),str(output_dir))
plot_proof_stats(df)

