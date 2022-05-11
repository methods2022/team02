# azdon_covid_mesh_process.jl
#
# Read input file: azdon_team2_update1.3.txt
# Clean and process tabulation of dates (using dictionaries)
# Write output file: azdon_team2_update1.4.txt
#
# open files

# get distribution using dictionary
function process_dict(input_file, output_file)
    input_file = open(input_file, "r")  # absolute path
    output_file = open(output_file, "w")  # relative path
    print("Getting distribution using dictionaries ...\n")
    
    dp_count_dict = Dict()

    # initialize total count
    count = 0

    # to save research phase
    line_num = 1

	# read in each line in input file
    for line in readlines(input_file)
        
        # print header
        if (line_num == 1)
            print(output_file, line)
            print(output_file, "\n")
            line_num += 1
        
        elseif occursin(r"\|", line)
            # split line
            field = split(line, "|")

            # assign values
            date = field[2]
            article_count = field[1]
            
            #Add key/value pair or sum value if key exists
            if !haskey(dp_count_dict, date)
                dp_count_dict[date] = parse(Int64, article_count)
            else
                dp_count_dict[date] += parse(Int64, article_count)
            end
        else
            continue
        end
    end

	for (date, article_count) in sort(collect(zip(keys(dp_count_dict), values(dp_count_dict))), rev=false)
        print("$article_count|$date\n")
        print(output_file, "$article_count|$date\n")
        count += article_count
    end

    print("$count dates extracted\n")
    print(output_file, "$count dates extracted\n")
end

process_dict("temporal_single/antiviral.txt", "temporal_single/antiviral1.txt")