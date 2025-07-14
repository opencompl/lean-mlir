#!/usr/bin/env python3
# Make plot from runner.py sqlite3 db.
import sqlite3
import matplotlib.pyplot as plt
import polars as pl
import argparse
import os

import argparse

import matplotlib
import matplotlib.pyplot as plt
import numpy as np
import math

from typing import Callable

def set_global_matplotlib_defaults():
    ## Use TrueType fonts instead of Type 3 fonts
    #
    # Type 3 fonts embed bitmaps and are not allowed in camera-ready submissions
    # for many conferences. TrueType fonts look better and are accepted.
    # This follows: https://www.conference-publishing.com/Help.php
    matplotlib.rcParams['pdf.fonttype'] = 42
    matplotlib.rcParams['ps.fonttype'] = 42

    ## Enable tight_layout by default
    #
    # This ensures the plot has always sufficient space for legends, ...
    # Without this sometimes parts of the figure would be cut off.
    matplotlib.rcParams['figure.autolayout'] = True

    ## Legend defaults
    matplotlib.rcParams['legend.frameon'] = False

    # Hide the right and top spines
    #
    # This reduces the number of lines in the plot. Lines typically catch
    # a readers attention and distract the reader from the actual content.
    # By removing unnecessary spines, we help the reader to focus on
    # the figures in the graph.
    matplotlib.rcParams['axes.spines.right'] = False
    matplotlib.rcParams['axes.spines.top'] = False

matplotlib.rcParams['figure.figsize'] = 5, 2

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

material_red = "#F48FB1"
material_blue = "#90CAF9"
material_green = "#4CAF50"
material_yellow = "#FFEB3B"
material_orange = "#FFAB40"
material_purple = "#B39DDB"
material_teal = "#80CBC4"
material_gray = "#B0BEC5"

def save(figure, name):
    # Do not emit a creation date, creator name, or producer. This will make the
    # content of the pdfs we generate more deterministic.
    metadata = {'CreationDate': None, 'Creator': None, 'Producer': None}

    # Save as PDF
    figure.savefig(name, metadata=metadata)

    # Save as JPEG
    jpeg_name = os.path.splitext(name)[0] + ".jpeg"
    figure.savefig(jpeg_name, format='jpeg')

    # Close figure to avoid warning about too many open figures.
    plt.close(figure)

    print(f'written to {name} and {jpeg_name}')

# helper for str_from_float.
# format float in scientific with at most *digits* digits.
#
# precision of the mantissa will be reduced as necessary,
# as much as possible to get it within *digits*, but this
# can't be guaranteed for very large numbers.
def get_scientific(x: float, digits: int):
    # get scientific without leading zeros or + in exp
    def get(x: float, prec: int) -> str:
      result = f'{x:.{prec}e}'
      result = result.replace('e+', 'e')
      while 'e0' in result:
        result = result.replace('e0', 'e')
      while 'e-0' in result:
        result = result.replace('e-0', 'e-')
      return result

    result = get(x, digits)
    len_after_e = len(result.split('e')[1])
    prec = max(0, digits - len_after_e - 2)
    return get(x, prec)

# format float with at most *digits* digits.
# if the number is too small or too big,
# it will be formatted in scientific notation,
# optionally a suffix can be passed for the unit.
#
# note: this displays different numbers with different
# precision depending on their length, as much as can fit.
def str_from_float(x: float, digits: int = 3, suffix: str = '') -> str:
  result = f'{x:.{digits}f}'
  before_decimal = result.split('.')[0]
  if len(before_decimal) == digits:
    return before_decimal
  if len(before_decimal) > digits:
    # we can't even fit the integral part
    return get_scientific(x, digits)

  result = result[:digits + 1] # plus 1 for the decimal point
  if float(result) == 0:
    # we can't even get one significant figure
    return get_scientific(x, digits)

  return result[:digits + 1]

