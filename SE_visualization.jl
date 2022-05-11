using Pkg
Pkg.add("Plots")
Pkg.add("PyPlot") # or Pkg.add("PlotlyJS"), for example
using Plots

# # function bar_plot(input_file)
# Anxiety = open("mental_health/Anxiety_Stress_Fear_processed.txt", "r")  # absolute path
# Depression = open("mental_health/depression.txt", "r")  # absolute path
# General = open("mental_health/general_psychology_processed.txt", "r")  # absolute path
# healthcare_worker = open("mental_health/healthcare_worker_psychology_processed.txt", "r")  # absolute path
# Quarantine = open("mental_health/Quarantine_Psychology_processed.txt", "r")  # absolute path
# my_array = []
# my_date = []
# for line in readlines(Anxiety)       
#         if occursin(r"\|", line)
#             # split line
#             field = split(line, "|")   
#             article_count = field[1]
#             date = field[2]
#             # print(field)
#             article_count = parse(Int64, article_count)
#             push!(my_array, article_count)
#             push!(my_date, date)            
#         end
# end
# # print(my_array)
# my_array2 = []
# my_date2 = []
# for line in readlines(Depression)       
#         if occursin(r"\|", line)
#             # split line
#             field = split(line, "|")   
#             article_count = field[1]
#             date = field[2]
#             # print(field)
#             article_count = parse(Int64, article_count)
#             push!(my_array2, article_count)
#             push!(my_date2, date)
#         end
# end
# my_array3 = []
# my_date3 = []
# for line in readlines(General)       
#         if occursin(r"\|", line)
#             # split line
#             field = split(line, "|")   
#             article_count = field[1]
#             date = field[2]
#             # print(field)
#             article_count = parse(Int64, article_count)
#             push!(my_array3, article_count)
#             push!(my_date3, date)
#         end
# end
# my_array4 = []
# my_date4 = []
# for line in readlines(healthcare_worker)       
#         if occursin(r"\|", line)
#             # split line
#             field = split(line, "|")   
#             article_count = field[1]
#             date = field[2]
#             # print(field)
#             article_count = parse(Int64, article_count)
#             push!(my_array4, article_count)
#             push!(my_date4, date)
#         end
# end
# my_array5 = []
# my_date5 = []
# for line in readlines(Quarantine)       
#         if occursin(r"\|", line)
#             # split line
#             field = split(line, "|")   
#             article_count = field[1]
#             date = field[2]
#             # print(field)
#             article_count = parse(Int64, article_count)
#             push!(my_array5, article_count)
#             push!(my_date5, date)
#         end
# end


# plot(my_date3, my_array3, title="Temporal patterns for publications about Mental Health", xaxis = (font(5), "Date"), 
# ylabel="Article count", label = "COVID-19 / General Psychology")
# plot!(my_date, my_array, title="Temporal patterns for publications about Mental Health", xaxis = (font(5), "Date"), 
# ylabel="Article count", label = "Anxiety")
# plot!(my_date2, my_array2, title="Temporal patterns for publications about Mental Health", xaxis = (font(5), "Date"), 
# ylabel="Article count", label = "Depression")
# plot!(my_date4, my_array4, title="Temporal patterns for publications about Mental Health", xaxis = (font(5), "Date"), 
# ylabel="Article count", label = "Healthcare Worker Psychology")
# plot!(my_date5, my_array5, title="Temporal patterns for publications about Mental Health", xaxis = (font(5), "Date"), 
# ylabel="Article count", label = "Quarantine")
# savefig("mental_health.pdf")




# function bar_plot(input_file)
combined = open("comorbidities.txt", "r")  # absolute path

my_array = []
my_date = []
for line in readlines(combined)       
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

plot(my_date, my_array, title="Temporal patterns for publications about Comorbidities",titlefont=font(10), xaxis = (font(5), "Date"), 
ylabel="Article count", label = "combined")
savefig("Comorbidities.pdf")


