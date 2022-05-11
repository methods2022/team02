# mesh_group_assignment.jl
#
# Read input file: team02_update_2.1_processed.txt
# Process tabulated and cleaned data into csv format for manual group assignment
# Write output file: team2_update_2.5.csv
#
# Header: count,mesh
# Example input line: 28374|Humans
# Example output line: 28374,Humans
#
# require CSV
# require DataFrames

println("Loading packages ...")
using DataFrames
using CSV

# get distribution using dictionary
function process_dict(input_file, output_file)
    input_file = open(input_file, "r")
    print("Getting distribution using DataFrames ...\n")
    print("Converting dictionary format to CSV ...\n")
    
    # load file into DataFrame
    mesh_count_df = CSV.File(input_file, header=1, footerskip=0, delim="|") |> DataFrame

    # sort by count
    sort!(mesh_count_df, (:count), rev=(true))
    
    # after sorting
    println(mesh_count_df)
    CSV.write(output_file, mesh_count_df)
end

process_dict("team2_update_3.1_processed.txt", "team2_update_3.1_table.csv")