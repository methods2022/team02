#407521d452cc948463ab38e791772aff9008

using HTTP

function ncbi_mesh_search(pubmed_query, header, api_key, output_file_name)

    retstart = 0
    global_retstart = 0

    retmax = 250000

    # initialize query_dict
    query_dict = Dict()

    while (global_retstart <= retmax)

        # initialize pubmed_table
        pubmed_table = Dict()
    
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

            retmax = parse(Int64, match(r"<Count>(.+)</Count>", search_result)[1])
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

        # initialize try/catch variables
        success = false
        fetch_result = ""
        
        # try/catch while loop to avoid API errors
        while(!success)
            try
                fetch_result = String(HTTP.post(base_fetch_query, body=HTTP.escapeuri(query_dict)))
                success = true # exit the while loop
            catch e
                println("Encountered $e. Re-attempting E-Fetch query.") # success remains false as an error was caught
            end
        end

        #println(fetch_result)

        for fetch_line in split(fetch_result, "\n")
            pubmed_capture = match(r"PHST- ([0-9]{4}\/[0-9]{2})\/[0-9]{2} [0-9]{2}:[0-9]{2} \[pubmed\]", fetch_line)
            if pubmed_capture !== nothing
                date = pubmed_capture[1] #pulls out all [pubmed] dates
                if !haskey(pubmed_table, date)
                    pubmed_table[date] = 1
                else
                    pubmed_table[date] += 1
                end            
            end
        end
        
        # initialize count
        count = 0

        output_file = open(output_file_name, "a")
        
        println("$header")
        println(output_file, "$header")

        println("searching for articles with query $pubmed_query")
        println(output_file, "searching for articles with query $pubmed_query")

        println("Retstart: $retstart")
        println(output_file, "Retstart: $retstart")

        println("Retmax: $retmax")
        println(output_file, "Retmax: $retmax")

        #increment global_retstart
        global_retstart += 10000
        retstart += 10000

        for (date, articles) in sort(collect(zip(keys(pubmed_table), values(pubmed_table))), rev=false)
            println("$articles|$date")
            count += articles
            print(output_file, "$articles|$date\n")
        end

        println("$count of $retmax dates extracted ($(match(r"<Count>(.+)</Count>", search_result)[1]) total search results)")
        println(output_file, "$count of $retmax dates extracted ($(match(r"<Count>(.+)</Count>", search_result)[1]) total search results)")

    end
end

function main()
    
    println("Enter desired MeSH header (singular):")
    header = ""
    header = readline()

    println("Enter desired output file name (add .txt):")
    output_file_name = readline()

    pubmed_query = "(2019-nCoV OR 2019nCoV OR COVID-19 OR SARS-CoV-2 OR (wuhan AND coronavirus)) AND $header[MH] AND 2019/12:2022/04[CRDT]"
    ncbi_mesh_search(pubmed_query, header, "407521d452cc948463ab38e791772aff9008", output_file_name)
end

main()