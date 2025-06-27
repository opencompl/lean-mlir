#!/usr/bin/env python3

import argparse
import os
import pandas as pd
import matplotlib
import matplotlib.pyplot as plt
import numpy as np

instCombineDataDir = "raw-data/InstCombine/"
hackersDelightDataDir = "raw-data/HackersDelight/"
SMTLIBDataDir = "raw-data/SMTLIB/"
plotsdir = "plots/"


def setGlobalDefaults():
    ## Use TrueType fonts instead of Type 3 fonts
    #
    # Type 3 fonts embed bitmaps and are not allowed in camera-ready submissions
    # for many conferences. TrueType fonts look better and are accepted.
    # This follows: https://www.conference-publishing.com/Help.php
    matplotlib.rcParams["pdf.fonttype"] = 42
    matplotlib.rcParams["ps.fonttype"] = 42

    ## Enable tight_layout by default
    #
    # This ensures the plot has always sufficient space for legends, ...
    # Without this sometimes parts of the figure would be cut off.
    matplotlib.rcParams["figure.autolayout"] = True

    ## Legend defaults
    matplotlib.rcParams["legend.frameon"] = False

    # Hide the right and top spines
    #
    # This reduces the number of lines in the plot. Lines typically catch
    # a readers attention and distract the reader from the actual content.
    # By removing unnecessary spines, we help the reader to focus on
    # the figures in the graph.
    matplotlib.rcParams["axes.spines.right"] = False
    matplotlib.rcParams["axes.spines.top"] = False


matplotlib.rcParams["figure.figsize"] = 14, 7
matplotlib.rcParams.update({"font.size": 16})


# Color palette
light_gray = "#cacaca"
dark_gray = "#827b7b"
light_blue = "#a6cee3"
dark_blue = "#1f78b4"
light_green = "#b2df8a"
dark_green = "#33a02c"
light_red = "#fb9a99"
dark_red = "#e31a1c"
black = "#000000"
white = "#ffffff"

col = [
    "#a6cee3",
    "#1f78b4",
    "#b2df8a",
    "#33a02c",
    "#fb9a99",
    "#e31a1c",
    "#000000",
    "#ffffff",
]


def save(figure, name):
    # Do not emit a creation date, creator name, or producer. This will make the
    # content of the pdfs we generate more deterministic.
    metadata = {"CreationDate": None, "Creator": None, "Producer": None}
    # plt.tight_layout()
    plt.tight_layout()

    figure.savefig(name, metadata=metadata)

    # Close figure to avoid warning about too many open figures.
    plt.close(figure)

    print(f"written to {name}")


def bar_bw_impact(dfs, bm, tool, bv_width):
    i = 0
    fig, ax = plt.subplots()
    width = 0.15
    items = []
    max = 0
    for i, bvw in enumerate(bv_width):
        df = dfs[dfs["bvw"] == str(bvw)]
        a = ax.bar(
            np.arange(df.shape[0]) - width + (i - 1) * width,
            df[tool],
            width,
            color=col[i],
            label=bv_width[i],
        )
        items.append(a)
        if np.max(df[tool]) > max:
            max = np.max(df[tool])
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.set_yscale("log")
    ax.set_xticks(np.arange(df.shape[0]))
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    # enable autolabel if necessary
    # for a in items:
    #   autolabel(ax, a)
    save(fig, plotsdir + tool + "_" + bm.split(".")[0] + ".pdf")


def compare_tools_same_bw(df, bm, tool1, tool2):
    max = np.max(df[tool1])
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="solved_bv_decide_times_average")
    ax.plot(
        np.arange(len(df_sorted[tool1])), df_sorted[tool1], color=col[0], label="bv_decide"
    )
    ax.plot(
        np.arange(len(df_sorted[tool2])), df_sorted[tool2], color=col[3], label="bitwuzla"
    )
    if np.max(df_sorted[tool2]) > max:
        max = np.max(df_sorted[tool2])
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.set_xticks(np.arange(len(df[tool1])))
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    ax.set_yscale("log")
    save(fig, plotsdir + tool1 + "_" + tool2 + "_" + bm.split(".")[0] + ".pdf")


