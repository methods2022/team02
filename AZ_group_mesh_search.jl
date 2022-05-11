#407521d452cc948463ab38e791772aff9008

using HTTP

function ncbi_mesh_search(pubmed_query, api_key, research_phase)
    
    # initialize count
    count = 0

    # create output file
    output_file_name = "group_mesh_search1.txt"
    output_file = open(output_file_name, "a")
    
    # note down research phase
    println("searching for articles for research phase: $research_phase\n")
    println(output_file, "searching for articles for research phase: $research_phase\n")
    
    # set retstart
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
        
        println("Retstart: $retstart")
        print(output_file, "Retstart: $retstart")

        println("Retmax: $retmax")
        print(output_file, "Retmax: $retmax")

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
    
    println("Enter desired research phase (all lowercase):")
    research_phase = ""
    research_phase = readline()
    header = ""

    if (research_phase == "general") # this could just search for everything?

    elseif (research_phase == "mechanism")
        # TO ADD: HEADER W/ TOP 5 MESH TERMS
    elseif (research_phase == "transmission")
        # TO ADD: HEADER W/ TOP 5 MESH TERMS
    elseif (research_phase == "diagnosis")
        header = "COVID-19 Testing[MH] OR Tomography, X-Ray Computed[MH]" 
        # OR Viral Load[MH] OR Tomography, X-Ray Computed/methods[MH] OR
        # Real-Time Polymerase Chain Reaction[MH] OR Polymerase Chain Reaction[MH]"
    elseif (research_phase == "treatment")
        header = "Treatment Outcome[MH] OR COVID-19 Vaccines[MH] OR Vaccination[MH] OR 
        Antiviral Agents/therapeutic use[MH] OR Antiviral Agents/pharmacology[MH]
        OR Intensive Care Units[MH] OR Critical Care[MH] OR Coronavirus Infections/drug therapy
        COVID-19/drug therapy[MH] OR Coronavirus Infections/therapy[MH] OR COVID-19/therapy[MH]"
    elseif (research_phase == "prevention")
        header = "Masks[MH] OR Physical Distancing[MH] OR Personal Protective Equipment[MH] OR Quarantine[MH]
        Contact Tracing[MH]"
    elseif (research_phase == "forecasting")
        # TO ADD: HEADER W/ TOP 5 MESH TERMS
    else
        println("Invalid research phase, please try again.")
        throw(error())
    end

    pubmed_query = "(2019-nCoV OR 2019nCoV OR COVID-19 OR SARS-CoV-2 OR (wuhan AND coronavirus)) 
    AND $header AND 2019/12:2022/04[CRDT]"
    ncbi_mesh_search(pubmed_query, "407521d452cc948463ab38e791772aff9008", research_phase)
end

main()