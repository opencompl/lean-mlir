#!/usr/bin/env python3
# /// script
# requires-python = ">=3.13"
# dependencies = [
#     "pygithub",
# ]
# ///

from github import Github
import argparse
import pathlib
import sys

def get_mathlib_nightly_dates(start):
  g = Github()
  r = g.get_repo('leanprover-community/mathlib4-nightly-testing')
  
  tags = []

  for t in r.get_tags():

    if 'nightly-testing-' + start > t.name:
      break

    tags.append(t.name[len('nightly-testing-'):])

  return tags

def get_lean_toolchain_date(dir='.'):
  file = dir + '/lean-toolchain'
  f = open(file, 'r')
  version = f.readline().split(':')[1][len('nightly-'):]
  
  return version


parser = argparse.ArgumentParser()
parser.add_argument('--dir', type=pathlib.Path)
args = parser.parse_args()


lean = get_lean_toolchain_date(str(args.dir) if args.dir else '.')
tags = get_mathlib_nightly_dates(lean)

if len(tags) > 1:
  print("nightly-testing-" + tags[-2])
else:
  print("No newer Lean version available")
  sys.exit(-1)

