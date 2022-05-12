## Team 02 README

### Investigating COVID-19 Pandemic Temporal Research Trends
- This project analyzes the temporal frequency patterns of MeSH header data from COVID-19 related publications in NCBI's PubMed using Julia's EFetch pipeline. This data is pulled into a series of Julia files that parse and prune the data for standardization purposes. The processing files output MeSH descriptor counts indexed by date of publication. This dataset can be pulled into two types of data visualization Julia functions, line graphs and heatmaps. Development of these files is complete and can be run in Julia by a user. 
- This project aimed to define discrete research stages during an ongoing pandemic. These defined research stages contribute to the advancement of pandemic related research by providing a reference for researchers to better organize and strategize their investigations. Additionally, the study explored the temporal trends of individual MeSH terms in relation to each other and the progression of the COVID-19 pandemic. 
- MeSH (Medical Subject Headings) is the NLM controlled vocabulary thesaurus used for indexing articles for PubMed.

### Core Technical Concepts/Inspiration
- The purpose for these functions is to build graphics to visualize the temporal publication trends of certain MeSH terms or group of MeSH terms in relation to the current COVID-19 pandemic. This project is intended to provide best practices or insight into strategizing for future pandemics or public health events. This project also gives information about how the research phases that were defined correlate with the real world events. Prior research mainly focused on examining research priorities during the COVID-19 pandemic, but their methodologies and main purposes differed. One study created an identification framework to better understand the transition of research priorities during the pandemic and another study examined trends of new and on-going research either related or unrelated to the COVID-19 pandemic. Nevertheless, there is a lack of research on temporal patterns of research during the pandemic. This project defines research stages by analyzing MeSH header patterns.

### Getting Started/Requirements/Prerequisites/Dependencies
- Required Packages for Julia: HTTP, CSV, PyPlot, PlotlyJS
- Pulling Data: single_header.jl is used to pull the data for a single MeSH header. group_mesh_search.jl is used for group MeSH searches. Both take in the user input specifying a desired MeSH term and research category respectively, as well as the desired output file name. covid_mesh.jl is used to get all the relevant headers related to COVID-19.  
- Processing Data: AC_DT_covid_mesh process.jl is used to process and clean up the MeSH header data (used for the output of covid_mesh.jl). covid_mesh_proces.jl is used to clean up the data (used for the output of single_header.jl and group_mesh_search.jl).
- Visualizing Data: DT_research_groups_combined.jl is used to plot the combined graph for all three research categories using their own MeSH header data. diagnosis_linegraph.jl is used to plot the MeSH headers for the diagnosis category and could be changed to plot the other categories according to their corresponding MeSH headers. JW_barchart creates a bar graph mapping publication frequencies over time. heatmap.jl, log10_heatmap.jl,and log_heatmap.jl are used to make the heatmaps for the categories. 
- Machine learning model: deniz_Arima_forecast.R file is used to plot the forecasting. It can be run inside Rstudio.

*To run all the Julia files, write julia [file_name].jl in the terminal

### Common Error Messages/related details
- May run into an API 500 error. A try-catch block was implemented to resolve other API errors. 

### TODO
- There is a lot of potential for expanding the scope of our group_mesh_search.jl and data visualization functions in order to encompass more research categories and their top MeSH term subcategories. Additionally, more search functions can be adjusted to be user-responsive, such that users could create visualizations for similar pandemics, such as SARS-CoV-1.
- In the future, we hope to implement a less manual and more AI-based method of identifying top research categories and top MeSH terms. Databases such as NIH's MeSH Tree View could be leveraged to create deep learning models that can identify more subtle and objective categories. 
