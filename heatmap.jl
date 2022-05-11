
using PlotlyJS

function makeHeatMap(input_file)
    input_file = open(input_file, "r") 

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
                frequency = parse(Int64, field[1])
                date = field[2]

                push!(x_axis, date)
                push!(z_axis, frequency)
                push!(y_axis, ylabel)
            end
        else
            continue
        end
    end

    prevention_heatmap = plot(
        heatmap((x=x_axis),(y=y_axis),(z=z_axis)), 
        Layout(xlabel="Month", ylabel="MeSH Term", title="Temporal Heatmap of Top 5 MeSH Terms: Diagnosis"))
        savefig(prevention_heatmap, "prevention_heatmap.pdf")
end

makeHeatMap("top5_prevention.txt")
