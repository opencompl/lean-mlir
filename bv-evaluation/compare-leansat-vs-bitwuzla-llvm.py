import subprocess
import os 

results_dir = "bv-evaluation/results/llvm/"

benchmark_dir = "../SSA/Projects/InstCombine/tests/proofs/"
benchmark_dir_lake = "SSA.Projects.InstCombine.tests.proofs"

reps = 5

bv_width = [4, 8, 16, 32, 64]

# import Leanwuzla and uncomment relevant line 

subprocess.Popen('sed -i \'\' -E \'s,-- import Leanwuzla,import Leanwuzla,g\' ../SSA/Projects/InstCombine/TacticAuto.lean', shell=True).wait()
subprocess.Popen('sed -i \'\' -E \'s,-- bv_compare \",bv_compare \",g\' ../SSA/Projects/InstCombine/TacticAuto.lean', shell=True).wait()
subprocess.Popen('sed -i \'\' -E \'s,bv_decide -- replace this with bv_compare to evaluate performance,-- bv_decide -- replace this with bv_compare to evaluate performance,g\' ../SSA/Projects/InstCombine/TacticAuto.lean', shell=True).wait()


for file in os.listdir(benchmark_dir):
    if "_proof" in file: # currently discard broken chapter
        subprocess.Popen('sed -i \'\' -E \'s,sorry,by bv_compare\'\\\'\',g\' '+benchmark_dir+file, shell=True).wait()
        for r in range(reps):
            # print(f'cd .. && lake build '+benchmark_dir_lake+'.'+file.split(".")[0]+' 2>&1 > '+results_dir+file.split(".")[0]+'_'+'r'+str(r)+'.txt')
            subprocess.Popen(f'cd .. && lake build '+benchmark_dir_lake+'.'+file.split(".")[0]+' 2>&1 > '+results_dir+file.split(".")[0]+'_'+'r'+str(r)+'.txt', shell=True).wait()
        subprocess.Popen('sed -i \'\' -E \'s,by bv_compare\'\\\'\',sorry,g\' '+benchmark_dir+file, shell=True).wait()


subprocess.Popen('sed -i \'\' -E \'s,import Leanwuzla,-- import Leanwuzla,g\' ../SSA/Projects/InstCombine/TacticAuto.lean', shell=True).wait()
subprocess.Popen('sed -i \'\' -E \'s,bv_compare \",-- bv_compare \",g\' ../SSA/Projects/InstCombine/TacticAuto.lean', shell=True).wait()
subprocess.Popen('sed -i \'\' -E \'s,-- bv_decide -- replace this with bv_compare to evaluate performance,bv_decide -- replace this with bv_compare to evaluate performance,g\' ../SSA/Projects/InstCombine/TacticAuto.lean', shell=True).wait()