def compare_tools_diff_bw(dfs, bm, tool1, tool2, bv_width):
    fig, ax = plt.subplots()
    width = 0.15
    max = 0.0
    for i, bvw in enumerate(bv_width):
        df = dfs[dfs["bvw"] == str(bvw)]
        ax.bar(
            np.arange(len(df[tool1])) - width + (i - 1) * width,
            np.subtract(df[tool1], df[tool2]),
            width,
            color=col[i],
            label=bv_width[i],
        )
        i = i + 1
        if np.max(np.subtract(df[tool1], df[tool2])) > max:
            max = np.max(np.subtract(df[tool1], df[tool2]))
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.set_xticks(np.arange(len(df[tool1])))
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, plotsdir + tool1 + "_" + tool2 + "_diff_" + bm.split(".")[0] + ".pdf")


def bv_decide_tot_stacked_perc(df, bm, type):
    if type == "h_tot":
        matplotlib.rcParams["figure.figsize"] = 14, 3
    x = np.arange(len(df["solved_bv_decide_times_average"]))
    width = 1.0
    fig, ax = plt.subplots(figsize=(14, 3.5))
    # df_sorted = df.sort_values(by="solved_bv_decide_times_average")
    # print(df_sorted)
    tot_sum = (
        df["solved_bv_decide_rw_times_average"]
        + df["solved_bv_decide_bb_times_average"]
        + df["solved_bv_decide_sat_times_average"]
        + df["solved_bv_decide_lratt_times_average"]
        + df["solved_bv_decide_lratc_times_average"]
    )
    df["tot-sum"] = tot_sum
    df_sorted = df.sort_values(by="tot-sum")
    # print(df_sorted)
    ax_right = ax.twinx()

    ax.bar(
        x,
        np.divide(df_sorted["solved_bv_decide_rw_times_average"], df_sorted["tot-sum"])
        * 100,
        width,
        label="rewriting",
        bottom=np.zeros_like(df_sorted["solved_bv_decide_rw_times_average"]),
        color=dark_blue,
        edgecolor=dark_blue,
    )
    ax.bar(
        x,
        np.divide(
            df_sorted["solved_bv_decide_bb_times_average"]
            + df_sorted["solved_bv_decide_sat_times_average"],
            df_sorted["tot-sum"],
        )
        * 100,
        width,
        label="bit-blasting and SAT solving",
        bottom=np.divide(
            df_sorted["solved_bv_decide_rw_times_average"], df_sorted["tot-sum"]
        )
        * 100,
        color=light_gray,
        edgecolor=light_gray,
    )
    ax.bar(
        x,
        np.divide(
            df_sorted["solved_bv_decide_lratt_times_average"]
            + df_sorted["solved_bv_decide_lratc_times_average"],
            df_sorted["tot-sum"],
        )
        * 100,
        width,
        label="LRAT",
        bottom=np.divide(
            df_sorted["solved_bv_decide_rw_times_average"], df_sorted["tot-sum"]
        )
        * 100
        + np.divide(
            df_sorted["solved_bv_decide_bb_times_average"]
            + df_sorted["solved_bv_decide_sat_times_average"],
            df_sorted["tot-sum"],
        )
        * 100,
        color=dark_green,
        edgecolor=dark_green,
    )
    ax_right.plot(
        x,
        df_sorted["tot-sum"],
        width,
        label="total time",
        color=black,
    )
    ax_right.set_yscale("log")
    ax.set_xticks(
        np.arange(0, len(df_sorted), 10 ** np.floor(np.log10(len(df_sorted))))
    )
    # ax.set_title("Time to solve theorems from "+bm, pad=20)
    ax.set_ylabel(
        "Distribution [%]", rotation="horizontal", horizontalalignment="left", y=1.05
    )
    ax_right.set_ylabel(
        "Time [ms]", rotation="horizontal", horizontalalignment="right", y=1.08
    )
    ax.legend(ncols=4, frameon=False, bbox_to_anchor=[0.5, 1], loc="lower center")
    plt.gca().spines["right"].set_visible(True)
    save(fig, plotsdir + "bv_decide_stacked_perc_" + bm.split(".")[0] + ".pdf")


