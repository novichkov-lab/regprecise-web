package com.lbl.regprecise.web;

import com.lbl.regprecise.dao.hibernate.ConstrainedDataProvider;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

/**
 * @author Roman Sutormin
 * Date: 17.11.12
 */
public class RegulogCascadeGraph {
    public static final String COLOR_REGULON_TF = "#102890";
    public static final String COLOR_REGULON_RNA = "#B22222";
    public static final String COLOR_OPERON = "#808080";

    private List<Node> nodes;
    private List<Link> links;

    public RegulogCascadeGraph(List<Node> nodes, List<Link> links) {
        this.nodes = Collections.unmodifiableList(nodes);
        this.links = Collections.unmodifiableList(links);
    }

    public static void main(String[] args) {
        DataProviderHelper.init(null);
        ConstrainedDataProvider dp = DataProviderHelper.getDataProvider();
        System.out.println(loadJS(dp, 2, true));
    }

    public static RegulogCascadeGraph load(ConstrainedDataProvider dp, final int genomeId, boolean onlyLinked) {
    	throw new RuntimeException("Not yet implemented");
    }
    
    
//    public static RegulogCascadeGraph load(ConstrainedDataProvider dp, final int genomeId, boolean onlyLinked) {
//        final Map<Integer, Node> regulonIdToNode = new TreeMap<Integer, Node>();
//        final List<int[]> regulonIdPairs = new ArrayList<int[]>();
//        try {
//            Connection connection =  dp.getSession().connection();
//            Statement st = connection.createStatement();
//            ResultSet rs = st.executeQuery("" +
//                    "select r.regulonId, rg.regulationTypeTermId, rg.regulatorName, r.operonId,\n" +
//                    "group_concat(coalesce(g.name, g.locusTag) order by g.operonIndex) as operonName\n" +
//                    "from Regulog rg\n" +
//                    "join (\n" +
//                    "select distinct r.regulogId, r.regulonId, o.operonId\n" +
//                    "from Regulon r\n" +
//                    "join Operon o using(regulonId)\n" +
//                    "join Gene using(operonId)\n" +
//                    "join Site using(geneId)\n" +
//                    "where genomeId = " + genomeId + "\n" +
//                    ") r using(regulogId)\n" +
//                    "join Gene g using (operonId)\n" +
//                    "where rg.statusTermId>=304\n" +
//                    "group by rg.regulationTypeTermId, r.regulonId,  rg.regulatorName, r.operonId");
//            while (rs.next()) {
//                int regulonId = rs.getInt(1);
//                Node node = regulonIdToNode.get(regulonId);
//                if (node == null) {
//                    int type = rs.getInt(2);
//                    String name = rs.getString(3);
//                    node = new Node(name, type == 201 ? COLOR_REGULON_TF : COLOR_REGULON_RNA,
//                            "tip_regulon.jsp?regulon_id=" + regulonId);
//                    regulonIdToNode.put(regulonId, node);
//                }
//                int operonId = rs.getInt(4);
//                String name = rs.getString(5);
//                node.children.add(new Node(name, COLOR_OPERON, "tip_operon.jsp?operon_id=" + operonId));
//            }
//            rs = st.executeQuery("" +
//                    "select distinct regulonId1, regulonId2\n" +
//                    "from\n" +
//                    "(select r.regulonId as regulonId2, rt.moId as moId\n" +
//                    "from Regulon r \n" +
//                    "join Regulator rt using(regulonId)\n" +
//                    "where genomeId = " + genomeId + "\n" +
//                    ") t1 join\n" +
//                    "(select distinct r.regulonId as regulonId1, g2.moId as moId\n" +
//                    "from Regulon r \n" +
//                    "join Operon o using(regulonId) \n" +
//                    "join Gene g using(operonId) \n" +
//                    "join Site using(geneId) \n" +
//                    "join Gene g2 using(operonId)\n" +
//                    "where genomeId = " + genomeId + "\n" +
//                    ") t2 using(moId)\n" +
//                    "where regulonId1 != regulonId2");
//            while (rs.next()) {
//                regulonIdPairs.add(new int[] {rs.getInt(1), rs.getInt(2)});
//            }
//            rs.close();
//            st.close();
//            connection.close();
//        } catch (SQLException ex) {
//            throw new IllegalStateException(ex);
//        }
//                          
//        
//        Map<Integer, Node> selectedRegToNode = new TreeMap<Integer, Node>();
//        if (onlyLinked) {
//            for (int[] pair : regulonIdPairs) {
//                if (regulonIdToNode.get(pair[0]) != null && regulonIdToNode.get(pair[1]) != null) {
//                    if (!selectedRegToNode.containsKey(pair[0])) {
//                        Node node = regulonIdToNode.get(pair[0]);
//                        selectedRegToNode.put(pair[0], node);
//                    }
//                    if (!selectedRegToNode.containsKey(pair[1])) {
//                        Node node = regulonIdToNode.get(pair[1]);
//                        selectedRegToNode.put(pair[1], node);
//                    }
//                }
//            }
//        } else {
//            selectedRegToNode.putAll(regulonIdToNode);
//        }
//        Map<Integer, Integer> regulonIdToPos = new TreeMap<Integer, Integer>();
//        List<Node> nodes = new ArrayList<Node>();
//        for (Map.Entry<Integer, Node> entry : selectedRegToNode.entrySet()) {
//            int pos = nodes.size();
//            nodes.add(entry.getValue());
//            regulonIdToPos.put(entry.getKey(), pos);
//        }
//        List<Link> links = new ArrayList<Link>();
//        for (int[] pair : regulonIdPairs) {
//            int srcNodePos = getPositionOfRegulonById(regulonIdToPos, pair[0]);
//            int dstNodePos = getPositionOfRegulonById(regulonIdToPos, pair[1]);
//            if (srcNodePos == -1 || dstNodePos == -1)
//                continue;
//            links.add(new Link(srcNodePos, dstNodePos));
//        }
//        return new RegulogCascadeGraph(nodes, links);
//    }

