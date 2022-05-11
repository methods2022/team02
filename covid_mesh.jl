#805003808c8736631529fc08e08e19166907

using HTTP

function ncbi_mesh_search(pubmed_query, api_key, retstart, retmax)
    # set global_retstart to adjust for sample size
    # global_retstart allows for user to set article count with retmax
    if retmax < 10000
        global_retstart = 0 # small data extraction (< 10000 articles), only one iteration
    else
        global_retstart = -10000 # large data extraction (> 10000 articles), multiple iterations
    end

    # initialize query_dict
    query_dict = Dict()

    while (global_retstart <= retmax)

        # initialize dp_table
        mesh_table = Dict()
    
        base_search_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/esearch.fcgi"
        
        query_dict["api-key"] = api_key
        query_dict["db"] = "pubmed"
        query_dict["term"] = pubmed_query
        query_dict["retstart"] = retstart
        query_dict["retmax"] = retmax

        search_result = String(HTTP.post(base_search_query, body=HTTP.escapeuri(query_dict)))

        #print(search_result)

        pmid_set = Set()

        for result_line in split(search_result, "\n")
            pmid_capture  = match(r"<Id>(\d+)<\/Id>", result_line)

            if pmid_capture !== nothing
                push!(pmid_set, pmid_capture[1])
            end
        end

        id_string = join(collect(pmid_set), ",")

        println(match(r"<Count>(.+)</Count>", search_result)[1])

        #println("the pmids are: $id_string")

        base_fetch_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"

        query_dict["db"] = "pubmed"
        query_dict["id"] = id_string
        query_dict["rettype"] = "medline"
        query_dict["retmode"] = "text"
        query_dict["retstart"] = 0
        query_dict["api-key"] = api_key

        fetch_result = ""
        success = false
        while (success == false)
            try 
                fetch_result = String(HTTP.post(base_fetch_query, body=HTTP.escapeuri(query_dict)))
                success = true
            catch e
                println("Error: $e, \n Retrying efetch.")
                ncbi_mesh_search(pubmed_query, "805003808c8736631529fc08e08e19166907",retstart,retmax)
            end
        end

        #println(fetch_result)

        for fetch_line in split(fetch_result, "\n")
            mesh_capture = match(r"MH  - (.+)", fetch_line)
            if mesh_capture !== nothing
                header = mesh_capture[1] #pulls out all MHs
                if !haskey(mesh_table, header)
                    mesh_table[header] = 1
                else
                    mesh_table[header] += 1
                end            
            end
        end
        
        output_file_name = "jwei34_team2_trycatch_update_2.2.txt"
        output_file = open(output_file_name, "a")
        
        println(output_file, "searching for articles with query $pubmed_query")

        print("Retstart: $retstart\n")
        print(output_file, "Retstart: $retstart\n")

        print("Retmax: $retmax\n")
        print(output_file, "Retmax: $retmax\n")

        #increment global_retstart
        global_retstart += 10000
        retstart += 10000

        for (mesh_count, headers) in sort(collect(zip(values(mesh_table), keys(mesh_table))), rev=true)
            println("$mesh_count|$headers")
            print(output_file, "$mesh_count|$headers\n")
        end
    end
end

function main()
    println("searching for articles with query $pubmed_query")
    
    println("Enter desired retstart: ")
    retstart = tryparse(Int64, readline())
    global_retstart = 0
    
    println("Enter desired retmax: ")
    retmax = tryparse(Int64, readline())

    ncbi_mesh_search(pubmed_query, "805003808c8736631529fc08e08e19166907",retstart,retmax)
end

pubmed_query = "(2019-nCoV OR 2019nCoV OR COVID-19 OR SARS-CoV-2 OR (wuhan AND coronavirus)) AND 2019/08[PDAT]:2022/04[PDAT]"
main()