def leanSAT_smtlib_unsat_stacked_perc(df: pd.DataFrame, bm, type):
    save(fig, "leanSAT_stacked_smtlib_" + bm.split(".")[0] + ".pdf")


def leanSAT_smtlib_sat_stacked_perc(df: pd.DataFrame, bm, type):
    save(fig, "leanSAT_stacked_smtlib_" + bm.split(".")[0] + ".pdf")


def bv_decide_tot_stacked(df, bm):
    x = np.arange(len(df["solved_bv_decide_times_average"]))
    width = 0.45
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="solved_bv_decide_times_average")
    # print(df_sorted)
    colors_in_order = ["#e31a1c", "#9ecae1", "#deebf7", "#74c476", "#bae4b3"]
    ax.bar(
        x,
        df_sorted["solved_bv_decide_rw_times_average"],
        width,
        label="rewriting",
        bottom=np.zeros_like(df_sorted["solved_bv_decide_rw_times_average"]),
        color=colors_in_order[0],
    )
    ax.bar(
        x,
        df_sorted["solved_bv_decide_bb_times_average"],
        width,
        label="bit-blasting",
        bottom=df_sorted["solved_bv_decide_rw_times_average"],
        color=colors_in_order[1],
    )
    ax.bar(
        x,
        df_sorted["solved_bv_decide_sat_times_average"],
        width,
        label="sat solving",
        bottom=np.array(df_sorted["solved_bv_decide_rw_times_average"])
        + np.array(df_sorted["solved_bv_decide_bb_times_average"]),
        color=colors_in_order[2],
    )
    ax.bar(
        x,
        df_sorted["solved_bv_decide_lratt_times_average"],
        width,
        label="lrat-trimming",
        bottom=np.array(df_sorted["solved_bv_decide_rw_times_average"])
        + np.array(df_sorted["solved_bv_decide_bb_times_average"])
        + np.array(df_sorted["solved_bv_decide_sat_times_average"]),
        color=colors_in_order[3],
    )
    ax.bar(
        x,
        df_sorted["solved_bv_decide_lratc_times_average"],
        width,
        label="lrat-checking",
        bottom=np.array(df_sorted["solved_bv_decide_rw_times_average"])
        + np.array(df_sorted["solved_bv_decide_bb_times_average"])
        + np.array(df_sorted["solved_bv_decide_sat_times_average"])
        + np.array(df_sorted["solved_bv_decide_lratt_times_average"]),
        color=colors_in_order[4],
    )
    # ax.set_yscale("log")
    ax.set_xticks(np.arange(0, len(df_sorted), len(df_sorted) - 1))
    ax.set_title("Time to solve theorems from " + bm, pad=20)
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.legend(loc="best", ncols=1, frameon=False)
    save(fig, plotsdir + "bv_decide_stacked_" + bm.split(".")[0] + ".pdf")


def bv_decide_tot_stacked_area(df, bm):
    x = np.arange(len(df["solved_bv_decide_times_average"]))
    fig, ax = plt.subplots()
    df_sorted = df.sort_values(by="solved_bv_decide_times_average")
    x = np.arange(len(df["solved_bv_decide_times_average"]))
    fig, ax = plt.subplots()
    colors_in_order = ["#bdd7e7", "#6baed6", "#3182bd", "#bae4b3", "#74c476"]
    ax.stackplot(
        x,
        df_sorted["solved_bv_decide_rw_times_average"],
        df_sorted["solved_bv_decide_bb_times_average"],
        df_sorted["solved_bv_decide_sat_times_average"],
        df_sorted["solved_bv_decide_lratt_times_average"],
        df_sorted["solved_bv_decide_lratc_times_average"],
        labels=["rw", "bb", "sat", "lrat-t", "lrat-c"],
        colors=colors_in_order,
    )

    ax.set_yscale("log")
    # ax.set_xticks(np.arange(0, 51, 50))
    ax.set_xlabel("Theorems")
    ax.set_ylabel("Time [ms]", rotation="horizontal", horizontalalignment="left", y=1)
    ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, plotsdir + "bv_decide_stacked_area_" + bm.split(".")[0] + ".pdf")


