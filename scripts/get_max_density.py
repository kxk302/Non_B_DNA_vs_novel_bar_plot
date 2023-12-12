import argparse
from pathlib import Path

import pandas as pd


def get_max_density(input_folder, output_file):
  density_files=Path(input_folder).glob('*.bed')

  density_files_list=[]
  max_density_list=[]

  for density_file in density_files:
    print(f"density_file: {density_file}")
    df=pd.read_csv(density_file, sep="\t")
    max_density=df["count"].max()
    print(f"max_density: {max_density}")

    density_files_list.append(density_file.name)
    max_density_list.append(max_density)

  out_df=pd.DataFrame({"Density_file":density_files_list, "Max_Density":max_density_list})
  out_df.sort_values(by=["Max_Density"], ascending=False, inplace=True)
  print(f"out_df: {out_df.head()}")
  out_df.to_csv(output_file, sep="\t", index=False)
  


if __name__=="__main__":
  argParse=argparse.ArgumentParser("Find the max density value for all the denisty .bed files in input folder")

  argParse.add_argument("-i","--input_folder", type=str, required=True)
  argParse.add_argument("-o","--output_file", type=str, required=True)

  args=argParse.parse_args()
  get_max_density(args.input_folder, args.output_file)