    private static int getPositionOfRegulonById(Map<Integer, Integer> regulonIdToPos, int regulonId) {
        Integer ret = regulonIdToPos.get(regulonId);
        return (ret == null) ? -1 : ret;
    }

    public static String loadJS(ConstrainedDataProvider dp, int genomeId, boolean onlyLinked) {
        RegulogCascadeGraph gr = load(dp, genomeId, onlyLinked);
        StringBuilder ret = new StringBuilder("{\n  \"nodes\":[");
        boolean firstNode = true;
        for (Node node : gr.getNodes()) {
            if (firstNode) {
                firstNode = false;
            } else {
                ret.append(",");
            }
            ret.append("\n    {\"name\":\"").append(escapeQuotas(node.getName())).append("\",\"color\":\"")
                    .append(node.getColor()).append("\",\"url\":\"").append(escapeQuotas(node.getTipUrl()))
                    .append("\",\"children\":[");
            boolean firstCh = true;
            for (Node ch : node.getChildren()) {
                if (firstCh) {
                    firstCh = false;
                } else {
                    ret.append(",");
                }
                ret.append("\n      {\"name\":\"").append(escapeQuotas(ch.getName())).append("\",\"color\":\"")
                        .append(ch.getColor()).append("\",\"url\":\"").append(escapeQuotas(ch.getTipUrl()))
                        .append("\"}");
            }
            ret.append("\n    ]}");
        }
        ret.append("\n  ],");
        ret.append("\n  \"links\":[");
        boolean firstLink = true;
        for (Link link : gr.getLinks()) {
            if (firstLink) {
                firstLink = false;
            } else {
                ret.append(",");
            }
            ret.append("\n    {\"source\":").append(link.getSrcNodePos()).append(",\"target\":")
                    .append(link.getTarNodePos()).append(",\"value\":1}");
        }
        ret.append("\n  ]\n}");
        return ret.toString();
    }

    private static String escapeQuotas(String text) {
        return text;
    }

    public List<Node> getNodes() {
        return nodes;
    }

    public List<Link> getLinks() {
        return links;
    }

    public static class Node {
        private String name;
        private String color;
        private String tipUrl;
        private List<Node> children = new ArrayList<Node>();

        public Node(String name, String color, String tipUrl) {
            this.name = name;
            this.color = color;
            this.tipUrl = tipUrl;
        }

        public String getName() {
            return name;
        }

        public String getColor() {
            return color;
        }

        public String getTipUrl() {
            return tipUrl;
        }

        public List<Node> getChildren() {
            return children;
        }
    }

    public static class Link {
        private int srcNodePos;
        private int tarNodePos;

        public Link(int srcNodePos, int tarNodePos) {
            this.srcNodePos = srcNodePos;
            this.tarNodePos = tarNodePos;
        }

        public int getSrcNodePos() {
            return srcNodePos;
        }

        public int getTarNodePos() {
            return tarNodePos;
        }
    }
}
