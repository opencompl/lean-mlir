#!/usr/bin/env python3
import pandas as pd
import numpy as np
import num2words

bv_widths = [4, 8, 16, 32, 64]


def geomean(xs):
    xs = [x for x in xs if x > 0]
    if len(xs) > 0:
        return np.exp(np.mean(np.log(np.array(xs))))
    else:
        return 0.0  # e^(-infty) = 0
        # raise RuntimeError("Trying to compute the geomean of an empty list. ")


def get_avg_bb_sat(df_tot, benchmark, phase, statsfile):
    df = df_tot[df_tot["leanSAT-sat"] > 0]
    if len(df["leanSAT"]) > 0:
        if phase == "sat":
            sat_bb = np.sum(np.array(df["leanSAT-bb"]) + np.array(df["leanSAT-sat"]))
            perc_sat_bb = (sat_bb / np.sum(df["leanSAT"])) * 100
            geomean_sat_bb = (
                geomean((df["leanSAT-bb"] + df["leanSAT-sat"]) / df["leanSAT"]) * 100
            )
            f = open(statsfile, "a+")
            f.write(
                "\\newcommand{\\"
                + benchmark.replace("_", "")
                + r"SatBitBlastingPerc}{"
                + ("%.1f" % perc_sat_bb)
                + "\\%}\n"
            )
            f.write(
                "\\newcommand{\\"
                + benchmark.replace("_", "")
                + r"SatBitBlastingGeoMean}{"
                + ("%.1f" % geomean_sat_bb)
                + "\\%}\n"
            )
            f.close
        elif phase == "lrat":
            lrat_tot = np.sum(
                np.array(df["leanSAT-lrat-t"]) + np.array(df["leanSAT-lrat-c"])
            )
            perc_sat_bb = (lrat_tot / np.sum(df["leanSAT"])) * 100
            # geomean (r1 / r2) = geomean(r1) / geomean(r2)
            geomean_lrat = (
                geomean((df["leanSAT-lrat-t"] + df["leanSAT-lrat-c"]) / df["leanSAT"])
                * 100
            )
            f = open(statsfile, "a+")
            f.write(
                "\\newcommand{\\"
                + benchmark.replace("_", "")
                + r"LRATPerc}{"
                + ("%.1f" % perc_sat_bb)
                + "\\%}\n"
            )
            f.write(
                "\\newcommand{\\"
                + benchmark.replace("_", "")
                + r"LRATGeoMean}{"
                + ("%.1f" % geomean_lrat)
                + "\\%}\n"
            )
            f.close()
        else:
            raise RuntimeError("Unexpected phase selected. ")


def print_df(x):
    pd.set_option("display.max_rows", None)
    print(x)
    pd.reset_option("display.max_rows")


def plot_smtlib_slowdown_families_raw(merged_df):
    df_with_bm_names = merged_df.copy()
    df_with_bm_names["family"] = merged_df["benchmark"].map(lambda s: s[: s.rfind("/")])

    lw_unknowns = df_with_bm_names.groupby("family").agg(
        total_entries=("result_lw", "size"),
        unknown=("result_lw", lambda x: (x == "unknown").sum()),
    )

    bw_unknowns = df_with_bm_names.groupby("family").agg(
        total_entries=("result_bw", "size"),
        unknown=("result_bw", lambda x: (x == "unknown").sum()),
    )

    merged_fam_unknowns = pd.merge(
        lw_unknowns,
        bw_unknowns,
        how="inner",
        on=["family", "total_entries"],
        suffixes=("_lw", "_bw"),
    )
    merged_fam_unknowns = merged_fam_unknowns.sort_values(
        by="total_entries", ascending=False
    )
    print_df(merged_fam_unknowns)
    merged_fam_unknowns.to_csv("smtlib-group-by-family-sort-by-total-problems.csv")
    return merged_fam_unknowns


