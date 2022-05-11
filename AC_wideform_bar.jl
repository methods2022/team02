using PlotlyJS, CSV, DataFrames
pltjs = PlotlyJS

df = dataset(DataFrame, "medals")

p1 = plot(
    [bar(df, x=:nation, y=y, name=String(y)) for y in [:gold, :silver, :bronze]],
    Layout(title="Wide-Form Input")
)

pltjs.savefig(p1, "wideform_bar.pdf")