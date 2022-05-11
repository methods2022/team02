using Pkg
# Pkg.add("Plots")
# Pkg.add("PyPlot") # or Pkg.add("PlotlyJS"), for example
using Plots

# function bar_plot(input_file)
clin_lab_techniques = open("diagnosis/clin_lab_techniques_processed.txt", "r")  # absolute path
diagnostic_imaging = open("diagnosis/diagnostic_imaging_processed.txt", "r")  # absolute path
general_diagnosis = open("diagnosis/general_diagnosis_processed.txt", "r")  # absolute path
pcr = open("diagnosis/pcr_processed.txt", "r")  # absolute path
testing = open("diagnosis/testing_processed.txt", "r")  # absolute path
my_array = []
my_date = []
for line in readlines(clin_lab_techniques)       
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
for line in readlines(diagnostic_imaging)       
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
for line in readlines(general_diagnosis)       
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
for line in readlines(pcr)       
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
for line in readlines(testing)       
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

# my_array6 = []
# my_date6 = []
# for line in readlines(therapy)       
#         if occursin(r"\|", line)
#             # split line
#             field = split(line, "|")   
#             article_count = field[1]
#             date = field[2]
#             # print(field)
#             article_count = parse(Int64, article_count)
#             push!(my_array6, article_count)
#             push!(my_date6, date)
#         end
# end


# data3 = hcat(Array(0:0.01:1),Array(1:-0.01:0)) #concatenate along dimension 2
# data3 += .05*randn(size(data3)) # lets add randomness so its not so boring

plot(my_date3, my_array3, title="Temporal patterns for COVID19 Diagnosis", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "General Diagnosis")

plot!(my_date, my_array, title="Temporal patterns for COVID19 Diagnosis", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Clinical Lab Techniques")
plot!(my_date2, my_array2, title="Temporal patterns for COVID19 Diagnosis", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Diagnostic Imaging")

plot!(my_date4, my_array4, title="Temporal patterns for COVID19 Diagnosis", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "PCR")
plot!(my_date5, my_array5, title="Temporal patterns for COVID19 Diagnosis", xaxis = (font(5), "Date"), 
ylabel="Article count", label = "Testing")
# plot!(my_date6, my_array6, title="Temporal patterns for publications about COVID19 Treatment", xaxis = (font(5), "Date"), 
# ylabel="Article count", label = "Therapy")
savefig("Combined_Diagnosis.pdf")