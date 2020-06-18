<%@ page errorPage="error.jsp" %>
<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%@page import="java.util.List"%> 

<%@page import="com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider"%>
<%@page import="com.lbl.regprecise.ent.Genome"%>
<%@page import="com.lbl.regprecise.web.DataProviderHelper"%>
<%@page import="com.lbl.regprecise.web.RegulogCascadeGraph"%>

<%
	ConstrainedDataProvider dataProvider = DataProviderHelper.getDataProvider();
	int genomeId = Integer.parseInt(request.getParameter("genome_id")) ;

	Genome genome = dataProvider.getGenome(genomeId);
	String graphJS = RegulogCascadeGraph.loadJS(dataProvider, genomeId, true);
	int d3AreaWidth = 915;
	int d3AreaHeight = 700;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<style>
.node {
  stroke: #fff;
  stroke-width: 1.5px;
}
.link {
  stroke: #999;
  stroke-opacity: .6;
}
text {
  font: 10px sans-serif;
  pointer-events: none;
}
text.shadow {
  stroke: #fff;
  stroke-width: 3px;
  stroke-opacity: .8;
}
</style>
<title>Regulator cascades of <%= genome.getName() %></title>
<link rel="stylesheet" type="text/css" href="styles/base.css" />
<link rel="stylesheet" type="text/css" href="styles/tabs.css" />
</head>
<body>
<div id="page">
	<%@ include file="/header.jsp" %>	
	<div id="content"> 

		<div >
			<div class="introduction">
				<h1> Regulator cascades of <span class="titleItem"><i><%= genome.getName() %></i></span></h1>
			</div>					
			
            <table width="99%" border=0 cellpadding="0px" style="border-collapse: collapse;"><tr>
 			<td><div class="vspace_separator"></div></td>
        	<td valign="bottom"><div id="tab_header">
                <ul>
                    	<li class="selected"><a style="font-size: 0.9em; line-height:27px;">Regulatory cascades</a></li>
                    	<li class="notselected"><a style="font-size: 0.9em; line-height:25px;" href="genome.jsp?genome_id=<%=genomeId%>">Table view</a></li>
                </ul>
        	</div></td>
            </tr></table>

			<div>

			<table class="stattbl" style="border-collapse: collapse">
				<caption></caption>
				<thead>
					<tr>					
						<th class="sup_column2" colspan="6"></th>
					</tr>					
				</thead>
				<tbody><tr><td>

                    <div id="svg_div" style="width: <%=d3AreaWidth%>px; height: <%=d3AreaHeight%>px; border: 1px solid black;"/>

				</td></tr></tbody>
			</table>
			</div>
		</div>
		
		<!--div class="vspace_separator"></div-->

	</div>
	<%@ include file="/footer.jsp" %>	
</div>

  <script src="http://d3js.org/d3.v3.min.js"></script>
  <script src="http://code.jquery.com/jquery-latest.js"></script>

<script type="text/javascript">

var width = <%=d3AreaWidth%>,
    height = <%=d3AreaHeight%>,
    line_len = 60;

var arrow_len = 4.0/line_len;

var tip_left = -1, tip_top = -1, tip_viz = false;

var force = d3.layout.force()
    .charge(function(d) { if (d.children) { if (d.open) { return -200; } else { return -200-12*d.children.length; } } else { return -30; } })
    .linkDistance(function(d) { if (d.short) { return 15 + 5*Math.sqrt(d.target.children.length); } else { return line_len + size(d.source) + size(d.target); } })
    .size([width, height]);

var orig_graph;

var tooltip;

$(document).mousemove(function(e) {
  if (tip_viz) {
    var min_x = tip_left;
    var min_y = tip_top;
    var max_x = min_x + $("#popup_tooltip").width();
    var max_y = min_y + $("#popup_tooltip").height();
    var x = e.pageX;
    var y = e.pageY;
    if (x < min_x | y < min_y | x > max_x | y > max_y) {
      if (Math.sqrt((x-min_x)*(x-min_x)+(y-min_y)*(y-min_y)) > 50) {
        hide_popup();
      }
    }
  }
});

