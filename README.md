

Clear documentation is critical to the success of your project. This checklist is meant to help you cover all your bases. Not every section/subsection will be relevant to your project; pick and choose what is. Inspired by READMEs of very successful projects like etcd.

Please copy-paste this into a new document and save as you build your READMEs. For alternative formats, you might create a [Structured README](https://github.com/shaloo/structuredreadme), which offers a thorough breakdown of optional README ingredients for you to consider. You might also take a look at [this similar checklist](https://github.com/cfpb/open-source-project-template); or check out [art-of-readme](https://github.com/noffle/art-of-readme).

## Team 02 README - Investigating COVID-19 Pandemic Temporal Research Trends

-This project pulls data from NCBI's PubMed using Julia's EFetch pipeline

-This data is pulled into a series of Julia files that parse and prune the data for standardization purposes

-The processing files output MeSH descriptor counts indexed by Date of publication

-This data set is pulled into another Julia function that plots this data for analysis

-Development of these files is complete and can be run in Julia by a user

**- Describe very briefly but clearly what the project does.
- State if it is out-of-the-box user-friendly, so it’s clear to the user.
- List its most useful/innovative/noteworthy features.
- State its goals/what problem(s) it solves.
- Note and briefly describe any key concepts (technical, philosophical, or both) important to the user’s understanding.
- Link to any supplementary blog posts or project main pages.
- Note its development status.
- Include badges.
- If possible, include screenshots and demo videos.**

### Core Technical Concepts/Inspiration

-The purpose for these functions is to build graphics and collect learnings from temporal publication trends the current COVID-19 pandemic.

-These learnings are intended to provide best practices or insight into strategizing for future pandemics.

-WE SHOULD INCLUDE REQUIRED PACKAGES HERE

-ADD SEQUENCE OF FILES TO RUN TO PULL, PROCESS, AND VISUALIZE DATA

-INCLUDE API ERROR WORK AROUNDS

-

**- Why does it exist?
- Frame your project for the potential user. 
- Compare/contrast your project with other, similar projects so the user knows how it is different from those projects.
- Highlight the technical concepts that your project demonstrates or supports. Keep it very brief.
- Keep it useful.**

### Getting Started/Requirements/Prerequisites/Dependencies
**Include any essential instructions for:
- Getting it
- Installing It
- Configuring It
- Running it**

### More Specific Topics (+ sample sub-categories)
**- Versioning: Services, APIs, Systems
- Common Error Messages/related details
- Tests
- Is it a Swift project? Please take a look at Mattt Thompson & Nate Cook's [Swift documentation](http://nshipster.com/swift-documentation/) guide**

### Contributing
**- Contributor Guidelines
- Code Style/Requirements
- Format for commit messages
- Thank you (name contributors)**

### TODO
**- Next steps
- Features planned
- Known bugs (shortlist)
**
### Contact
**- Email address
- Google Group/mailing list (if applicable)
- IRC or Slack (if applicable)**

### License
