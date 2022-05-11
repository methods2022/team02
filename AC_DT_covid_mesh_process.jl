
# get distribution using dictionary
function process_dict(input_file, output_file)
    input_file = open(input_file, "r")  # absolute path
    output_file = open(output_file, "w")  # relative path
    print("Getting distribution using dictionaries ...\n")
    
    dp_count_dict = Dict()

    # print header
    print("count|mesh_header\n")

    # initialize total count
    count = 0

	# read in each line in input file
	for line in readlines(input_file)
        
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")

            # assign values
            article_count = field[1]
            mesh_header = field[2]

           
            # mesh_header = strip(mesh_header, '*')
            # mesh_header = strip(mesh_header, ['C', 'O', 'V', 'I', 'D', '-', '1' , '9' ,'/'])
            # mesh_header = strip(mesh_header, ['S', 'A', 'R', 'S', '-', 'C', 'o', 'V', '-', '2', '/'])
            # mesh_header = strip(mesh_header, '*')
            #Add key/value pair or sum value if key exists

            # pmid_set = Set()
            # pmid_capture = match(r"[^*]", mesh_header) #regex


            # if pmid_capture != nothing
            #     push!(pmid_set, pmid_capture[1])
            # end
            # println(pmid_set)
            mesh_header = replace(mesh_header, "*" => "")


            if !haskey(dp_count_dict, mesh_header)
                dp_count_dict[mesh_header] = parse(Int64, article_count)
            else
                dp_count_dict[mesh_header] += parse(Int64, article_count)
            end
        else
            continue
        end
    end

	for (article_count, mesh_header) in sort(collect(zip(values(dp_count_dict), keys(dp_count_dict))), rev=true)
        println("$article_count|$mesh_header")
        println(output_file, "$article_count|$mesh_header")
        count += 1
    end

    print("$count mesh headers extracted\n")
    print(output_file, "$count mesh headers extracted\n")
end

# process_dict("team02_update_2.5.txt", "DT_AC_processed_DP_data.txt")
process_dict("team2_update_2.1.txt", "DT_AC_processed_DP_data.txt")