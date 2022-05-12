## Team 02 README

### Investigating COVID-19 Pandemic Temporal Research Trends
Describe very briefly but clearly what the project does.
    State if it is out-of-the-box user-friendly, so it’s clear to the user.
    List its most useful/innovative/noteworthy features.
    State its goals/what problem(s) it solves.
    Note and briefly describe any key concepts (technical, philosophical, or both) important to the user’s understanding.
    Link to any supplementary blog posts or project main pages.
    Note its development status.
    Include badges.
    If possible, include screenshots and demo videos.
    
- This project analyzes the temporal frequency patterns of MeSH header data from COVID-19 related publications in NCBI's PubMed using Julia's EFetch pipeline. This data is pulled into a series of Julia files that parse and prune the data for standardization purposes. The processing files output MeSH descriptor counts indexed by date of publication. This dataset is pulled into another Julia function that plots this data for analysis. Development of these files is complete and can be run in Julia by a user. 
- This project attempted to define discrete research stages during an ongoing pandemic. These defined research stages contribute to the advancement of pandemic related research by providing a reference for researchers to better organize and strategize their investigations. Additionally, the study explored the temporal trends of individual MeSH terms in relation to each other and the progression of the COVID-19 pandemic. 
- MeSH (Medical Subject Headings) is the NLM controlled vocabulary thesaurus used for indexing articles for PubMed.

### Core Technical Concepts/Inspiration
Why does it exist?
    Frame your project for the potential user.
    Compare/contrast your project with other, similar projects so the user knows how it is different from those projects.
    Highlight the technical concepts that your project demonstrates or supports. Keep it very brief.
    Keep it useful.

- The purpose for these functions is to build graphics to visualize the temporal publication trends of certain MeSH terms or group of MeSH terms in relation to the current COVID-19 pandemic. This project is intended to provide best practices or insight into strategizing for future pandemics.

### Getting Started/Requirements/Prerequisites/Dependencies
Include any essential instructions for:
    Getting it
    Installing It
    Configuring It
    Running it
- Required Packages: HTTP, CSV, PyPlot, PlotlyJS
- Pulling Data:
- Processing Data:
- Visualizing Data:

### Common Error Messages/related details
- May run into an API 500 error. A try-catch block was implemented to resolve other API errors. 