# for hackers delight we want to consider bitwidth in the plotting
def cumul_solving_time_hackers_delight(df, tool1, tool2, bm, bv_width):
    matplotlib.rcParams["figure.figsize"] = 14, 5

    fig, ax = plt.subplots(1, 3)
    for i, bvw in enumerate([4, 16, 64]):
        df_tmp = df.loc[df["bvw"] == str(bvw)]
        df_sorted = df_tmp.sort_values(by="solved_bv_decide_times_average")

        sorted1 = np.sort(df_sorted[tool1])
        sorted2 = np.sort(df_sorted[tool2])
        cumtime1 = [0]
        cumtime1.extend(np.cumsum(sorted1))
        cumtime2 = [0]
        cumtime2.extend(np.cumsum(sorted2))

        ax[i].plot(
            cumtime1,
            np.arange(0, len(df_sorted[tool1]) + 1),
            marker="o",
            color=col[0],
            label="bv_decide",
        )
        ax[i].plot(
            cumtime2,
            np.arange(0, len(df_sorted[tool2]) + 1),
            marker="x",
            color=col[3],
            label="bitwuzla",
        )
        ax[i].set_xlabel("bitwidth: " + str(bvw))
        ax[i].set_xscale("log")
    ax[0].set_ylabel("Problems solved", rotation="vertical", ha="center")
    # ax.set_yscale("log")
    ax[1].set_title("bv_decide vs. Bitwuzla Scaling Solving Hackers' Delight Theorems")
    ax[0].legend(loc="upper left", ncols=1, frameon=False)
    ax[1].text(
        0.5, -0.28, "Cumulative Time [ms]", transform=ax[1].transAxes, ha="center"
    )
    save(fig, plotsdir + "cumul_problems_bv_4_16_64_" + bm.split(".")[0] + ".pdf")


def cumul_solving_time(df, tool1, tool2, bm):
    fig, ax = plt.subplots(figsize=(14, 3))
    sorted1 = np.sort(df[tool1])
    sorted2 = np.sort(df[tool2])
    cumtime1 = [0]
    cumtime1.extend(np.cumsum(sorted1))
    cumtime2 = [0]
    cumtime2.extend(np.cumsum(sorted2))
    ax.plot(
        cumtime1,
        np.arange(0, len(df[tool1]) + 1),
        marker="o",
        color=col[0],
        label="bv_decide",
    )
    ax.plot(
        cumtime2,
        np.arange(0, len(df[tool2]) + 1),
        marker="x",
        color=col[3],
        label="bitwuzla",
    )
    ax.set_xlabel("Time [ms]")
    ax.set_xscale("log")
    ax.set_ylabel("Problems solved", rotation="horizontal", ha="left", y=1)
    # ax.set_xscale("log")
    # ax.set_yscale("log")
    ax.legend(loc="upper left", ncols=1, frameon=False)
    # ax.legend(loc="center right", ncols=1, frameon=False, bbox_to_anchor=(1.2, 0.5))
    save(fig, plotsdir + "cumul_problems_llvm_" + bm.split(".")[0] + ".pdf")


def cumul_solving_time_smtlib(df, name):
    save(fig, "cumul_problems_smtlib_"+name+".pdf")

def scatter_solving_time_smtlib(df_sat, df_unsat): 
    save(fig, "scatter_smtlib.pdf")