function update() {
  var svg = d3.select("#svg_div").append("svg")
    .attr("width", width)
    .attr("height", height);

  var graph_nodes = orig_graph.nodes.slice();
  var graph_links = orig_graph.links.slice();

  var count = graph_nodes.length;
  for (var i = 0; i < count; i++) {
    var node = graph_nodes[i];
    if (node.open) {
      for (var j = 0; j < node.children.length; j++) {
        var new_node_pos = graph_nodes.length;
        graph_nodes.push(node.children[j]);
        var new_link = new Object();
        new_link.source = new_node_pos;
        new_link.target = i;
        new_link.value = 1;
        new_link.short = true;
        graph_links.push(new_link);
      }
    }
  }

  force
      .nodes(graph_nodes)
      .links(graph_links)
      .start();

  var link = svg.selectAll("line.link")
      .data(graph_links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });

  var link2 = svg.selectAll("line.link2")
      .data(graph_links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });

  var link3 = svg.selectAll("line.link3")
      .data(graph_links)
    .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(d.value); });

  tooltip = d3.select("body").append("div")
	.style("position", "absolute")
	.style("z-index", "10")
	.style("visibility", "hidden")
	.style("width", "425px")
	.style("height", "auto")
	.style("opacity", ".90")
	.style("background", "white")
	.style("background-color", "white")
	.style("border", "1px solid black")
	.attr("id","popup_tooltip")
	.text("Please wait...");

  var node = svg.selectAll("circle.node")
      .data(graph_nodes)
    .enter().append("circle")
      .attr("class", "node")
      .attr("r", function(d) { return size(d); })
      .style("fill", function(d) { return d3.rgb(d.color); })
      .style("stroke", function(d) { return d3.rgb(d.color).darker(1); })
      .on("click", click)
      .on("mouseover", function(d,i) { })
      .on("mousemove", function(d) { })
      .on("mouseout", function(d) { })
      .call(force.drag);

  node.append("title")
      .text(function(d) {
var ret = "Shift+Click for detailes";
if (d.children) {
  var act = "open";
  if (d.open) {
    act = "close";
  }
  ret = "Click to " + act + ", " + ret;
}
return ret;
});

  var text = svg.append("svg:g").selectAll("g")
      .data(force.nodes())
    .enter().append("svg:g");

  // A copy of the text with a thick white stroke for legibility.
  text.append("svg:text")
      .attr("x", function(d) { return size(d) + 2; })
      .attr("y", ".31em")
      .attr("class", "shadow")
      .text(function(d) { return d.name; });

  text.append("svg:text")
      .attr("x", function(d) { return size(d) + 2; })
      .attr("y", ".31em")
      .text(function(d) { return d.name; });

  force.on("tick", function() {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    link2.attr("x1", function(d) { return (d.source.x + (d.target.y-d.source.y)/2)*l(d) + (d.target.x - (d.target.x-d.source.x) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target))*(1-l(d)); })
         .attr("y1", function(d) { return (d.source.y - (d.target.x-d.source.x)/2)*l(d) + (d.target.y - (d.target.y-d.source.y) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target))*(1-l(d)); })
         .attr("x2", function(d) { return d.target.x - (d.target.x-d.source.x) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target); })
         .attr("y2", function(d) { return d.target.y - (d.target.y-d.source.y) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target); });

    link3.attr("x1", function(d) { return (d.source.x - (d.target.y-d.source.y)/2)*l(d) + (d.target.x - (d.target.x-d.source.x) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target))*(1-l(d)); })
         .attr("y1", function(d) { return (d.source.y + (d.target.x-d.source.x)/2)*l(d) + (d.target.y - (d.target.y-d.source.y) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target))*(1-l(d)); })
         .attr("x2", function(d) { return d.target.x - (d.target.x-d.source.x) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target); })
         .attr("y2", function(d) { return d.target.y - (d.target.y-d.source.y) /
Math.sqrt((d.target.x-d.source.x)*(d.target.x-d.source.x)+(d.target.y-d.source.y)*(d.target.y-d.source.y))*size(d.target); });

    node.attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; });

    text.attr("transform", function(d) {
      return "translate(" + d.x + "," + d.y + ")";
    });

  });
}

function l(lnk) {
  if (lnk.short) {
    return 0;
  } else {
    return arrow_len;
  }
}

function size(nd) {
  if (nd.children) {
    if (nd.open) {
      return 5;
    } else {
      return 5 * (1 + Math.sqrt(nd.children.length));
    }
  } else {
    return 5;
  }
}

function click(d) {
var shiftPressed = d3.event.shiftKey;
if (!shiftPressed) {
  if (d.children) {
    if (d.open) {
      d.open = false;
    } else {
      d.open = true;
      for (var j = 0; j < d.children.length; j++) {
        var ch = d.children[j];
        if (ch.x) {
        } else {
          ch.x = d.x + 50 * Math.sin(j);
          ch.y = d.y + 50 * Math.cos(j);
          ch.px = ch.x;
          ch.py = ch.y;
        }
      }
    }
    d3.select("svg").remove();
    hide_popup();
    $("#popup_tooltip").remove();
    update();
  }
} else {
  var corner = $('#svg_div').offset();
  var pos = d3.mouse(this);
  tip_left = corner.left + pos[0] + 10;
  tip_top = corner.top + pos[1];
  tip_viz = true;
  tooltip.style("top", tip_top + "px");
  tooltip.style("left", tip_left + "px");
  tooltip.text("Loading information about " + d.name + "...");
  $("#popup_tooltip").load(d.url);
  tooltip.style("visibility", "visible");
}
}

function hide_popup() {
  tip_viz = false;
  tooltip.style("visibility", "hidden");
}

orig_graph = <%=graphJS%>;
update();
</script>

</body>
</html>