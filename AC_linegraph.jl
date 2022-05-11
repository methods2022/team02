using Plots

#store text file into array
function makeGraph(input_file)
    input_file = open(input_file, "r")  # absolute path
        
    x_axis = []
    y_axis = []

    # initialize total count
    count = 0

	# read in each line in input file
	for line in readlines(input_file)
        
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")

            # assign values
            frequency = parse(Int64, field[1])
            date = field[2]

            push!(x_axis, date)
            push!(y_axis, frequency)
           
        else
            continue
        end
    end

    plot(x_axis, y_axis, title = "Temporal Frequency of COVID-19 Therapy", label = "COVID-19 Therapy")
    savefig("therapy.pdf")

end

makeGraph("treatment/therapy_processed.txt")