def scatter_solving_time_instcombine(df):
    fig, ax = plt.subplots(figsize=(14, 3), sharey=True)
    tot_sum = (
        df["solved_bv_decide_rw_times_average"]
        + df["solved_bv_decide_bb_times_average"]
        + df["solved_bv_decide_sat_times_average"]
        + df["solved_bv_decide_lratt_times_average"]
        + df["solved_bv_decide_lratc_times_average"]
    )
    # tot_sum = (df["solved_bv_decide_times_average"])
    ax.scatter(df["solved_bitwuzla_times_average"], tot_sum, c="#beaed4", marker=".")
    ax.set_xlabel("T")

    time_min = min(df["solved_bitwuzla_times_average"].min(), tot_sum.min())
    time_max = max(df["solved_bitwuzla_times_average"].max(), tot_sum.max())

    ax.set_ylim(
        10 ** (np.floor(np.log10(time_min))), 10 ** (np.ceil(np.log10(time_max)))
    )
    ax.plot(
        [df["solved_bitwuzla_times_average"].min(), tot_sum.max()],
        [df["solved_bitwuzla_times_average"].min(), tot_sum.max()],
        c=black,
    )
    ax.set_xscale("log")
    ax.set_yscale("log")
    # ax[1].text(1.2, 0, "Time [ms]\nbitwuzla", transform=ax[1].transAxes, ha="right")
    ax.set_xlabel("Time [ms] - bitwuzla", ha="center", va="center", y=-0.2)
    ax.set_ylabel("Time [ms] - bv_decide", rotation="horizontal", ha="left", y=1.05)
    # ax.legend(loc="lower center", ncols=2, frameon=False)
    save(fig, plotsdir + "scatter_smtlib_instcombine.pdf")


def plot_hackersdelight():
    dfs = []
    for file in os.listdir(hackersDelightDataDir):
        if "err" not in file and "ceg" not in file and "sym" not in file:
            print(file)
            bvw = file.split("_")[2]
            df_bw = pd.read_csv(hackersDelightDataDir + file)
            df_sorted = df_bw.sort_values(by="solved_bv_decide_times_average")
            if len(df_sorted > 0):
                compare_tools_same_bw(
                    df_bw,
                    file,
                    "solved_bv_decide_times_average",
                    "solved_bitwuzla_times_average",
                )
                bv_decide_tot_stacked(df_bw, file)
                bv_decide_tot_stacked_perc(df_bw, file, "h")
                bv_decide_tot_stacked_area(df_bw, file)
                df_sorted.insert(1, "bvw", [bvw] * len(df_sorted), True)
                df_sorted.insert(
                    1, "filename", file.split("_")[1] + "_" + file.split("_")[2], True
                )
                dfs.append(df_sorted)

    df = pd.concat(dfs, axis=0)

    df.to_csv("gigantic-df.csv")

    bv_width = df["bvw"].unique()

    file = "HackersDelight"
    df_new = df[df["bvw"] == str(64)]
    bv_decide_tot_stacked(df_new, file + "_bvw64")
    bv_decide_tot_stacked_perc(df_new, file + "_bvw64", "h_tot")

    cumul_solving_time_hackers_delight(
        df,
        "solved_bv_decide_times_average",
        "solved_bitwuzla_times_average",
        file,
        bv_width,
    )

    bar_bw_impact(df, file, "solved_bitwuzla_times_average", bv_width)
    bar_bw_impact(df, file, "solved_bv_decide_times_average", bv_width)
    compare_tools_diff_bw(
        df,
        file,
        "solved_bv_decide_times_average",
        "solved_bitwuzla_times_average",
        bv_width,
    )


def plot_instcombine():
    for file in os.listdir(instCombineDataDir):
        if "err" not in file and "ceg" not in file:
            df = pd.read_csv(instCombineDataDir + file)
            cumul_solving_time(
                df,
                "solved_bv_decide_times_average",
                "solved_bitwuzla_times_average",
                file,
            )
            bv_decide_tot_stacked(df, "instCombine")
            bv_decide_tot_stacked_perc(df, "instCombine", "i")
            bv_decide_tot_stacked_area(df, "instCombine")
            scatter_solving_time_instcombine(df)


def plot_smtlib():
    leanSAT_smtlib_unsat_stacked_perc(df_unsat_stats, 'trusted_unsat', 'i')


def main():
    parser = argparse.ArgumentParser(
        prog="plot",
        description="Plot the figures for this paper",
    )
    parser.add_argument(
        "names", nargs="+", choices=["all", "hackersdelight", "instcombine", "smtlib"]
    )
    args = parser.parse_args()

    setGlobalDefaults()

    if "all" in args.names or "hackersdelight" in args.names:
        plot_hackersdelight()

    if "all" in args.names or "instcombine" in args.names:
        plot_instcombine()

    if "all" in args.names or "smtlib" in args.names:
        plot_smtlib()


if __name__ == "__main__":
    main()
