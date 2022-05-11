using Pkg
# Pkg.add("Plots")
# Pkg.add("PyPlot") # or Pkg.add("PlotlyJS"), for example
using Plots

# function bar_plot(input_file)
diagnosis = open("diagnosis/DT_diagnosis_processed.txt", "r")  # absolute path
treatment = open("treatment/treatment_processed.txt", "r")  # absolute path
prevention = open("temporal_single/DT_prevention_processed.txt", "r")  # absolute path

my_array = []
my_date = []
for line in readlines(diagnosis)       
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")   
            article_count = field[1]
            date = field[2]
            # print(field)
            article_count = parse(Int64, article_count)
            push!(my_array, article_count)
            push!(my_date, date)            
        end
end
# print(my_array)
my_array2 = []
my_date2 = []
for line in readlines(treatment)       
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")   
            article_count = field[1]
            date = field[2]
            # print(field)
            article_count = parse(Int64, article_count)
            push!(my_array2, article_count)
            push!(my_date2, date)
        end
end
my_array3 = []
my_date3 = []
for line in readlines(prevention)       
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")   
            article_count = field[1]
            date = field[2]
            # print(field)
            article_count = parse(Int64, article_count)
            push!(my_array3, article_count)
            push!(my_date3, date)
        end
end


# data3 = hcat(Array(0:0.01:1),Array(1:-0.01:0)) #concatenate along dimension 2
# data3 += .05*randn(size(data3)) # lets add randomness so its not so boring
plot(my_date2, my_array2, title="Temporal patterns for COVID19 Research Groups", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Treatment")

plot!(my_date, my_array, title="Temporal patterns for COVID19 Research Groups", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Diagnosis")

plot!(my_date3, my_array3, title="Temporal patterns for COVID19 Research Groups", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Prevention")

savefig("Combined_Research_Groups.pdf")