
using PlotlyJS;
pltjs = PlotlyJS

function bar1()
    trace1 = pltjs.bar(;x=[1, 2, 3, 4], y=[1, 4, 9, 16], name="Trace1")
    trace2 = pltjs.bar(;x=[1, 2, 3, 4], y=[6, -8, -4.5, 8], name="Trace2")
    data   = [trace1, trace2];

    layout = pltjs.Layout(;xaxis_title="X axis",
                           yaxis_title="Y axis",
                           barmode="relative",
                           title="Relative 1");
    pltjs.plot(data, layout)
end


function bar2()
    trace3 = pltjs.bar(;x=[1, 2, 3, 4], y=[-15, -3, 4.5, -8], name="Trace3")
    trace4 = pltjs.bar(;x=[1, 2, 3, 4], y=[-1, 3, -3, -4], name="Trace4")
    data   = [trace3, trace4];

    layout = pltjs.Layout(;xaxis_title="X axis",
                           yaxis_title="Y axis",
                           barmode="relative",
                           title="Relative 2");
    pltjs.plot(data, layout)
end

p1 = bar1();
pltjs.savefig(p1, "fig1.pdf") # This works

p2 = bar2();
pltjs.savefig(p2, "fig2.pdf") # This works

# p3 = [bar1() bar2()];
# pltjs.savefig(p3, "./fig3.pdf") # This doesn't works

# p3.plot.layout["barmode"] = "relative"; #solution