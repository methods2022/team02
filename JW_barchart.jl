using Vega, Plots

#store text file into array
function makeBarGraph(input_file)
    input_file = open(input_file, "r")
        
    x_axis = []
    y_axis = []

    # initialize total count
    count = 0

	# read in each line in input file
	for line in readlines(input_file)
        
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")

            if (field[1] != "count") 
                # assign values
                frequency = parse(Int64, field[1])
                date = field[2]

                push!(x_axis, date)
                push!(y_axis, frequency)
            end

        else
            continue
        end
    end

    bar(x_axis, y_axis)
    Layout(xlabel="Month", ylabel="# of Publications", 
        title="Group Mesh Search Publication Frequency: Diagnosis")
    savefig("barchart_diagnosis.pdf")

end

makeBarGraph("diagnosis/DT_diagnosis_processed.txt")

