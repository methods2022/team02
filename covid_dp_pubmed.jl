#407521d452cc948463ab38e791772aff9008

using HTTP

function ncbi_mesh_search(pubmed_query, api_key)
    println("searching for articles with query $pubmed_query")
    
    println("Enter desired retstart: ")
    retstart = tryparse(Int64, readline())
    global_retstart = 0
    
    println("Enter desired retmax: ")
    retmax = tryparse(Int64, readline())

    # initialize query_dict
    query_dict = Dict()

    while (global_retstart + 10000 <= retmax)

        # initialize dp_table
        dp_table = Dict()
    
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

        #println("the pmids are: $id_string")

        base_fetch_query = "https://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi"

        query_dict["db"] = "pubmed"
        query_dict["id"] = id_string
        query_dict["rettype"] = "medline"
        query_dict["retmode"] = "text"
        query_dict["retstart"] = 0
        query_dict["api-key"] = api_key

        fetch_result = String(HTTP.post(base_fetch_query, body=HTTP.escapeuri(query_dict)))
        

        #println(fetch_result)

        for fetch_line in split(fetch_result, "\n")
            dp_capture = match(r"PHST- ([0-9]{4}\/[0-9]{2})\/[0-9]{2} [0-9]{2}:[0-9]{2} \[pubmed\]", fetch_line)
            if dp_capture !== nothing
                date = dp_capture[1] #pulls out all DPs
                if !haskey(dp_table, date)
                    dp_table[date] = 1
                else
                    dp_table[date] += 1
                end            
            end
        end
        
        # initialize count
        count = 0

        output_file_name = "azdon_team2_update_1.5.txt"
        output_file = open(output_file_name, "a")
        
        print("Retstart: $retstart\n")
        print(output_file, "Retstart: $retstart\n")

        print("Retstart: $retmax\n")
        print(output_file, "Retstart: $retmax\n")

        #increment global_retstart
        global_retstart += 10000
        retstart += 10000

        for (date, articles) in sort(collect(zip(keys(dp_table), values(dp_table))), rev=false)
            println("$articles|$date")
            count += articles
            print(output_file, "$articles|$date\n")
        end

        print("$count of $(match(r"<Count>(.+)</Count>", search_result)[1]) dates extracted\n")
        print(output_file, "$count of $(match(r"<Count>(.+)</Count>", search_result)[1]) dates extracted\n")

    end
end

function main()
    pubmed_query = "2019-nCoV OR 2019nCoV OR COVID-19 OR SARS-CoV-2 OR (wuhan AND coronavirus) AND 2019/12[PDAT]:2022/04[PDAT]"
    ncbi_mesh_search(pubmed_query, "407521d452cc948463ab38e791772aff9008")
end

main()