# Attach a text label above each bar in *rects*, displaying its height
def autolabel(ax, rects, label_from_height: Callable[[float], str] =str_from_float, xoffset=0, yoffset=1, **kwargs):
    # kwargs is directly passed to ax.annotate and overrides defaults below
    assert 'xytext' not in kwargs, "use xoffset and yoffset instead of xytext"
    default_kwargs = dict(
        xytext=(xoffset, yoffset),
        fontsize="smaller",
        rotation=0,
        ha='center',
        va='bottom',
        textcoords='offset points')

    for rect in rects:
        height = rect.get_height()
        ax.annotate(
            label_from_height(height),
            xy=(rect.get_x() + rect.get_width() / 2, height),
            **(default_kwargs | kwargs),
        )

# utility to print times as 1h4m, 1d15h, 143.2ms, 10.3s etc.
def str_from_ms(ms):
  ms = int(ms)
  def maybe_val_with_unit(val, unit):
    return f'{val}{unit}' if val != 0 else ''

  if ms < 1000:
    return f'{ms:.3g}ms'

  s = ms / 1000
  ms = 0
  if s < 60:
    return f'{s:.3g}s'

  m = int(s // 60)
  s -= 60*m
  if m < 60:
    return f'{m}m{maybe_val_with_unit(math.floor(s), "s")}'

  h = int(m // 60)
  m -= 60*h;
  if h < 24:
    return f'{h}h{maybe_val_with_unit(m, "m")}'

  d = int(h // 24)
  h -= 24*d
  return f'{d}d{maybe_val_with_unit(h, "h")}'

def autolabel_ms(ax, rects, **kwargs):
  autolabel(ax, rects, label_from_height=str_from_ms, **kwargs)


def plot(args):
    con = sqlite3.connect(args.db)
    # cur.execute("""
    #     CREATE TABLE IF NOT EXISTS tests (
    #         filename TEXT,
    #         test_content TEXT,
    #         solver TEXT,
    #         timeout INTEGER,
    #         status TEXT,
    #         exit_code INTEGER,
    #         walltime FLOAT,
    #         PRIMARY KEY (filename, timeout)  -- Composite primary key
    #         )
    # """)
    # con.commit()
    # con.close()
    # load the database with polars
    df = pl.read_database(query="SELECT * from tests",
        connection=con)
    con.close()

    print(df)
    # fileTitle   ┆ thmName ┆ goalStr ┆ tactic ┆ status ┆ errmsg ┆ timeElapsed
    # │ gapinthcasthcasthtohand_proof ┆  test1_thm    ┆ case some x✝ : BitVec 61 ⊢ Bit… ┆ reflect_ok       ┆ err    ┆ found multiple bitvector width… ┆ 0.17294     │
    # │ …                             ┆ …             ┆ …                               ┆ …                ┆ …      ┆ …                               ┆ …           │
    # │ gfreehinversion_proof         ┆  select_1_thm ┆ case pos x✝⁴ : BitVec 8 x✝³ : … ┆ circuit          ┆ ok     ┆ <noerror>                       ┆ 261.047698  │

    # Define outlier threshold (e.g., 99th percentile)
    outlier_threshold = df["timeElapsed"].quantile(0.99)

    # Filter out outliers
    # outliers = df.filter(pl.col("timeElapsed") > outlier_threshold)

    # Print outliers as LaTeX
    # for row in outliers.iter_rows(named=True):
    #     print(f"\\texttt{{{row['fileTitle']}}} & {row['timeElapsed']} \\\\")

    # Plot cumulative scatter plot for each solver
    fig, ax = plt.subplots(figsize=(10, 3))


    # print available solver
    print(list(df["tactic"].unique().head(100)))
    # Series: 'tactic' [str]
    # [
    #     "width_ok"
    #     "bv_decide"
    #     "presburger"
    #     "circuit"
    #     "no_uninterpreted"
    #     "reflect_ok"
    # ]

    solver_colors : dict[str, str] = {
        "normCircuitVerified": material_yellow,
        "normCircuitUnverified": material_blue,
        "normPresburger": material_green,
        "bv_decide": material_purple,
        "bv_normalize": material_red,
        #"reflect_ok": material_yellow,
    }
    solver_names : dict[str, str] = {
        "normCircuitVerified": "k-induction (verified)",
        "normCircuitUnverified": "k-induction (unverified)",
        "normPresburger": "bv_automata_classic",
        "bv_decide": "bv_decide",
        "bv_normalize": "bv_normalize",
        # "reflect_ok": "Reflect",
    }
    solver_latex_names : dict[str, str] = {
        "normCircuitVerified": "NormCircuitVerified",
        "normCircuitUnverified": "NormCircuitUnverified",
        # "normCircuit": "NormCircuit",
        "normPresburger": "NormPresburger",
        "bv_decide": "BvDecide",
        "bv_normalize": "BvNormalize",
        # "reflect_ok": "ReflectOK"
    }
    solver_geo_mean : dict[str, float] = {}

    solver_num_solved = {}
    solver_total_time = {}
    total_problems = 0

    for solver_tuple, sub_df in df.group_by("tactic"):
        solver : str = str(solver_tuple[0])  # Extract solver name from tuple
        if solver not in solver_colors:
            continue
        print(f"## solver: {solver} ##")
        print(f"  #problems (total): {len(sub_df)}")
        total_problems = len(sub_df)
        sub_df = sub_df.filter(pl.col("status") == "ok")
        # print number of problems solved
        print(f"  #problems solved : {len(sub_df)}")
        solver_num_solved[solver] = len(sub_df)
        sub_df = sub_df.sort("timeElapsed")  # Sort in ascending order
        # geo_mean = df.select( (pl.col("values").log().mean()).exp().alias("geometric_mean"))
        # geomean of timeElapsed
        geomean_timeElapsed = sub_df.select((pl.col('timeElapsed').log().mean()).exp().alias('geomean_timeElapsed'))
        geometric_mean = geomean_timeElapsed['geomean_timeElapsed'][0]
        print(f"  geomean timeElapsed: {geometric_mean}")
        solver_geo_mean[solver] = geometric_mean


        sub_df = sub_df.with_columns(pl.col("timeElapsed").cum_sum().alias("cumulative_timeElapsed"))
        num_problems_solved = range(1, len(sub_df) + 1)
        solver_total_time[solver] = sub_df["cumulative_timeElapsed"].last()

        color : str = solver_colors.get(solver, "black")  # Default to black if solver not in dict
        _ = ax.plot(num_problems_solved, sub_df["cumulative_timeElapsed"],
            label=solver_names[solver],
            alpha=0.4,
            color=color,
            marker='x',
            markersize=1)
    _ = ax.set_yscale("log")
    _ = ax.set_xlabel("#Problems Solved")
    _ = ax.set_ylabel("Cumulative Time Elapsed (ms)")
    _ = ax.set_title("#Problems Solved vs Cumulative Time Elapsed on LLVM Peephole Rewrites")
    _ = ax.legend()
    save(fig, "automata-automata-circuit-cactus-plot.pdf")
    _ = plt.show()

    # write data to latex file
    with open("automata-automata-circuit-cactus-plot-data.tex", "w") as f:
        for solver, num_solved in solver_num_solved.items():
            if num_solved is None: num_solved = 0
            solver = solver_latex_names[solver]
            f.write(f"\\newcommand{{\\InstCombine{solver}NumSolved}}{{{num_solved}}}\n")
        for solver, total_time in solver_total_time.items():
            if total_time is None: total_time = 0
            print(f"solver: {solver} | total_time: {total_time}")
            solver = solver_latex_names[solver]
            f.write(f"\\newcommand{{\\InstCombine{solver}TotalTime}}{{{str_from_ms(total_time)}}}\n")
        for solver, geo_mean in solver_geo_mean.items():
            if geo_mean is None: geo_mean = 0
            solver = solver_latex_names[solver]
            f.write(f"\\newcommand{{\\InstCombine{solver}GeoMean}}{{{str_from_ms(geo_mean)}}}\n")
        f.write(f"\\newcommand{{\\InstCombineTotalProblems}}{{{total_problems}}}\n")
        print("written to automata-automata-circuit-cactus-plot-data.tex")

def parse_args():
    parser = argparse.ArgumentParser(prog='runner')
    _ = parser.add_argument('db',  help='path to sqlite3 database')
    return parser.parse_args()

if __name__ == "__main__":
    set_global_matplotlib_defaults()
    args = parse_args()
    plot(args)