def slowdown_smtlib_stats():
    df_bitwuzla_46k = pd.read_csv("raw-data/SMTLIB/bitwuzla_46k.csv")
    df_leanwuzla_2k = pd.read_csv("raw-data/SMTLIB/leanwuzla_46k.csv")
    merged_df = pd.merge(
        df_bitwuzla_46k, df_leanwuzla_2k, on="benchmark", suffixes=("_bw", "_lw")
    )
    df_clean_tmp = merged_df[merged_df["result_bw"] != "unknown"]
    df_clean = df_clean_tmp[df_clean_tmp["result_lw"] != "unknown"]
    # filter out results that are not consistent
    df_cons = df_clean[df_clean["result_bw"] == df_clean["result_lw"]]
    df_unsat = df_cons[df_cons["result_bw"] == "unsat"]
    df_unsat_slowdown = df_unsat.copy()
    df_unsat_slowdown["slowdown"] = np.divide(
        np.array(df_unsat["time_cpu_lw"]), np.array(df_unsat["time_cpu_bw"])
    )
    df_unsat_sorted = df_unsat_slowdown.sort_values(by="slowdown", ascending=False)
    df_unsat_sorted.to_csv("slowdown.csv")


def smtlib_stats(performance_smtlib_dir):
    df_bitwuzla_46k = pd.read_csv("raw-data/SMTLIB/bitwuzla_46k.csv")
    df_leanwuzla_46k = pd.read_csv("raw-data/SMTLIB/leanwuzla_46k.csv")
    assert len(df_bitwuzla_46k) == len(df_leanwuzla_46k)
    merged_df = pd.merge(
        df_bitwuzla_46k,
        df_leanwuzla_46k,
        on="benchmark",
        how="inner",
        suffixes=("_bw", "_lw"),
    )
    df_clean_tmp = merged_df[merged_df["result_bw"] != "unknown"]
    df_clean = df_clean_tmp[df_clean_tmp["result_lw"] != "unknown"]
    # filter out results that are not consistent
    # create new df for slowdown
    slowdown_df = df_clean.copy()
    slowdown_df["slowdown"] = df_clean["time_cpu_lw"] / df_clean["time_cpu_bw"]
    # geomean slowdown, leanwuzla vs. bitwuzla, SAT problems (removing all unknowns)
    slowdown_df_sat = slowdown_df[slowdown_df["result_bw"] == "sat"]
    geomean_slowdown_smtlib_sat = geomean(slowdown_df_sat["slowdown"])
    # geomean slowdown, leanwuzla vs. bitwuzla, UNSAT problems (removing all unknowns)
    slowdown_df_unsat = slowdown_df[slowdown_df["result_bw"] == "unsat"]
    geomean_slowdown_smtlib_unsat = geomean(slowdown_df_unsat["slowdown"])
    # geomean slowdown, leanwuzla vs. bitwuzla, UNSAT+SAT problems (removing all unknowns)
    geomean_slowdown_smtlib_tot = geomean(slowdown_df["slowdown"])
    tot_num_problems = len(df_bitwuzla_46k)
    # num. of problems where leanwuzla terminates and bitwuzla does not terminate
    merged_df_both_unknown = merged_df[
        (merged_df["result_bw"] == "unknown") & (merged_df["result_lw"] == "unknown")
    ]
    problems_both_unknown = len(merged_df_both_unknown)
    # num. of problems where bitwuzla terminates and leanwuzla does not terminate
    merged_df_lw_only_unknown = merged_df[
        (merged_df["result_bw"] != "unknown") & (merged_df["result_lw"] == "unknown")
    ]
    problems_lw_only_unknown = len(merged_df_lw_only_unknown)
    # num. of problems where neither leanwuzla nor bitwuzla terminate
    merged_df_bw_only_unknown = merged_df[
        (merged_df["result_bw"] == "unknown") & (merged_df["result_lw"] != "unknown")
    ]
    problems_bw_only_unknown = len(merged_df_bw_only_unknown)
    # perc. of SAT solved by leanwuzla
    tot_bitwuzla_sat = len(merged_df[merged_df["result_bw"] == "sat"])
    tot_leanwuzla_sat = len(
        merged_df[(merged_df["result_bw"] == "sat") & (merged_df["result_lw"] == "sat")]
    )
    perc_leanwuzla_sat = tot_leanwuzla_sat / tot_bitwuzla_sat * 100
    # perc. of UNSAT solved by leanwuzla
    tot_bitwuzla_unsat = len(merged_df[merged_df["result_bw"] == "unsat"])
    tot_leanwuzla_unsat = len(
        merged_df[
            (merged_df["result_bw"] == "unsat") & (merged_df["result_lw"] == "unsat")
        ]
    )
    perc_leanwuzla_unsat = tot_leanwuzla_unsat / tot_bitwuzla_unsat * 100
    plot_smtlib_slowdown_families_raw(merged_df)

    f = open(performance_smtlib_dir, "a+")
    f.write(r"\newcommand{\SMTLIBProblemsTot}{" + str(tot_num_problems) + "}\n")
    f.write(
        r"\newcommand{\SMTLIBGeomeanSlowdownSat}{"
        + ("%.1f" % geomean_slowdown_smtlib_sat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBGeomeanSlowdownUnsat}{"
        + ("%.1f" % geomean_slowdown_smtlib_unsat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBGeomeanSlowdownTot}{"
        + ("%.1f" % geomean_slowdown_smtlib_tot)
        + "}\n"
    )
    f.write(r"\newcommand{\SMTLIBBothUnknown}{" + str(problems_both_unknown) + "}\n")
    f.write(
        r"\newcommand{\SMTLIBLeanwuzlaOnlyUnknown}{"
        + str(problems_lw_only_unknown)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBBitwuzlaOnlyUnknown}{"
        + str(problems_bw_only_unknown)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLenwuzlaSolvedSAT}{"
        + ("%.1f" % perc_leanwuzla_sat)
        + "}\n"
    )
    f.write(
        r"\newcommand{\SMTLIBPercLenwuzlaSolvedUNSAT}{"
        + ("%.1f" % perc_leanwuzla_unsat)
        + "}\n"
    )
    f.close()


def instcombine_stats(performance_instcombine_dir):
    df_ceg = pd.read_csv("raw-data/InstCombine/err-llvm.csv")
    df = pd.read_csv("raw-data/InstCombine/llvm-proved-data.csv")
    df_err = pd.read_csv("raw-data/InstCombine/llvm-ceg-data.csv")
    get_avg_bb_sat(df, "InstCombine", "sat", performance_instcombine_dir)
    get_avg_bb_sat(df, "InstCombine", "lrat", performance_instcombine_dir)
    tot_problems = len(df) + len(df_ceg) + len(df_err)
    tot_problems_solved = len(df)
    f = open(performance_instcombine_dir, "a+")
    f.write(r"\newcommand{\InstCombineNProblemsTot}{" + str(tot_problems) + "}\n")
    f.write(
        r"\newcommand{\InstCombineNumProblemsSolved}{"
        + str(tot_problems_solved)
        + "}\n"
    )
    # slowdown
    slowdown_df = df.copy()

    slowdown_df["slowdown"] = df["leanSAT"] / df["bitwuzla"]
    # geomean slowdown where both leanwuzla and bitwuzla terminate
    geomean_time_instcombine_bvdecide = geomean(df["leanSAT"])
    geomean_time_instcombine_bitwuzla = geomean(df["bitwuzla"])
    geomean_slowdown_instcombine = geomean(slowdown_df["slowdown"])
    mean_slowdown_instcombine = np.mean(slowdown_df["slowdown"])
    f.write(
        r"\newcommand{\InstCombineGeomeanBvDecide}{"
        + ("%.2f" % geomean_time_instcombine_bvdecide)
        + "}\n"
    )
    f.write(
        r"\newcommand{\InstCombineGeomeanBitwuzla}{"
        + ("%.2f" % geomean_time_instcombine_bitwuzla)
        + "}\n"
    )
    f.write(
        r"\newcommand{\InstCombineGeomeanSlowdown}{"
        + ("%.1f" % geomean_slowdown_instcombine)
        + "}\n"
    )
    f.write(
        r"\newcommand{\InstCombineMeanSlowdown}{"
        + ("%.1f" % mean_slowdown_instcombine)
        + "}\n"
    )
    f.close()


def hackersdelight_stats(performance_hackersdelight_dir):
    files = ["ch2_1DeMorgan", "ch2_2AdditionAndLogicalOps"]
    for bvw in bv_widths:
        dfs = []
        for file in files:
            # df_ceg=pd.read_csv('raw-data/HackersDelight/bvw'+str(bvw)+'_'+file+'_ceg_data.csv')
            df = pd.read_csv(
                "raw-data/HackersDelight/bvw"
                + str(bvw)
                + "_"
                + file
                + "_proved_data.csv"
            )
            if len(df) > 0:
                dfs.append(df)
        # concatenate all dataframes from all files
        df_concat = pd.concat(dfs, ignore_index=True)
        get_avg_bb_sat(
            df_concat,
            "HackersDelight" + num2words.num2words(bvw).replace("-", ""),
            "sat",
            performance_hackersdelight_dir,
        )
        get_avg_bb_sat(
            df_concat,
            "HackersDelight" + num2words.num2words(bvw).replace("-", ""),
            "lrat",
            performance_hackersdelight_dir,
        )


def instcombine_symbolic_stats(outpath: str):
    with open(outpath, "w") as f:
        df = pd.read_csv("raw-data/InstCombineSymbolic/instcombineSymbolic.csv")
        # get the number of problems we can solve with bv_auto,
        # get the total number of problems
        # get the number of problems we can solve with ring
        # name: the block of tacbench / the tactic that they came from
        n_total = len(set(list(df["filename"] + "_guid_" + df["guid"].astype(str))))
        print(f"total # of theorems: {n_total}")

        names = df["name"].unique().tolist()
        f.write("\\newcommand{\InstCombineSymbolicTotalTheorems}{%s}\n" % n_total)
        for name in names:
            df_name = df[df["name"] == name]
            # print(df_name)
            df_solved = df_name[df_name["status"] == "PASS"]
            # print(df_solved)
            time_elapsed = df_solved["time_elapsed"]
            # print(time_elapsed)
            geomean_time = geomean(time_elapsed)
            print(f"geomean time for '{name}' is '{geomean_time}'")
            print(f"#solved by '{name}' is '{len(df_solved)}'")
            f.write(
                "\\newcommand{\InstCombineSymbolicNumSolvedBy%s}{%s}\n"
                % (name.replace("_", ""), len(df_solved))
            )
            f.write(
                "\\newcommand{\InstCombineSymbolicGeomeanTimeSolvedBy%s}{%4.2f}\n"
                % (name.replace("_", ""), geomean_time)
            )


def alive_symbolic_stats(outpath: str):
    with open(outpath, "w") as f:
        df = pd.read_csv("raw-data/AliveSymbolic/aliveSymbolic.csv")
        # get the number of problems we can solve with bv_auto,
        # get the total number of problems
        # get the number of problems we can solve with ring
        # name: the block of tacbench / the tactic that they came from
        n_total = len(set(list(df["filename"] + "_guid_" + df["guid"].astype(str))))
        print(f"total # of theorems: {n_total}")

        names = df["name"].unique().tolist()
        f.write("\\newcommand{\AliveSymbolicTotalTheorems}{%s}\n" % n_total)
        for name in names:
            df_name = df[df["name"] == name]
            # print(df_name)
            df_solved = df_name[df_name["status"] == "PASS"]
            # print(df_solved)
            time_elapsed = df_solved["time_elapsed"]
            # print(time_elapsed)
            geomean_time = geomean(time_elapsed)
            print(f"geomean time for '{name}' is '{geomean_time}'")
            print(f"#solved by '{name}' is '{len(df_solved)}'")
            f.write(
                "\\newcommand{\AliveSymbolicNumSolvedBy%s}{%s}\n"
                % (name.replace("_", ""), len(df_solved))
            )
            f.write(
                "\\newcommand{\AliveSymbolicGeomeanTimeSolvedBy%s}{%4.2f}\n"
                % (name.replace("_", ""), geomean_time)
            )


def hackersdelight_symbolic_stats(outpath: str):
    with open(outpath, "w") as f:
        df = pd.read_csv("raw-data/HackersDelightSymbolic/hackersDelightSymbolic.csv")
        # get the number of problems we can solve with bv_auto,
        # get the total number of problems
        # get the number of problems we can solve with ring
        # name: the block of tacbench / the tactic that they came from
        n_total = len(set(list(df["filename"] + "_guid_" + df["guid"].astype(str))))
        print(f"total # of theorems: {n_total}")

        names = df["name"].unique().tolist()
        f.write("\\newcommand{\HackersDelightSymbolicTotalTheorems}{%s}\n" % n_total)
        for name in names:
            df_name = df[df["name"] == name]
            # print(df_name)
            df_solved = df_name[df_name["status"] == "PASS"]
            # print(df_solved)
            time_elapsed = df_solved["time_elapsed"]
            # print(time_elapsed)
            geomean_time = geomean(time_elapsed)
            print(f"geomean time for '{name}' is '{geomean_time}'")
            print(f"#solved by '{name}' is '{len(df_solved)}'")
            f.write(
                "\\newcommand{\HackersDelightSymbolicNumSolvedBy%s}{%s}\n"
                % (name.replace("_", ""), len(df_solved))
            )
            f.write(
                "\\newcommand{\HackersDelightSymbolicGeomeanTimeSolvedBy%s}{%4.2f}\n"
                % (name.replace("_", ""), geomean_time)
            )


def generate_latex_table_smtlib_problems_solved():
    df_bitwuzla_46k = pd.read_csv("raw-data/SMTLIB/bitwuzla_46k.csv")
    df_leanwuzla_46k = pd.read_csv("raw-data/SMTLIB/leanwuzla_46k.csv")
    df_coq_46k = pd.read_csv("raw-data/SMTLIB/coq_46k.csv")
    df_coq_46k = df_coq_46k.rename(
        columns=lambda x: x + "_coq" if x != "benchmark" else x
    )
    merged_df = pd.merge(
        df_bitwuzla_46k, df_leanwuzla_46k, on="benchmark", suffixes=("_bw", "_lw")
    )
    merged_df = pd.merge(merged_df, df_coq_46k, on="benchmark")
    # merged_df.to_csv('tmp.csv')
    # filter out results that are unknown for either of the two or not consistent
    unknown_bw = len(merged_df[merged_df["result_bw"] == "unknown"])
    unknown_lw = len(merged_df[merged_df["result_lw"] == "unknown"])
    unknown_coq = len(merged_df[merged_df["result_coq"] == "unknown"])
    sat_bw = len(merged_df[merged_df["result_bw"] == "sat"])
    sat_lw = len(merged_df[merged_df["result_lw"] == "sat"])
    sat_coq = len(merged_df[merged_df["result_coq"] == "sat"])
    unsat_bw = len(merged_df[merged_df["result_bw"] == "unsat"])
    unsat_lw = len(merged_df[merged_df["result_lw"] == "unsat"])
    unsat_coq = len(merged_df[merged_df["result_coq"] == "unsat"])

    latex_table = "\\begin{tabular}{" + "l|" * 4 + "}\n"
    latex_table += "\\hline\n"
    latex_table += " Result & LeanSAT & Bitwuzla & CoqQFBV \\\\\n"
    latex_table += "\\hline\n"
    # no need to add a line for every bitwidth
    latex_table += (
        "unsat"
        + " & "
        + str(unsat_lw)
        + " & "
        + str(unsat_bw)
        + " & "
        + str(unsat_coq)
        + "\\\\\n"
    )
    latex_table += (
        "sat (counterexample found)"
        + " & "
        + str(sat_lw)
        + " & "
        + str(sat_bw)
        + " & "
        + str(sat_coq)
        + "\\\\\n"
    )
    latex_table += (
        "unknown"
        + " & "
        + str(unknown_lw)
        + " & "
        + str(unknown_bw)
        + " & "
        + str(unknown_coq)
        + "\\\\\n"
    )
    latex_table += "\\end{tabular}"
    return latex_table


# f = open('../solved_theorems.tex', 'w')
# f.write(generate_latex_table_tot_solved())
# f.close()

# f = open('../solved_times_hackersdelight.tex', 'w')
# f.write(generate_latex_table_hackerdelight_solved_times())
# f.close()

# f = open('../ceg_times_hackersdelight.tex', 'w')
# f.write(generate_latex_table_hackerdelight_ceg_times())
# f.close()

# f = open('../solved_times_instcombine.tex', 'w')
# f.write(generate_latex_table_instcombine_solved_times())
# f.close()

# f = open('../ceg_times_instcombine.tex', 'w')
# f.write(generate_latex_table_instcombine_ceg_times())
# f.close()

# f = open('../solved_problems_smtlib.tex', 'w')
# f.write(generate_latex_table_smtlib_problems_solved())
# f.close()

performance_smtlib_dir = "tables/performance-smtlib.tex"
performance_instcombine_dir = "tables/performance-instcombine.tex"
performance_hackerdelight_dir = "tables/performance-hackersdelight.tex"
performance_hackersdelight_symbolic_file = (
    "tables/performance-hackersdelight-symbolic.tex"
)
performance_instcombine_symbolic_file = "tables/performance-instcombine-symbolic.tex"
performance_alive_symbolic_file = "tables/performance-alive-symbolic.tex"

# smtlib_stats(performance_smtlib_dir)
instcombine_stats(performance_instcombine_dir)
hackersdelight_stats(performance_hackerdelight_dir)
hackersdelight_symbolic_stats(performance_hackersdelight_symbolic_file)
instcombine_symbolic_stats(performance_instcombine_symbolic_file)
alive_symbolic_stats(performance_alive_symbolic_file)
