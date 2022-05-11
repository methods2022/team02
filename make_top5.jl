function combine_single_headers(input1, input2, input3, input4, input5, output_file)
    input1 = open(input1, "r")
    input2 = open(input2, "r")
    input3 = open(input3, "r")
    input4 = open(input4, "r")
    input5 = open(input5, "r") 

    output_file = open(output_file, "w") 

    for line in readlines(input1)
        println(output_file, line)
    end
    for line in readlines(input2)
        println(output_file, line)
    end
    for line in readlines(input3)
        println(output_file, line)
    end
    for line in readlines(input4)
        println(output_file, line)
    end
    for line in readlines(input5)
        println(output_file, line)
    end
    
    close(input1)
    close(input2)
    close(input3)
    close(input4)
    close(input5)
end

function main()
    println("Enter output category:")
    category = readline()

    println("Enter Input 1:")
    input1 = "$category/" * readline() * "_processed.txt"

    println("Enter Input 2:")
    input2 = "$category/" * readline() * "_processed.txt"

    println("Enter Input 3:")
    input3 = "$category/" * readline() * "_processed.txt"

    println("Enter Input 4:")
    input4 = "$category/" * readline() * "_processed.txt"

    println("Enter Input 5:")
    input5 = "$category/" * readline() * "_processed.txt"

    output = category * "_top5.txt"

    combine_single_headers(input1, input2, input3, input4, input5, output)
end

main()