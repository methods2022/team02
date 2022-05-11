
using PlotlyJS

function makeHeatMap(input)
    input_file = open(input, "r")
    category = input[1:length(input) - 9]

    x_axis = []
    y_axis = []
    z_axis = []

    

    # initialize total count
    count = 0

    # read in each line in MULTIPLE mesh input file
    ylabel = ""
	for line in readlines(input_file)
        
        if !occursin(r"\|", line)
            ylabel = line
        elseif occursin(r"\|", line)
            # split line
            field = split(line, "|")

            if (field[1] != "count") 
                # assign values
                frequency = log10(parse(Int64, field[1]))
                date = field[2]

                push!(x_axis, date)
                push!(z_axis, frequency)
                push!(y_axis, ylabel)
            # elseif (field[1] == "Mesh term")
            #     push!(y_axis, field[2])
            end
        else
            continue
        end
    end

    heatmap_image = plot(
        heatmap((x=x_axis),(y=y_axis),(z=z_axis)), 
        Layout(xlabel="Month", ylabel = "MeSH Term", title="Temporal Heatmap of Top 5 MeSH Terms: $(uppercasefirst(category))"))
    savefig(heatmap_image, "log_" * category * "_heatmap.png")
end

function combine_single_headers(input1, input2, input3, input4, input5, output_file)
    input1 = open(input1, "r")
    input2 = open(input2, "r")
    input3 = open(input3, "r")
    input4 = open(input4, "r")
    input5 = open(input5, "r") 

    output_file = open(output_file, "a") 

    for line in readlines(input1)
        print(output_file, line)
        print(output_file, "\n")
    end
    for line in readline(input2)
        print(output_file, line)
        print(output_file, "\n")
    end
    for line in readline(input3)
        print(output_file, line)
        print(output_file, "\n")
    end
    for line in readline(input4)
        print(output_file, line)
        print(output_file, "\n")
    end
    for line in readline(input5)
        print(output_file, line)
        print(output_file, "\n")
    end
    
    close(input1)
    close(input2)
    close(input3)
    close(input4)
    close(input5)
end

# combine_single_headers(
#     "temporal_single/Contact_Tracing_mesh_team2_update_3.txt",
#     "temporal_single/Masks_mesh_team2_update_3.txt",
#     "temporal_single/Personal_Protective_Equipment_mesh_team2_update_3.txt",
#     "temporal_single/Physical_Distancing_mesh_team2_update_3.txt",
#     "temporal_single/Quarantine_mesh_team2_update_3.txt", "top5_prevention.txt")

println("Enter source data file:")
input = readline()

makeHeatMap(input)


# OTHER CODE
# to do: make a function or file that combine files into 1 thing with headers 
# also, find if there's a way to do all 5 at once rather than 1 by 1



	# # read in each line in single mesh input file
	# for line in readlines(input_file)
        
    #     if occursin(r"\|", line)
    #         # split line
    #         field = split(line, "|")

    #         if (field[1] != "count") 
    #             # assign values
    #             frequency = parse(Int64, field[1])
    #             date = field[2]

    #             push!(x_axis, date)
    #             push!(z_axis, frequency)
    #             push!(y_axis, "Masks")
    #         # elseif (field[1] == "Mesh term")
    #         #     push!(y_axis, field[2])
    #         end
    #     else
    #         continue
    #     end
    # end

    # masks_heatmap = plot(
    #     heatmap((x=x_axis),(y=y_axis),(z=z_axis)), 
    #     Layout(xlabel="Month", ylabel="MeSH Term", title="Temporal Heatmap of Top 5 MeSH Terms"))
    #     savefig(masks_heatmap, "masks_heatmap.pdf")
