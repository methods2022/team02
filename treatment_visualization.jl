using Pkg
# Pkg.add("Plots")
# Pkg.add("PyPlot") # or Pkg.add("PlotlyJS"), for example
using Plots

# function bar_plot(input_file)
drug_therapy = open("treatment/drug_therapy_processed.txt", "r")  # absolute path
antiviral = open("treatment/antiviral_processed.txt", "r")  # absolute path
respiration = open("treatment/respiration_processed.txt", "r")  # absolute path
hcq = open("treatment/hcq_processed.txt", "r")  # absolute path
antibody = open("temporal_single/antibody.txt", "r")  # absolute path
therapy = open("treatment/therapy_processed.txt", "r")  # absolute path
my_array = []
my_date = []
for line in readlines(drug_therapy)       
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
for line in readlines(antiviral)       
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
for line in readlines(respiration)       
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
my_array4 = []
my_date4 = []
for line in readlines(hcq)       
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")   
            article_count = field[1]
            date = field[2]
            # print(field)
            article_count = parse(Int64, article_count)
            push!(my_array4, article_count)
            push!(my_date4, date)
        end
end
my_array5 = []
my_date5 = []
for line in readlines(antibody)       
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")   
            article_count = field[1]
            date = field[2]
            # print(field)
            article_count = parse(Int64, article_count)
            push!(my_array5, article_count)
            push!(my_date5, date)
        end
end

my_array6 = []
my_date6 = []
for line in readlines(therapy)       
        if occursin(r"\|", line)
            # split line
            field = split(line, "|")   
            article_count = field[1]
            date = field[2]
            # print(field)
            article_count = parse(Int64, article_count)
            push!(my_array6, article_count)
            push!(my_date6, date)
        end
end


# data3 = hcat(Array(0:0.01:1),Array(1:-0.01:0)) #concatenate along dimension 2
# data3 += .05*randn(size(data3)) # lets add randomness so its not so boring
plot(my_date6, my_array6, title="Temporal patterns for publications about COVID19 Treatment", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Therapy", yaxis=:log)
plot!(my_date, my_array, title="Temporal patterns for COVID19 Treatment", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Drug Therapy", yaxis=:log)
plot!(my_date2, my_array2, title="Temporal patterns for COVID19 Treatment", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Antiviral Agents", yaxis=:log)
plot!(my_date3, my_array3, title="Temporal patterns for COVID19 Treatment", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Artificial Respiration", yaxis=:log)
plot!(my_date4, my_array4, title="Temporal patterns for COVID19 Treatment", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Hydroxychloroquine", yaxis=:log)
plot!(my_date5, my_array5, title="Temporal patterns for COVID19 Treatment", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Viral Antibodies", yaxis=:log)
plot!(legend=:outertopright)

savefig("Combined_Treatment.pdf")